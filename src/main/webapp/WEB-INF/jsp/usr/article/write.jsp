<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="게시물 작성"/>
<%@include file="../common/head.jspf" %>
<%@include file="../../common/toastUiEditorLib.jspf" %>

<c:set var="fileInputMaxCount" value="2" />
<script>
ArticleAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
</script>

<script>
	let ArticleWrite__submitDone = false;
	function ArticleWrite__submit(form) {
		if ( ArticleWrite__submitDone ) {
			alert("처리중입니다.");
			return;
		}
		
		form.boardId.value = form.boardId.value.trim();
		
		if ( form.boardId.value.length == 0 ) {
			alert('게시판을 선택해주세요.');
			form.boardId.focus();
			return;
		}
		
		form.title.value = form.title.value.trim();
		
		if ( form.title.value.length == 0 ) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}
		
		const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		
		if ( markdown.length == 0 ) {
			alert('내용을 입력해주세요.');
			editor.focus();
			return;
		}
		
		form.body.value = markdown;
		
		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024;
		for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
			const input = form["file__article__0__common__attachment__" + inputNo];
			
			if (input.value) {
				if (input.files[0].size > maxSize) {
					alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
					input.focus();
					
					return;
				}
			}
		}
		
		const startSubmitForm = function(data) {
			if (data && data.body && data.body.genFileIdsStr) {
				form.genFileIdsStr.value = data.body.genFileIdsStr;
			}
			
			for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
				const input = form["file__article__0__common__attachment__" + inputNo];
				input.value = '';
			}
			
			form.submit();
		};
		
		const startUploadFiles = function(onSuccess) {
			var needToUpload = false;
			for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
				const input = form["file__article__0__common__attachment__" + inputNo];
				if ( input.value.length > 0 ) {
					needToUpload = true;
					break;
				}
			}
			
			if (needToUpload == false) {
				onSuccess();
				return;
			}
			
			var fileUploadFormData = new FormData(form);
			
			$.ajax({
				url : '/common/genFile/doUpload',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}
		
		ArticleWrite__submitDone = true;
		startUploadFiles(startSubmitForm);
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
	<form class="table-box-type-1" method="POST" enctype="multipart/form-data" action="../article/doWrite" onsubmit="ArticleWrite__submit(this); return false;">
	  <input type="hidden" name="body"/>
	  <input type="hidden" name="genFileIdsStr" value="" />
	
      <table>
      <colgroup>
        <col width="200"/>
      </colgroup>
        <tbody>
        <tr>
            <th>게시판</th>
            <td>
            <select name="boardId" class="select select-bordered max-w-x">
            	<option selected disabled>게시판을 선택해주세요.</option>
            	<option value="1">공지</option>
            	<option value="2">자유</option>
            </select>
            </td>
          </tr>
          <tr>
            <th>작성자</th>
            <td>${rq.loginedMember.nickname}</td>
          </tr>
          <tr>
          <c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
          	<tr>
	            <th>첨부파일 ${inputNo}</th>
	            <td>
	            	<input type="file" name="file__article__0__common__attachment__${inputNo}" class="cursor-pointer"/>
	            </td>
            </tr>
          </c:forEach>
          <tr>
            <th>제목</th>
            <td>
              <input required="required" type="text" class="w-96 input input-bordered max-w-xs" name="title" placeholder="제목" value="${article.title}"/>
            </td>
          </tr>
          <tr>
            <th>내용</th>
            <td>
              <div class="toast-ui-editor">
              	<script type="text/x-template">${article.body}</script>
              </div>
            </td>
          </tr>
          <tr>
            <th>작성</th>
            <td>
              <input type="submit" class="btn btn-primary" value="작성"/>
              <button type="button" class="btn btn-outline btn-primary" onclick="history.back();">뒤로가기</button>
            </td>
          </tr>
        </tbody>
      </table>
	</form>
  </div>
</section>

<%@include file="../common/foot.jspf" %>