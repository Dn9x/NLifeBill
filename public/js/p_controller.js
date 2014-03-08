//整个项目的内容页是单页
var app = angular.module('pApp', ['ngRoute']);

app.config(['$routeProvider', function($routeProvider){
	//定义路由
	$routeProvider
		.when('/', { templateUrl: 'part/p_rl', controller: 'RlCtrl' })
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