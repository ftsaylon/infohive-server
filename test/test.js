var chai = require('chai');
var chaiHttp = require('chai-http');
// var server = require('../server');
var server = "http://localhost:3001"
var should = chai.should();
var expect = chai.expect;
chai.use(chaiHttp);


//Test Home
describe("Home Page",function(){
  it("should return home page",function(done){

    // calling home page api
    chai.request(server)
      .get("/")
      .end(function(err,res){
        // HTTP status should be 400
        res.body.should.have.property('message');
        res.body.should.have.property('result');
        res.should.have.header("Content-type",/json/)
        res.should.have.status(400);
        done();
    });
  });

});


//Test Product

  //All Products

describe("getProducts",function(){
  it("should return all products",function(done){
    chai.request(server)
      .get('/product')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(element => {
          element.should.be.a('object')
          element.should.have.property('id');
          element.should.have.property('category_id');
          element.should.have.property('name');
          element.should.have.property('description');
          element.should.have.property('distributorId');
          element.should.have.property('contactId');
          element.should.have.property('price');
          element.should.have.property('stock');
          element.should.have.property('size');
          element.should.have.property('imageUrl');
          element.should.have.property('siteUrl');
          element.should.have.property('created');
          element.should.have.property('updated');
          element.should.have.property('category');
          element.should.have.property('distributorName');
          element.should.have.property('distributorAddress');
          element.should.have.property('distributorPhone');
          element.should.have.property('distributorAddress');
          element.should.have.property('distributorWebUrl');
          element.should.have.property('contactName');
          element.should.have.property('contactAddress');
          element.should.have.property('contactPhone');
          element.should.have.property('contactAddress');
          element.should.have.property('contactWebUrl');
        });
        done();
     })
  })
});

  //All Products Individual

describe("getProducts indvidually",function(){
  it("should return all products individually",function(done){
    chai.request(server)
      .get('/product')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(element => {
          chai.request(server)
            .get(`/product/${element.id}`)
            .end(
              function(err2,res2){
                res2.body.should.be.a('object')
                res2.body.result[0].should.have.property('id');
                res2.body.result[0].should.have.property('category_id');
                res2.body.result[0].should.have.property('name');
                res2.body.result[0].should.have.property('description');
                res2.body.result[0].should.have.property('distributorId');
                res2.body.result[0].should.have.property('contactId');
                res2.body.result[0].should.have.property('price');
                res2.body.result[0].should.have.property('stock');
                res2.body.result[0].should.have.property('size');
                res2.body.result[0].should.have.property('imageUrl');
                res2.body.result[0].should.have.property('siteUrl');
                res2.body.result[0].should.have.property('created');
                res2.body.result[0].should.have.property('updated');
                res2.body.result[0].should.have.property('category');
                res2.body.result[0].should.have.property('distributorName');
                res2.body.result[0].should.have.property('distributorAddress');
                res2.body.result[0].should.have.property('distributorPhone');
                res2.body.result[0].should.have.property('distributorAddress');
                res2.body.result[0].should.have.property('distributorWebUrl');
                res2.body.result[0].should.have.property('contactName');
                res2.body.result[0].should.have.property('contactAddress');
                res2.body.result[0].should.have.property('contactPhone');
                res2.body.result[0].should.have.property('contactAddress');
                res2.body.result[0].should.have.property('contactWebUrl');      
              }
            )
        });
        done();
     })
  })
});

  //Search Product using single letters

describe("get searched products",function(){
  it("should return all products w/ product_name like %search% ",function(done){
    var alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('');
    alphabet.forEach(
      function(letter){
        chai.request(server)
        .get(`/product/search?searchKey=${letter}`)
        .end(function(err, res){
          res.should.have.header("Content-type",/json/)
          res.status.should.equal(200);
          res.body.should.be.a('array');
          res.body.forEach(element => {
                  element.should.be.a('object')
                  element.should.have.property('id');
                  element.should.have.property('category_id');
                  element.should.have.property('name');
                  element.should.have.property('description');
                  element.should.have.property('distributorId');
                  element.should.have.property('contactId');
                  element.should.have.property('price');
                  element.should.have.property('stock');
                  element.should.have.property('size');
                  element.should.have.property('imageUrl');
                  element.should.have.property('siteUrl');
                  element.should.have.property('created');
                  element.should.have.property('updated');
                  element.should.have.property('category');
                  element.should.have.property('distributorName');
                  element.should.have.property('distributorAddress');
                  element.should.have.property('distributorPhone');
                  element.should.have.property('distributorAddress');
                  element.should.have.property('distributorWebUrl');
                  element.should.have.property('contactName');
                  element.should.have.property('contactAddress');
                  element.should.have.property('contactPhone');
                  element.should.have.property('contactAddress');
                  element.should.have.property('contactWebUrl');      
                }
          )
        });  
      }
    );
    done();
  })
});
  
