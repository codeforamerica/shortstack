<script type="text/javascript" src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js?ver=1.3.2'></script>

<script type='text/javascript'>
	document.forms.reset();
</script>
<script type='text/javascript'>
	function switchContent(obj) {

		obj = (!obj) ? 'sub1' : obj;

		var contentDivs = document.getElementById('traffic_graph').getElementsByTagName('div');
		for (i=0; i<contentDivs.length; i++) {
			if (contentDivs[i].id && contentDivs[i].id.indexOf('sub') != -1) {
				contentDivs[i].className = 'hide';
			}
		}
		document.getElementById(obj).className = '';

	}
</script>

<script type="text/javascript"	
	$(document).ready(function(){
		$('.mySelectBoxClass').customStyle();
	});
</script>

// <script>
// 
// 	(function($){
// 	 $.fn.extend({
//  
// 	 	customStyle : function(options) {
// 		  if(!$.browser.msie || ($.browser.msie&&$.browser.version>6)){
// 		  return this.each(function() {
// 	  
// 				var currentSelected = $(this).find(':selected');
// 				$(this).after('<span class="customStyleSelectBox"><span class="customStyleSelectBoxInner">'+currentSelected.text()+'</span></span>').css({position:'absolute', opacity:0,fontSize:$(this).next().css('font-size')});
// 				var selectBoxSpan = $(this).next();
// 				var selectBoxWidth = parseInt($(this).width()) - parseInt(selectBoxSpan.css('padding-left')) -parseInt(selectBoxSpan.css('padding-right'));			
// 				var selectBoxSpanInner = selectBoxSpan.find(':first-child');
// 				selectBoxSpan.css({display:'inline-block'});
// 				selectBoxSpanInner.css({width:selectBoxWidth, display:'inline-block'});
// 				var selectBoxHeight = parseInt(selectBoxSpan.height()) + parseInt(selectBoxSpan.css('padding-top')) + parseInt(selectBoxSpan.css('padding-bottom'));
// 				$(this).height(selectBoxHeight).change(function(){
// 					// selectBoxSpanInner.text($(this).val()).parent().addClass('changed');   This was not ideal
// 				selectBoxSpanInner.text($(this).find(':selected').text()).parent().addClass('changed');
// 					// Thanks to Juarez Filho & PaddyMurphy
// 				});
// 			
// 		  });
// 		  }
// 		}
// 	 });
// 	})(jQuery);
// 
// </script>