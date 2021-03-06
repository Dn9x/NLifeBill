var process = require('child_process');
var fs = require('fs');
var os = require('os');
var nodemailer = require("nodemailer");

var Backup = {};

module.exports = Backup;

Backup.send = function() {
	var date = new Date();

	var time = date.getFullYear() + "" + (date.getMonth() + 1) + "" + date.getDate() + date.getHours() + "" + date.getMinutes() + "" + date.getSeconds();


		var file = __dirname + "/../bak/lb" + time + ".sql"

	var shell = "mysqldump -u root -p1234 lifebill > " + file;

	process.exec(shell, function(error, stdout, stderr) {
		// console.log("error: " + error);
		//    console.log('stdout: ' + stdout);
		//    console.log('stderr: ' + stderr);

		var shell = "chmod 777 " + file;
		console.log("shell: " + shell);

		process.exec(shell, function(error, stdout, stderr) {
			console.log('stdout: ' + stdout);
			console.log('stderr: ' + stderr);
			if (error !== null) {
				console.log('exec error: ' + error);
			}

			console.log(time + "：已经备份成功");

			upload(file);
		});
	});
}

// fs.watch('bak', function (event, filename) {

// 	//判断事件，一般新增文件会触发两次，一次是rename,一次是change
// 	if(event == 'change'){
// 		if (filename) {
// 		    console.log('filename provided: ' + filename);
// 		    upload(filename);
// 		} else {
// 		    console.log('filename not provided');
// 		}
// 	}

// });

function upload(filename) {

	var date = new Date();
	var time = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes();

	//获取地址信息
	var address = os.networkInterfaces();
	var totalmem = os.totalmem();
	var freemem = os.freemem();

	var msg = "<p>总内存量：" + totalmem + "</p><p>空闲内存量：" + freemem + "</p><p>地址信息：<pre>" +
		JSON.stringify(address) + "</pre></p>";

	// create reusable transport method (opens pool of SMTP connections)
	var smtpTransport = nodemailer.createTransport("SMTP", {
		service: "QQ",
		auth: {
			user: "171373243@qq.com",
			pass: "307zhanghanyun"
		}
	});


	// setup e-mail data with unicode symbols
	var mailOptions = {
		from: "171373243@qq.com", // sender address
		to: "xiuxu123@live.cn, 932578775@qq.com", // list of receivers
		subject: "LifeBill备份：" + time, // Subject line
		text: "LifeBill备份" + time, // plaintext body
		html: msg, // html body
		attachments: [{ // stream as an attachment
			fileName: filename,
			streamSource: fs.createReadStream(filename)
		}]
	}

	// send mail with defined transport object
	smtpTransport.sendMail(mailOptions, function(error, response) {
		if (error) {
			console.log(error);
		} else {
			console.log("Message sent: " + response.message);
		}
	});

}