<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
<c:set var="orderer_hp" 			 value=""/>			<!-- 주문자 휴대폰 번호 -->
<c:set var="final_total_order_price" value="0" />		<!-- 최종 결제 금액 -->
<c:set var="total_order_price"       value="0" />		<!-- 총주문 금액 -->
<c:set var="total_order_goods_qty"   value="0" />		<!-- 총 상품수 -->
<c:set var="total_discount_price"    value="0" />		<!-- 총할인금액 -->
<c:set var="total_delivery_price"    value="0" />		<!-- 총 배송비 -->

<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup_order_detail {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 10%;
	top: 0%;
	width: 60%;
	height: 100%;
	background-color:#ccff99;
	border: 2px solid  #0000ff;
}

#close {
	z-index: 4;
	float: right;
}
</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if (data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if (extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	            if (fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('roadAddress').value = fullRoadAddr;
	            document.getElementById('jibunAddress').value = data.jibunAddress;
	
	         
	        }
	    }).open();
	}
	
	
	function fn_pay_phone(){
		var e_card  = document.getElementById("tr_pay_card");
		var e_phone = document.getElementById("tr_pay_phone");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="visible";
	}

	
	function fn_pay_card(){
		var e_card  = document.getElementById("tr_pay_card");
		var e_phone = document.getElementById("tr_pay_phone");
		e_card.style.visibility="visible";
		e_phone.style.visibility="hidden";
	}
	
	function f() {
		
		
		var Hp1 = document.getElementById("Hp1");
		var Hp2 = document.getElementById("Hp2");
		var Hp3 = document.getElementById("Hp3");
		var i_zipcode          = document.getElementById("zipcode");
		var i_roadAddress      = document.getElementById("roadAddress");
		var i_jibunAddress     = document.getElementById("jibunAddress");
		var i_namujiAddress    = document.getElementById("namujiAddress");
		var i_delivery_message = document.getElementById("delivery_message");
		var i_pay_method       = document.getElementById("pay_method");
		var payMethod = document.getElementsByName("payMethod");
		for (var i = 0; i < payMethod.length; i++) {
			if(payMethod[i].checked==true){
				payMethod = payMethod[i].value;
				if(payMethod == "휴대폰결제"){
					var i_pay_order_tel1 = document.getElementById("pay_order_tel1");
					var i_pay_order_tel2 = document.getElementById("pay_order_tel2");
					var i_pay_order_tel3 = document.getElementById("pay_order_tel3");
					if(i_pay_order_tel1.value.length <4 || i_pay_order_tel2.value.length <4 || i_pay_order_tel3.value.length <4){
						alert("휴대폰결제번호를 정확하게 입력해주세요]");
						return false;
					}
				  } 
			}
		}
	
		
		
		
		
		if( Hp2.value.length < 4 || Hp3.value.length < 4) {
			alert("휴대폰 번호를 정확하게 입력해주세요");
			return false;
		}
		
		
		
		
		if(i_roadAddress.value == '' || i_jibunAddress.value == '' ){
			alert("주소를 정확하게 입력해주세요");
			return false;
		}

		
	
  }
		
</script>
</head>
<body>
	<h1>1.주문확인</h1>
