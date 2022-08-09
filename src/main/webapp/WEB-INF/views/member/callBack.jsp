<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("krTpGmw1srdtf8k1XhLL", "http://www.wisebookshop.com/member/naver.do");
  // 접근 토큰 값 출력
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	  
	
	var email = naver_id_login.getProfileData('email');
	var gender = naver_id_login.getProfileData('gender');
	var birthday = naver_id_login.getProfileData('birthday');
	var birthyear = naver_id_login.getProfileData('birthyear');
	var name = naver_id_login.getProfileData('name');
	var mobile = naver_id_login.getProfileData('mobile');
    
	var url = "${contextPath}/member/naverLoginPro.do?email="+email+"&gender="+gender;
 		url += "&birthday="+birthday+"&birthyear="+birthyear+"&name="+name+"&mobile="+mobile;
	
	location.href=url;
	
	window.close();
  }
</script>
</body>
</html>