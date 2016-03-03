$(function(){
  //提示气泡
  var formList = $('.form-list');




  animate();


  $(document).scroll(function(){
    if($(document).scrollTop()-$('#launch').offset().top <= 0){
      $('#launch').find('.tit').removeClass('float_top');
    }else{
      $('#launch').find('.tit').addClass('float_top');
    }
  });
});

function animate(){
  $(".Js-switch").click(function(){
    var $parent = $(this).parent();
    if($parent.hasClass('close_bg')){
      $parent.next().slideUp(function(){
        $parent.removeClass('close_bg');
      });
      $(this).html('<i></i>展开');
    } else {
      $parent.next().slideDown(function(){
        $parent.addClass('close_bg');
      });
      $(this).html('<i></i>收起');
    }
  });
}

function slide_next(name){
    var m = $(".launch-list-tit[data-form-id='" + name + "']");
    
    
    $(".launch-list").slideUp();
    $(".launch-list-tit").removeClass("close_bg");
    $(".launch-list-tit").find(".Js-switch").html("<i></i>展开");
    m.find(".Js-switch").html("<i></i>展开");
  
    
    m.next().next().next().find(".Js-switch").html("<i></i>收起");
    if(name != 'financial_needs'){
    	m.next().next().addClass("close_bg");	
    }
    
    m.next().next().next().slideDown();
}




//提交表单序列化上传图片
function create_project_before(form){
  var allpic = $('.picul',form).find('img');
  var picval = [];
  for(var i=0;i<allpic.length;i++){
    picval.push(allpic.attr('src'));
  }
  $('.picarr').val(picval.join());
}

