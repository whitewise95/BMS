<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
</head>
<body>
	<h1>BMS</h1>
	<br>
	<form action="${contextPath}/member/findIdAndPw.do" method="post">
		<table class="table table-hover">
			<colgroup>
				<col width="20%">
				<col width="60%">
			</colgroup>
			<c:if test="${whatFind eq 'id' }">
			<tr>
				<td align="center"><label for="memberName">이름</label></td>
				<td><input class="form-control" id="memberName" name="memberName" type="text" placeholder="이름을 입력하세요" /></td>
			</tr>
		 <tr>
	        <td align="center">
	        	<label class="small mb-1" for="memberBirthY">생년월일</label>
	        </td>
	        <td>
                <select class="form-control" id="memberBirthY" name="memberBirthY" style="display:inline; width:70px; padding:0" >
				<c:forEach var="year" begin="1" end="100">
					<c:choose>
						<c:when test="${year==80}">
							<option value="${1921+year}" selected>${ 1921+year}
							</option>
						</c:when>
						<c:otherwise>
							<option value="${1921+year}">${ 1921+year}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</select> 년 
				<select class="form-control" name="memberBirthM" style="display:inline; width:50px; padding:0">
				  <c:forEach var="month" begin="1" end="12">
				      <c:choose>
				        <c:when test="${month==5}">
					   <option value="${month}" selected>${month }</option>
					</c:when>
					<c:otherwise>
					  <option value="${month}">${month}</option>
					</c:otherwise>
					</c:choose>
				  	</c:forEach>
				</select> 월  
				<select class="form-control" name="memberBirthD" style="display:inline; width:50px; padding:0">
				<c:forEach var="day" begin="1" end="31">
				      <c:choose>
				        <c:when test="${day==10}">
					   <option value="${day}" selected>${day}</option>
					</c:when>
					<c:otherwise>
					  <option value="${day}">${day}</option>
					</c:otherwise>
					</c:choose>
				  	</c:forEach>
				</select> 일 &nbsp;
				<div class="custom-control custom-radio" style="display:inline;">
					<input class="custom-control-input" type="radio" id="memberBirthGn2" name="memberBirthGn" value="2" checked />
					<label class="custom-control-label" for="memberBirthGn2">양력</label>
				</div>  
				<div class="custom-control custom-radio" style="display:inline;">
					<input class="custom-control-input" type="radio" id="memberBirthGn1" name="memberBirthGn" value="1" />
					<label class="custom-control-label" for="memberBirthGn1">음력</label>
	            </div>  
	        </td>
        </tr> 
        </c:if>       
          <c:if test="${whatFind eq 'pw' }">
			<tr>
				<td align="center"><label for="memberId">아이디</label></td>
				<td><input class="form-control" id="memberId" name="memberId" type="text" placeholder="아이디를 입력하세요." /></td>
			</tr>
			<tr>
				<td align="center"><label for="memberName">이름</label></td>
				<td><input class="form-control" id="memberName" name="memberName" type="text" placeholder="이름을 입력하세요" /></td>
			</tr>
		 <tr>
	        <td align="center">
	        	<label class="small mb-1" for="memberBirthY">생년월일</label>
	        </td>
	        <td>
                <select class="form-control" id="memberBirthY" name="memberBirthY" style="display:inline; width:70px; padding:0" >
				<c:forEach var="year" begin="1" end="100">
					<c:choose>
						<c:when test="${year==80}">
							<option value="${1921+year}" selected>${ 1921+year}
							</option>
						</c:when>
						<c:otherwise>
							<option value="${1921+year}">${ 1921+year}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</select> 년 
				<select class="form-control" name="memberBirthM" style="display:inline; width:50px; padding:0">
				  <c:forEach var="month" begin="1" end="12">
				      <c:choose>
				        <c:when test="${month==5}">
					   <option value="${month}" selected>${month }</option>
					</c:when>
					<c:otherwise>
					  <option value="${month}">${month}</option>
					</c:otherwise>
					</c:choose>
				  	</c:forEach>
				</select> 월  
				<select class="form-control" name="memberBirthD" style="display:inline; width:50px; padding:0">
				<c:forEach var="day" begin="1" end="31">
				      <c:choose>
				        <c:when test="${day==10}">
					   <option value="${day}" selected>${day}</option>
					</c:when>
					<c:otherwise>
					  <option value="${day}">${day}</option>
					</c:otherwise>
					</c:choose>
				  	</c:forEach>
				</select> 일 &nbsp;
				<div class="custom-control custom-radio" style="display:inline;">
					<input class="custom-control-input" type="radio" id="memberBirthGn2" name="memberBirthGn" value="2" checked />
					<label class="custom-control-label" for="memberBirthGn2">양력</label>
				</div>  
				<div class="custom-control custom-radio" style="display:inline;">
					<input class="custom-control-input" type="radio" id="memberBirthGn1" name="memberBirthGn" value="1" />
					<label class="custom-control-label" for="memberBirthGn1">음력</label>
	            </div>  
	        </td>
        </tr> 
          </c:if>            
			<tr >
				<c:if test="${whatFind  eq 'pw'}" ><td colspan="2" align="right"><input type="submit" class="btn btn-primary btn-sm" value="패스워드찾기">
				<input type="reset" class="btn btn-primary btn-sm" value="다시 쓰기">
				</td></c:if>
				<c:if test="${whatFind  eq 'id'}" ><td colspan="2" align="right"><input type="submit" class="btn btn-primary btn-sm" value="아이디찾기">
				<input type="reset" class="btn btn-primary btn-sm" value="다시 쓰기">
				</td></c:if>
			</tr>
		</table>
		
		<p align="center">
   			<img src="${contextPath }/resources/image/bms_logo1.png" width=300>
   		</p>
   		<input type="hidden" value="${whatFind }" name="whatFind">
	</form>
</body>
</html>