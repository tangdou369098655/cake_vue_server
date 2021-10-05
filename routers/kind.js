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
	var search1=decodeURI(req.query.kid);
	if(!search1){
		res.send('请至少输入一个商品关键字');
		return;
	}else{
	pool.query(`select * from product_details where product_kinds_id=? `,[search1],(err, result) =>{
		if (err) console.log(err);
		var search = result;
		console.log(search);
		res.send(search);
	});}

});
//商品查询
router.get('/new',(req,res)=>{
	var search1=decodeURI(req.query.kid);
	var obj = {
		product:null
	}
	if(!search1){
		res.send('请至少输入一个商品关键字');
		return;
	}else{
	pool.query(`select * from product_details where product_kinds_id=? `,[search1],(err, result) =>{
		if (err) console.log(err);
		var search = result;
		console.log(search);
		obj.product = search
		res.send(obj);
	});}

});
// 获取种类
router.get('/all',(req,res)=>{
	var search1=decodeURI(req.query.kid);
	var obj = {
		product:null
	}
	if(!search1){
		res.send('请至少输入一个商品关键字');
		return;
	}else{
	pool.query(`select * from product_kinds `,(err, result) =>{
		if (err) console.log(err);
		var search = result;
		console.log(search);
		obj.product = search
		res.send(obj);
	});}

});
//导出路由器对象
module.exports=router;

