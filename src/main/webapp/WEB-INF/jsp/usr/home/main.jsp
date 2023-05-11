<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="메인" />
<%@include file="../common/head.jspf"%>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.min.js"></script>
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>
<script src="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.js"></script>
<script src=""></script>

<section class="mt-5">
		<div class="container mx-auto px-3">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo beatae
				veniam placeat odio voluptatibus est error consequatur enim optio consectetur sunt accusantium molestiae cupiditate
				quis repellendus facere atque ducimus velit.</div>


		<h1>Toast UI</h1>
		<h2 id="calendarTitle"></h2>
		<div>
				<button type="button" class="btn btn-default js-calendar-prev">&lt;</button>
				<button type="button" class="btn btn-default js-calendar-next">&gt;</button>
				<button type="button" class="btn btn-default js-calendar-month-view">Month</button>
				<button type="button" class="btn btn-default js-calendar-week-view">Week</button>
				<button type="button" class="btn btn-default js-calendar-day-view">Day</button>
		</div>
		<div id="calendar">
</section>

<script>
$(function () {
	  
	  // Function declaration to support header text
	  function setCalendarTitleText() {
	    var calendarTitle = document.getElementById('calendarTitle');    
	    var viewName = calendar.getViewName();
	    var curDate = calendar.getDate()
	    if (viewName === 'day') {
	      calendarTitle.innerText = (curDate.getMonth()+1) + '/' + curDate.getDate() + '/' + curDate.getFullYear()
	    } else {
	      calendarTitle.innerText = (curDate.getMonth()+1) + '/' + curDate.getFullYear()
	    }
	  }
	  // Example schedules
	  var schedules = [
	    {
	      id: '1',
	      calendarId: '1',
	      title: 'Halloween',
	      category: 'allday',
	      color: '#000000',
	      bgColor:'#eb6123',
	      isAllDay: true,
	      isVisible: true,
	      isPrivate: false,
	      start: '2018-10-30T00:00:00Z',
	    },
	    {
	      id: '2',
	      calendarId: '2',
	      title: 'Event ID: 2',
	      category: 'time',
	      isAllDay: false,
	      isVisible: true,
	      isPrivate: false,
	      start: '2018-10-23T17:30:00-05:00',
	      end: '2018-10-23T19:00:00-05:00'
	    },
	    {
	      id: '3',
	      calendarId: '2',
	      title: 'Event ID: 3',
	      category: 'time',
	      isAllDay: false,
	      isVisible: true,
	      isPrivate: false,
	      start: '2018-10-24T17:30:00-05:00',
	      end: '2018-10-24T19:00:00-05:00'
	    },
	    {
	      id: '4',
	      calendarId: '2',
	      title: 'Event ID: 4',
	      category: 'time',
	      isAllDay: false,
	      isVisible: true,
	      isPrivate: false,
	      start: '2018-10-01T17:30:00-05:00',
	      end: '2018-10-3T19:00:00-05:00'
	    }
	  ];
	  
	  
	  
	  // Initialize the calendar
	  var calendar = new tui.Calendar('#calendar', {
	    defaultView: 'month',
	    isReadOnly: false,
	    useDetailPopup: true,
	    useCreationPopup: true,
	  });
	  
	  // Add events to the calendar
	  calendar.createSchedules(schedules, true);
	    
	  // Bind some commonly used events
	  $('.js-calendar-next').on('click', function() {
	    calendar.next();
	    setCalendarTitleText();
	  });

	  $('.js-calendar-prev').on('click', function() {
	    calendar.prev();
	    setCalendarTitleText();
	  });

	  $('.js-calendar-today').on('click', function() {
	    calendar.today();
	    setCalendarTitleText();
	  });

	  $('.js-calendar-day-view').on('click', function() {
	    calendar.changeView('day', true);
	    setCalendarTitleText();
	  });

	  $('.js-calendar-week-view').on('click', function() {
	    calendar.changeView('week', true);
	    setCalendarTitleText();
	  });

	  $('.js-calendar-month-view').on('click', function() {
	    calendar.changeView('month', true);
	    setCalendarTitleText();
	  });
	  
	  setCalendarTitleText();
	});
</script>

<%@include file="../common/foot.jspf"%>