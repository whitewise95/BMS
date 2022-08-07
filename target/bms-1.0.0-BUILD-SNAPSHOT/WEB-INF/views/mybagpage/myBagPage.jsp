<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

 function submit(bagGoodsId){
	 
	 var bagGoodsQty = document.getElementById("bagGoodsQty");
	 
		var formObj	            = document.createElement("form");
	    var i_order_goods_qty   = document.createElement("input");
	    var i_bagGoods_id        = document.createElement("input"); 
	    
	    i_bagGoods_id.name          = "bagGoodsId";
	    i_order_goods_qty.name   = "bagGoodsQty";
	    
	    i_bagGoods_id.value          = bagGoodsId;
	    i_order_goods_qty.value   = bagGoodsQty.value;

	    
	    formObj.appendChild(i_bagGoods_id);
	    formObj.appendChild(i_order_goods_qty);
	
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mybag/bagGoodsQtyChage.do";
	    formObj.submit();
  
 }

</script>
</head>
<body>
<h1>장바구니</h1>
<table class="list_view">	
	<tbody align=center >
		<tr style="background:#33ff00" >
			<td>번호</td>
			<td>상품 이름</td>
			<td>
			<td>저자</td>
			<td>수량</td>
			<td>가격</td>
			<td>분야</td>
		</tr>
		<c:choose>
        	 <c:when test="${ empty mbList  }">
			  <tr>
		    	<td colspan=5 class="fixed">
				  <strong>장바구니에 상품이 없습니다.</strong>
		  	  </td>
		 	 </tr>
       		 </c:when>
       		 <c:otherwise>
	      		<c:forEach var="item" items="${mbList }">
           		 <tr>
             		<td>
		      		 	<a href="${contextPath}/goods/goodsDetail.do?goodsId=${item.goodsId }"><span>${item.bagGoodsId }</span>  </a>
		     		</td>
			   		 <td>${item.bagGoodsTitle }</td>
			   		 <td>
					<td>${item.bagGoodsWriter}</td>
					<td><input type="text" value=" ${item.bagGoodsQty}" id="bagGoodsQty" name="bagGoodsQty"><input type="button" value="변경" id="chageQty" name="chageQty" onclick="submit(${item.bagGoodsId})"></td>
					<td>${item.bagGoodsPrice}</td>
					<td>${item.bagGoodsSort } <input type="button" value="삭제" onclick="location.href='${contextPath}/mybag/deleteMyBag.do?bagGoodsId=${item.bagGoodsId }'"></td>
					 
				</tr>
		   		</c:forEach>
	  	 	</c:otherwise>
	   </c:choose>
	</tbody>
	</table>
	<br>
	<table class="list_view">	
		<tfoot align=center>
			<tr>
				<td>총 상품수</td>
				<td>총 상품금액</td>
				<td></td>
				<td>총 배송비</td>
				<td></td>
				<td>최종 결제금액</td>
			</tr>
			<tr>
				<td>${totalQTY }개</td>
				<td>${totalPrice }원</td>
				<td><IMG width="25" alt=""
				src="${pageContext.request.contextPath}/resources/image/plus.jpg"></td>
				<td>
				</td>
				<td>0원</td>
				<td><img width="25" alt="" src="${pageContext.request.contextPath}/resources/image/equal.jpg"></td>
				<td><font size="15">${totalPrice }</font> </td>
			</tr>
		</tfoot>
	</table>
	<hr>
	<br>
	<a href="${contextPath}/mybag/myBagOrder.do?goodsId=${item.goodsId }&orderGoodsQty=${totalQTY }"><img width="125" alt="" src="${contextPath}/resources/image/btn_gulje.jpg"></a>
    <a href="${contextPath}/main/main.do"><img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg"></a>

</body>
</html>