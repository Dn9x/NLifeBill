
/*
 * GET home page.
 */


var user = require('./user');
var bill = require('./bill');

module.exports = function(app){

  	app.get('/', function(req,res){
		res.render('login', { title: 'Express' });
	});

	app.get('/login', function(req,res){
		res.render('login', { title: 'Express' });
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

	//首页
	app.get('/index', function(req,res){
		res.render('index', { title: 'Express' });
	});

	//处理angularjs分部视图
	app.get('/part/:filename', function(req,res){
		var filename = req.params.filename;
		if(!filename) return; // might want to change this
		res.render("part/" + filename);
	});

};