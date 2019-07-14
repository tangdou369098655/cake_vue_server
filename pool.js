const mysql=require('mysql');
//创建连接池对象
var pool=mysql.createPool({
	host:'localhost',
	port:'3306',
	user:'root',
	password:'',
	database:'cake',
	connectionLimit:20
});
//到处连接池对象
module.exports=pool;
