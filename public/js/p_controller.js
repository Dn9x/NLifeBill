//整个项目的内容页是单页
var app = angular.module('pApp', ['ngRoute', 'priceFilters']);

app.config(['$routeProvider', function($routeProvider){
	//定义路由
	$routeProvider
		.when('/', { templateUrl: 'part/p_rl', controller: 'RlCtrl' })
		.when('/add/:year/:month/:day', { templateUrl: 'part/p_add', controller: 'AddCtrl' })
		.when('/upd/:id', { templateUrl: 'part/p_upd', controller: 'UpdCtrl' })
		.when('/mtotal', { templateUrl: 'part/p_mtotal', controller: 'MtotalCtrl' })
		.when('/msort', { templateUrl: 'part/msort', controller: 'MsortCtrl' })
		.when('/quarter', { templateUrl: 'part/quarter', controller: 'QuarterCtrl' })
		.when('/week', { templateUrl: 'part/week', controller: 'WeekCtrl' })
		.when('/sort', { templateUrl: 'part/sort', controller: 'SortCtrl' })
		.when('/budget', { templateUrl: 'part/p_budget', controller: 'BudgetCtrl' })
		.when('/ewm', { templateUrl: 'part/ewm', controller: 'EwmCtrl' })
		.otherwise({ redirectTo: '/' });

}]);

//日历分部视图的控制器
app.controller('RlCtrl', ['$scope', '$http', '$location', function($scope, $http, $location){
	showLeft("rl_left");
	showMenuSwipe();

	$scope.names = "日历";

    var year = new Date().getFullYear();
    var month = new Date().getMonth() + 1;
    var day = new Date().getDate();

    showRl(year, month, day);

	changeRl();

	$scope.updAdd = function(mid){
		if(mid != 0){
			$location.path('/upd/' + mid);  
		}else{
			$location.path('/add/' + year + '/' + month + '/' + day);  
		}
	};
	
	//控制上下改变日期
	function changeRl(){

        Quo("#p_pub_cont").swipeUp(function(){
            //判断天
            if(day == 1 && month != 1){   //这个月的第一天，那么前一天就是上个月
                //获取上个月有多少天
                day = daysInMonth(year, month-1);

                //月份减一
                month--;
            }else if(day == 1 && month == 1){  //某年的第一个月第一天，前一天就是上年最后一天
                year--;
                month = 12;
                day = daysInMonth(year, 12);
            }else if(day > 1){
                day--;
            }

            showRl(year, month, day);    
        }).swipeDown(function(){   //向左滑动后一天
        
            //获取当月有多少天
            var days = daysInMonth(year, month);

            //判断天
            if(day == days && month != 12){
                day = 1;

                month++;
            }else if(day == days && month == 12){  
                year++;
                month = 1;
                day = 1;
            }else if(day < days){
                day++;
            }

            showRl(year, month, day);   
        });
	};

    //读取日历信息
	function showRl(year, month, day){
		var data = { y: year, m: month , d: day};
		$http.post('/getRl_p', data).success(function(data, status, headers, config){
			if(data.info.length > 0){
				//主档ID
				$scope.mid = data.info[0].id;

	            $scope.header = year + "年" + month + "月" + day + "日";
	            $scope.price = "-" + data.info[0].outlay + "/+" + data.info[0].revenue;

	            //从服务器获取预算
				$http.get('/getBill/' + data.info[0].id).success(function(json, status, headers, config){
					$scope.body = json.bills;
				});

	        }else{
	        	//主档ID
				$scope.mid = 0;
	            $scope.header = year + "年" + month + "月" + day + "日";
	            $scope.price = "-0/+0";
	            $scope.body = null;
	        }
		});
	}
}]);

