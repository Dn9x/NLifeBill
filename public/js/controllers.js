//整个项目的内容页是单页
var app = angular.module('lbApp', []);

app.config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider){
	//定义路由
	$routeProvider
		.when('/', { templateUrl: 'part/rl', controller: 'rlctrl' })
		.when('/month', { templateUrl: 'part/month', controller: 'monthctrl' })
		.when('/add/:year/:month/:day', { templateUrl: 'part/add', controller: 'addctrl' })
		.when('/upd/:id', { templateUrl: 'part/upd', controller: 'updctrl' })
		.otherwise({ redirectTo: '/' });

}]);

//日历分部视图的控制器
app.controller('rlctrl', ['$scope', '$http', function($scope, $http){

}]);

//添加分部视图的控制器
app.controller('addctrl', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams){
	var params = {
		year: $routeParams.year,
		month: $routeParams.month,
		day: $routeParams.day
	};

	$scope.params = params;

	$http.get('/getTags').success(function(data, status, headers, config){
		$scope.tags = data.tag;
	});

	$scope.show = function(index){
		var name = "SDF";
		$scope.tagname = index;
	}

}]);

//修改分部视图的控制器
app.controller('updctrl', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams){
	var params = {
		id: $routeParams.id
	};

	$scope.params = params;
}]);

//图表分部视图的控制器
app.controller('monthctrl', ['$scope', '$http', function($scope, $http){
	
}]);