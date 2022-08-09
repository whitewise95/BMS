<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
<c:if test='${not empty message}'>
	<script>
		$().ready(function(){
			alert("아이디와 비밀번호를 확인하세요.");
		});
	</script>
</c:if>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('c5ed9dec78dd7f299b5fb58df983c3f4'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response);
        	  
        		var email = response.kakao_account.email;
        		var gender = response.kakao_account.gender;
        		var nickname = response.kakao_account.profile.nickname;
        		
        		 location.href='${contextPath}/member/cacaoRogin.do?email='+email+"&gender="+gender+"&nickname="+nickname;
        		
        	  
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
</head>
<body>
	<h1>Login in to BMS</h1>
	<br>
	<form action="${contextPath}/member/login.do" method="post">
		<table class="table table-hover">
			<colgroup>
				<col width="20%">
				<col width="60%">
			</colgroup>
			<tr>
				<td align="center"><label for="memberId">아이디</label></td>
				<td><input class="form-control" id="memberId" name="memberId" type="text" placeholder="아이디를 입력하세요." /></td>
			</tr>
			<tr align="center">
				<td><label for="memberPw">비밀번호</label></td>
				<td><input class="form-control" id="memberPw" name="memberPw" type="password" placeholder="비밀번호를 입력하세요." /></td>
			</tr>
			<tr >
				<td colspan="2" align="right"><input type="submit" class="btn btn-primary btn-sm" value="로그인">
				<input type="button" class="btn btn-primary btn-sm" value="아이디찾기" onclick="location.href='${contextPath}/member/findIdAndPw.do?whatFind=id'">
				<input type="button" class="btn btn-primary btn-sm" value="비밀번호찾기" onclick="location.href='${contextPath}/member/findIdAndPw.do?whatFind=pw'"></td>
			</tr>
		</table>
		<table>
		<tr>
			<td style="padding-left: 650px">
			<td colspan="2"></td>
			<td>
		</tr>
			<tr >
				<td id="naver_id_login" colspan="1"  align="right">
			</td>
			 <td align="right"  colspan="2">
				 <img onclick="kakaoLogin();" alt="" src="${contextPath }/resources/image/kakao_login_medium.png" >
			</td>
			</tr>
		</table>
		<p align="center">
   			<img src="${contextPath }/resources/image/bms_logo1.png" width=300>
   		</p>
	</form>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
	 <script type="text/javascript">
	  	var naver_id_login = new naver_id_login("krTpGmw1srdtf8k1XhLL", "http://www.wisebookshop.com/member/naver.do");
	  	var state = naver_id_login.getUniqState();
	  	naver_id_login.setButton("white", 2,40);
	  	naver_id_login.setState(state);
	  	naver_id_login.init_naver_id_login()
	</script> 	
</body>
</html>