
/*
 * GET users listing.
 */

var Users = require('../models/users');

var user={};
module.exports = user;

user.login=function(req,res){
	console.log(req.body.login);

	//查找用户
	Users.getUser(req.body.login, function(err, user){ 
		if(user.length > 0){ 
			//如果存在，就返回用户的所有信息，取出password来和post过来的password比较
			if(user[0].pswd == req.body.password){ 
				req.flash('error','密码不正确');
				res.redirect('/login'); 
			}else{ 
				req.session.user = user[0]; 
				res.redirect('/index'); 
			} 
		}else{ 
			req.flash('error','用户不存在'); 
			res.redirect('/login'); 
		} 
	}); 
};