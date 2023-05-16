<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="캘린더" />
<%@include file="../common/head.jspf"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js'></script>
<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<link rel="stylesheet" href="/resource/home/main.css" />

<section class="mt-5">
	<div class="container mx-auto px-3">
		<div id="calendar"></div>
	</div>
</section>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		$.get('../caln/getCalendar', {
			isAjax : 'Y',
			dataType : "json"
		}, function(data) {
			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
				},
				navLinks : true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
				editable : true, // 수정 가능
				selectable : true,// 달력 일자 드래그 설정가능
				locale : 'ko', // 한국어 설정
				nowIndicator : true, // 현재 시간 마크
				dayMaxEvents : true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)				
				events : data,
				select : function(arg) { // add event
					var title = prompt('Event Title:');
					if (title) {
						calendar.addEvent({
							title : title,
							start : arg.start,
							end : arg.end,
							allDay : arg.allDay
						})
					}
					calendar.unselect();
				},
				eventClick : function(arg) { // remove event
					if (confirm('일정을 삭제하시겠습니까?') == false) {
						return;
					}
				
					$.post('../caln/doDeleteSchedule', {
						id : arg.event.id
					}, function(data) {
						if (data.success) {
							arg.event.remove();
							alert(data.msg);
						} else {
							if (data.msg) {
								alert(data.msg);
							}
						}

					}, 'json');
				}
			});
			calendar.render();
		}, 'json');
	});
</script>


<%@include file="../common/foot.jspf"%>