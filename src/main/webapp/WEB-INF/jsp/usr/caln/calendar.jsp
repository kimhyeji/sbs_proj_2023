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
<script src="/resource/caln/caln.js" defer="defer"></script>

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




<%@include file="../common/foot.jspf"%>