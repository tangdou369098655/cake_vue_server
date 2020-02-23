const express = require("express");
const router = express.Router();
const pool = require("../pool");

//一次查询返回4条数据
router.get("/", (req, res) => {
  var status = req.query.status;
  var output = {
    product: {}
  }
  if (status !== undefined) {
    var sql1 = `select * from cake_index_product where index_status=?`;
    pool.query(sql1, [status], (err, result) => {
      if (err) console.log(err);
      output.product = result;
      // console.log(output);
      // console.log("haha1");
          res.send(output);
      })
    
  }else{
    res.send(output);
    console.log(444)
  }
})

//一次查询返回多条数据
router.get("/insale", (req, res) => {
  var status = req.query.insale;
  var output = {
    product: {}
  }
  if (status !== undefined) {
    var sql1 = `select * from cake_index_product where index_sale_new=?`;
    pool.query(sql1, [status], (err, result) => {
      if (err) console.log(err);
      output.product = result;
          res.send(output);
      })
    
  }else{
    res.send(output);
    // console.log(444)
  }
})
//首页产品一次性展示+轮播图查询
router.get("/all", (req, res) => {
  var output = {
    carouselItems:{},
    product: {},
    pics:{},
    kinds:{}
  }
    var sql1 = `select * from index_img `;
    pool.query(sql1,(err, result) => {
      if (err) console.log(err);
      output.carouselItems = result;
      var sql2 = `select * from cake_index_product `;
      pool.query(sql2,(err, result) => {
      if (err) console.log(err);
      output.product = result;
      
      var sql3 = `select * from product_pic `;
      pool.query(sql3,(err, result) => {
      if (err) console.log(err);
      output.pics = result;

      var sql4 = `select * from product_kinds `;
      pool.query(sql4,(err, result) => {
      if (err) console.log(err);
      output.kinds = result;
          res.send(output);
      })
      })})
      })
})
// 測試接口員工健康掃碼
router.post("/scan/collect", (req, res) => {
  console.log('wolaila11')
  let emp_no = req.body.emp_no;
  let emp_name = req.body.emp_name;
  let card_time = req.body.card_time;
  let qrcode = req.body.qrcode;
  var output = {
    error:0,
    message:'success'
  }
  var err = {
    error:1,
    message:'參數有誤或者缺失參數'
  }
  
  if(emp_no&&emp_name&&card_time&&qrcode){
    res.send(output);
  }else{
    res.send(err);
  }
    
})
// 測試接口員工健康掃碼
//一次查询返回多条数据post
router.post("/postStatus", (req, res) => {
  console.log('wolaila')
  var status = req.body.status;
  var output = {
    product: {},
    lalala:'woshiceshi'
  }
  if (status !== undefined) {
    var sql1 = `select * from cake_index_product where index_sale_new=?`;
    pool.query(sql1, [status], (err, result) => {
      if (err) console.log(err);
      output.product = result;
          res.send(output);
      })
    
  }else{
    res.send(output);
    // console.log(444)
  }
})

//首页产品轮播图查询
router.get("/img", (req, res) => {
  var output = {
    carouselItems:{}
  }
    var sql1 = `select * from index_img `;
    pool.query(sql1,(err, result) => {
      if (err) console.log(err);
      output.carouselItems = result;
          res.send(output);
      })
})
module.exports = router;
