
/*
 * GET users listing.
 */
var async = require('async');
var Bills = require('../models/bills');

var bill={};
module.exports = bill;

//获取日历控件
bill.getBudgetByMonths = function(req, res){
    var years = req.params.years;
    var months = req.params.months;

    Bills.getBudgetByMonths(years, months, function(err, info){
        res.json({ info: info});
    });
};


//获取日历控件
bill.getBudget = function(req, res){
    Bills.getBudget(function(err, info){
        res.json({ info: info});
    });
};


//获取日历控件
bill.addBudget = function(req, res){
    var budget = req.body.budget;

    Bills.addBudget(budget, function(err, info){

        res.json({ info: info});
    });
};

//获取日历控件
bill.getTagTotalByYearAndTag = function(req, res){
    var year = req.params.year;
    var name = req.params.tagname;

    Bills.getTagTotalByYearAndTag(year, name, function(err, info){

        //存储结果
        var result = {
            xAxis: "[",
            series: "["
        };

        for(var i=0;i<info.length;i++){
           if(i == info.length-1){
                //X轴数据
                result.xAxis += "'" + info[i].months + "'";

                //数据
                result.series += "" + info[i].price;
            }else{
                 //X轴数据
                result.xAxis += "'" + info[i].months + "',";

                //数据
                result.series += "" + info[i].price + ", ";
            }
        }

        result.xAxis += "]";
        result.series += "]";

        res.json({ bill: result});
    });
};

//获取日历控件
bill.getTagTotalByYear = function(req, res){
    var year = req.params.year;

    Bills.getTagTotalByYear(year, function(err, info){

        //存储结果
        var result = {
            xAxis: "[",
            series: "["
        };

        for(var i=0;i<info.length;i++){
           if(i == info.length-1){
                //X轴数据
                result.xAxis += "'" + info[i].tagname + "'";

                //数据
                result.series += "" + info[i].price;
            }else{
                 //X轴数据
                result.xAxis += "'" + info[i].tagname + "',";

                //数据
                result.series += "" + info[i].price + ", ";
            }
        }

        result.xAxis += "]";
        result.series += "]";

        res.json({ bill: result});
    });
};

//获取tangs
bill.years = function(req, res){
    Bills.getYears(function(err, years){
        res.json({ year: years });
    });
};

//获取日历控件
bill.getMonthTotalByYear = function(req, res){
    var year = req.params.year;
    var month = req.params.month;

    Bills.getMonthTotalByYear(year, month, function(err, info){

        //存储结果
        var result = {
            xAxis: "[",
            series: "["
        };

        for(var i=0;i<info.length;i++){
           if(i == info.length-1){
                //X轴数据
                result.xAxis += "'" + info[i].days + "'";

                //数据
                result.series += "" + info[i].outlay;
            }else{
                 //X轴数据
                result.xAxis += "'" + info[i].days + "',";

                //数据
                result.series += "" + info[i].outlay + ", ";
            }
        }

        result.xAxis += "]";
        result.series += "]";

        res.json({ bill: result});
    });
};

//获取日历控件
bill.getYearTotalByYear = function(req, res){
    var year = req.params.year;

    Bills.getYearTotalByYear(year, function(err, info){

        //存储结果
        var result = {
            xAxis: "[",
            series: "["
        };

        for(var i=0;i<info.length;i++){
           if(i == info.length-1){
                //X轴数据
                result.xAxis += "'" + info[i].months + "'";

                //数据
                result.series += "" + info[i].outlay;
            }else{
                 //X轴数据
                result.xAxis += "'" + info[i].months + "',";

                //数据
                result.series += "" + info[i].outlay + ", ";
            }
        }

        result.xAxis += "]";
        result.series += "]";


        res.json({ bill: result});
    });
};


//获取日历控件
bill.rili=function(req,res){
	var year = req.body.y || new Date().getFullYear();
    var month = req.body.m || new Date().getMonth() + 1;

    Bills.getTotalByDate(year, month, function(err, bill){
		
		var json = "{";
    	
    	if(bill.length > 0){
    		for(var i=0;i<bill.length;i++){
    			json += "\"_" + bill[i]["date"] + "\":[{\"total\":\"" + bill[i]["total"] + "\", \"id\":\""+bill[i]["id"]+"\"}], ";
    		}
    	}
    	
    	json += "}";

    	res.json({ bill: json});
    });
};

//获取tangs
bill.tags = function(req, res){

    Bills.getTags('Y', function(err, tag){

        //获取结果并且升序排序
        var arr = changeTags(tag).sort(function(a, b){
            return a[0].id - b[0].id;
        });;

        res.json({ tag: arr });
    });
};

//添加入账信息
bill.add = function(req, res){

    var master = req.body.master;
    var details = req.body.details;

    Bills.addBills(master, details, function(err, info){
        res.json({ info: 'OK' });
    });
};

//获取账单用于修改
bill.get = function(req, res){

    var id = req.params.id;

    Bills.getBills(id, function(err, bills){

        res.json({ bills: bills });
    });
};

//获取账单用于修改
bill.upd = function(req, res){

    var master = req.body.master;
    var details = req.body.details;

    Bills.updBills(master, details, function(err, info){
        res.json({ info: 'OK' });
    });
};


//把tag分类
function changeTags(temp){
    //存放结果的数组
    var arr = new Array();

    //外围循环控制数组数量
    for(var i=0, x=0;i<temp.length;i++){

        //临时数组存放每个单个数组项
        var temparr = new Array();

        //查找相同对象并且标记
        for(var j=x+1;j<temp.length;j++){

            //如果是父类就放到第一个位置
            if(temp[x].pid == temp[j].id){
                temparr.unshift(temp[j]);

                //标记这个项是处理过的
                temp[j].mark = 'D';
            }

            
            //如果是子类就放第一个的后面
            if(temp[x].pid == temp[j].pid && temp[j].pid != 0){
                temparr[temparr.length] = temp[j];

                temp[j].mark = 'D';
            }

            //本身也要放进数组
            if(j == temp.length-1){
                temparr[temparr.length] = temp[x];

                temp[x].mark = 'D';
            }
        }

        //查找到的结果放到结果数组里
        arr[arr.length] = temparr;

        //清除标记的对象
        for(var z=0, k=0;z<temp.length;z++){
            //判断前一个是否已经删除
            if(k==0){
                z=0;
            }

            //如果是标记过的就删除
            if(temp[z].mark == 'D'){
                //这里没有多余，这个属性也用不着
                delete temp[z].mark;

                //清除标记过的项
                temp.splice(z, 1);

                //归零，方便下次从0开始
                k=0;

                //继续操作
                continue;
            }else{
                //如果没有标记就累加，用于跳过
                k++;
            }
        }
    }

    return arr;
}