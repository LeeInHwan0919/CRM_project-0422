<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>  
<%@include file="./header.jsp" %>
</head>
<body>
<div class="container">
<table class="table table-bordered" style="text-align: center;"> 
			<tr>
				<th>번호</th>
				<td>${bVo.seq}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>관리자</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${bVo.title}</td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td>${bVo.startdate}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea class="form-control" rows="10" cols="50" name="content" readonly>${bVo.content}</textarea>
				</td>
			</tr>
	</table>
	<div style="text-align: center;"><br>
<%-- 			<c:if test="${bVo.id eq member.id }"> --%>
			<button class="btn btn-default" onclick="location.href='./updateBoard.do?seq=${bVo.seq}'">수정</button>
<%-- 			</c:if> onclick="location.href='./deleteBoard.do?seq=${bVo.seq}'" --%>
			<button class="btn btn-default" onclick="deletboard()">삭제</button>
			<button class="btn btn-default" onclick="javascript:history.back(-1)" >목록</button>
		</div>
</div>
</body>


<%@include file="./footer.jsp" %>
</html>