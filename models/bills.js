var queues = require('mysql-queues');
var db = require('./db');
var config = require('../config');


var Bills = {};

module.exports = Bills;

/**
 * 根据年月查询当前年月的每天的金额
 * Callback:
 * - err, 数据库错误
 * @param {string} year 年份
 * @param {string} month 月份
 * @param {Function} callback 回调函数
 */
Bills.getTotalByDate = function(year, month, callback){

	//从连接池中获取一个连接
	db.getConnection(function(err, connection) {

		var sql = "select Concat(years, months, days) as date, CONCAT('-', outlay, '/', '+', revenue) as total, id from billmaster where years="+connection.escape(year)+" and months="+connection.escape(month);

		//查询
		connection.query(sql, function(err, bill) {
			if (err){
		        callback(err, null);
			}
			
			callback(null, bill);

			connection.release();		//使用完之后断开连接，放回连接池
			//connection.destroy();	//使用之后释放资源，下次使用重新连接
		});
	});
};

/**
 * 根据是否显示查询tag
 * Callback:
 * - err, 数据库错误
 * @param {string} isshow 是否显示
 * @param {Function} callback 回调函数
 */
Bills.getTags = function(isshow, callback){
	//从连接池中获取一个连接
	db.getConnection(function(err, connection) {

		var sql = "select id, tagname, tagtype, pid, isshow as mark from billtags where isshow = "+connection.escape(isshow)+" order by id desc";

		//查询
		connection.query(sql, function(err, tag) {
			if (err){
		        callback(err, null);
			}

			callback(null, tag);

			connection.release();		//使用完之后断开连接，放回连接池
		  });
	});
};


/**
 * 添加入账信息
 * Callback:
 * - err, 数据库错误
 * @param {string} master 主档数据对象
 * @param {string} details 明细档数据对象数组
 * @param {Function} callback 回调函数
 */
Bills.addBills = function(master, details, callback){
	//从连接池中获取一个连接
	db.getConnection(function(err, connection) {

		queues(connection, config.mysql_queues_debug);

		//开启事务
		var trans = connection.startTransaction();

		//拼接主档sql
		var sql = "insert into billmaster(years, months, days, revenue, outlay, addtime, userid) values(?, ?, ?, ?, ?, now(), 1)";
		var inserts = [master.years, master.months, master.days, master.revenue, master.outlay];
		sql = connection.format(sql, inserts);

		//先插入主档
		trans.query(sql, function(err, info) {
			if(err){
				//callback(err, null);
				trans.rollback();
			}else{
				//trans.commit();
			}
		});

		//查询主档ID
		var cql = "(select id from billmaster where years=? and months=? and days=?)";
		var csert = [master.years, master.months, master.days];
		cql = connection.format(cql, csert);

		for(var i=0;i<details.length;i++){
			(function(detail, index, leng){
				
				var dql = "insert into billdetail(masterid, tagid, price, notes, addtime) values("+cql+", ?, ?, ?, now())";
				var dsert = [detail.tagid, detail.price, detail.notes];
				dql = connection.format(dql, dsert);

				//插入明细档
				trans.query(dql, function(err, info) {
					if(err){
						//callback(err, null);
						trans.rollback();
					}else{
						//如果是最后一次就提交事务断开连接
						if(index == leng-1){
							trans.commit(function(err, infos){

								callback(null, info);
								connection.release();		//使用完之后断开连接，放回连接池
							});
						}
						//
					}
				});
			})(details[i], i, details.length);
		}

		//提交执行
		trans.execute();
	});
};

