const express = require("express");
const router = express.Router();
const pool = require("../pool");

//需要查询多个数据表格
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
      console.log(output);
      console.log("haha1");
          res.send(output);
      })
    
  }else{
    res.send(output);
    console.log(444)
  }
})

module.exports = router;
