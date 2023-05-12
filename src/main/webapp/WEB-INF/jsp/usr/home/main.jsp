<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="메인" />
<%@include file="../common/head.jspf"%>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.css" />
<link rel="stylesheet" type="text/css"	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" type="text/css"	href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
					  
<script	src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.dom/v3.0.0/tui-dom.js"></script>
<script	src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
<script	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>
<script	src="https://uicdn.toast.com/tui-calendar/latest/tui-calendar.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js"></script>

<link rel="stylesheet" href="/resource/home/main.css" />

<section class="mt-5">
	<div class="container mx-auto px-3">
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo
		beatae veniam placeat odio voluptatibus est error consequatur enim
		optio consectetur sunt accusantium molestiae cupiditate quis
		repellendus facere atque ducimus velit.

		<hr />
		<h1>Toast Calendar</h1>
		<span id="renderRange" class="render-range"></span>
		<div id="menu-navi" class="btn-wrap flex">
			<button type="button" class="btn btn-outline btn-sm" data-action="move-prev">
				<i class="fas fa-caret-left"></i>
			</button>
			<button type="button" class="btn btn-outline btn-sm" data-action="move-today">Today</button>
			<button type="button" class="btn btn-outline btn-sm" data-action="move-next">
				<i class="fas fa-caret-right"></i>
			</button>
			<button type="button" class="btn btn-outline btn-sm" data-action="move-month-view">Month</button>
			<button type="button" class="btn btn-outline btn-sm" data-action="move-week-view">Week</button>
			<button type="button" class="btn btn-outline btn-sm" data-action="move-day-view">Day</button>
		</div>
		
		<div id="calendar"></div>
	</div>	
</section>

<script src="/resource/home/main.js"></script>

<%@include file="../common/foot.jspf"%>