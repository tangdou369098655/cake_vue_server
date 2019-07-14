const express = require("express");
const router = express.Router();
const pool = require("../pool");

//需要查询多个数据表格
router.get('/',(req,res)=>{
	var search1=decodeURI(req.query.search_product);
	// search1=search1.split("");
	search1 = search1.replace(/\"/g, "");
	search1 = search1.replace(/'/g, "");
console.log(search1);
	if(!search1){
		res.send('请至少输入一个商品关键字');
		return;
	}else{
  var output = {
    list:[],
  }
//开始
function getlist(){
  return new Promise(function(door){
    var sql0=`select * from product_details where advertisement LIKE ? `;
    pool.query(sql0,[`%${search1}%`],(err,result)=>{
      if (err) console.log(err)
      output.list=result;
      var list1=output.list;
      door();
  })})}

getlist()
.then(function(){res.send(output)})
} 
})

module.exports = router;
