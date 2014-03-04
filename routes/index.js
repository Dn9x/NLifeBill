
/*
 * GET home page.
 */


var user = require('./user');
var bill = require('./bill');

module.exports = function(app){

	//获取某年所有分类报表
	app.get('/getBudgetByMonths/:years/:months', function(req,res){
		bill.getBudgetByMonths(req, res);
	});


	//获取某年所有分类报表
	app.get('/getBudget', function(req,res){
		bill.getBudget(req, res);
	});

	//获取某年所有分类报表
	app.post('/addBudget', function(req,res){
		bill.addBudget(req, res);
	});

	//获取某年所有分类报表
	app.get('/tagTotal/:year/:tagname', function(req,res){
		bill.getTagTotalByYearAndTag(req, res);
	});

	//获取某年所有分类报表
	app.get('/tagsTotal/:year', function(req,res){
		bill.getTagTotalByYear(req, res);
	});

	//获取年
	app.get('/year', function(req,res){
		bill.years(req, res);
	});

	//获取年报表
	app.get('/mTotals/:year/:month', function(req,res){
		bill.getMonthTotalByYear(req, res);
	});

	//获取年报表
	app.get('/yTotals/:year', function(req,res){
		bill.getYearTotalByYear(req, res);
	});

  	app.get('/', function(req,res){
		res.render('login', { title: 'LifeBill', error: null  });
	});

	app.get('/login', function(req,res){
		res.render('login', { title: 'LifeBill', error: null });
	});

	//登录处理
	app.post('/login', function(req,res){
		//在post请求后的反应
		user.login(req, res);
	});

	//获取日历
	app.post('/getRl',function(req,res){
		//在post请求后的反应
		bill.rili(req, res);
	});

	//添加账目数据
	app.post('/addBill',function(req,res){
		//在post请求后的反应
		bill.add(req, res);
	});

	//获取所有分类
	app.get('/getTags',function(req,res){
		//在post请求后的反应
		bill.tags(req, res);
	});

	//根据ID获取账目信息
	app.get('/getBill/:id',function(req,res){
		//在post请求后的反应
		bill.get(req, res);
	});

	//添加账目数据
	app.post('/updBill',function(req,res){
		//在post请求后的反应
		bill.upd(req, res);
	});

	//首页
	app.get('/index', function(req,res){
		res.render('index', {
		    title: '主页',
		    user: req.session.user
		});
	});

	//登出
	app.get('/logout', function(req,res){
		req.session.user = null; 
		res.redirect('/');
	});

	//处理angularjs分部视图
	app.get('/part/:filename', function(req,res){
		var filename = req.params.filename;
		if(!filename) return; // might want to change this
		res.render("part/" + filename);
	});

};