/*创建时间hSea 2015-07-10 18:18:10 PM */
define(function(require,exports,module){function a(a){var b=this,c=null;this.setCssHW=function(){var b=a.wrapper,c=b.children(),d=a.container,e=a.containerHeight,f=a.containerWidth;e?b.height(e):b.height($(window).height()),f?b.width(f):b.width($(window).width()),b.css({position:"absolute"}),c.css({position:"absolute",width:"100%",padding:"0px"}),d.css({padding:"0px",margin:"0px",width:"100%"})},this.refresh=function(){c.refresh()},this.init=function(){this.setCssHW();var b=require("iscroll");c=new b(a.wrapper[0],{onScrollMove:function(){a.wrapper.children("div").eq(1).show()},onScrollEnd:function(){a.wrapper.children("div").eq(1).hide()}}),setTimeout(function(){a.wrapper.children("div").eq(1).hide()},200)},this.destroy=function(){null!=c&&(c.destroy(),c=null)},b.init()}module.exports=a});
/*创建时间 2015-07-10 18:18:10 PM */