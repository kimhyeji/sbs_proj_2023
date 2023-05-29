<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="게시물 수정"/>
<%@include file="../common/head.jspf" %>
<%@include file="../../common/toastUiEditorLib.jspf" %>

<c:set var="fileInputMaxCount" value="2" />
<script>
ArticleModify__fileInputMaxCount = parseInt("${fileInputMaxCount}");
const articleId = parseInt("${article.id}");
</script>

<script>
	let ArticleModify__submitDone = false;
	function ArticleModify__submit(form) {
		if ( ArticleModify__submitDone ) {
			alert("처리중입니다..");
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

		for ( let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++ ) {
			const input = form["file__article__" + articleId + "__common__attachment__" + inputNo];
			
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
			
			for ( let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++ ) {
				const input = form["file__article__" + articleId + "__common__attachment__" + inputNo];
				input.value = '';
			}

			for ( let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++ ) {
				const input = form["deleteFile__article__" + articleId + "__common__attachment__" + inputNo];

				if ( input ) {
					input.checked = false;
				}
			}
			
			form.submit();
		};

		const startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			for ( let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++ ) {
				const input = form["file__article__" + articleId + "__common__attachment__" + inputNo];

				if ( input.value.length > 0 ) {
					needToUpload = true;
					break;
				}
			}

			if ( needToUpload == false ) {
				for ( let inputNo = 1; inputNo <= ArticleModify__fileInputMaxCount; inputNo++ ) {
					const input = form["deleteFile__article__" + articleId + "__common__attachment__" + inputNo];

					if ( input && input.checked ) {
						needToUpload = true;
						break;
					}
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
				enctype: 'multipart/form-data',
				success : onSuccess
			});
		}
		
		ArticleModify__submitDone = true;

		startUploadFiles(startSubmitForm);		
	}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
	<form class="table-box-type-1" method="POST" enctype="multipart/form-data" action="../article/doModify" onsubmit="ArticleModify__submit(this); return false;">
	  <input type="hidden" name="id" value="${article.id}"/>
	  <input type="hidden" name="genFileIdsStr" value="" />
	  <input type="hidden" name="body"/>
	
      <table>
      <colgroup>
        <col width="200"/>
      </colgroup>
        <tbody>
          <tr>
            <th>번호</th>
            <td>${article.id}</td>
          </tr>
          <tr>
            <th>작성날짜</th>
            <td>${article.getRegDateForPrint()}</td>
          </tr>
          <tr>
            <th>수정날짜</th>
            <td>${article.getUpdateDateForPrint()}</td>
          </tr>
          <tr>
            <th>작성자</th>
            <td>${article.extra__writerName}</td>
          </tr>
          <tr>
            <th>조회수</th>
            <td>
            	<span class="text-blue-700 article-detail__hit-count">${article.hitCount}</span>
			</td>
          </tr>
          <tr>
            <th>추천</th>
            <td>
            	<span class="text-blue-700">${article.goodReactionPoint}</span>
			</td>
          </tr>
          <tr>
            <th>제목</th>
            <td>
              <input type="text" class="w-96 input input-bordered w-full max-w-xs" name="title" placeholder="제목" value="${article.title}"/>
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
            <th>내용</th>
            <td>
              <c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
				<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
                <c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
				<div class="form-row flex flex-col lg:flex-row">
					<div class="lg:flex lg:items-center lg:w-28">
						<span>첨부파일 ${inputNo}</span>
					</div>
					<div class="lg:flex-grow input-file-wrap">
						<input type="file" name="file__article__${article.id}__common__attachment__${inputNo}"
							class="form-row-input w-full rounded-sm" />
						<c:if test="${file != null}">
							<div>
								<a href="${file.downloadUrl}" target="_blank" class="text-blue-500 hover:underline" href="#">${file.originFileName}</a> ( ${Util.numberFormat(file.fileSize)} Byte )
							</div>
							<div>
								<label>
									<input onclick="$(this).closest('.input-file-wrap').find(' > input[type=file]').val('')" type="checkbox" name="deleteFile__article__${article.id}__common__attachment__${fileNo}" value="Y" />
									<span>삭제</span>
                            	</label>
							</div>
							<c:if test="${file.fileExtTypeCode == 'img'}">
	                            <div class="img-box img-box-auto">
	                            	<a class="inline-block" href="${file.forPrintUrl}" target="_blank" title="자세히 보기">
	                            		<img class="max-w-sm" src="${file.forPrintUrl}">
	                            	</a>
	                            </div>
                            </c:if>
						</c:if>
					</div>
				</div>
			</c:forEach>
            </td>
          </tr>
          
          <tr>
            <th>수정</th>
            <td>
              <input type="submit" class="btn btn-primary" value="수정"/>
              <button type="button" class="btn btn-outline btn-primary" onclick="history.back();">뒤로가기</button>
            </td>
          </tr>
        </tbody>
      </table>   
	
	  <div class="btns">
		<button class="btn btn-link" type="button" onclick="history.back();">뒤로가기</button>
		<a class="btn btn-link" href="../article/modify?id=${article.id}">게시물 수정</a>
		
		<c:if test="${article.extra__actorCanDelete}">
			<a class="btn btn-link" onclick="if( confirm('정말 삭제하시겠습니까?') == false )return false;" href="../article/doDelete?id=${article.id}">게시물 삭제</a>
		</c:if>	
	  </div>
	</form>
  </div>
</section>
<%@include file="../common/foot.jspf" %>