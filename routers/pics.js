const express = require("express");
const router = express.Router();
const pool = require("../pool");

//需要查询多个数据表格
router.get("/", (req, res) => {
  var pid = req.query.pid;
  var output = {
    pics: {}
  }
  if (pid !== undefined) {
    var sql2 = `select * from product_pic where prcid=?`
    pool.query(sql2, [pid], (err, result) => {
          if (err) console.log(err);
          output.pics = result;
          console.log(output);
          console.log("haha2");
          res.send(output);
        })
  }else{
    res.send(output);
    console.log(444)
  }
})

module.exports = router;
