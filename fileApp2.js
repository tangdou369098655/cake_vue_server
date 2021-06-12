// 上传文件支持utf-8以及另存到file文件夹里+带进度条
// 传文件好用版本2021-6-5，新增二进制文件下载办法
// 使用方法如下
// http://10.100.100.100:3002/getData?fileType=2&fileName=test01.txt
// http://10.100.100.100:3002/getData?fileType=2&fileName=2000.jpg
var express = require('express');
var path = require('path');
var fs = require('fs');
var app = express();
var bodyParser = require('body-parser');	// 过滤请求头部相应格式的body
var multer = require('multer');
var chalk = require('chalk');	// 只是一个 cli 界面字体颜色包而已
var log = console.log.bind(console);

const cors=require('cors');
//跨域请求cors
app.use(cors
  (
    {
  origin:"*" ,
  // origin:"http://localhost:8080" ,
  // origin:"http://10.100.100.100:4200" ,
  // origin:"http://10.100.100.100:5502" ,
  credentials: true
}
)
);
app.use(express.static('static'));
// 接受 application/json 格式的过滤器
var jsonParser = bodyParser.json()
// 接受 application/x-www-form-urlencoded 格式的过滤器
var urlencodedParser = bodyParser.urlencoded({ extended: false })
// 接受 text/html 格式的过滤器
var textParser = bodyParser.text()

// 自定义 multer 的 diskStorage 的存储目录与文件名
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/file-server/files') // 注意一下这里，这个是设置上传到哪个文件夹的哦~~
  },
  filename: function (req, file, cb) {
    cb(null, file.fieldname)
  }
})

var upload = multer({ storage: storage })

// 页面渲染
app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, 'view/upload.html'));
})
app.get('/getFile', function (req, res) {
  var readDir = fs.readdirSync("public/file-server/files");
  console.log('读取了文件', readDir);
  const obj = {
    data: readDir,
    msg: "Query Success!",
    status: "Success"
  }
  res.send(obj)
})
app.post('/test', textParser, jsonParser, function (req, res) {
  log(req.body);
  var httpInfo = http.address();
  res.send({
    host: httpInfo.address,
    port: httpInfo.port
  })
})


// 对应前端的上传接口 http://127.0.0.1:3000/upload, upload.any() 过滤时不对文件列表格式做任何特殊处理
app.post('/upload', upload.any(), function (req, res) {
  log(req.files)
  res.send({message: '上传成功'})
})
/* GET home page. */
app.get('/getData', function(req, res, next) {
  console.log('调用了这个接口getData')
  console.log(req.query)
  var fileType = req.query.fileType;
  var fileName = req.query.fileName;

  if (fileType == 1) {
      //直接访问文件进行下载
      res.redirect(fileName);
  } else if (fileType == 2) {
      //以文件流的形式下载文件
      var filePath = path.join(__dirname, './public/file-server/files/' + fileName);
      var stats = fs.statSync(filePath);
      var isFile = stats.isFile();
      if(isFile){
          res.set({
              'Content-Type': 'application/octet-stream', //告诉浏览器这是一个二进制文件
              'Content-Disposition': 'attachment; filename=' + encodeURIComponent(fileName), //告诉浏览器这是一个需要下载的文件,之所以使用这个，是为了避免下载中文名字的文件出问题
              // 'Content-Disposition': 'attachment; filename=' + fileName, //告诉浏览器这是一个需要下载的文件
              'Content-Length': stats.size  //文件大小
          });
          fs.createReadStream(filePath).pipe(res);
      } else {
          res.end(404);
      }
  } else if (fileType == 3) {
      //读取文件内容后再响应给页面
      var filePath = path.join(__dirname, './public/file-server/files/' + fileName);
      var stats = fs.statSync(filePath);
      var isFile = stats.isFile();
      if (isFile) {
          fs.readFile(filePath, function(isErr, data){
              if (isErr) {
                  res.end("Read file failed!");
                  return;
              }
              res.set({
                  'Content-Type': 'application/octet-stream', //告诉浏览器这是一个二进制文件
                  'Content-Disposition': 'attachment; filename=' + fileName, //告诉浏览器这是一个需要下载的文件
                  'Content-Length': stats.size  //文件大小
              });
              res.end(data)
          })
      } else {
          res.end(404);
      }
  } else {
      res.end(404);
}
});
// 监控 web 服务
var http = app.listen(3002, '10.100.100.100', function () {
  var httpInfo = http.address();
  log(`创建服务${chalk.green(httpInfo.address)}:${chalk.yellow(httpInfo.port)}成功`)
})

