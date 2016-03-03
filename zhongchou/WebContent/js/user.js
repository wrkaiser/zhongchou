$(init);

function init(){
    cancelAttention();
    cancelPre();
    changePre();
    menuDown();
    deleteMsg();
    showAll();
    chooseleader();
    cancleLeader();
    changeLeader();
    moreInfo();
}
function showAll(){   
    $(".show-all").click(function(){
      $(this).prev().removeClass("p-wrap");
      $(this).hide();
    });
}
function menuDown(){
    $(".js-show-menu").hover(function(){
        $(this).find('ul').show();
      },function(){
       $(this).find('ul').hide();
      });
}
//取消关注
function cancelAttention(){
    $(".js-cancel-attention").click(function(){
        var that=this;      
        var id=$(that).data("id"); 
        wx.sendData("/focus/delete","dealId="+id,function(data){             
             if(data.errno == 0){                 
               if($(that).attr('class').match('gz') == null){
                  $(that).parents(".project-list-content").remove();
               }else{
                 location.reload();
               }
             }else{
                 wx.alert(data.usercode);
             }
        });
    });
}
//取消预约
function cancelPre(){
    $('.js-cancel-pre').click(function(){
        var _this = $(this),_id = _this.data('id'),_dealid = _this.data('dealid');
        wx.sendData("/reserve/cancle/reserveId/"+_id+"/dealId/"+_dealid,"",function(data){
             if(data.errno == 0){                 
                _this.parents(".project-list-content").remove();
             }else{
                 wx.alert(data.usercode);
             }
        });
    });
}
//变更预约
function changePre(){
    $('.js-change-pre').click(function(){
        var _this = $(this),_id = _this.data('id'),_dealid = _this.data('dealid');
        //wx.sendData("/reserve/cancle/reserveId/"+_id+"/dealId/"+_dealid,"",function(data){
             //if(data.errno == 0){                 
                //_this.parents(".project-list-content").remove();
             //}else{
                 //wx.alert(data.usercode);
             //}
        //});
        wx.pop(
            '<div class="changepre"><form action="/reserve/add" name="jsbgyy" wx-validator wx-validator-ajax="reload"><div class="clearfix"><label for="money">预约金额：</label><input class="wx-inputErrBorder" wx-validator-rule="required" type="text" id="money" name="money"></div><br />'+
            '<div class="clearfix" style="display:none;"><label>是否领投：</label><input value="0" checked="checked" type="radio" name="is_leader" id="is_leader0"><label  class="sub" for="is_leader0">否</label>'+
            '<input type="radio" id="is_leader1" value="1" name="is_leader"><label class="sub" for="is_leader1">是</label></div>'+
            '<div class="clearfix"><label for="reseron">备注：</label><input type="text" id="reseron" name="reseron"></div>'+
            '<div class="clearfix mul-opt"><a class="btn btn-big bg-orange" type="submit" href="javascript:;">变更</a></div>'+
            '<input type="hidden" name="dealId" value="'+_id+'">'+
            '<input type="hidden" name="reserveId" value="'+_dealid+'">'+
            '</form></div>'
            ,{title:"变更预约"});
    });
}
//
function jsbgyy(data){
  wx.alert(data.usercode);
}

//变更领投
function changeLeader(){
    $('.js-change-leader').click(function(){
      wx.pop(wx.tpl("#Js-lingtouTpl",{reserveId:$(this).data("id"),dealId:$(this).data("dealid"),zgb:$(this).data("marktprice")}),{title:'变更领投'});
    });


  $(".Js-computFund").live('keyup',function() {
    var val = $(this).val(),
        elem = $(this).parent().parent().next().find(".rate");
      if(isNaN(val)){
        elem.text("");
      } else {
        elem.text((parseFloat($(this).val())/parseFloat($(this).parent().parent().siblings('[name="gzbval"]').val())).toFixed(2)+'%');
      }
  });
}

//取消领投
function cancleLeader(){
    $('.js-cancel-leader').click(function(){
        var _this = $(this),_id = _this.data('id'),_dealid = _this.data('dealid');
        wx.sendData("/reserve/canleader/reserveId/"+_id+"/dealId/"+_dealid,"",function(data){
             if(data.errno == 0){                 
                _this.parents(".project-list-content").remove();
             }else{
                 wx.alert(data.usercode);
             }
        });
    });
  
}

//取消订单
$('.js-cancle-bill').click(function(){
  var _this=$(this);
  wx.sendData(_this.data('href'),'',function(data){
    wx.alert(data.usercode);
    if(data.errno == 0){
      _this.remove();
      location.reload();
    }
  });
});

function deleteMsg(){
    $(".js-delete-msg").click(function(){
        var that=this;      
        var id=$(that).data("id"); 
        wx.sendData("/msg/delete","id="+id,function(data){             
             if(data.errno == 0){                 
                $(that).parents(".message-content").remove();
             }else{
                 wx.alert(data.usercode);
             }
        });
    });
}

//choose leader
function chooseleader(){
  $('.js-chooseleader-handler').click(function(){
    var _this=$(this);
    wx.sendData('/investor/auditleader','deal_id='+_this.data('dealid')+'&f_id='+_this.data('fid'),function(data){
        var tpl = "";
        for(var i=0;i<data.data.length;i++){
          if(data.data[i].mark.length<40){
            tpl += wx.tpl('#chooseleader',data.data[i]);
          }else{
            tpl += wx.tpl('#chooseleader2',data.data[i]);
          }
        }
        wx.pop('<div class="popleader" style="width: 580px; margin: 0 auto; padding: 15px 0; text-align: left; overflow-y: scroll; height: 330px; overflow-x: hidden; ">'+tpl+'</div>',{shown:function(){
          $('.js-type').click(function(){
            var _this_=$(this);
            wx.sendData('/reserve/chooseleader','dealId='+_this_.data('did')+'&reserveIds='+_this_.data('rid')+'&type='+_this_.data('type'),function(data){
              _this_.closest('.leaderlist').remove();
              if(!$('.leaderlist').length){
                wx.popClose();
                location.reload();
              }
            });
          });
        }});
    });
  });
}


//选择领投人更多
function moreInfo(){
  $('.gre').live('click',function(){
  console.log(2)
    $(this).siblings('p').css("height","auto");
    $(this).remove();
  })
}



$('.Js-computFund').live('blur',function(){
  $(this).val(wx.trim($(this).val(),true));
    var val = $(this).val(),
        elem = $(this).parent().parent().next().find(".rate");
      if(isNaN(val)){
        elem.text("");
      } else {
        elem.text((parseFloat($(this).val())/parseFloat($(this).parent().parent().siblings('[name="gzbval"]').val())).toFixed(2)+'%');
      }
})

$(".pre-publish").click(function(){
    var _this = this;
  //  alert($(_this).attr("id"));return;
    wx.confirm('您的项目一旦进入发行阶段，所有发行条款及相关协议均将具有法律效力且不可随意更改，融资方如不按发行条款及相关协议履行承诺，投资人及本平台有权向融资方及发起人或创始人追偿损失或提起诉讼，请慎重操作。',function(){location.href=$(_this).attr("id")});

})


