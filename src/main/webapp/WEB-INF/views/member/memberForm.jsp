<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="${contextPath}/resources/jquery/jquery-3.5.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script >
	   function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname != '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName != '' && data.apartment == 'Y'){
	                   extraRoadAddr += (extraRoadAddr != '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr != ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                document.getElementById("jibunAddress").value = data.jibunAddress;
	       
	                } 
	   		 }).open();
	    }
	</script>
<script>
	$().ready(function() {
	
	
		
		
		$("#select_email").change(function(){
			
			var select_email = $("#select_email").val();
			
			if(select_email == 'none'){
				$("#email2").attr("disabled", false);
				$("#email2").val('');
			}
			else{
				$("#email2").val($("#select_email option:selected" ).val());
				$("#email2").attr("disabled", true);
			}
		});
		
		$("#btnOverlapped").click(function(){
			
		    var memberId = $("#memberId").val();
		   
		    if (memberId==''){
		   	 alert("ID를 입력하세요");
		   	 return;
		    }
		   
		    $.ajax({
		       type:"post",
		       async:false,  
		       url:"${contextPath}/member/overlapped.do",
		       dataType:"text",
		       data: {id:memberId},
		       success:function (data,textStatus){
		          if (data == 'false'){
		          	alert("사용할 수 있는 ID입니다.");
		          }
		          else {
		          	alert("사용할 수 없는 ID입니다.");
		          }
		       },
		       error:function(data,textStatus){
		          alert("적절하지 않은 값을 입력하였습니다. 다시 시도해주십시요.");
		          history.go(-1);
		       },
		    });
		    
		 });
		
		
		
		
		
		$("form").submit(function(){
			
			var memberId = $("#memberId").val();
			var memberPw = $("#memberPw").val();
			var password = $("#password").val();
			var memberName = $("#memberName").val();
			var Address = $("#roadAddress").val() + $("#jibunAddress").val(); 
			var email1 = $("#email1").val();
			var email2 = $("#email2").val();
			var hp2 = $("#hp2").val(); 
			var hp3 = $("#hp3").val(); 
			 
			
			if(memberId == '' ){
				alert("아이디를 입력해주세요")
				return false;
			}
			if(memberPw.length < 7 ){
				alert("비밀번호는 8자 이상 사용해주세요")
				return false;
			}
			if(password != memberPw ){
				alert("비밀번호가 같지 않습니다. 확인해주세요")
				return false;
			}
			if(memberName == '' ){
				alert("이름을 입력해주세요")
				return false;
			}
			if(email1 == '' || email2==''){
				alert("이메일을 입력해주세요")
				return false;
			}
			if(hp2.length < 4 || hp3.length < 4){
				alert("휴대번호를 확인해주세요")
				return false;
			}
			
			if(Address == '' ){
				alert("주소를 자세히 입력해주세요")
				return false;
			}
			return true;
			
		})
		
	});
</script>	
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
<link href="${contextPath }/resources/css/myStyle.css" rel="stylesheet" />
<style>
	td:first-child {
		text-align: center;
		font-weight: bold;
	}
