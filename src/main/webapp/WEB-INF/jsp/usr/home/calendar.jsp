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
		$.get('../home/getCalendar', {
			isAjax : 'Y',
			dataType : "json"
		}, function(data) {
			var calendar = new FullCalendar.Calendar(calendarEl, {
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
				},
				navLinks : true, // can click day/week names to navigate views
				businessHours : true, // display business hours
				editable : true,
				selectable : true,
				locale: 'ko',
				select: function (arg) { // add event
		          var title = prompt('Event Title:');
		          if (title) {
		            calendar.addEvent({
		              title: title,
		              start: arg.start,
		              end: arg.end,
		              allDay: arg.allDay
		            })
		          }
		          calendar.unselect();
		        },
		        eventClick: function (arg) { // remove event
		          if (confirm('Are you sure you want to delete this event?')) {
		            arg.event.remove();
		          }
		        },
		        events: data
			});
		        calendar.render();
		}, 'json');
	});
</script>


<%@include file="../common/foot.jspf"%>