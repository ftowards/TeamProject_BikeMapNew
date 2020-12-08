<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/inc/headerMainBxSlider.jspf"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">


<!-- 도시 검색창 -->		
	<div class = "locationSearchDiv">
		<div class="locationSearchTitle">
			<span class="locationTitle1">어디로 떠날까요?</span><br/>
			<span class="locationTitle2">The journey not the arrival matters.</span>
		</div>
		<ul style='margin-top:25px'>
			<li class="location1">
				<span class="locationTitle">서울</span>
				<div style="height:340px;">
					<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img1.png"/></a>
				</div>
				<span class="locationTitle">부산</span>
				<div style="height:340px; margin-top:25px;">
					<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img2.jpg"/></a>
				</div>
			</li>
			<li class="location2">
				<span class="locationTitle">여수</span>
				<div style="height:340px">
					<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img3.png"/></a>
				</div>
				<div style="background:gray; height:340px; margin-top:25px;">
					<span class="locationTitle">제주</span>
					<div style="width:350px; height:100%;">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img4.jpg"/></a>
					</div>
				</div>
			</li>
		</ul>
	</div>





<div id="mainDivHome">
	<div id="hitRoute">
		<span class="routeTitle" style="width:100%; font-size:35px; font-weight:bold;">
			추천여행 코스&nbsp;
			<sub>561개</sub><br/>
			<span class="routeTitle2">바이크맵 관리자가 엄선하여 추천하는 추천 코스입니다.</span>
		</span><br/>
		<div id="content1">
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div><br/>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
		</div>
	</div><br/>
	
	<!-- <div id="routeSearch">
		<a href="<%=request.getContextPath()%>/routeSearch">
			<img style='width:3%' src="<%=request.getContextPath() %>/img/img_main/search.png"/>
			최근 다녀온 200개 루트 검색
		</a>
	</div> -->
</div>





<div id="mainDivHome2">
		<div class="courseReview">
			<span>코스 후기</span>
		</div>
</div>

<div class="banner_wrap2">

