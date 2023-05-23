function doDeleteEvent(arg) {
	var msg;
	if (confirm('일정을 삭제하시겠습니까?')) {
		$.post('../caln/doDeleteEventdoDeleteEvent', {
			id: arg.event.id
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

function addEvent(calendar, arg) {
	console.log(arg);

	$('#createEventModal').click();

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
}

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	$.get('../caln/getCalendar', {
		isAjax: 'Y',
		dataType: "json"
	}, function(data) {
		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
			},
			businessHours: false, // 주말 선택여부
			navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
			editable: true, // 수정 가능
			selectable: true,// 달력 일자 드래그 설정가능
			locale: 'ko', // 한국어 설정
			nowIndicator: true, // 현재 시간 마크
			dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)				
			events: data,
			eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
				console.log(obj);
			},
			eventClick: function(arg) { // 생성된 이벤트 클릭 시 발생되는 이벤트 => 일정삭제
				deleteSchedule(arg);
			},
			select: function(arg) { // 달력 클릭, 드래그 시 발생되는 이벤트 => 일정생성
				addSchedule(calendar, arg);
			}
		});
		calendar.render();
	}, 'json');
});