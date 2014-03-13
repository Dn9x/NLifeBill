//整个项目的内容页是单页
var app = angular.module('lbApp', ['ngRoute', 'priceFilters']);

app.config(['$routeProvider', function($routeProvider){
	//定义路由
	$routeProvider
		.when('/', { templateUrl: 'part/rl', controller: 'RlCtrl' })
		.when('/add/:year/:month/:day', { templateUrl: 'part/add', controller: 'AddCtrl' })
		.when('/upd/:id', { templateUrl: 'part/upd', controller: 'UpdCtrl' })
		.when('/mtotal', { templateUrl: 'part/mtotal', controller: 'MtotalCtrl' })
		.when('/msort', { templateUrl: 'part/msort', controller: 'MsortCtrl' })
		.when('/quarter', { templateUrl: 'part/quarter', controller: 'QuarterCtrl' })
		.when('/week', { templateUrl: 'part/week', controller: 'WeekCtrl' })
		.when('/sort', { templateUrl: 'part/sort', controller: 'SortCtrl' })
		.when('/budget', { templateUrl: 'part/budget', controller: 'BudgetCtrl' })
		.otherwise({ redirectTo: '/' });

}]);

//日历分部视图的控制器
app.controller('RlCtrl', ['$scope', '$http', function($scope, $http){

}]);

