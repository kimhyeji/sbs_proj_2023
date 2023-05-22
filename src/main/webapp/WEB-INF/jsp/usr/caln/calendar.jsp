<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="캘린더" />
<%@include file="../common/head.jspf"%>
<!-- fullcalendar 설정관련 script -->
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js'></script>

<!-- fullcalendar 언어 설정관련 script -->
<script	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

<link rel="stylesheet" href="/resource/caln/caln.css" />

<section class="mt-5">
	<div class="container mx-auto px-3">
		<div id='calendar'></div>
	</div>
	
	<label for="my-modal" class="btn">open modal</label>
	
	<div class="modal">
	  <div class="modal-box">
	    <h3 class="font-bold text-lg">Congratulations random Internet user!</h3>
	    <p class="py-4">You've been selected for a chance to get one year of subscription to use Wikipedia for free!</p>
	    <div class="modal-action">
	      <label for="my-modal" class="btn">Yay!</label>
	    </div>
	  </div>
	</div>
</section>

<script>
	function deleteSchedule(arg) {
		var msg;
		if (confirm('일정을 삭제하시겠습니까?')) {
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
		return msg;
	}

	function addSchedule(calendar, arg) {
		console.log(arg);
		
		$('#createEventModal').click();
		
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
	}

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
				businessHours : false, // 주말 선택여부
				navLinks : true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
				editable : true, // 수정 가능
				selectable : true,// 달력 일자 드래그 설정가능
				locale : 'ko', // 한국어 설정
				nowIndicator : true, // 현재 시간 마크
				dayMaxEvents : true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)				
				events : data,
				eventChange : function(obj) { // 이벤트가 수정되면 발생하는 이벤트
					console.log(obj);
				},
				eventClick : function(arg) { // 생성된 이벤트 클릭 시 발생되는 이벤트 => 일정삭제
					deleteSchedule(arg);
				},
				select : function(arg) { // 달력 클릭, 드래그 시 발생되는 이벤트 => 일정생성
					addSchedule(calendar, arg);
				}
			});
			calendar.render();
		}, 'json');
	});
</script>


<%@include file="../common/foot.jspf"%>