//日历分部视图的控制器
app.controller('AddCtrl', ['$scope', '$http', '$routeParams', '$location', function($scope, $http, $routeParams, $location){
	showLeft("rl_left");
	showMenuSwipe();

	var params = {
		year: $routeParams.year,
		month: $routeParams.month,
		day: $routeParams.day
	};

	$scope.params = params;
	$scope.isShowTags = false;

	var cont = {
		result: [],			//用户存储添加的信息
		ashow: false,		//用于控制添加按钮是否显示
		isAlert: true,		//用于是否显示提示框
		tagname: '点击分类可以切换',  //初始化分类
		inkey:[]			//用于存放时收入的分类
	};

	$scope.cont = cont;

	getTags();
	
	function getTags(){
		//从服务器获取所有类别事件
		$http.get('/getTags').success(function(data, status, headers, config){

			var temp = [];

			//因为传过来的数据时数组套数组对象
			for(var i=0;i<data.tag.length;i++){
				var obj = data.tag[i];
				//内层数组循环
				for(var j=0;j<obj.length;j++){
					//如果类型是进账行就保存下来
					if(obj[j].tagtype == 'I'){
						cont.inkey.push(obj[j].tagname);
					}

					var name = obj[j].tagname;
					if(name != '衣' && name != '食' && name != '它' && name != '住' && name != '行'){
						temp[temp.length] = obj[j];
					}
				}
			}

			$scope.tags = temp;

		});
	};

	$scope.showTags = function(name){
		cont.tagname = name;
		$scope.isShowTags = false;

		//循环判断是否是新的分类
		for(var i=0, k=0;i<cont.result.length;i++){
			if(cont.result[i].name == name){
				cont.scontent = cont.result[i].value;
				break;
			}else{
				k++;
			}
		}

		//如果是新的分类就清空输入框
		if(k == cont.result.length){
			cont.scontent = "";
		}
	};

	//输入框失去焦点事件
	$scope.blur = function(){
		//1.0.7版本的blur不行的

		var content = $scope.cont.scontent;

		var val = content.replace(/,/g, ";").replace(/；/g, ";").replace(/，/g, ";").replace(/：/g, ":");

		//判断分类
		if($scope.cont.tagname != '点击分类可以切换'){
			//计算输入框中的总额
	        if(val.length > 0 && val != null && cont.tagname != null){

	        	var s = val;
		        var reg = /[+-]?\d+\.?\d*/g;
		        var sum = 0.0;
		        var expr;
		        var numbers = s.match(reg);
		        if (numbers != null) {
		            for (v in numbers) {
		                if (v == 0)
		                    expr = numbers[v];
		                else
		                    expr += '+' + numbers[v];

		                sum += parseFloat(numbers[v]);
		            }
		        }

		        var resulttype = 'O';

		        //判断记账类型
		        for(var i =0;i<cont.inkey.length;i++){
		        	if(cont.tagname == cont.inkey[i]){
						resulttype = 'I';
						break;
		        	}
		        }

				//判断是否是第一次
				if(cont.result.length == 0){
					cont.result[cont.result.length] = { name: cont.tagname, value: val, total: sum, type: resulttype };
				}else{
					//循环判断是否这个新增的tag是否已经存在
					for(var i=0, k=0;i<cont.result.length;i++){
						if(cont.result[i].name == cont.tagname){
							cont.result.splice(i, 1, { name: cont.tagname, value: val, total: sum, type: resulttype });
							break;
						}else{
							k++;
						}
					}

					//如果是新的分类就添加
					if(k == cont.result.length){
						cont.result[cont.result.length] = { name: cont.tagname, value: val, total: sum, type: resulttype };
					}
				}
	        }
		}
	};

	//提交方法
	$scope.submit = function(){
		var total = sum();

		//拼接主档
		var master = {
			years: params.year,
			months: params.month,
			days: params.day,
			revenue: total.iTotal,
			outlay: total.oTotal
		};

		//明细档
		var details = [];
		//cont.result

		var temptags = $scope.tags;

		//循环存储起来的数组
		for(var i=0;i<cont.result.length;i++){
			//{ name: cont.tagname, value: val, total: sum, type: resulttype };
			var temp = cont.result[i];

			for(var j=0;j<temptags.length;j++){
				if(temp.name == temptags[j].tagname){
					details[details.length] = {
						tagid: temptags[j].id,
						price: temp.total,
						notes: temp.value
					};
				}
			}
		}

		var data = {master: master, details: details};

		//把数据写入到数据库
		$http.post('/addBill', data).success(function(data, status, headers, config){
			$location.path('/');
		});
	};

	//重置方法
	$scope.reset = function(){
		cont.result.length = 0;
		cont.scontent = "";
	};

	//监视添加的账单的总额
    $scope.$watch(function(){
    	var total = sum();

    	if(total.iTotal > 0 || total.oTotal > 0){
    		cont.ashow = true;
    	}else{
    		cont.ashow = false;
    	}

		cont.total = '总进账: ' + total.iTotal.toFixed(2) + ' 总出账: ' + total.oTotal.toFixed(2);
    });

    //计算总额
    function sum(){
    	var total = {
    		iTotal: 0,
    		oTotal: 0
    	};
    	var arr = $scope.cont.result;
    	for(var i=0;i<arr.length;i++){
    		if(arr[i].type == 'I'){
    			total.iTotal += arr[i].total;
    		}else{
    			total.oTotal += arr[i].total;
    		}
    	}
    	return total;
    }
}]);

