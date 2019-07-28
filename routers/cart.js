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

//购物车增加数据
router.post('/add',function(req,res){
	var obj=req.body;
	//遍历对象属性，获取所有的属性
	var n=400;
	for(var key in obj){
		n++;
	  if(!obj[key]){
		  res.send({code: n ,msg:key +' required'});
		  return 
	  }
	};
	//执行SQL语句，在此之前要连接数据库
	pool.query('insert into cake_cart set ? ',[obj],function(err,result){
		if(err) throw err;
		if(result.affectedRows>0){
		  res.send({code:200,msg:'reg successful'});
		}
		console.log(result);
	});
});



//导出路由器对象
module.exports=router;

