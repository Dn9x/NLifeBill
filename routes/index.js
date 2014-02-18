
/*
 * GET home page.
 */


var user = require('./user');

module.exports = function(app){

  app.get('/',function(req,res){
		res.render('login', { title: 'Express' });
	});

	app.get('/login',function(req,res){
		res.render('login', { title: 'Express' });
	});

	app.post('/login',function(req,res){
		//在post请求后的反应
		user.login(req,res);
	});

	app.get('/index',function(req,res){
		res.render('index', { title: 'Express' });
	});

};