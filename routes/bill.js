
/*
 * GET users listing.
 */
var async = require('async');
var Bills = require('../models/bills');

var bill={};
module.exports = bill;

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

bill.tags = function(req, res){

    Bills.getTags('Y', function(err, tag){

        //获取结果并且升序排序
        var arr = changeTags(tag).sort(function(a, b){
            return a[0].id - b[0].id;
        });;

        for(var i=0;i<arr.length;i++){
            console.log('index: %s ; count: %s', arr[i][0].id, arr[i].length);
        }

        res.json({ tag: arr });
    });
};

bill.add = function(req, res){

    var master = req.body.master;
    var details = req.body.details;

    Bills.addBills(master, details, function(err, info){
        res.json({ info: 'OK' });
    });

};


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