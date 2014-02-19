
/*
 * GET users listing.
 */

var Bills = require('../models/bills');

var bill={};
module.exports = bill;

bill.rili=function(req,res){
	var year = req.body.y || new Date().getFullYear();
    var month = req.body.m || new Date().getMonth() + 1;

    Bills.getTotalByDate(year, month, function(err, bill){
    	console.log('y:%s,  m:%s', year, month);
		
		var json = "{";
    	
    	if(bill.length > 0){
    		for(var i=0;i<bill.length;i++){
    			console.log('bill' + bill[i].total);
    			json += "\"_" + bill[i]["date"] + "\":[{\"total\":\"" + bill[i]["total"] + "\", \"id\":\""+bill[i]["id"]+"\"}], ";
    		}
    	}
    	
    	json += "}";

    	res.json({ bill: json});
    });
	 
};