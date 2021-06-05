// 新版本接口服务
const express=require('express');
// const bodyParser=require('body-parser');
const session = require('express-session')
var MySQLStore = require('express-mysql-session')(session);
 
var options = {
    host: '10.100.100.100',
    port: 3306,
    user: 'root',
    password: 'root',
    database: 'cake'
};
 
var sessionStore = new MySQLStore(options);

//引入路由模块
const cors=require('cors');
// const index=require("./routes/index");
const userRouter=require('./routers/user.js');
const cartRouter=require('./routers/cart.js');
const details=require('./routers/detail.js');
const product=require('./routers/product');
const index=require('./routers/index');
const pics=require('./routers/pics');
const login=require('./routers/login');//本接口仅供测试使用  
const find=require('./routers/find');
const kind=require('./routers/kind');
const captcha=require('./routers/captcha');
const portal=require('./routers/portal');
const test = require('./routers/test')
const haha = require('./routers/haha')

//创建web服务器
var server=express();

// server.all('*', function(req, res, next) {
//   console.log(req.headers.origin)
//   console.log(req.environ)
//   res.header("Access-Control-Allow-Origin", req.headers.origin);
//   // res.header("Access-Control-Allow-Origin", '*');
//   res.header("Access-Control-Allow-Headers", "Content-Type,Content-Length, Authorization, Accept,X-Requested-With");
//   res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
//   res.header("Access-Control-Allow-Credentials","true");
//   res.header("X-Powered-By",' 3.2.1')
//   if(req.method === "OPTIONS") res.send(200);/*让options请求快速返回*/
//   else  next();
// });
 
//托管静态资源到public下；
server.use(express.static('public'));
//跨域请求cors
server.use(cors
  (
    {
  origin:"*" ,
  // origin:"http://localhost:8080" ,
  // origin:"http://10.100.100.100:4200" ,
  // origin:"http://10.100.100.100:8080" ,
  // origin:"http://127.0.0.1:5500" ,
  credentials: true
}
)
);

// server.writeHead(200,{"Access-Control-Allow-Credentials":true});
server.use(express.json())
server.use(express.urlencoded({
  extended:false
}));

//session 启用会话中间件，用来保存用户登录状态以及验证码
server.use(session({
  name: 'sessioqqqqqq',
  resave: true,
  saveUninitialized: true,
  secret: 'APP_SESSION_SECRET',
  store: sessionStore // 将会话存到数据库
}))






server.use('/user',userRouter);
server.use('/cart',cartRouter);
server.use('/test',test);
server.use('/product',product);
server.use('/details',details);
server.use('/index',index);
server.use('/pics',pics);
server.use('/login',login);//本接口仅供测试使用  
server.use('/find',find);
server.use('/kind',kind);
server.use('/captcha',captcha);
server.use('/portal',portal);
server.use('/test',test);
server.use('/tossService',toss);

server.use((req, res, next) => {
  res.status(404).send('404 not found')
})

// 异常处理器
server.use((req,res,next,err)=>{
  console.log('err.message')
  console.log(err)
  console.log(err.message)
  // res.send(500);
})

server.listen(3000, '10.100.100.100');
console.log('啟動啦3000')