// Test Category
  
  //All Categories

describe("getCategory",function(){
  it("should return all categories, category id",function(done){
    chai.request(server)
      .get('/category')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(element => {
          element.should.have.property('id');
          element.should.have.property('category');
        });
        done();
     })
  })
});

  //All Categories + Count  (used in Home)

describe("getCategoryCount",function(){
  it("should return all categories, category_id, no of products",function(done){
    chai.request(server)
      .get('/category/count')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(element => {
          element.should.have.property('id');
          element.should.have.property('category');
          element.should.have.property('count');
        });
        done();
     })
  })
});

//Test Distributor

  //All Distributors

describe("getDistributor",function(){
  it("should return all distributors' id, name, address, city, province, zipcode, completeAddress, phone, webUrl",function(done){
    chai.request(server)
      .get('/distributor')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(element => {
          element.should.have.property('id');
          element.should.have.property('name');
          element.should.have.property('address');
          element.should.have.property('city');
          element.should.have.property('province');
          element.should.have.property('zipcode');
          element.should.have.property('completeAddress');
          element.should.have.property('phone');
          element.should.have.property('webUrl');
        });
        done();
     })
  })
});

//Test Contact

  //All Contacts

describe("getDistributor",function(){
  it("should return all contacts' id, name, address, city, province, zipcode, completeAddress, phone, webUrl",function(done){
    chai.request(server)
      .get('/contact')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(element => {
          element.should.have.property('id');
          element.should.have.property('name');
          element.should.have.property('address');
          element.should.have.property('city');
          element.should.have.property('province');
          element.should.have.property('zipcode');
          element.should.have.property('completeAddress');
          element.should.have.property('phone');
          element.should.have.property('webUrl');
        });
        done();
     })
  })
});


//Test Comments
  //All Comments

describe("getProductComments",function(){
  it("should return all comments on products",function(done){
    chai.request(server)
      .get('/product')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(function(element){
          chai.request(server)
            .get(`/product/${element.id}/comment`)
            .end(
              function(err2,res2){
                res2.body.should.be.a('array')
                if(res.body.length>0){
                  res2.body.forEach(
                    function(comment){
                      comment.should.be.a('object');
                      comment.should.have.property('productId');
                      comment.should.have.property('date');
                      comment.should.have.property('commenter');     
                    }
                  )
                }              
              }
            )
        });
        done();
      })
  })
});
  
  //Insert Comment

describe("insertComments",function(){
  it("should insert comments on all products",function(done){
    chai.request(server)
      .get('/product')
      .end(function(err, res){
        res.should.have.header("Content-type",/json/)
        res.status.should.equal(200);
        res.body.should.be.a('array');
        res.body.forEach(function(element){
          chai.request(server)
            .post(`/product/${element.id}/comment/`)
            .set('content-type', 'application/x-www-form-urlencoded')
            .send({ user_tag:JSON.stringify({content:"21b373",tag:{type:"Buffer",data:[198,113,139,57,194,241,239,237,81,11,8,120,78,185,108,198]}}),
                    comment:`lalalala in ${element.id}`,
                    commenter:`Dunno`                    
            })
            .end(
              function(err2,res2){
                res2.status.should.equal(200);
                res2.body.message.should.be.a('string','Successfully posted comment');
              }
            )
        });
        done();
      })
  })
});

//Test Cart
  //Put Products

describe("insertProductstoCart",function(){
  it("should insert one of every product in cart if there is at least one in stock",function(done){
    chai.request(server)
      .get(`/product`)
      .end(function (err,res){
        res.should.have.header("Content-type",/json/);
        res.status.should.equal(200);
        new Promise((resolve,resject)=>{
          // console.log(res.body);
          res.body.forEach(function(element){
            if(element.stock>1){
              chai.request(server)
                .put('/cart/putproduct')
                .set('content-type', 'application/x-www-form-urlencoded')
                .send({ user_tag:JSON.stringify({content:"21b373",tag:{type:"Buffer",data:[198,113,139,57,194,241,239,237,81,11,8,120,78,185,108,198]}}),
                        product_id:element.id,
                        quantity:1
                })
                .end(
                  function(err2,res2){
                    res2.status.should.be.equal(200);
                  }
                )
              }
          });  
        }).then(
          ()=>{
            done();
          }
        )
      });
  })
})

//All Tester w/ for each need promises