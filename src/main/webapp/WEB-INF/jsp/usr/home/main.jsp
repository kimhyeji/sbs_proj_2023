<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="메인" />
<%@include file="../common/head.jspf"%>
<link rel="stylesheet" href="/resource/home/main.css" />

<section class="mt-5">
	<div class="container mx-auto px-3">
		Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo
		beatae veniam placeat odio voluptatibus est error consequatur enim
		optio consectetur sunt accusantium molestiae cupiditate quis
		repellendus facere atque ducimus velit.
	</div>
	<label for="my-modal" class="btn">open modal</label>

<!-- Put this part before </body> tag -->
<input type="checkbox" id="my-modal" class="modal-toggle" />
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