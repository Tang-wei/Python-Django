  /*公共导航部分--------------------------------------*/
  //顶部导航鼠标经过出现内容
  function topNav(){
    for(var i =1;i<5;i++){
      $('.layout-header-nav li').eq(i).mouseover(function(){
        var $this = $('.layout-header-nav-child');
        var lw = $('.layout-header-nav-child-list li').width();
        var t = $('.layout-header-nav-child-list li').length;
        var uw = lw * t /2;
        $this.show();
        $this.find('.layout-header-nav-child-list').css('margin-left',-uw);
        }).mouseout(function(){
          $('.layout-header-nav-child').hide();
        });
    }
 }//顶部导航鼠标经过出现内容 E

  function topLogin(){
      // 登录图片鼠标经过
      $('#layoutHeaderUser').mouseover(function(){
        $('.layout-user-downmenu').show();
      }).mouseout(function() {
          $('.layout-user-downmenu').hide();
      });
  }
  // 公共返回顶部
  function backTop(){
    $(window).scroll(function(){
      var dTop = $(document).scrollTop();
      var fTop = $('.layout-header .navbar').height();
      if(dTop >fTop){
        $('.layout-magnet').show();
      }else{
        $('.layout-magnet').hide();
      }
    });
    $(".layout-magnet").click(function(){
      $("html").animate({"scrollTop": "0px"},500); //IE,FF
      $("body").animate({"scrollTop": "0px"},500); //Webkit
    });
  } 
  /*---------------------------------------------------*/ 

  /*首页部分-------------------------------------------*/
  // 首页侧导航鼠标经过出现内容
  function leftNav(){
    $('#homeCategory li').mouseover(function(){
      $(this).find('.home-category-child').show();
    }).mouseout(function(){
      $(this).find('.home-category-child').hide();
    })
  }

  /*---------------------------------------------------*/ 

  /*全部商品部分---------------------------------------*/
  function comPro(){
    $(".gl-item").mouseover(function(){
      $(this).find('.compare-btn-list').css('display','block');
    });
    $(".gl-item").mouseout(function(){
      $(this).find('.compare-btn-list').css('display','none');
    });

  }

  /*---------------------------------------------------*/ 

  /*产品详情页部分-------------------------------------*/
  function  detaNav(){
    $('#detailFast ul li').click(function(){
      var t = $(this).index();
      
      $('#detailFast ul li').addClass('current').siblings().removeClass('current');
      $('.detail-content div').eq(t).addClass('current').siblings().removeClass('current');
    })
      $(window).scroll(function(){
        var dt = $('#detail').offset().top;
        var dTop = $(document).scrollTop();
        if(dTop >= dt){
          $('#detailFast').addClass('float-nav');
        }else{
          $('#detailFast').removeClass('float-nav');
        }
        //console.log(dt,dTop)
      })
    } 
     // 数量增加减少
    function addMin(){
      // 减少
      $('.vm-minus').click(function(){
          var n=$('#J_quantity').val();
          var num=parseInt(n)-1;
          if(num<=1){ 
            $('.vm-minus').addClass('disabled');
            $(this).next().val(1);
          }else{
            $('.vm-minus').removeClass('disabled');
            $(this).next().val(num);
          }
          
      })
      //增加
      $('.vm-plus').click(function(){
          var n=$('#J_quantity').val();
          var num=parseInt(n)+1;
          if(num>1){ $('.vm-minus').removeClass('disabled');}
          if(num>5){ return;}
            $(this).prev().val(num);
          })
      }// 数量增加减少E
  /*---------------------------------------------------*/ 
  /*移动端特效-----------------------------------------*/
  function appTopNav(){
    $(window).scroll(function(){
      var dTop = $(document).scrollTop();
      if(dTop>0){
        $('#J_listFilter').addClass('fixed');
      }else{
        $('#J_listFilter').removeClass('fixed');
      }
    })
  }
  /*---------------------------------------------------*/ 
  

/*购物车--------------------------------------------*/ 

