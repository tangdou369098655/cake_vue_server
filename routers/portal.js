//创建路由器对象
const express = require('express');
const { checkAuth } = require('../middleware')
//引入连接池模块
const pool = require('../pool.js');
//创建路由器对象
var router = express.Router();

function toPromise () {
	return new Promise((resolve, reject) => {
		pool.query(...arguments, (err, result) => {
			if (err) return reject(err)
			resolve(result)
		})
	})
}


//按照用户ID查询用户所有订单
router.get("/orderall", checkAuth, async (req, res) => {
	var output = {}
	var uid = req.session.uid
	var sql = 'select * from orders where user_orders_id=?'
	var sq2 = 'select * from orderdetails where nub=?'
	let result = await toPromise(sql, [uid])
	output.order = result[0]
	if(output.order){
		let result2 = await toPromise(sq2, [output.order.nub])
		output.detail = result2
		res.json({
			code: 1,
			data: output
		})
	}else{
		return res.send('0')
	}
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
		if(output.order){
			var sq2 = 'select * from orderdetails where nub=?'
			pool.query(sq2, [output.order.nub], (err, result) => {
				if (err)  next(err);
				output.detail = result
					res.json({
						code: 1,
						data: output
					})
				
			})
		}else{
			return res.send('0')
		}
	
	})
})


//导出路由器对象
module.exports = router;