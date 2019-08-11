//创建路由器对象
const express = require('express');
//引入连接池模块
const pool = require('../pool.js');
const i18n = require('../i18n')
const { checkAuth }=require('../middleware')
//创建路由器对象
var router = express.Router();

//查询购物车数据
router.get("/mycart", checkAuth, (req, res) => {
	var uid = req.session.uid;
	var sql = 'select * from cake_cart where user_id=?'
	pool.query(sql, [uid], (err, result) => {
		if (err) throw err;
		res.json({
			info: i18n.posts.GET_SUCCESS,
			data: result
		})
		// res.send()
	})
})


//购物车增加数据
router.post('/add', checkAuth,function (req, res) {
	var obj = req.body;
	obj.user_id = req.session.uid;
	console.log(obj)
	console.log(uid)
	//执行SQL语句，在此之前要连接数据库
	pool.query('insert into cake_cart set ? ', [obj], function (err, result) {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({
				code: 200,
				msg: 'reg successful'
			});
		}
		console.log(result);
	});
});

//添加购物车
router.post("/adds",checkAuth, (req, res) => {
	var obj = req.body;
	var kinds;
	var img;
	var sql = `insert into cake_cart set user_id=?,p_id=?,sizes=?,product_kinds_name=?,cake_name=?,price=?,count=?,other_one=?`;
	var uid = req.session.uid;
	// 查询商品补全购物车信息
	pool.query('select * from product_details  where   product_id=?', [obj.p_id], (err, result) => {
		if (err) throw err;
		kinds = result[0].product_kinds_name;
		img = result[0].img;
		// 执行购物车操作
		pool.query('select * from cake_cart where  p_id=? and user_id=? and sizes=?', [obj.p_id, uid, obj.sizes], (err, result) => {
			if (err) throw err;
			if (result.length >= 1) {
				var c_id = result[0].c_id;
				let count = result[0].count;
				count += obj.count;
				pool.query('update cake_cart set count=?  where  c_id=? and user_id=? and sizes=?', [count, c_id, uid, obj.sizes], (err, result) => {
					if (err) throw err;
					if (result.affectedRows >= 1) {
						res.send({
							code: 1
						});
					} else {
						res.send({
							code: 0
						});
					}
				})
			} else {
				pool.query(sql, [uid, obj.p_id, obj.sizes, kinds, obj.cake_name, obj.price, obj.count, img], (err, result) => {
					if (err) throw err;
					if (result.affectedRows >= 1) {
						res.send({
							code: 1
						});
					} else {
						res.send({
							code: 0
						});
					}
				})
			}
		})
	})
})



// 删除多个商品
router.post("/del",checkAuth, (req, res) => {
	var cids = req.body.cids;
	var sql = `delete from cake_cart where c_id IN (${cids})`;
	pool.query(sql, (err, result) => {
		if (err) throw err;
		if (result.affectedRows > 0) {
			res.send({
				code: 1,
				msg: "删除成功"
			})
		}
	})
})

//用户修改购物车数据
router.post('/update',checkAuth, function (req, res) {
	var obj = req.body;
	var uid = req.session.uid;
	if (!uid) {
		return res.sendStatus(401)
	}
	//遍历对象属性，获取所有的属性
	var n = 400;
	for (var key in obj) {
		n++;
		if (!obj[key]) {
			res.send({
				code: n,
				msg: key + ' required'
			});
			return
		}
	};
	pool.query('update cake_cart set count=? where c_id=? ', [
			obj.count,
			obj.c_id,
		],
		function (err, result) {
			if (err) {
				throw err
			};
			if (result.affectedRows > 0) {
				res.send({
					code: 200,
					msg: 'update suc'
				});
			} else {
				res.send({
					code: 301,
					mag: 'update err'
				})
			};
			console.log(result);
		});
});

//导出路由器对象
module.exports = router;