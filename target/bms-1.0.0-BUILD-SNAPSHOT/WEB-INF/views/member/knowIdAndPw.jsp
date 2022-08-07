<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<script>
	function isCheck(){
		
		var memberPw = document.getElementById("memberPw").value;
		var memberIdCheck = document.getElementById("memberIdCheck").value;
		
		if(memberPw.length < 7){
			alert("비밀번호를 8자 이상 사용해주세요");
			
			return false;
		}
		
		if(memberPw!= memberIdCheck){
			alert("두개의 패스워드가 맞지 않습니다. 다시 확인해주세요");
			
			return false;
		}
	
		
	}

</script>
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
</head>
<body>
	<h1>BMS</h1>
	<br>
		<form action="${contextPath }/member/passwordChage.do" method="post"  onsubmit="return isCheck()">
		<table class="table table-hover">
			<colgroup>
				<col width="20%">
				<col width="60%">
			</colgroup>
		<c:choose>
			<c:when test="${whatFind eq 'knowId'}">
			<tr>
			<td>
			</td>
				<td align="center" colspan="2" >아이디는 </td>
			</tr>
				<c:forEach var="i" items="${memberId }" varStatus="s">
			<tr>
				<td  align="center">
				  ${s.count }
				</td>
				<td align="center">
					${i.memberId }
				</td>
			</tr>
					</c:forEach>
			<tr>
			<td colspan="2" align="center">즐거운 시간 보내세요.</td>
			</tr>
			<tr >
				<td align="center" colspan="2"><input class="btn btn-primary btn-sm" onclick="location.href='${contextPath}/member/loginForm.do'" value="로그인하기">
				<input class="btn btn-primary btn-sm"  onclick="location.href='${contextPath}/main/main.do'" value="메인화면으로 이동"></td>
			</tr>
			</c:when>
			
			<c:when test="${whatFind eq 'knowPw'}">
			<tr>
				<td align="center"><label for="memberId">변경할 비밀번호 : </label></td>
				<td><input class="form-control" type="password" name="memberPw" id="memberPw"   placeholder="비밀번호를 입력해주세요" ></td>
			</tr>
			<tr>
				<td align="center">비밀번호 확인:</td>
				<td><input  class="form-control" type="password" name="memberIdCheck" id="memberIdCheck"  placeholder="확인을 위해 비밀번호 한번 더 입력해주세요"></td>
			</tr>
			<tr >
				<td align="center" colspan="2"><input class="btn btn-primary btn-sm" type="submit" value="변경하기">
				<input class="btn btn-primary btn-sm"  onclick="location.href='${contextPath}/main/main.do'" value="메인화면으로 이동">
				<input type="hidden" value="${memberId }" name="memberId">
				</td>
			</tr>
			</c:when >
			<c:otherwise>
			 	<tr>
			 		<td align="center">
			 			 <a  href="${contextPath}/member/loginForm.do"><img alt="" src="${contextPath}/resources/image/sorry.png" width="650"></a>
			 		</td>
			 	</tr>
			</c:otherwise>
		</c:choose>
		</table>
		</form>
		<p align="center">
   			<img src="${contextPath }/resources/image/bms_logo1.png" width=400>
   		</p>
</body>
</html>