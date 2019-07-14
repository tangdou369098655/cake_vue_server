//本接口仅供测试使用  

//引入路由模块
const express=require('express');
//创建路由器对象
var router=express.Router();
//引入连接池模块
const pool=require('../pool.js');
const querystring=require('querystring');
// const bodyParser=require('body-parser');
//商品查询
router.get('/',(req,res)=>{
	var search1=decodeURI(req.query.uname);
	if(!search1){
		res.send('必须输入用户名');
		return;
	}else{
	pool.query(`select * from cake_users where username=? `,[search1],(err, result) =>{
		if (err) console.log(err);
		var search = result;
		console.log(search);
		res.send(search);
	});}

});
//导出路由器对象
module.exports=router;

