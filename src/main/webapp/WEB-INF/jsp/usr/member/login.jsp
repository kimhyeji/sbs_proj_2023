<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="로그인"/>
<%@include file="../common/head.jspf" %>

<script>
	  let MemberLogin__submitDone = false;
	  function MemberLogin__submit(form) {
	    if (MemberLogin__submitDone) {
	      alert('처리중입니다.');
	      return;
	    }
	    
		form.loginId.value = form.loginId.value.trim();
	    
	    if (form.loginId.value.length == 0) {
	        alert('아이디를 입력해주세요.');
	        form.loginId.focus();
	        return;
	    }
	
	    form.loginPwInput.value = form.loginPwInput.value.trim();
	    
	    if (form.loginPwInput.value.length == 0) {
	        alert('비밀번호를 입력해주세요.');
	        form.loginPwInput.focus();
	        return;
	    }
	    
	    form.loginPw.value = sha256(form.loginPwInput.value);
	    form.loginPwInput.value = '';
	
	    MemberLogin__submitDone = true;
	    form.submit();
	  }
</script>

<section class="mt-5">
  <div class="container mx-auto">
	  <form class="table-box-type-1" method="POST" action="../member/doLogin" onsubmit="MemberLogin__submit(this); return false;">
	  <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>
	  <input type="hidden" name="loginPw" />
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
			  		<th>로그인비밀번호</th>
			  		<td>
			  			<input required="required" type="password" class="w-96 input input-bordered w-full max-w-xs" name="loginPwInput" placeholder="로그인비밀번호"/>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>로그인</th>
			  		<td>
			  			<input type="submit" class="btn btn-primary" value="로그인"/>
			  			<button type="button" class="btn btn-outline btn-primary" onclick="history.back();">뒤로가기</button>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>비고</th>
			  		<td>
			  			<a href="${rq.findLoginIdUri}" class="btn btn-link">아이디 찾기</a>
			  			<a href="${rq.findLoginPwUri}" class="btn btn-link">비밀번호 찾기</a>
			  		</td>
			  	</tr>
			  </tbody>
		  </table>
	  </form>
  </div>
</section>

<%@include file="../common/foot.jspf" %>