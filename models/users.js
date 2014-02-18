var db = require('./db');

function Users(user){
	this.id = user.id;
	this.login = user.login;
	this.pswd = user.pswd;
	this.name = user.name;
	this.tel = user.tel;
	this.email = user.email;
	this.sex = user.sex;
	this.addtime = user.addtime;
};

module.exports = Users;

/**
 * 根据用户名查询用户的方法
 * Callback:
 * - err, 数据库错误
 * @param {string} login 查询的登录名
 * @param {Function} callback 回调函数
 */
Users.getUser = function(login, callback){

	//从连接池中获取一个连接
	db.getConnection(function(err, connection) {

	  //查询
	  connection.query('select u.id, u.login, u.pswd, u.name, u.email from users u where login='+connection.escape(login), function(err, user) {
		if (err){
		  callback(err, null);
		}

		callback(null, user);

		connection.release();		//使用完之后断开连接，放回连接池
		//connection.destroy();	//使用之后释放资源，下次使用重新连接
	  });
	});
};


