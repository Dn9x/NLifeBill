
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

	app.post('/login', function(req,res){
		//在post请求后的反应
		user.login(req, res);
	});

	app.post('/getTotal',function(req,res){
		//在post请求后的反应
		bill.rili(req, res);
	});

	app.get('/index', function(req,res){
		res.render('index', { title: 'Express' });
	});

	app.get('/part/:filename', function(req,res){
		var filename = req.params.filename;
		if(!filename) return; // might want to change this
		res.render("part/" + filename);
	});

};