/**
 * 这里是通用的消息处理，跟具体模块的业务无关
 * 处理的消息列表：
 * 	1、Android手机的返回键消息处理，原生监听返回键
 *  2、原生键盘操作的响应事件，通知 H5 调用者，键盘的点击情况
 */
define(function(require, exports, module){
	var	gconfig = require("gconfig");
	var	global = gconfig.global;
	var appUtils = require("appUtils");
	var	layerUtils = require("layerUtils");
	var nativePluginService = require("nativePluginService");
	
	var backBtnMarkTime = 0; // 安卓返回按钮退出的标记时间
	var KEYBOARDCODE = {"CLEAR": -2, "DONE": -3, "DEL": -5}; //常量，键盘上面的按键对应编码（-2表示清空，-3表示完成，-5表示删除）
	var keyBoardInputFunction = null; // 原生键盘输入时执行的事件处理函数
	var keyBoardFinishFunction = null; // 原生键盘点击完成按钮的事件处理函数
	
	/**
	 * Android手机的返回键消息处理，原生监听返回键
	 * @param paramMap json格式参数
	 */
	function function50107(paramMap) {
		// 判断是否直接退出
		if(!gconfig.isDirectExit) 
		{
			// 弹出层消失，弹出层抽象利于处理，返回上一级页面，page增加上一级页面
			var pageLevel = $(".page[data-display=block]").attr("data-pageLevel");
			if(pageLevel == "1") 
			{
				_exitApp();
			} 
			else 
			{
				var curPageCode = appUtils.getSStorageInfo("_curPageCode");
				curPageCode = (!curPageCode || curPageCode== "null")? "" : curPageCode;
				require.async(gconfig.scriptsPath + curPageCode, function(page) {
					if(page.pageBack) 
					{
						page.pageBack();
					}
					else 
					{
						appUtils.pageBack();
					}
				});
			}
		} 
		else
		{
			_exitApp();
		}
	}
	
	/**
	 * 键盘操作的响应事件，通知 H5 调用者，键盘的点击情况
	 * @param paramMap json格式参数
	 */
	function function50212(paramMap) 
	{
		var customKeyboardEvent = window.customKeyboardEvent || {}; // 页面自定义的针对原生键盘事件
		var pageId = paramMap.pageId;
		var eleId = paramMap.eleId;
		var keyCode = paramMap.keyCode;
		var $targetEle = $("#" + pageId + " #" + eleId);
		var curEleVal = $targetEle.val();
		// 完成按钮
		if(keyCode == KEYBOARDCODE.DONE) 
		{
			// 原生键盘点击完成按钮的事件处理函数
			if(customKeyboardEvent.keyBoardFinishFunction)
			{
				customKeyboardEvent.keyBoardFinishFunction();
			}
			$("#"+pageId).css("height",$(window).height()+"px");
		}
		else
		{
			// 获取输入域光标的当前索引
			var cursurPosition = _getTxtCursorPosition($targetEle);
			// 将输入域分成光标前后2个分部的值
			var prePositionVal = curEleVal.substring(0, cursurPosition);
			var nextPositionVal = curEleVal.substring(cursurPosition, curEleVal.length);
			console.log("键盘点击出来:"+cursurPosition + "~~~" + curEleVal + "~~~" + prePositionVal + "~~~" + nextPositionVal);
			// 删除，则将光标前面部分的输入域内容删除一个字符
			if(keyCode == KEYBOARDCODE.DEL) 
			{
				if(prePositionVal) 
				{
					prePositionVal = prePositionVal.substring(0, prePositionVal.length-1);
				}
				$targetEle.val(prePositionVal + nextPositionVal);
				_setCursorPosition($targetEle, cursurPosition - 1);
			}
			// 清空按钮
			else if(keyCode == KEYBOARDCODE.CLEAR) 
			{
				$targetEle.val("");
			}
			// 特殊操作，如：半仓、全仓等
			else if(+keyCode < 0)
			{
			}
			else
			{
				if(typeof(keyCode) !== "undefined" && keyCode !== null && keyCode.length > 0 && curEleVal.length<6)
				{
					$targetEle.val(prePositionVal + keyCode+nextPositionVal);
					_setCursorPosition($targetEle, cursurPosition + keyCode.length);
				}
			}
			// 原生键盘输入时执行的事件处理函数
			if(customKeyboardEvent.keyBoardInputFunction)
			{
				customKeyboardEvent.keyBoardInputFunction(keyCode);
			}
		}
	}

	/**
	 * 获取输入input域的光标索引位置
	 * @param jQEle input元素
	 */
	function _getTxtCursorPosition(jQEle) 
	{
		var ele = $(jQEle)[0];
		var cursurPosition = 0;
		// 非IE浏览器
		if(ele.selectionStart) 
		{
			cursurPosition= ele.selectionStart;
		}
		// IE
		else 
		{
			if(document.selection) 
			{
				var range = document.selection.createRange();
				range.moveStart("character",-ele.value.length);
				cursurPosition = range.text.length;
			}
		}
		return cursurPosition;
	}
	
	/*
	 * 设置输入域(input/textarea)光标的位置
	 * @param jQEle jquery元素
	 * @param index 要设置的索引位置
	 */
	function _setCursorPosition(jQEle, index) {
		var ele = $(jQEle)[0];
	    var val = jQEle.val();
	    var len = val.length;
	 
	    // 要设置的光标位置不超过文本长度时
	    if(index <= len) 
	    {
	        ele.focus();
	        // 标准浏览器
	        if(ele.setSelectionRange)
	        {
	            ele.setSelectionRange(index, index);
	        }
	        // IE9-
	        else 
	        {
	            var range = ele.createTextRange();
	            range.moveStart("character", -len);
	            range.moveEnd("character", -len);
	            range.moveStart("character", index);
	            range.moveEnd("character", 0);
	            range.select();
	        }
	    }
	}
	
	/**
	 * 退出应用程序
	 */
	function _exitApp() 
	{
		// 短时间第二次点击返回键，则确认退出app
		if(new Date().getTime() - backBtnMarkTime < 2000)
		{
			backBtnMarkTime = 0;
			nativePluginService.function50105(); // 退出应用
		} 
		// 相隔时间大于2秒，则只提示是否退出app
		else 
		{
			nativePluginService.function50106({"content": "再按一次退出应用程序"}); // 提示是否退出app
			backBtnMarkTime = new Date().getTime();
		}
	}
	
	/**
	 * 合并具体模块中定义的消息函数
	 * @param oMsgFunction 暴露给外部的对象
	 */
	function conbine(oMsgFunction)
	{
		oMsgFunction = oMsgFunction || {};
		oMsgFunction.function50212 = function50212;
		oMsgFunction.function50107 = function50107;
	}
	
	module.exports = {
		"conbine": conbine
	};
});