//日历分部视图的控制器
app.controller('UpdCtrl', ['$scope', '$http', '$routeParams', '$location', function($scope, $http, $routeParams, $location){

	var params = {
		id: $routeParams.id
	};

	showLeft("rl_left");
	showMenuSwipe();

	//控制tags列是否显示
	$scope.isShowTags = false;

	var cont = {
		result: [],			//用户存储添加的信息
		ashow: false,		//用于控制添加按钮是否显示
		isAlert: true,		//用于是否显示提示框
		tagname: '点击分类可以切换',  //初始化分类
		inkey:[]			//用于存放时收入的分类
	};

	$scope.cont = cont;

	getTags();
	
	function getTags(){
		//从服务器获取所有类别事件
		$http.get('/getTags').success(function(data, status, headers, config){

			var temp = [];

			//因为传过来的数据时数组套数组对象
			for(var i=0;i<data.tag.length;i++){
				var obj = data.tag[i];
				//内层数组循环
				for(var j=0;j<obj.length;j++){
					//如果类型是进账行就保存下来
					if(obj[j].tagtype == 'I'){
						cont.inkey.push(obj[j].tagname);
					}

					var name = obj[j].tagname;
					if(name != '衣' && name != '食' && name != '它' && name != '住' && name != '行'){
						temp[temp.length] = obj[j];
					}
				}
			}

			$scope.tags = temp;
		});
	};

	//把数据写入到数据库
	$http.get('/getBill/'+params.id).success(function(data, status, headers, config){
		
		//循环判断是否这个新增的tag是否已经存在
		for(var i=0;i<data.bills.length;i++){
			var temp = data.bills[i];
			cont.result.push({ name: temp.tagname, value: temp.notes, total: temp.price, type: temp.type });
		}
	});

	$scope.showTags = function(name){
		cont.tagname = name;
		$scope.isShowTags = false;

		//循环判断是否是新的分类
		for(var i=0, k=0;i<cont.result.length;i++){
			if(cont.result[i].name == name){
				cont.scontent = cont.result[i].value;
				break;
			}else{
				k++;
			}
		}

		//如果是新的分类就清空输入框
		if(k == cont.result.length){
			cont.scontent = "";
		}
	};

	//输入框失去焦点事件
	$scope.blur = function(){
		//1.0.7版本的blur不行的

		var content = $scope.cont.scontent;

		var val = content.replace(/,/g, ";").replace(/；/g, ";").replace(/，/g, ";").replace(/：/g, ":");

		//判断分类
		if($scope.cont.tagname != '点击分类可以切换'){
			//计算输入框中的总额
	        if(val.length > 0 && val != null && cont.tagname != null){

	        	var s = val;
		        var reg = /[+-]?\d+\.?\d*/g;
		        var sum = 0.0;
		        var expr;
		        var numbers = s.match(reg);
		        if (numbers != null) {
		            for (v in numbers) {
		                if (v == 0)
		                    expr = numbers[v];
		                else
		                    expr += '+' + numbers[v];

		                sum += parseFloat(numbers[v]);
		            }
		        }

		        var resulttype = 'O';

		        //判断记账类型
		        for(var i =0;i<cont.inkey.length;i++){
		        	if(cont.tagname == cont.inkey[i]){
						resulttype = 'I';
						break;
		        	}
		        }

				//判断是否是第一次
				if(cont.result.length == 0){
					cont.result[cont.result.length] = { name: cont.tagname, value: val, total: sum, type: resulttype };
				}else{
					//循环判断是否这个新增的tag是否已经存在
					for(var i=0, k=0;i<cont.result.length;i++){
						if(cont.result[i].name == cont.tagname){
							cont.result.splice(i, 1, { name: cont.tagname, value: val, total: sum, type: resulttype });
							break;
						}else{
							k++;
						}
					}

					//如果是新的分类就添加
					if(k == cont.result.length){
						cont.result[cont.result.length] = { name: cont.tagname, value: val, total: sum, type: resulttype };
					}
				}
	        }
		}
	};

	//提交方法
	$scope.submit = function(){
		var total = sum();

		//拼接主档
		var master = {
			revenue: total.iTotal,
			outlay: total.oTotal,
			id: params.id
		};

		//明细档
		var details = [];
		//cont.result

		var temptags = $scope.tags;

		//循环存储起来的数组
		for(var i=0;i<cont.result.length;i++){
			//{ name: cont.tagname, value: val, total: sum, type: resulttype };
			var temp = cont.result[i];

			for(var j=0;j<temptags.length;j++){
				if(temp.name == temptags[j].tagname){
					details[details.length] = {
						tagid: temptags[j].id,
						price: temp.total,
						notes: temp.value,
						mid: params.id
					};
				}
			}
		}

		var data = {master: master, details: details};

		//把数据写入到数据库
		$http.post('/updBill', data).success(function(data, status, headers, config){
			$location.path('/');
		});
	};

	//重置方法
	$scope.reset = function(){
		cont.result.length = 0;
		cont.scontent = "";
	};

	//监视添加的账单的总额
    $scope.$watch(function(){
    	var total = sum();

    	if(total.iTotal > 0 || total.oTotal > 0){
    		cont.ashow = true;
    	}else{
    		cont.ashow = false;
    	}

		cont.total = '总进账: ' + total.iTotal.toFixed(2) + ' 总出账: ' + total.oTotal.toFixed(2);
    });

    //计算总额
    function sum(){
    	var total = {
    		iTotal: 0,
    		oTotal: 0
    	};
    	var arr = $scope.cont.result;
    	for(var i=0;i<arr.length;i++){
    		if(arr[i].type == 'I'){
    			total.iTotal += arr[i].total;
    		}else{
    			total.oTotal += arr[i].total;
    		}
    	}
    	return total;
    }
}]);

