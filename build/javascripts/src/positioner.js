((function(){window.Positioner=function(){function a(a,b,c,d){this.box=a,this.parent=b,this.margin=c!=null?c:0,this.preserveSpace=d!=null?d:!1,this.box!=null&&$(this.box).length>0&&(this.accountant=new Accountant(this.box,this.parent),this.$box=$(this.box),this._setData(),this._initEvents(),this._controlBoxPosition())}return a.prototype._setData=function(){return this.isBoxFixed=!1,this.isBoxAtTheBottom=!1,this.isPreserved==null&&(this.isPreserved=!1),this._unpinBox(),this.boxData=this.accountant.getBoxData(),this.startPoint=this.accountant.getStartPoint()-this.margin,this.endPoint=this.accountant.getEndPoint()-this.margin},a.prototype._initEvents=function(){var a=this;return $(window).on("scroll.positioner",function(){return a._controlBoxPosition()}),$(window).on("resize.positioner",function(){return a._setData(),a._controlBoxPosition()})},a.prototype._controlBoxPosition=function(){var a;return a=$(window).scrollTop(),a>this.startPoint&&a<this.endPoint?(this._pinBox(),this._preserveSpace()):a>=this.endPoint?this._unpinBoxAtTheEnd():(this._unpinBox(),this._returnSpace())},a.prototype._pinBox=function(){return this.$box.addClass("pinned").css({position:"fixed",width:this.boxData.width,left:this.boxData.fixedPositionLeft,top:this.margin,bottom:""}),this.isBoxFixed=!0,this.isBoxAtTheBottom=!1},a.prototype._unpinBox=function(){return this.$box.removeClass("pinned").css({position:"",width:"",left:"",top:"",bottom:""}),this.isBoxFixed=!1,this.isBoxAtTheBottom=!1},a.prototype._unpinBoxAtTheEnd=function(){return this.$box.removeClass("pinned").css({position:"absolute",width:this.boxData.width,left:this.boxData.absolutePositionLeft,top:"",bottom:0}),this.isBoxFixed=!1,this.isBoxAtTheBottom=!0},a.prototype._preserveSpace=function(){var a,b;if(this.preserveSpace){a=$('<div class="positioner-spacer">');if(!this.isPreserved)return b=this.$box.outerHeight(!0),a.css("height",b).insertAfter(this.box),this.isPreserved=!0}},a.prototype._returnSpace=function(){if(this.isPreserved)return $(".positioner-spacer").remove(),this.isPreserved=!1},a.prototype.refresh=function(){return this._setData()},a.prototype.destroy=function(){return this._unpinBox(),$(".positioner-spacer").remove(),$(window).off(".positioner")},a}()})).call(this)