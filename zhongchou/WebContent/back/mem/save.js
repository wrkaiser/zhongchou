$(function(){
	$("#bsubmit").click(function(){
		$.post("update.jsp",{
			q:ok
		},function(ststus){
			alert("修改成功！");
		});
		
		});
});
	
