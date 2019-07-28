//创建路由器对象
const express=require('express');
//引入连接池模块
const pool=require('../pool.js');
const querystring=require('querystring');
const bodyParser=require('body-parser');
//创建路由器对象
var router=express.Router();
var code200={code:200,msg:'successful'};
var code401={code:401,msg:'this is required,so you cannot leave any of those blank '};
var code403={code:403,msg:'something has wrong'};
//post提交需要三项，引入body-parser 中间件 然后.body
router.use(bodyParser.urlencoded({
	extended:false
}));
//用户注册
router.post('/reg',function(req,res){
	var obj=req.body;
	if(obj.username==''){
		res.send(code401);
		return;
	};
	if(!obj.password){
		res.send(code401);
		return;
	};
	if(!obj.sex){
		res.send(code401);
		return;
	};
	if(!obj.age){
		res.send(code401);
		return;
	};
	pool.query('insert into cake_users set  username=?,password=?,sex=?,age=?',[obj.username,obj.password,obj.sex,obj.age],function(err,result){
		if(err) throw err;
		if(result.affectedRows>0){
			res.send(code200);
		};
		console.log(result);
	});
});

//用户登录--使用手机号
router.post('/login',function(req,res){
	var obj=req.body;
	if ((obj.captcha || '').toLowerCase() !== req.session.captcha) {
		return res.send("4");
	}
	delete req.session.captcha
	//先判断用户名和密码是否为空
	if(!obj.utelephone){
		res.send("3");
		return;
	};
	if(!obj.upassword){
		res.send("3");
		return;
	};
	//执行sql语句
	//查询用户表中是否含有用户名和密码同时匹配的数据
	pool.query('select * from cake_users where utelephone=? and upassword=?',[obj.utelephone,obj.upassword],function(err,result){
		if(err) throw err;
		if(result.length>0){
			req.session.uid=result[0].uid;
			res.send("1")
		}else{
			res.send("2");
			return;
		};
		console.log(result);
	});
});


//用户登录--使用用户名
router.post('/loginname',function(req,res){
	var obj=req.body;
	//先判断用户名和密码是否为空
	if(!obj.uname){
		res.send("3");
		return;
	};
	if(!obj.upassword){
		res.send("3");
		return;
	};
	//执行sql语句
	//查询用户表中是否含有用户名和密码同时匹配的数据
	pool.query('select * from cake_users where username=? and upassword=?',[obj.uname,obj.upassword],function(err,result){
		if(err) throw err;
		if(result.length>0){
			res.send("1")
		}else{
			res.send("2");
			return;
		};
		console.log(result);
	});
});



//--使用用户名查询用户所有信息
//可以使用两个参数uname   utelephone
router.post('/userdetails',function(req,res){
	var obj=req.body;
	//先判断用户名或者手机号是否为空
	if(!obj.uname&&!obj.utelephone){
		res.send("用户名或者手机号不能为空");
		return;
	};

	if(!obj.uname){
	//执行sql语句
	//查询用户表中是否含有用户名匹配的数据
	pool.query('select * from cake_users where username=? ',[obj.uname],function(err,result){
		if(err) throw err;
		if(result.length>0){
			res.send(result)
		}else{
			res.send("没有此用户");
			return;
		};
	});
	}else if(!obj.utelephone){
		//执行sql语句
	//查询用户表中是否含有手机号匹配的数据
	pool.query('select * from cake_users where utelephone=? ',[obj.utelephone],function(err,result){
		if(err) throw err;
		if(result.length>0){
			res.send(result)
		}else{
			res.send("没有此用户");
			return;
		};
	});
	}
	
});

//获取用户信息
router.get('/info',function(req,res){
	var uid=req.session.uid;
	pool.query('select * from cake_users where uid=?',[uid],function(err,result){
		if(err) throw err;
		console.log(result);
		res.send(result[0]);
	});
});

//用户退出
router.post('/logout',function(req,res){
	delete req.session.uid;
	res.send("退出成功")
});
//导出路由器对象
module.exports=router;