//日历分部视图的控制器
app.controller('MtotalCtrl', ['$scope', '$http', function($scope, $http){
	showLeft("yz_left");
	$scope.names = "月总额";
	showMenuSwipe();


	//用于存放数据
	var cont = {
		year: new Date().getFullYear()
	};

	$http.get('/year').success(function(data, status, headers, config){
		$scope.years = data.year;
	});

	//初始化
	showYear(cont.year);

	$scope.show = function(year){
		cont.year = year;

		showYear(year);
	};

	//显示年份数据
	function showYear(op){
		//从服务器获取所有类别事件
		$http.get('/yTotals/' + cont.year).success(function(data, status, headers, config){
			var temp = data;

			var x = data.bill.xAxis.split(",");

			$('#p_mtotal_container').highcharts({                   //图表展示容器，与div的id保持一致
		        chart: {
		            type: 'line'                         //指定图表的类型，默认是折线图（line）
		        },
		        title: {
		            text: op + '年度账单统计'      //指定图表标题
		        },
		        xAxis: {
		            categories: eval('(' + data.bill.xAxis + ')'),  //指定x轴分组
		            title: {
		                text: '月份'                  //指定y轴的标题
		            }
		        },
		        yAxis: {
		            title: {
		                text: 'RMB(￥)'                  //指定y轴的标题
		            }
		        },
	            tooltip: {
	            	formatter: function() {  
	                    return '<b>'+ this.series.name +'</b><br/>'+  
	                    this.x +': '+ this.y +'￥';  
	                }
	            },
	            plotOptions: {
	                line: {
	                    dataLabels: {
	                        enabled: true
	                    },
	                    enableMouseTracking: true, 
			            point: {     //图上的数据点(这个在线形图可能就直观)
				            events: {
				                click: function(){
			                		showMonth(cont.year, this.category); 
				                }
				            }
			            }
	                }
	            },
		        series: [{                                 //指定数据列
		            name: '消费',                          //数据列名
		            data: eval('(' + data.bill.series + ')')                      //数据
		        }]
		    });
		});
	}

	//显示详细月份里面的数据
	function showMonth(year, month){
		//从服务器获取所有类别事件
		$http.get('/mTotals/'+year+'/'+month).success(function(data, status, headers, config){
			var piedata = [];

			var x = eval('(' + data.bill.xAxis + ')');
			var y = eval('(' + data.bill.series + ')');

			for(var i=0;i<x.length;i++){
				piedata[piedata.length] = [x[i], y[i]]; 
			}

			$('#p_mtotal_container2').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
                text: year + '年' + month + '月账单统计'      //指定图表标题      //指定图表标题
		        },
		        tooltip: {
		    	    pointFormat: '{point.y}元/{point.percentage:.1f} %</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    color: '#000000',
		                    connectorColor: '#000000',
		                    format: '{point.name}号:{point.y}元'
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: '消费：',
		            data: piedata
		        }]
		    });


			$('#p_mtotal_container').highcharts({                   //图表展示容器，与div的id保持一致
		        chart: {
		            type: 'column'                         //指定图表的类型，默认是折线图（line column）
		        },
		        title: {
		            text: year + '年' + month + '月账单统计'      //指定图表标题      //指定图表标题
		        },
		        xAxis: {
		            categories: eval('(' + data.bill.xAxis + ')')  //指定x轴分组
		        },
		        yAxis: {
		            title: {
		                text: 'RMB(￥)'                  //指定y轴的标题
		            }
		        },
	            tooltip: {
	                formatter: function() {  
	                    return '<b>'+ this.series.name +'</b><br/>'+  
	                    this.x +': '+ this.y +'￥';  
	                }
	            },
	            plotOptions: {
	                column: {
	                    dataLabels: {
	                        enabled: true
	                    },
	                    enableMouseTracking: true
	                }
	            },
		        series: [{                                 //指定数据列
		            name: '消费',                          //数据列名
		            data: eval('(' + data.bill.series + ')')                      //数据
		        }]
		    });
		});
	}

}]);

