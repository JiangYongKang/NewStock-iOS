/**
 * 手机开户3.0
 */
define(function(require, exports, module){
	/* 私有业务模块的全局变量 begin */
	var appUtils = require("appUtils"),
		_pageId = "#error_networkException";
	var external = require("external");
	/* 私有业务模块的全局变量 end */
	
	function init()
	{
       $(_pageId).css("overflow-y","hidden");
       
       if(typeof(paramObj) != "undefined" && paramObj){
       
       if(paramObj["p"]){
       
         $(_pageId+" #refreash").prev().html(decodeURIComponent(paramObj["p"]));
       }
       
       if(paramObj["display"] && paramObj["display"] =="1"){
       
         $(_pageId+" #refreash").css({"display":"none"});
       
       }
       
      }

	}
	
	function bindPageEvent(){
		
		/* 绑定返回  */
		appUtils.bindEvent($(_pageId+" #back"),function(){
                           
           var param = {
               "funcNo": "50101",
               "moduleName":"exit_open"
           };
           external.callMessage(param);
			
		});
		
		/* 绑定刷新 */
		appUtils.bindEvent($(_pageId+" #refreash"),function(){
          $(this).prev().html("正在重新加载...");
          $(_pageId+" .header_title h3").html("刷新中");
          setTimeout(function(){
              var param = {
              "funcNo": "50101",
              "moduleName":"refreash_h5"
              };
              external.callMessage(param);
          
          },500);

			
		});
		
	}
	
	function destroy(){}

	var index = {
		"init" : init,
		"bindPageEvent" : bindPageEvent,
		"destroy" : destroy
	};
	
	module.exports = index;
});