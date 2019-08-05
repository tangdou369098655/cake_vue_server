//创建路由器对象
const express = require('express');
//引入连接池模块
const pool = require('../pool.js');
//创建路由器对象
var router = express.Router();


//按照用户ID查询用户所有订单
router.get("/orderall", (req, res) => {
	var output = {}
	var uid = req.session.uid;
	if (!uid) {
		res.send({
			code: 0,
			msg: "请登录"
		})
		return;
	}
	var sql = 'select * from orders where user_orders_id=?'
	pool.query(sql, [uid], (err, result) => {
		if (err) next(err);
		output.order = result[0]
		var sq2 = 'select * from orderdetails where nub=?'
		pool.query(sq2, [output.order.nub], (err, result) => {
			if (err) throw err;
			output.detail = result
			res.json({
				code: 1,
				data: output
			})
		})
	})
})

//按照状态码查询订单
router.get("/order", (req, res) => {
	var output = {}
	var status = req.query.status;
	var uid = req.session.uid;
	if (!uid) {
		res.send({
			code: 0,
			msg: "请登录"
		})
		return;
	}
	var sql = 'select * from orders where user_orders_id=? and status=?'
	pool.query(sql, [uid, status], (err, result) => {
		if (err) next(err);
		output.order = result[0]
		var sq2 = 'select * from orderdetails where nub=?'
		pool.query(sq2, [output.order.nub], (err, result) => {
			if (err)  next(err);
			output.detail = result
			if(output.detail){
				return res.json({
					code: 1,
					data: output
				})
			}else{
			return 	res.send('0')
			}
			
		})
	})
})


//导出路由器对象
module.exports = router;