//选择框操作
function allSelect(){
  var aee = false;
  var see = false;
  // 全选
  $('.JSelectAll .mz-checkbox').click(function(){
    if(aee==false){
      $(this).addClass('checked');
      $('.cart-col-select .mz-checkbox').addClass('checked');
      aee = true;
    }else if(aee==true){
      $(this).removeClass('checked');
      $('.cart-col-select .mz-checkbox').removeClass('checked');
      aee = false;
    }
  })

  //单选
   $('.cart-col-select .mz-checkbox').click(function(){
    $(this).toggleClass("checked");
    loadTotal();
    /*
    if(see==false){
      $(this).addClass('checked');
      see = true;
    }else if(see==true){
      $(this).removeClass('checked');
      see = false;
    }
    */
  })
}
//   $('.cart-col-select .mz-checkbox').click(function(){
//     if(see==false){
//       $(this).addClass('checked');
//       see = true;
//     }else if(see==true){
//       $(this).removeClass('checked');
//       see = false;
//     }
//   })
// }

//计算商品数量和总金额
function loadTotal(){
    var ids = [];
    //alert('ok');
    //获取所有选择的商品
    var list = $("table.cart-merchant-body div.mz-checkbox").filter(".checked");
    $("#totalCount").html(list.length);
    var total = 0.0;
    for(var i=0;i<list.length;i++){
       total += parseFloat($(list[i]).attr('price'));
       ids.push($(list[i]).attr('gid'));
    }
    //alert(total);
    $("#totalPrice").html(total);
    return ids;
}
// 数量增加减少
function cartAddMin(){
      var pList = $('.cart-product');
      //页面底部显示初始值
      //初始商品总数量
      $('#totalCount').html(pList.length); 
      var fsnC = Number( $('#totalCount').text());

      //初始商品总和
      var i = 0;
      var fsPrice = 0;

      while(i<pList.length){
        // var v = pList.eq(i).index();
        var sPrice=Number($('.cart-product').eq(i).find('.cart-product-price.total').text());
        var fsPrice = Number(fsPrice)+Number(sPrice);
        i++;
        $('#totalPrice').html(fsPrice+'.00');
      }

      
      // 减少
      $('.mz-adder-subtract').click(function(){
           //检测操作的是哪个商品
           var fzhi=$(this).parents('.cart-product').attr('id');
           var reg=/^pro\d$/;
           var prod=reg.exec(fzhi);

           //商品展示个数、减号、超过数量的文本
           var $mText = $(this).parents('#'+prod).find('.cart-product-number-max');
           var $nSub = $(this).parents('#'+prod).find('.mz-adder-subtract');
           var $nInput = $(this).parents('#'+prod).find('.mz-adder-input');
           var n=$nInput.val();
           var num=parseInt(n)-1;

           

           //获取当前商品的单价和小计
           var $nPrice = $(this).parents('#'+prod).find('.cart-col-price .cart-product-price');
           var npText = parseInt($nPrice.text());
           var $sumPrice = $(this).parents('#'+prod).find('.cart-col-total  .cart-product-price');
           var spText = parseInt($sumPrice.text());

           //单个商品的小计
           spText= spText - npText;
           $sumPrice.html(spText+'.00');
            
           
           //商品减少操作
           if(num<=1){ 
              $nSub.addClass('disabled');
              $nInput.val(1);
           }else if(num>1){
              $nInput.val(num);
           }
           if(num<5){
              $mText.removeClass('show');
           }

           //页面底部显示一共多少商品和选择的商品个数
           var fsNum = Number( $('#totalCount').text());
           var newNum = fsNum-1;
           $('#totalCount').html(newNum);

           //页面底部总和
           var fPrice=$('#totalPrice').text();
           var regs=/\d+/;
           var sfPrice= Number(regs.exec(fPrice));

           //算出新的总价格
           var nsfPrice=spText+sfPrice;
           $('#totalPrice').html(nsfPrice+'.00');

      })
      //增加
      $('.mz-adder-add').click(function(){
           //检测操作的是哪个商品
           var fzhi=$(this).parents('.cart-product').attr('id');
           var reg=/^pro\d$/;
           var prod=reg.exec(fzhi);

           //商品展示个数、加号、超过数量的文本
           var $nAdd = $(this).parents('#'+prod).find('.mz-adder-add');
           var $nSub = $(this).parents('#'+prod).find('.mz-adder-subtract');
           var $nInput = $(this).parents('#'+prod).find('.mz-adder-input');
           var n=$nInput.val();
           var $mText = $(this).parents('#'+prod).find('.cart-product-number-max');
           var num=parseInt(n)+1;

           //获取当前商品的单价和小计
           var $nPrice = $(this).parents('#'+prod).find('.cart-col-price .cart-product-price');
           var npText = parseInt($nPrice.text());
           var $sumPrice = $(this).parents('#'+prod).find('.cart-col-total  .cart-product-price');
           var spText = parseInt($sumPrice.text());


           
           //商品增加操作
           if(num>1){ 
                $nSub.removeClass('disabled');
                $nInput.val(num);

           }
           if(num==5){
                $nAdd.addClass('disabled');
                $mText.addClass('show');
                $mText.text("限购5件");
                $nInput.val(num);
           } 
           if(num>5){ 
                $nAdd.addClass('disabled');
                $mText.addClass('show');
                $mText.text("限购5件");
                $nInput.val(5);
               return false;
           }
           //单个商品的小计
           spText= spText + npText;
           $sumPrice.html(spText+'.00');
           // console.log(num);

           //页面底部显示一共多少商品和选择的商品个数
           var fsNum = Number( $('#totalCount').text());
           var newNum = fsNum+1;
           $('#totalCount').html(newNum);


           //页面底部总和
           var fPrice=$('#totalPrice').text();
           var regs=/\d+/;
           var sfPrice= Number(regs.exec(fPrice));


           //算出新的总价格
           var nsfPrice=spText+sfPrice;
           $('#totalPrice').html(nsfPrice+'.00');
           console.log(sfPrice)
      })

      //叉号删除商品

      $('.cart-product-remove').click(function(){
            // //获取商品个数
            // var geshu=Number($(this).parents('.zhanshi1').find('.yi1').text());
            // //获取商品价格
            // var dqjinbi=$(this).parents('.zhanshi1').find('.jiage').text();
            // var reg=/\d+/;
            // var dqjb=Number(reg.exec(dqjinbi));
            // //获取总共价格
            // var zgjinbi=$('.jine').find('h4 span').text();
            // var regs=/\d+/;
            // var zgjb=Number(regs.exec(zgjinbi));
            // //求出新的价格
            // var newjinbi=zgjb-dqjb*geshu;
            // //赋值
            // $('.jine').find('h4 span').html(newjinbi+'.00');
            // //求出商品个数
            // var gs=Number($('.zg h5 span').text());
            // var newgs=gs-geshu;
            // $('.zg h4 span').html(newgs);
            // $('.zg h5 span').html(newgs);
            $(this).parents('.cart-product').remove();
      })

    
}// 数量增加减少E 