//二维码分部视图的控制器
app.controller('EwmCtrl', ['$scope', '$http', function($scope, $http){
	showLeft("ss_left");
	$scope.names = "二维码";
	showMenuSwipe();
}]);

//添加预算的控制器
app.controller('BudgetCtrl', ['$scope', '$http', function($scope, $http){
	showLeft("ys_left");
	showMenuSwipe();
	$scope.names = "预算";

	//用于存放数据
	var cont = {
		isava: true
	};

	$scope.cont = cont;

	showBud();

	$scope.submit = function(){

		var data = {budget: cont};

		//把数据写入到数据库
		$http.post('/addBudget', data).success(function(data, status, headers, config){
			showBud();

			cont.years = "";
			cont.months = "";
			cont.outlay = "";
			cont.revenue = "";
		});
	};

	function showBud(){
		//把数据写入到数据库
		$http.get('/getBudget').success(function(data, status, headers, config){
			$scope.lists = data.info;
		});
	};

}]);

//显示左侧菜单
function showLeft(op){

	$(".cell").removeClass("cell_active");

	if(op == "rl_left"){
		$("#rl_left").addClass("cell_active");
	}else if(op == "ys_left"){
		$("#ys_left").addClass("cell_active");
	}else if(op == "yz_left"){
		$("#yz_left").addClass("cell_active");
	}else if(op == "yf_left"){
		$("#yf_left").addClass("cell_active");
	}else if(op == "jd_left"){
		$("#jd_left").addClass("cell_active");
	}else if(op == "we_left"){
		$("#we_left").addClass("cell_active");
	}else if(op == "ss_left"){
		$("#ss_left").addClass("cell_active");
	}else if(op == "sz_left"){
		$("#sz_left").addClass("cell_active");
	}

	//初始化
	$(".app_left").animate({ 
	    left: "-66%",
	    opacity: '1'
	}, 100);

	$(".p_pub_nav").animate({ 
    	left: "0",
    	opacity: '1'
    }, 100);

	var left = true;

	$("#p_pub_nav_left").click(function(){

		if(left){
			$(".app_left").animate({ 
			    left: "0",
			    opacity: '1'
			}, 100);

			$(".p_pub_nav").animate({ 
		    	left: "66%",
		    	opacity: '1'
		    }, 100);

		    left = false;
		}else{
			$(".app_left").animate({ 
			    left: "-66%",
			    opacity: '1'
			}, 100);

			$(".p_pub_nav").animate({ 
		    	left: "0",
		    	opacity: '1'
		    }, 100);

		    left = true;
		}
		
	});
}

//左右滑动显示菜单
function showMenuSwipe(){
	//向右滑动，
    $$(".p_pub_view").swipeRight(function(){
        $(".app_left").animate({ 
		    left: "0",
		    opacity: '1'
		}, 100);

		$(".p_pub_nav").animate({ 
	    	left: "66%",
	    	opacity: '1'
	    }, 100);  
    }).swipeLeft(function(){ 
		$(".app_left").animate({ 
		    left: "-66%",
		    opacity: '1'
		}, 100);

		$(".p_pub_nav").animate({ 
	    	left: "0",
	    	opacity: '1'
	    }, 100);
    });
}

//获取指定月份有多少天
function daysInMonth(year, month) {
     month = parseInt(month, 10);  //parseInt(number,type)这个函数后面如果不跟第2个参数来表示进制的话，默认是10进制。
     var temp = new Date(year, month, 0);
     return temp.getDate();
}


