/**
 * 中文语言包模块
 */

const ACTIVATE_EMAIL_SEND_SUCCESS = '激活链接已发送至您的邮箱，请在24小时内激活；如果收件箱中没有找到，那么请检查垃圾箱。'

module.exports = {
  user: {
    NAME_ERR: '请输入2-15位用户名',
    PHONE_ERR: '请输入正确的手机号码',
    PWD_ERR: '请输入6-18位密码',
    USED: '该用户名已被使用',
    NOT_FOUND: '用户不存在',
    ACCOUNT_ACTIVATE: '用户账号激活',
    PWD_RESET: '用户密码重置',
    PWD_RESET_SUCCESS: '密码重置成功',
    EXIT_SUCCESS: '退出成功',
    NO_SESSION: '用户会话不存在，请先登录',
    REGISTER_SUCCESS: `恭喜你！注册成功，${ACTIVATE_EMAIL_SEND_SUCCESS}`,
    LOGIN_SUCCESS: '登录成功',
    CAPTCHA_ERR: '验证码错误',
    NAME_OR_PWD_ERR: '用户名或密码错误',
    PWD_ERR2: '密码错误'
  },
  email: {
    ACTIVATE_SUBJECT: '用户账号激活',
    SMTP_ERR: '邮件服务器连接错误',
    ADDRESS_ERR: '请输入正确的邮箱地址',
    USED: '该邮箱已被使用',
    EMAIL_OR_PWD_ERR: '邮箱或密码错误',
    CAPTCHA_SEND_SUCCESS: '验证码已发送到您的邮箱，24小时内有效，请查收邮件',
    VERIF_SEND_SUCCESS: '重置链接已发送至您的邮箱，24小时内有效，请查收邮件',
    SEND_SUCCESS: ACTIVATE_EMAIL_SEND_SUCCESS,
    ACTIVATE_SUCCESS: '恭喜你！激活成功',
    ACTIVATE_CODE_INVALID: '激活码无效或已过期',
    NO_ACTIVATE: '很抱歉！你的账号没有通过邮箱激活，必须激活后才可使用；点击激活，系统将发送一封电子邮件到你的登录邮箱，请注意查收。'
  },
  posts: {
    GET_SUCCESS: '获取成功',
    POST_SUCCESS: '提交成功',
    DEL_SUCCESS: '删除成功',
    UPDATE_SUCCESS: '更新成功',
    ADD_SUCCESS: '添加成功',
    PUBLISH_SUCCESS: '发布成功',
    TITLE_EMPTY: '文章标题不能为空',
    TITLE_TOO_LONG: '文章标题不能超过40个字符',
    CONTENT_EMPTY: '文章内容不能为空',
    CONTENT_TOO_LONG: '文章内容不能超过3万个字符'
  },
  base: {
    DB_ERR: '数据库连接错误',
    DB_OPENED: '数据库打开成功',
    DB_CLOSED: '数据库关闭成功',
    CAPTCHA_ERR: '验证码错误',
    SERVER_ERR: '服务器内部错误',
    LINK_INVALID: '该链接已失效',
    SOURCE_NOT_FOUND: ':) 不好意思! 你请求的资源木有找着',
    URL_ERR: '无效的URL地址',
    REQ_INVALID: '无效的请求'
  }
}