</style>
</head>
<body>
	<form action="${contextPath}/member/addMember.do" method="post" onsubmit="return isCheck()">
	<h3>회원가입</h3>
	<table class="table table-bordered table-hover">
		<colgroup>
			<col width="20%" >
			<col width="80%">
		</colgroup>
		<tr>
			<td>
				<label for="memberId"><span style="color: red;">*</span>아이디</label>
			</td>
			<td>
	            <input type="text" class="form-control" style="display:inline; width:300px;" 
	            	name="memberId"  id="memberId" maxlength="15" placeholder="아이디를 입력하세요." />
	        	&emsp;<input type="button" id="btnOverlapped" class="btn btn-primary btn-sm" value="중복확인" />
	        </td>
	    </tr>
        <tr>
	        <td>
	        	 <label class="small mb-1" for="memberPw"><span style="color: red;">*</span>비밀번호</label>
	        </td>
	        <td>
	        	<input class="form-control" id="memberPw" name="memberPw" type="password" placeholder="비밀번호를 입력하세요." />
	        </td>
        </tr>
        <tr>
	        <td>
	        	 <label class="small mb-1"><span style="color: red;">*</span>비밀번호 확인</label>
	        </td>
	        <td>
	        	<input class="form-control" type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." />
	        </td>
        </tr>         
        <tr>
	        <td>
	        	<label class="small mb-1" for="memberName"><span style="color: red;">*</span>이름</label>
	        </td>
	        <td>
	        	<input type="text" class="form-control" name="memberName"  id="memberName" maxlength="15" placeholder="이름을 입력하세요." />
	        </td>
        </tr>                
	    <tr>
	        <td>
	        	<label for="g1"><span style="color: red;">*</span>성별</label>
	        </td>
	        <td>
	        	<input class="custom-control-input" type="radio" id="g1" name="memberGender" value="101" checked />
				<label class="custom-control-label" for="g1">남성</label>&emsp;&emsp;&emsp;
				<input class="custom-control-input" type="radio" id="g2" name="memberGender" value="102" />
				<label class="custom-control-label" for="g2">여성</label>
	        </td>
        </tr>                              
        <tr>
	        <td>
	        	<label class="small mb-1" for="memberBirthY"><span style="color: red;">*</span>생년월일</label>
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
        <tr>
	        <td>
	        	<label class="small mb-1" for="tel1">집 전화번호</label>
	        </td>
	        <td>
	        	<select class="form-control" id="tel1" name="tel1" style="display:inline; width:70px; padding:0">
					<option>없음</option>
					<option value="02" selected>02</option>
					<option value="031">031</option>
					<option value="032">032</option>
					<option value="033">033</option>
					<option value="041">041</option>
					<option value="042">042</option>
					<option value="043">043</option>
					<option value="044">044</option>
					<option value="051">051</option>
					<option value="052">052</option>
					<option value="053">053</option>
					<option value="054">054</option>
					<option value="055">055</option>
					<option value="061">061</option>
					<option value="062">062</option>
					<option value="063">063</option>
					<option value="064">064</option>													
				 </select> - 
		 		<input class="form-control" size="10px" type="text" name="tel2" style="display:inline; width:100px; padding:0" > - 
		 		<input class="form-control" size="10px" type="text" name="tel3" style="display:inline; width:100px; padding:0">
	        </td>
        </tr>                         
        <tr>
	        <td>
	        	<label class="small mb-1" for="hp1"><span style="color: red;">*</span>핸드폰 번호</label>
	        </td>
	        <td>
	        	<select  class="form-control" id="hp1" name="hp1" style="display:inline; width:70px; padding:0">
					<option>없음</option>
					<option selected value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
				</select> - 
				<input class="form-control"  size="10px"  type="text" name="hp2"  id="hp2" style="display:inline; width:100px; padding:0" maxlength="4"> - 
				<input class="form-control"  size="10px"  type="text"name="hp3" id="hp3" style="display:inline; width:100px; padding:0" maxlength="4"><br><br>
				<input class="custom-control-input" id="smsstsYn" type="checkbox" name="smsstsYn"  value="Y" checked/>
                <label for="smsstsYn" >BMS에서 발송하는 SMS 소식을 수신합니다.</label>
	        </td>
        </tr>                         
        <tr>
	        <td>
	        	<label class="small mb-1" for="email1"><span style="color: red;">*</span>이메일</label>
	        </td>
	        <td>
	        	<input class="form-control"  size="10px"  type="text" id="email1" name="email1" style="display:inline; width:100px; padding:0"> @ 
					<input class="form-control"  size="10px"  type="text" id="email2" name="email2" style="display:inline; width:100px; padding:0">
					<select class="form-control" id="select_email" name="email3" style="display:inline; width:100px; padding:0">
						 <option value="none" selected>직접입력</option>
						 <option value="gmail.com">gmail.com</option>
						 <option value="naver.com">naver.com</option>
						 <option value="daum.net">daum.net</option>
						 <option value="nate.com">nate.com</option>
					</select><br><br>
                    <input class="custom-control-input" id="emailstsYn" type="checkbox" name="emailstsYn"  value="Y" checked/>
                    <label for="emailstsYn">BMS에서 발송하는 E-mail을 수신합니다.</label>
	        </td>
        </tr>                              
        <tr>
	        <td>
	        	<label class="small mb-1" for="zipcode"><span style="color: red;">*</span>주소</label>
	        </td>
	        <td>
	        	<input class="form-control"  size="70px"  type="text" placeholder="우편번호 입력" id="zipcode" name="zipcode" style="display:inline; width:150px; padding:0">
                <input type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:execDaumPostcode()" value="검색">
                <div></div><br>
                도로명 주소 : <input type="text" class="form-control" id="roadAddress"  name="roadAddress" > <br>
				지번 주소 : <input type="text" class="form-control" id="jibunAddress" name="jibunAddress" > <br>
				나머지 주소: <input type="text" class="form-control" name="namujiAddress"/>
	        </td>
        </tr>                             
        <tr>
	        <td colspan="2">
	        	<input type="submit" value="회원가입하기" class="btn btn-primary btn-block" >
	        </td>
	    </tr>
	         		 <tr>
	        <td colspan="3" align="center">
	        	<div></div>
	        	이미 회원가입이 되어있다면 ? <a href="${contextPath}/member/loginForm.do"><strong>로그인하기</strong></a>
	        </td>
        </tr> 
	                       
     </table>
     </form>
		<table>
		<tr>
			<td style="padding-left: 300px">
			<td colspan="2"></td>
			<td>
		</tr>
			<tr >
			<td>
			</td>
			 <td align="left"  >
				 <img onclick="kakaoLogin();" alt="" src="${contextPath }/resources/image/kakao_login_medium.png" >
			</td>
			<td id="naver_id_login"   align="right">
			</td>
			</tr>
		</table>
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