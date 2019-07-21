const svgCaptcha = require('svg-captcha')
const express = require('express')
const router = express.Router()

router.get('/', (req, res) => {
    let captcha = svgCaptcha.create()
    req.session.captcha = captcha.text.toLowerCase()
    res.type('svg').send(captcha.data)
})

module.exports = router