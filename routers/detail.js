const express = require("express");
const router = express.Router();
const pool = require("../pool");

//需要查询多个数据表格
router.get("/", (req, res) => {
  var product_id = req.query.product_id;
  var output = {
    product: {},
    kinds:{},
    pics: []
  }
  if (product_id !== undefined) {
    var sql1 = `select * from product_details where product_id=?`;
    pool.query(sql1, [product_id], (err, result) => {
      if (err) console.log(err);
      output.product = result[0];
      console.log(output);
      console.log("haha1");


    var family_id = output.product["product_kinds_id"];
    var sql3 = `select * from product_kinds where pid=?`;
    pool.query(sql3, [family_id], (err, result) => {
        if (err) console.log(err);
        output.kinds = result[0];
        console.log(output);

      


    var sql2 = `select * from product_pic where prcid=?`
    pool.query(sql2, [product_id], (err, result) => {
          if (err) console.log(err);
          output.pics = result[0];
          console.log(output);
          console.log("haha2");
          res.send(output);
        })
      })
    })
  }else{
    res.send(output);
  }
})

module.exports = router;
