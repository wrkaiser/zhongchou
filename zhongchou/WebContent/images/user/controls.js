$(document).ready(function(){
	(function(){
		  var formList = $('.form-list');
		formList.find('.inp input').focus(function(){
		    var popContent =  $(this).closest('.form-list').find('.prompt .sub');
		    if(popContent.text()){
		      popContent.show();
		    }
		  });
		  formList.find('.prompt').find('i').hover(
		    function(){
		      var popContent =  $(this).closest('.form-list').find('.prompt .sub');
		      if(popContent.text()){
		        popContent.show();
		      }
		    },
		    function(){
		      $(this).closest('.form-list').find('.prompt .sub').hide();
		    }
		  );
		
		  formList.find('.inp input').blur(function(){
		    $(this).closest('.form-list').find('.prompt .sub').hide();
		  });
	})();
});