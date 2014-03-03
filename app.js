
/**
 * Module dependencies.
 */

var express = require('express');
var routes = require('./routes');
var http = require('http');
var path = require('path');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'html');
app.engine('.html', require('ejs').__express);
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.cookieParser());
app.use(express.session({secret: 'lifebill'}));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(express.static(path.join(__dirname, 'public')));
app.use(function(req, res, next){
	if(req.originalUrl == '/' || req.originalUrl == '/login'){
		next();
	}else{
		var user = req.session.user;
		if(!user){
			return res.redirect('/');
		}else{
			next();
		}
	}
});
app.use(app.router);

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});

routes(app);