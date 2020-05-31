const express=require('express');
// const bodyParser=require('body-parser');
const session = require('express-session')
var MySQLStore = require('express-mysql-session')(session);
 
var options = {
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
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

//创建web服务器
var server=express();
//托管静态资源到public下；
server.use(express.static('public'));
server.use(express.static('dist'));
//跨域请求cors
server.use(cors
  (
    {
  // origin:"*" ,
  origin:"http://localhost:9528" ,
  // origin:"http://localhost:4200" ,
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
  name: 'sessionId',
  resave: true,
  saveUninitialized: true,
  secret: 'APP_SESSION_SECRET',
  store: sessionStore // 将会话存到数据库
}))

server.use('/api/user',userRouter);
server.use('/api/cart',cartRouter);

server.use('/api/product',product);
server.use('/api/details',details);
server.use('/api/index',index);
server.use('/api/pics',pics);
// server.use('/api/login',login);本接口仅供测试使用  
server.use('/api/find',find);
server.use('/api/kind',kind);
server.use('/api/captcha',captcha);
server.use('/api/portal',portal);

server.get('*', (req, res) => {
  res.sendFile(__dirname + '/dist/index.html')
})

// 异常处理器
server.use((req,res,next,err)=>{
  console.log(err.message)
  res.sendStatus(500);
})

server.listen(3000);
