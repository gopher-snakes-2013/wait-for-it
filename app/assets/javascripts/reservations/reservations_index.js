$(document).ready(function(){
	$("#main-nav").mouseenter(showNav).mouseleave(hideNav);
	$(".submit_button").prop("value", "+")
	$(".delete-button").click(archive); 

	function archive(e) {
		$(this).remove();
	}

	function showNav(e){
		e.preventDefault()
		$(".subnav").slideDown("slow")
		$(".subnav").removeClass("hidden")
	}

	function hideNav(e){
		$(".subnav").slideUp("slow")
		$(".subnav").addClass("hidden")
	}
})