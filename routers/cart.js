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

//查询购物车数据
router.get("/mycart",(req,res)=>{
	var uid=req.session.uid;
	if(!uid){
		res.send({code:0,msg:"请登录"})
		return;
	}
	var sql='select * from cake_cart where uid=?'
	pool.query(sql,[uid],(err,result)=>{
		if(err) throw err;
		res.send({code:1,data:result})
	})
})


//购物车增加数据
router.post('/add',function(req,res){
	var obj=req.body;
	console.log(uid)
	//执行SQL语句，在此之前要连接数据库
	pool.query('insert into cake_cart set ? ',[obj],function(err,result){
		if(err) throw err;
		if(result.affectedRows>0){
		  res.send({code:200,msg:'reg successful'});
		}
		console.log(result);
	});
});

// 删除多个商品
router.get("/del",(req,res)=>{
	var cids=req.query.cids;
	var sql=`delete from cake_cart where c_id IN (${cids})`;
	pool.query(sql,(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send({code:1,msg:"删除成功"})
		}
	})
})

//用户修改购物车数据
router.get('/update',function(req,res){
	var obj=req.query;
	//遍历对象属性，获取所有的属性
	var n=400;
	for(var key in obj){
		n++;
	  if(!obj[key]){
		  res.send({code: n ,msg:key +' required'});
		  return 
	  }
	};
	pool.query('update cake_cart set c_id=?,count=? where uid=?',[
		obj.c_id,
		obj.count,
		obj.uid],
		function(err,result){
			if(err){throw err};
			if(result.affectedRows>0){
			  res.send({code:200,msg:'update suc'});
			}else {res.send({code:301,mag:'update err'})};
			console.log(result);
	});	
});

//导出路由器对象
module.exports=router;

