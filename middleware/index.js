const i18n=require('../i18n')
module.exports={
    checkAuth(req,res,next){
        console.log(req.session)
        if(req.session.uid){
            next()
        }else{
            res.status(401).send(i18n.user.NO_SESSION)
        }
    }
}