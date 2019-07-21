const express=require('express');
const bodyParser=require('body-parser');
const session = require('express-session')

//引入路由模块
const cors=require('cors');
// const index=require("./routes/index");
const userRouter=require('./routers/user.js');
const details=require('./routers/detail.js');
const product=require('./routers/product');
const index=require('./routers/index');
const pics=require('./routers/pics');
const login=require('./routers/login');//本接口仅供测试使用  
const find=require('./routers/find');
const kind=require('./routers/kind');
const captcha=require('./routers/captcha');

//创建web服务器
var server=express();
//托管静态资源到public下；
server.use(express.static('public'));
//跨域请求cors
server.use(cors
  (
    {
  origin:"*" ,
  origin:"http://localhost:8080" ,
  // origin:"http://127.0.0.1:5501" ,
  credentials: true
}
)
);
// server.writeHead(200,{"Access-Control-Allow-Credentials":true});
server.use(express.json())
server.use(bodyParser.urlencoded({
  extended:false
}));
server.use(session({
  name: 'sessionId',
  resave: false,
  saveUninitialized: false,
  secret: 'APP_SESSION_SECRET',
  // store: new MongoStore({ mongooseConnection: mongoose.connection }) // 将会话存到数据库
}))






server.use('/user',userRouter);

server.use('/product',product);
server.use('/details',details);
server.use('/index',index);
server.use('/pics',pics);
server.use('/login',login);//本接口仅供测试使用  
server.use('/find',find);
server.use('/kind',kind);
server.use('/captcha',captcha);
server.listen(3000);
