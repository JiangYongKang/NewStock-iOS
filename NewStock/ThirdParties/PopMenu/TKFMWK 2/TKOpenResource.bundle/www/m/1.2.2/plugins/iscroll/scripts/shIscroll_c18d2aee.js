/*创建时间hSea 2015-07-10 18:18:10 PM */
define(function(require,exports,module){function a(a){var b=this,c=null;this.setCssHW=function(){var b=a.wrapper,c=b.children(),d=a.container,e=d.children().length,f=d.children(":eq(0)").outerHeight(!0);d.children().outerHeight(f),b.outerHeight(f);for(var g=0,h=0;e>h;h++)g+=d.children().eq(h).outerWidth(!0);c.width(g),b.css({position:"absolute",width:"100%"}),c.css({height:"100%","float":"left"}),d.children().css({"float":"left"}),d.css({display:"block","float":"left",width:"100%",height:"100%"})},this.init=function(){this.setCssHW(),null!=c&&(c.destroy(),c=null);var b=require("iscroll");a.wrapperObj=new b(a.wrapper[0],{vScroll:!1,momentum:!0,hScrollbar:!1,vScrollbar:!1,onScrollEnd:function(){a.onScrollEnd&&a.onScrollEnd()}})},this.destroy=function(){null!=c&&(c.destroy(),c=null)},this.getXPosition=function(){return a.wrapperObj.x},this.getMaxScrollX=function(){return a.wrapperObj.maxScrollX},this.scrollToElement=function(b,c){a.wrapperObj.scrollToElement(b[0],c)},b.init()}module.exports=a});
/*创建时间 2015-07-10 18:18:10 PM */