<script language="javascript" type="text/javascript">
	// 스크롤러 가로크기
	var sliderwidth=1160
	// 스크롤러 높이
	var sliderheight=400
	// 스크롤 속도 (클수록 빨라짐 1-10)
	var slidespeed=1
	// 배경색
	slidebgcolor="#"

	// 이미지 설정
	var leftrightslide=new Array()
	var finalslide=''
	leftrightslide[1]="<a href='#'><div class='slider_Review'><img class='slider_img' src='<%=request.getContextPath() %>/img/img_Review/임시.jpg'/></a><br/><div class='slider_subject'>후기 제목이 들어갈 자리입니다 글자 넘어가면 워드컷</div><br/><p class='slider_txt'><span class='slider_username'>홍길동</span>님의 생생한 후기</p></div>"
	leftrightslide[2]="<a href='#'><div class='slider_Review'><img class='slider_img' src='<%=request.getContextPath() %>/img/img_Review/임시.jpg'/></a><br/><div class='slider_subject'>후기 제목이 들어갈 자리입니다 글자 넘어가면 워드컷</div><br/><p class='slider_txt'><span class='slider_username'>홍길동</span>님의 생생한 후기</p></div>"
	leftrightslide[3]="<a href='#'><div class='slider_Review'><img class='slider_img' src='<%=request.getContextPath() %>/img/img_Review/임시.jpg'/></a><br/><div class='slider_subject'>후기 제목이 들어갈 자리입니다 글자 넘어가면 워드컷</div><br/><p class='slider_txt'><span class='slider_username'>홍길동</span>님의 생생한 후기</p></div>"
	leftrightslide[4]="<a href='#'><div class='slider_Review'><img class='slider_img' src='<%=request.getContextPath() %>/img/img_Review/임시.jpg'/></a><br/><div class='slider_subject'>후기 제목이 들어갈 자리입니다 글자 넘어가면 워드컷</div><br/><p class='slider_txt'><span class='slider_username'>홍길동</span>님의 생생한 후기</p></div>"	
	
	var copyspeed=slidespeed
	leftrightslide='<nobr>'+leftrightslide.join(" ")+'</nobr>'
	var iedom=document.all||document.getElementById
	
	if (iedom)
	    document.write('<span id="temp" style="visibility:hidden;position:absolute;top:-100;left:-4000px">'+leftrightslide+'</span>')
	
	var actualwidth=''
	var cross_slide, ns_slide
	
	function fillup(){
	    if (iedom){
	        cross_slide=document.getElementById? document.getElementById("test2") : document.all.test2
	        cross_slide2=document.getElementById? document.getElementById("test3") : document.all.test3
	        cross_slide.innerHTML=cross_slide2.innerHTML=leftrightslide
	        actualwidth=document.all? cross_slide.offsetWidth : document.getElementById("temp").offsetWidth
	        cross_slide2.style.left=actualwidth+5 +"px"
	    }
	    else if (document.layers){
	        ns_slide=document.ns_slidemenu.document.ns_slidemenu2
	        ns_slide2=document.ns_slidemenu.document.ns_slidemenu3
	        ns_slide.document.write(leftrightslide)
	        ns_slide.document.close()
	        actualwidth=ns_slide.document.width
	        ns_slide2.left=actualwidth+5 +"px"
	        ns_slide2.document.write(leftrightslide)
	        ns_slide2.document.close()
	    }
	    lefttime=setInterval("slideleft()",30)
	}
	
	function slideleft(){
	    if (iedom){
	        if (parseInt(cross_slide.style.left)>(actualwidth*(-1)+5))
	            cross_slide.style.left=parseInt(cross_slide.style.left)-copyspeed +"px"
	        else
	            cross_slide.style.left=parseInt(cross_slide2.style.left)+actualwidth+5 +"px"
	
	        if (parseInt(cross_slide2.style.left)>(actualwidth*(-1)+5))
	            cross_slide2.style.left=parseInt(cross_slide2.style.left)-copyspeed +"px"
	        else
	            cross_slide2.style.left=parseInt(cross_slide.style.left)+actualwidth+5 +"px"
	
	    }
	    else if (document.layers){
	        if (ns_slide.left>(actualwidth*(-1)+5))
	            ns_slide.left-=copyspeed +"px"
	        else
	            ns_slide.left=ns_slide2.left+actualwidth+5 +"px"
	
	        if (ns_slide2.left>(actualwidth*(-1)+5))
	            ns_slide2.left-=copyspeed +"px"
	        else
	            ns_slide2.left=ns_slide.left+actualwidth+5 +"px"
	    }
	}
	
	
		if (iedom||document.layers){
	 		with (document){
	  			document.write('<div style="padding:3px 0 0 365px; background:white;">')
	  		if (iedom){
	   			write('<div style="position:relative;width:'+sliderwidth+'px;height:'+sliderheight+'px;overflow:hidden">')
	   			write('<div style="position:absolute;width:'+sliderwidth+'px;height:'+sliderheight+'px;background-color:'+slidebgcolor+'" onfocus="copyspeed=0" onblur="copyspeed=slidespeed" onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed">')
	   			write('<div id="test2" style="position:absolute;left:0px;top:0px"></div>')
	   			write('<div id="test3" style="position:absolute;left:-1000px;top:0px"></div>')
	   			write('</div></div>')
	 	}
			else if (document.layers){
	   			write('<ilayer width='+sliderwidth+' height='+sliderheight+' name="ns_slidemenu" bgColor='+slidebgcolor+'>')
	   			write('<layer name="ns_slidemenu2" left="0px" top="0px" onfocus="copyspeed=0" onblur="copyspeed=slidespeed" onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed"></layer>')
	   			write('<layer name="ns_slidemenu3" left="0px" top="0px" onfocus="copyspeed=0" onblur="copyspeed=slidespeed" onMouseover="copyspeed=0" onMouseout="copyspeed=slidespeed"></layer>')
	   			write('</ilayer>')
				}
			}
		}
</script>
<noscript></noscript>
<script type="text/javascript">fillup();</script><noscript></noscript>
</div>

<div class="bg_bikemap">
	<img class="star" src="<%=request.getContextPath() %>/img/img_main/bg_bikemap.png"/>
</div>