//添加分部视图的控制器
app.controller('AddCtrl', ['$scope', '$http', '$routeParams', '$location', function($scope, $http, $routeParams, $location){
	var params = {
		year: $routeParams.year,
		month: $routeParams.month,
		day: $routeParams.day
	};

	$scope.params = params;

	var cont = {
		result: [],			//用户存储添加的信息
		ashow: false,		//用于控制添加按钮是否显示
		isAlert: true,		//用于是否显示提示框
		inkey:[]			//用于存放时收入的分类
	};

	$scope.cont = cont;

	//从服务器获取预算
	$http.get('/getBudgetByMonths/' + params.year + '/' + params.month).success(function(data, status, headers, config){
		$scope.budget = data.info[0];
	});

	//从服务器获取所有类别事件
	$http.get('/getTags').success(function(data, status, headers, config){
		$scope.tags = data.tag;

		//因为传过来的数据时数组套数组对象
		for(var i=0;i<data.tag.length;i++){
			var obj = data.tag[i];
			//内层数组循环
			for(var j=0;j<obj.length;j++){
				//如果类型是进账行就保存下来
				if(obj[j].tagtype == 'I'){
					cont.inkey.push(obj[j].tagname);
				}
			}
		}
	});

	//点击类别事件
	$scope.show = function(name){
		//判断是否有几个大分类，大分类不计入
    	if (name == '衣' || name == '食' || name == '它' || name == '住' || name == '行'){
			cont.error = "你所点击分类：'" + name + "' 不支持入账；";
			cont.eshow = true;		//错误信息框打开
		}else{
			cont.tagname = name;
			cont.eshow = false;		//错误信息框关闭

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
		}
	};

	//输入框失去焦点事件
	$scope.blur = function(){
		//1.0.7版本的blur不行的

		var content = $scope.cont.scontent;

		var val = content.replace(/,/g, ";").replace(/；/g, ";").replace(/，/g, ";").replace(/：/g, ":");

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

		var temptags = new Array();

		//循环拼接明细档
		var tags = $scope.tags;
		for(var i=0;i<tags.length;i++){
			var tag = tags[i];
			for(var j=0;j<tag.length;j++){
				temptags[temptags.length] = tag[j];
			}
		}

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
			window.alert('添加成功');
			$location.path('/');
		});
	};

	//重置方法
	$scope.reset = function(){
		cont.result.length = 0;
		cont.scontent = "";
		cont.tagname = "";
	};
	
    //监视添加的账单的总额
    $scope.$watch(function(){
    	var total = sum();

    	if(total.iTotal > 0 || total.oTotal > 0){
    		cont.ashow = true;
    	}else{
    		cont.ashow = false;
    	}
    	
    	//如果当前消费加上这个月前面的消费大于预算就提示
    	if(total.oTotal+$scope.budget.moutlay > $scope.budget.outlay){
    		if(cont.isAlert){
    			if(window.confirm("您的消费已经超过预算了SB！省着点。\n 关闭继续提示？")){
	    			cont.isAlert = false;	
	    		}
    		}
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

//修改分部视图的控制器
app.controller('UpdCtrl', ['$scope', '$http', '$routeParams', '$location', function($scope, $http, $routeParams, $location){
	var params = {
		id: $routeParams.id
	};

	var cont = {
		result: [],			//用户存储添加的信息
		ashow: false,		//用于控制添加按钮是否显示
		inkey:[]			//用于存放时收入的分类
	};

	$scope.cont = cont;

	//从服务器获取所有类别事件
	$http.get('/getTags').success(function(data, status, headers, config){
		$scope.tags = data.tag;

		//因为传过来的数据时数组套数组对象
		for(var i=0;i<data.tag.length;i++){
			var obj = data.tag[i];
			//内层数组循环
			for(var j=0;j<obj.length;j++){
				//如果类型是进账行就保存下来
				if(obj[j].tagtype == 'I'){
					cont.inkey.push(obj[j].tagname);
				}
			}
		}
	});

	//把数据写入到数据库
	$http.get('/getBill/'+params.id).success(function(data, status, headers, config){
		
		//循环判断是否这个新增的tag是否已经存在
		for(var i=0;i<data.bills.length;i++){
			var temp = data.bills[i];
			cont.result.push({ name: temp.tagname, value: temp.notes, total: temp.price, type: temp.type });
		}
	});


	//点击类别事件
	$scope.show = function(name){
		//判断是否有几个大分类，大分类不计入
    	if (name == '衣' || name == '食' || name == '它' || name == '住' || name == '行'){
			cont.error = "你所点击分类：'" + name + "' 不支持入账；";
			cont.eshow = true;		//错误信息框打开
		}else{
			cont.tagname = name;
			cont.eshow = false;		//错误信息框关闭

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
		}
	};

	//输入框失去焦点事件
	$scope.blur = function(){
		//1.0.7版本的blur不行的

		var content = $scope.cont.scontent;

		var val = content.replace(/,/g, ";").replace(/；/g, ";").replace(/，/g, ";").replace(/：/g, ":");

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

		var temptags = new Array();

		//循环拼接明细档
		var tags = $scope.tags;
		for(var i=0;i<tags.length;i++){
			var tag = tags[i];
			for(var j=0;j<tag.length;j++){
				temptags[temptags.length] = tag[j];
			}
		}

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
			window.alert('修改成功');
			$location.path('/');
		});
	};

	//重置方法
	$scope.reset = function(){
		cont.result.length = 0;
		cont.scontent = "";
		cont.tagname = "";
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

//月总额报表视图的控制器
app.controller('MtotalCtrl', ['$scope', '$http', function($scope, $http){

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

			$('#container').highcharts({                   //图表展示容器，与div的id保持一致
		        chart: {
		            type: 'line'                         //指定图表的类型，默认是折线图（line）
		        },
		        title: {
		            text: op + '年度账单统计'      //指定图表标题
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
			var temp = data;

			$('#container').highcharts({                   //图表展示容器，与div的id保持一致
		        chart: {
		            type: 'line'                         //指定图表的类型，默认是折线图（line）
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
	                line: {
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

//月总额报表视图的控制器
app.controller('SortCtrl', ['$scope', '$http', function($scope, $http){

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
		$http.get('/tagsTotal/' + cont.year).success(function(data, status, headers, config){
			var temp = data;

			var x = data.bill.xAxis.split(",");

			$('#container').highcharts({                   //图表展示容器，与div的id保持一致
		        chart: {
		            type: 'column'                         //指定图表的类型，默认是折线图（line）
		        },
		        title: {
		            text: op + '年度分类账单统计'      //指定图表标题
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
	function showMonth(year, name){
		//从服务器获取所有类别事件
		$http.get('/tagTotal/'+year+'/'+name).success(function(data, status, headers, config){
			var temp = data;

			$('#container').highcharts({                   //图表展示容器，与div的id保持一致
		        chart: {
		            type: 'column'                         //指定图表的类型，默认是折线图（line）
		        },
		        title: {
		            text: year + '年' + name + '类账单统计'      //指定图表标题      //指定图表标题
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
		        series: [{                                 //指定数据列
		            name: '消费',                          //数据列名
		            data: eval('(' + data.bill.series + ')')                      //数据
		        }]
		    });
		});
	}
}]);

//添加预算的控制器
app.controller('BudgetCtrl', ['$scope', '$http', function($scope, $http){

	//用于存放数据
	var cont = {
		isava: true
	};

	$scope.cont = cont;

	//把数据写入到数据库
	$http.get('/getBudget').success(function(data, status, headers, config){
		$scope.lists = data.info;
	});

	$scope.submit = function(){

		var data = {budget: cont};

		//把数据写入到数据库
		$http.post('/addBudget', data).success(function(data, status, headers, config){
			window.alert('添加成功');
		});
	};

}]);


