module.exports = (req,res,list) => {
  if (!req.body) {
     res.status(400).send({
      message: "Content can not be empty!",
    });
    return true;
  }else if(list){
    for (const key in list) {
      if (!list[key]) {
         res.status(400).send({
          message: "The data is null!",
        });
        return true;
      }
    }
  }
};
