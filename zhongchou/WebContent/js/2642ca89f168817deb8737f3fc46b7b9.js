$(init);

function init(){
  $(".Js-confirm").click(confirm);
  $(".Js-cancelLike").click(cancelLike);
  //$(".Js-addr-new").click(addNewAddr);
  $(".Js-hoverContent").hover(contentIn,contentOut);
  $(".Js-hoverContentFont").hover(contentInFont,contentOut);
}

function confirm(){
  var id =$(this).parent().attr("data-id");
  wx.confirm("确认收货，确认后项目发起人会确认您已收到相应物品。",function(){
    wx.sendData(url.confirm,'order_id='+id,wx.RELOAD);
  });
}

function cancelLike(){
  var id = $(this).attr("data-id");
  wx.confirm("确定取消喜欢？",function(){
    wx.sendData(url.cancelLike,'deal_id='+id,wx.RELOAD);
  });
}

function addNewAddr(){
  wx.pop(wx.tpl("#Js-addrTpl",{id:0}));
}

function contentIn(){
  var $target = $($(this).attr("data-target"));
  $target.css({"left":$(this).position().left-230,"top":$(this).position().top+25}).show();
}
function contentInFont(){
  var $target = $($(this).attr("data-target"));
  $target.css({"left":$(this).position().left+15,"top":$(this).position().top+25}).show();
}

function contentOut(){
  $($(this).attr("data-target")).hide();
}

function image_file_Ts(data){
  if(data.status == 1){
    wx.alert(data.info,wx.RELOAD);
  } else {
    wx.alert(data.info);
  }
}


// function addConsignee(order_id){
//     addr = wx.pop(wx.template("Js-addrModify",{"type":0,"order_id":order_id}),{"shown":getCity});
//     getProvince();
// }

// $(".Js-address").hover(function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-addr-content").css({"left":$(this).offset().left-230,"top":$(this).offset().top+25}).show();
//   },function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-addr-content").hide();
//   });
//   $(".Js-reason").hover(function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-reason-content").css({"left":$(this).offset().left-230,"top":$(this).offset().top+$(this).height()+5}).show();
//   },function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-reason-content").hide();
//   });
//   $(".Js-back").hover(function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-back-content").css({"left":$(this).offset().left-230,"top":$(this).offset().top+25}).show();
//   },function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-back-content").hide();
//   });
//   var vierTimer;
//   $(".Js-view").hover(function(){
//     var $parent =$(this).parent();
//     $parent.find(".Js-view-content").css({"left":$(this).offset().left-230,"top":$(this).offset().top+25}).show();
//   },function(){
//     var $parent =$(this).parent();
//     vierTimer = setTimeout(function(){
//       $parent.find(".Js-view-content").hide();
//     },100);
//   });
//   $(".Js-view-content").hover(function(){
//     clearTimeout(vierTimer);
//   },function(){
//     $(this).hide();
//   });
    
  //   function getCity(selectedProId,selectedCity){
  //   $("select[name='province']").change(function() {
  //     var id = selectedProId || $(this).find("option:selected").attr("data-id");
  //     wx.sendData("{url r="settings#get_region"}","id="+id,function(data){
  //       var options = "<option data-id='-1' value='请选择'>请选择</option>";
  //       for(var i=0;i<data.length;i++){
  //         options += "<option data-id='"+data[i].id+"' value='"+data[i].name+"' "+(selectedCity==data[i].name?"selected":"")+">"+data[i].name+"</option>";
  //       }
  //       $("select[name='city']").empty().append(options);
  //     });
  //   });
  //   if(selectedProId || selectedCity){
  //     $("select[name='province']").trigger('change');
  //     $("#wx-validator-province-error").hide();
  //   }
  //   selectedProId = 0;
  // }
    
  //   function getProvince(selectedPro,selectedCity){
  //   selectedPro = selectedPro||"";
  //   wx.sendData("{url r="settings#get_region"}","id=0",function(data){
  //     var options = "";
  //     for(var i=0;i<data.length;i++){
  //       options += "<option data-id='"+data[i].id+"' value='"+data[i].name+"' "+(selectedPro==data[i].name?"selected":"")+">"+data[i].name+"</option>";
  //       if(selectedPro && selectedPro == data[i].name)
  //         getCity(data[i].id,selectedCity);
  //     }
  //     $("select[name='province']").append(options);
  //   });
  // }
    
  //   function address(data){
  //   addr.close();
  //   if(data.status == 1){
  //     wx.alert("添加成功",function(){location.reload();});
  //   }
  //   else{
  //     wx.alert(data.info);
  //   }
  // }