<form  name="form_order" action="${contextPath}/mybag/myBagOrderPro.do" method="post" onsubmit="return f()">	
	<table class="list_view">
		<tbody align=center>
			<tr style="background: #33ff00">
				<td colspan=2 class="fixed">주문상품명</td>
				<td>수량</td>
				<td>주문금액</td>
				<td>배송비</td>
				<td>예상적립금</td>
				<td>주문금액합계</td>
			</tr>
			<c:forEach var="item" items="${mbList }"  varStatus="status" >
				<tr>
					<td colspan=2 class="fixed">
					  <h2>
					     <a href="${pageContext.request.contextPath}/goods/goods.do?command=goodsDetail&goodsId=${item.bagGoodsId }">${item.bagGoodsTitle }</A>
					      <input type="hidden" id="goodsTitle" name="goodsTitle" value="${item.bagGoodsTitle }" />
					  </h2>
					</td>
					<td>
					  <h2>${item.bagGoodsQty }개</h2>
					    <input type="hidden" id="orderGoodsQty" name="orderGoodsQty" value="${totalQTY}" />
					</td>
					<td><h2>${item.bagGoodsPrice}원</h2>
					 <input type="hidden" id="goodsSalesPrice" name="goodsSalesPrice" value="${totalPrice}" /></td>
					<td><h2>0원</h2></td>
					<td><h2>${0 *item.bagGoodsQty}원</h2></td>
					<td>
					  <h2>${item.bagGoodsPrice * item.bagGoodsQty}원 ,  </h2>
					  <input type="hidden" name="goodsId" value="${item.goodsId }">
					  <input type="hidden" id="h_each_goods_price"  name="h_each_goods_price" value="${item.bagGoodsPrice * item.bagGoodsQty}" />
					</td>
			</tr>
			<c:set var="final_total_order_price" value="${final_total_order_price+ item.bagGoodsPrice* item.bagGoodsQty}" />
			<c:set var="total_order_price"       value="${total_order_price+ item.bagGoodsPrice* item.bagGoodsQty}" />
			<c:set var="total_order_goods_qty"   value="${total_order_goods_qty + item.bagGoodsQty }" />
			<tr>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="clear"></div>

	<br>
	<br>
	<H1>2.배송지 정보</H1>
	<DIV class="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">배송방법</td>
					<td>
					    <input type="radio" id="deliveryMethod" name="deliveryMethod" value="일반택배" checked>일반택배 &nbsp;&nbsp;&nbsp; 
						<input type="radio" id="deliveryMethod" name="deliveryMethod" value="편의점택배">편의점택배 &nbsp;&nbsp;&nbsp; 
						<input type="radio" id="deliveryMethod" name="deliveryMethod" value="해외배송">해외배송 &nbsp;&nbsp;&nbsp;
				    </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">배송지 선택</td>
					<td><input type="radio" name="delivery_place"
						onClick="restore_all()" value="기본배송지" checked>기본배송지 &nbsp;&nbsp;&nbsp; 
						<input type="radio" name="delivery_place" value="새로입력" onClick="reset_all()">새로입력 &nbsp;&nbsp;&nbsp;
						<input type="radio" name="delivery_place" value="최근배송지">최근배송지 &nbsp;&nbsp;&nbsp;
				    </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">받으실 분</td>
					<td><input id="receiverName" name="receiverName" type="text" size="40" value="${orderer.memberName }" />
					   <input type="hidden" id="receiverName" name="receiverName"  value="${orderer.memberName }" /> 
					   <input type="hidden" id="receiverName" name="receiverName"  value="${orderer.memberName }" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td><select id="Hp1" name="Hp1">
							<option value="010" selected>010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
					</select> 
					 - <input size="10px" type="text" id="Hp2" name="Hp2" value="${orderer.hp2 }"  maxlength="4"> 
					 - <input size="10px" type="text" id="Hp3" name="Hp3" value="${orderer.hp3 }"  maxlength="4"><br><br> 
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">유선전화(선택)</td>
					<td><select id="Tel1" name="Tel1">
							<option value="02">02</option>
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
							<option value="0502">0502</option>
							<option value="0503">0503</option>
							<option value="0505">0505</option>
							<option value="0506">0506</option>
							<option value="0507">0507</option>
							<option value="0508">0508</option>
							<option value="070">070</option>
					</select> - <input size="10px" type="text" id="receiverTel2" name="receiverTel2" value="${orderer.tel2 }"> - <input size="10px" type="text" id="receiverTel3" name="receiverTel3" value="${orderer.tel3 }">

					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td><input type="text" id="zipcode" name="zipcode" size="5"
						value="${orderer.zipcode }"> 
						<a href="javascript:execDaumPostcode()">우편번호검색</a> <br>
						<p>
							지번 주소:<br>
							<input type="text" id="roadAddress" name="roadAddress" size="50" value="${orderer.roadAddress }" /><br>
							<br> 
							도로명 주소: 
							<input type="text" id="jibunAddress" name="jibunAddress" size="50" value="${orderer.jibunAddress }" /><br>
							<br> 
							나머지 주소: 
							<input type="text" id="namujiAddress"  name="namujiAddress" size="50" value="${orderer.namujiAddress }" /> 
						</p> 
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">배송 메시지</td>
					<td>
					   <input id="deliveryMessage" name="deliveryMessage" type="text" size="50"
						                   placeholder="택배 기사님께 전달할 메시지를 남겨주세요." />
				     </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">선물 포장</td>
					<td><input type="radio" id="giftWrapping" name="giftWrapping" value="yes">예
						&nbsp;&nbsp;&nbsp; <input type="radio"  id="giftWrapping" name="giftWrapping" checked value="no">아니요</td>
				</tr>
		</table>
	</div>
	<div >
	  <br><br>
	   <h2>주문고객</h2>
		 <table>
		   <tbody>
			 <tr class="dot_line">
				<td ><h2>이름</h2></td>
				<td>
				 <input  type="text" value="${orderer.memberName}"  name="ordererName" size="15" />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td ><h2>핸드폰</h2></td>
				<td>
				 <input  type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td ><h2>이메일</h2></td>
				<td>
				 <input  type="text" value="${orderer.email1}@${orderer.email2}" size="15" />
				</td>
			  </tr>
		   </tbody>
		</table>
	</div>
	<div class="clear"></div>
	<br><br><br>

	<h1>3.결제정보</h1>
	<div class="detail_table">
		<table>
			<tbody>
				<tr >
					<td>
					   <input type="radio" id="payMethod" name="payMethod" value="신용카드"   onClick="fn_pay_card()" checked>신용카드 &nbsp;&nbsp;&nbsp; 
					   <input type="radio" id="payMethod" name="payMethod" value="제휴 신용카드"  >제휴 신용카드 &nbsp;&nbsp;&nbsp; 
					   <input type="radio" id="payMethod" name="payMethod" value="실시간 계좌이체">실시간 계좌이체 &nbsp;&nbsp;&nbsp;
					   <input type="radio" id="payMethod" name="payMethod" value="무통장 입금">무통장 입금 &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr >
					<td>
					   <input type="radio" id="payMethod" name="payMethod" value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제 &nbsp;&nbsp;&nbsp;
					   <input type="radio" id="payMethod" name="payMethod" value="카카오페이(간편결제)">카카오페이(간편결제) &nbsp;&nbsp;&nbsp; 
					   <input type="radio" id="payMethod" name="payMethod" value="페이나우(간편결제)">페이나우(간편결제) &nbsp;&nbsp;&nbsp; 
					   <input type="radio" id="payMethod" name="payMethod" value="페이코(간편결제)">페이코(간편결제) &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr >
					<td>
					   <input type="radio"  id="payMethod" name="payMethod" value="직접입금">직접입금&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr id="tr_pay_card">
					<td>
					  <strong>카드 선택</strong>:&nbsp;&nbsp;&nbsp;
					  <select id="cardComName" name="cardComName">
							<option value="삼성" selected>삼성</option>
							<option value="하나SK">하나SK</option>
							<option value="현대">현대</option>
							<option value="KB">KB</option>
							<option value="신한">신한</option>
							<option value="롯데">롯데</option>
							<option value="BC">BC</option>
							<option value="시티">시티</option>
							<option value="NH농협">NH농협</option>
					</select>
					<br><Br>
					<strong>할부 기간:</strong>  &nbsp;&nbsp;&nbsp;
					<select id="cardPayMonth" name="cardPayMonth">
							<option value="일시불" selected>일시불</option>
							<option value="2개월">2개월</option>
							<option value="3개월">3개월</option>
							<option value="4개월">4개월</option>
							<option value="5개월">5개월</option>
							<option value="6개월">6개월</option>
					</select>
					
					</td>
				</tr>
				<tr id="tr_pay_phone" style="visibility:hidden">
				  <td>
				  <strong>휴대폰 번호 입력: </strong>
				  	       <input  type="text" size="5" value=""  id="pay_order_tel1" name="pay_order_tel1" maxlength="4"/>-
				           <input  type="text" size="5" value="" id="pay_order_tel2" name="pay_order_tel2" maxlength="4" />-
				           <input  type="text" size="5" value="" id="pay_order_tel3" name="pay_order_tel3"  maxlength="4"/>
				  </td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<table style="width:80%" class="list_view" style="background: #ccffff">
		<tbody>
			<tr align=center class="fixed">
				<td class="fixed">총 상품수</td>
				<td>총 상품금액</td>
				<td></td>
				<td>총 배송비</td>
				<td></td>
				<td>총 할인 금액</td>
				<td></td>
				<td>최종 결제금액</td>
			</tr>
			<tr align="center">
				<td id="">
					<p id="p_totalNum">${total_order_goods_qty}개</p> 
					<input id="h_total_order_goods_qty" type="hidden" value="${total_order_goods_qty}" />
				</td>
				<td>
					<p id="p_totalPrice">${total_order_price}원</p> <input
					id="h_totalPrice" type="hidden" value="${total_order_price}" />
				</td>
				<td><IMG width="25" alt=""
					src="${pageContext.request.contextPath}/resources/image/plus.jpg"></td>
				<td>
					<p id="p_totalDelivery">${total_delivery_price }원</p> <input
					id="h_totalDelivery" type="hidden" value="${total_delivery_price}" />
				</td>
				<td>
				<img width="25" alt="" 	src="${pageContext.request.contextPath}/resources/image/minus.jpg"></td>
				<td>
					<p id="p_totalSalesPrice">${total_discount_price }원</p> 
					<input id="h_total_sales_price" type="hidden" value="${total_discount_price}" />
				</td>
				<td><img width="25" alt="" src="${pageContext.request.contextPath}/resources/image/equal.jpg"></td>
				<td>
					<p id="p_final_totalPrice">
						<font size="15">${final_total_order_price }원 </font>
					</p> <input id="h_final_total_Price" type="hidden" value="${final_total_order_price}" />
				</td>
			</tr>
		</tbody>
	</table>
   <div class="clear"></div>
    <div class="clear"></div>
	<br>
	<br>
	<br>
		<br>
		<br> <input type="submit" value=" 결제하기"   >
		<a href="${contextPath}/main/main.do"> 
		   <img width="70" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a>
		
		</form>		
	