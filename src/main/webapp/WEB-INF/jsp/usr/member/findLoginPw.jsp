<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="비밀번호 찾기"/>
<%@include file="../common/head.jspf" %>

<script>
	  let MemberfindLoginPw__submitDone = false;
	  function MemberfindLoginPw__submit(form) {
	    if (MemberfindLoginPw__submitDone) {
	      alert('처리중입니다.');
	      return;
	    }
	    
		form.loginId.value = form.loginId.value.trim();
	    
	    if (form.loginId.value.length == 0) {
	        alert('로그인아이디를 입력해주세요.');
	        form.loginId.focus();
	        return;
	    }
	
	    
		form.email.value = form.email.value.trim();
	    
	    if (form.email.value.length == 0) {
	        alert('이메일을 입력해주세요.');
	        form.email.focus();
	        return;
	    }
	    
	    MemberfindLoginPw__submitDone = true;
	    form.submit();
	  }
</script>

<section class="mt-5">
  <div class="container mx-auto">
	  <form class="table-box-type-1" method="POST" action="../member/doFindLoginPw" onsubmit="MemberfindLoginPw__submit(this); return false;">
	  <input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri}"/>
		  <table>
			  <colgroup>
			  	<col width="200"/>
			  </colgroup>
			  <tbody>
			  	<tr>
			  		<th>로그인아이디</th>
			  		<td>
			  			<input type="text" class="w-96 input input-bordered w-full max-w-xs" name="loginId" placeholder="로그인아이디"/>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>이메일</th>
			  		<td>
			  			<input type="email" class="w-96 input input-bordered w-full max-w-xs" name="email" placeholder="이메일"/>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>비밀번호 찾기</th>
			  		<td>
			  			<input type="submit" class="btn btn-primary" value="비밀번호 찾기"/>
			  			<button type="button" class="btn btn-outline btn-primary" onclick="history.back();">뒤로가기</button>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>비고</th>
			  		<td>
			  			<a href="${rq.loginUri}" class="btn btn-link">로그인</a>
			  			<a href="${rq.findLoginIdUri}" class="btn btn-link">아이디 찾기</a>
			  		</td>
			  	</tr>
			  </tbody>
		  </table>
	  </form>
  </div>
</section>

<%@include file="../common/foot.jspf" %>