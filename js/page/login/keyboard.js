/**
 * jQuery–°º¸≈Ã
 * Author : ÕıÀß
 * Version : 2012/12/21
 */

$(function(){
	var $write;
	var	shift = false,
		capslock = false;
	// Download by http://www.codefans.net
	$('#keyboard li').click(function(){
		$write.focus();
		var $this = $(this),
			character = $this.html(); // If it's a lowercase letter, nothing happens to this variable
		
		// Shift keys
		if ($this.hasClass('left-shift') || $this.hasClass('right-shift')) {
			$('.letter').toggleClass('uppercase');
			$('.symbol span').toggle();
			
			shift = (shift === true) ? false : true;
			capslock = false;
			return false;
		}
		
		// Caps lock
		if ($this.hasClass('capslock')) {
			$('.letter').toggleClass('uppercase');
			capslock = true;
			return false;
		}
		
		// Delete
		if ($this.hasClass('delete')) {
			var html = $write.val();
			
			$write.val(html.substr(0, html.length - 1));
			return false;
		}
		
		// Special characters
		if ($this.hasClass('symbol')) character = $('span:visible', $this).html();
		if ($this.hasClass('space')) character = ' ';
		if ($this.hasClass('tab')) {
			if($write.attr("type") == "password"){
				character = '';
			}else{
				character = '\t';
			}
		}
		if ($this.hasClass('return')) character = "\n";
		if ($this.hasClass('close')){
			$("#keyboard").hide();
			return false;
		}
		
		// Uppercase letter
		if ($this.hasClass('uppercase')) character = character.toUpperCase();
		
		//& < >
		if (character == "&amp;") character = "&";
		if (character == "&lt;") character = "<";
		if (character == "&gt;") character = ">";
		
		
		// Remove shift once a key is clicked.
		if (shift === true) {
			$('.symbol span').toggle();
			if (capslock === false) $('.letter').toggleClass('uppercase');
			
			shift = false;
		}
		
		// Add the character
		$write.val($write.val() + character);
	});
	$(".write").click(function(){
		$write = $(this);
		$("#keyboard").show();
		
	});
});

