$(document).ready(function(){
	$("#main-nav").mouseenter(showNav).mouseleave(hideNav);
	$(".submit_button").prop("value", "+")
	$(".archive").click(archive); 

	function archive(e) {
		$(".archive-button").append("Archived!");
		$(".archive").remove()
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