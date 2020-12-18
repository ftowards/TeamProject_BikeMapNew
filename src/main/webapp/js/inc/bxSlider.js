	$(function(){
		$("#bxsliderSub").bxSlider({
			mode: 'horizontal'			
			,auto: true				
			,speed: 200		
			,infiniteLoop: true		
			,autoHover: true		
			,pager: false //페이징삭제
		});
		
		$("#bxslider").bxSlider({
			mode: 'horizontal'		//horizontal랑 fade중 고르기.
			,auto: true				//자동 실행
			,speed: 1000			//속도
			,infiniteLoop: true		//무한루프
			,autoHover: true		//마우스 hover시 화면전환 정지
			,pager: true //페이징삭제
		});
	});
	