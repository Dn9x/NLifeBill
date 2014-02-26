//整个项目的内容页是单页
var app = angular.module('lbApp', ['ngRoute']);

app.config(['$routeProvider', function($routeProvider){
	//定义路由
	$routeProvider
		.when('/', { templateUrl: 'part/rl', controller: 'rlctrl' })
		.when('/add/:year/:month/:day', { templateUrl: 'part/add', controller: 'addctrl' })
		.when('/upd/:id', { templateUrl: 'part/upd', controller: 'updctrl' })
		.when('/mtotal', { templateUrl: 'part/mtotal', controller: 'mtotalctrl' })
		.when('/msort', { templateUrl: 'part/msort', controller: 'msortctrl' })
		.when('/quarter', { templateUrl: 'part/quarter', controller: 'quarterctrl' })
		.when('/week', { templateUrl: 'part/week', controller: 'weekctrl' })
		.when('/sort', { templateUrl: 'part/sort', controller: 'sortctrl' })
		.otherwise({ redirectTo: '/' });

}]);

//日历分部视图的控制器
app.controller('rlctrl', ['$scope', '$http', function($scope, $http){

}]);

//添加分部视图的控制器
app.controller('addctrl', ['$scope', '$http', '$routeParams', '$location', function($scope, $http, $routeParams, $location){
	var params = {
		year: $routeParams.year,
		month: $routeParams.month,
		day: $routeParams.day
	};

	$scope.params = params;

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
app.controller('updctrl', ['$scope', '$http', '$routeParams', '$location', function($scope, $http, $routeParams, $location){
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

	var data = {id: params.id};

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

//图表分部视图的控制器
app.controller('monthctrl', ['$scope', '$http', function($scope, $http){
	
}]);


