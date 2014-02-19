//整个项目的内容页是单页
var app = angular.module('lbApp', []);

app.config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider){
	//定义路由
	$routeProvider
		.when('/', { templateUrl: 'part/rl', controller: 'rlctrl' })
		.when('/month', { templateUrl: 'part/month', controller: 'monthctrl' })
		.otherwise({ redirectTo: '/' });

}]);

//日历分部视图的控制器
app.controller('rlctrl', ['$scope', '$http', function($scope, $http){

}]);

//图表分部视图的控制器
app.controller('monthctrl', ['$scope', '$http', function($scope, $http){
	
}]);