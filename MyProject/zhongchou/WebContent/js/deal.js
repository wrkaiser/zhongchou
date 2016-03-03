$(init);

function init(){
    common();
    plan();
    QA();
    feed();
    coderef();
    jslong();
}

function common(){
  var targetFund = $("#Js-targetFund").attr('data-fund')|0,
      dealId = $("#dealId").data("id");

  $("#Js-focus").click(function() {
      var $this = $(this),
          num = $this.find('.Js-focus-num').text()|0,
          focus = $this.data("isfocus")=="0" ? "add" : "delete";
      wx.sendData("/focus/"+focus,"dealId="+dealId,function(data){
          if(data.errno == 0){
              $this.find('.Js-focus-num').text(focus=="add"?num+=1:num-=1);
              $this.find(".Js-focus-label").text(focus=="add"?"已关注":"关注");
              $this.data("isfocus",focus=="add"?"1":"0");
          } else {
              wx.alert(data.usercode);
          }
      });
  });

  $(".Js-focus-label").hover(function() {
      if($(this).text()=="已关注"){
        $(this).text("取消关注");
      }
  }, function() {
      if($(this).text()=="取消关注"){
        $(this).text("已关注");
      }
  });
 
  $("#Js-action a").click(function(event) {
	  
        status = $(this).data("status"),
        id = $(this).parent().data("id") || 0;
    if(status == '3'){
    
      wx.confirm("是否要取消预约",function(){
        wx.sendData("deal.do","m=cancel&proid="+id);
      });
    } else  {
    	  wx.pop(wx.tpl("#Js-yuyueTpl",{reserveId:id}),{title:'申请预约'});
    }
  });

  $(".Js-computFund").live('keyup',function() {
    var val = $(this).val(),
        elem = $(this).parent().parent().next().find(".rate");
      if(isNaN(val)){
        elem.text("");
      } else {
        elem.text(($(this).val()/targetFund*Number($('#Js-stakes').text())).toFixed(2)+'%');
      }
  });
}

function yuyueForm(data){
  if(data.errno == 0){
    var url = window.location.href;
    if(data.send_msg)
      wx.alert(data.mess,url);
    else
      location.href=url;
  } else {
    wx.alert(data.usercode);
  }
}

function login(data){
  if(data.errno ==0){
    location.href=data.jump;
  } else {
    wx.alert(data.usercode);
    $("#codeImg").attr("src",'/verify/code?t='+new Date().getTime());
  }
}

function plan(){
    if($.fn.bxSlider){
        $('.pro-album-big').bxSlider({
            pagerCustom:'#pro-album-small'
        });
    }

    $("#Js-toggle-detail").click(function(){
        if($("#Js-detail").hasClass('plan-detail')){
            $("#Js-detail").removeClass('plan-detail');
            $(this).text("收起");
        } else {
            $("#Js-detail").addClass('plan-detail');
            $(this).text("展开");
        }
    });
    $("#Js-toggle-analysis").click(function(){
        if($("#plan-analysis").hasClass('plan-analysis')){
            $("#plan-analysis").removeClass('plan-analysis');
            $(this).text("收起");
        } else {
            $("#plan-analysis").addClass('plan-analysis');
            $(this).text("展开");
        }
    });
}

function feed(){
    var pop;
    $("#Js-feed-add").click(function() {
        if(pop)
            pop.open();
        else
            pop = wx.pop('#Js-pop-tpl',{removeAfterShow:true,title:'新增动态'});
    });
}

function file(data){
    if(data.errno == 0){
        $("#wx-validator-cover-required").hide();
    }
}


//Q&A comment
function QA(){
  $('.js-comment-add,.js-comment-reply').click(function(){
    $('.replay-box').focus();
    if(!$(this).hasClass('discuss-reply')){
      $('.grey-btn.fr').text('提问');
      $('form [name="pid"]').val('0');
    }else{
      var thisName = $(this).data('username'),
          replyName = $(this).closest('dl').find('b').text();
      $('.replay-box').attr('placeholder',thisName+'回复'+replyName);
      $('.grey-btn.fr').text('回复');
      $('form [name="pid"]').val($(this).data('id'));
    }
  });
}

function coderef(){
  $('.js-code-reflash').click(function(){
    $("#codeimg").attr("src",'/verify/code?t='+new Date().getTime());
  });
}

$('.Js-computFund').live('blur',function(){
  $(this).val(wx.trim($(this).val(),true));
    var val = $(this).val(),
  targetFund = $("#Js-targetFund").attr('data-fund')|0,
        elem = $(this).parent().parent().next().find(".rate");
      if(isNaN(val)){
        elem.text("");
      } else {
        elem.text(($(this).val()/targetFund*Number($('#Js-stakes').text())).toFixed(2)+'%');
      }
})

function lingtoutForm_before($form){
  if(isNaN($form.find('.Js-computFund').val())){
    wx.alert('请填写数字');
    return false;
  }else{
    return true;
  }
}

function jslong(){
  var longlist = $('.Js-long').find('.pro-promoters'),listheight = longlist.outerHeight()*5;
  if(longlist.length>5){
    $('.Js-long').css({height:listheight,overflow:'hidden'}).after('<div class="Js-long-btn " style="color:gray;cursor:pointer;text-align:center;">显示全部</div>');
  }
  $('.Js-long-btn').live('click',function(){
    $('.Js-long').css({overflow:'visible',height:'auto'});
    $(this).remove();
  })
}