/*---------------------------------------------------*/ 



/*登录页面----------------------------------------*/ 
function nLogin(){
      //   提交
      var nameOk=false;
      var paddOk=false;
      //获取焦点事件
     $('input[name=account]').focus(function(){
          //添加颜色
          $('.cycode-box').addClass('btn-focus');
          $('.passwd-box').removeClass('btn-focus');
     })
     $('input[name=password]').focus(function(){
          $('.cycode-box').removeClass('btn-focus');
          $('.passwd-box').addClass('btn-focus');
     })
     //丧失焦点事件
     $('input[name=account]').blur(function(){
          //获取用户信息进行正则获取
          var v =$(this).val();
          var reg=/^\d{6,18}$/;
          //判断如果为true则通过
          if(reg.test(v)){
                $('.cycode-box').removeClass('btn-error');
                $('.tip-box').addClass('visiblility-hidden');
                nameOk=true;
          }else{
                $('.cycode-box').addClass('btn-error');
                $('.tip-box').removeClass('visiblility-hidden');
                $('.tip-box .tip-font').html("请输入合法的手机号码")
                nameOk=false;
          }
          console.log(v)
     })
      //丧失焦点事件
     $('input[name=password]').blur(function(){
          //获取用户信息
          var v =$(this).val();
          var reg=/^\w{6,18}$/;
          //判断如果为true则通过
          if(reg.test(v)){
                $('.passwd-box').removeClass('btn-error');
                $('.tip-box').addClass('visiblility-hidden');
                passOk=true;
          }else{
                $('.passwd-box').addClass('btn-error');
                $('.tip-box').removeClass('visiblility-hidden');
                $('.tip-box .tip-font').html("请输入正确的密码")
                passOk=false;
          }
          console.log(v)
     })
}



/*---------------------------------------------------*/ 