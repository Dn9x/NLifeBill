
/*
 * GET users listing.
 */

var crypto = require('crypto');
var Users = require('../models/users');

var user={};
module.exports = user;

user.login=function(req,res){
	console.log(req.body.login);

	//查找用户
	Users.getUser(req.body.login, function(err, user){ 
		if(user.length > 0){ 
			//对密码进行加密操作 
			var md5 = crypto.createHash('md5'); 
			var password = md5.update(req.body.password).digest('hex'); 

			//如果存在，就返回用户的所有信息，取出password来和post过来的password比较
			if(user[0].pswd == password){ 
				res.render('login', {
				    title: '登录',
				    error: '密码不正确'
				});
			}else{ 
				req.session.user = user[0];  
				res.render('index', {
				    title: '主页',
				    user: req.session.user
				});
			} 
		}else{ 
			res.render('login', {
			    title: '登录',
			    error: '用户不存在'
			});
		} 
	}); 
};