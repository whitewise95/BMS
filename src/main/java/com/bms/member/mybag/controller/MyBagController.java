package com.bms.member.mybag.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bms.goods.dto.GoodsDTO;
import com.bms.member.dto.MemberDTO;
import com.bms.member.mybag.service.MyBagService;
import com.bms.order.dto.OrderDTO;

@Controller
@RequestMapping(value="/mybag")
public class MyBagController {
	
	@Autowired
	private MyBagService myBagService;
	
	@Autowired
	private MemberDTO memberDTO;
	
	
	@RequestMapping(value="/myBagPage.do", method = RequestMethod.POST)
	public ResponseEntity<Object> myBagPage(@RequestParam("goodsId")int goodsId,
											@RequestParam("orderGoodsQty")int orderGoodsQty,
			HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String message = "";
		memberDTO = (MemberDTO)session.getAttribute("memberInfo");  //DTO정보 연결
		if(memberDTO != null) {
		String memberId = memberDTO.getMemberId(); //아이디 저장
		
		message= "<script>";
		message += "if(confirm('장바구니에 담겼습니다. 확인하시겠습니까?')){";
		message +=" location.href='"+request.getContextPath()+"/mybag/myBagPageView.do';}";
		message +=" else{";
		message +=" history.go(-1);}";
		message +="</script>";
		
		GoodsDTO goodsDTO= myBagService.selectGoods(goodsId);
		Map<Object, Object> myBagInfo =new HashMap<Object, Object>();
		myBagInfo.put("memberId", memberId);
		myBagInfo.put("goodsId", goodsDTO.getGoodsId());
		myBagInfo.put("goodsSort", goodsDTO.getGoodsSort());
		myBagInfo.put("goodsPrice", goodsDTO.getGoodsPrice());
		myBagInfo.put("bagGoodsQty", orderGoodsQty);
		myBagInfo.put("goodsWriter", goodsDTO.getGoodsWriter());
		myBagInfo.put("goodsTitle", goodsDTO.getGoodsTitle());
		myBagInfo.put("memberId", memberId);
		myBagService.mybagIn(myBagInfo);
		}
		else {
			message= "<script>";
			message += "alert('로그인 후 이용 가능 합니다.');";
			message +=" history.go(-1);";
			message +="</script>";
		}
		
		
		

		
		

		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		return new ResponseEntity<Object>(message , responseHeaders , HttpStatus.OK);
	}
	@RequestMapping(value="/myBagPageView.do", method = RequestMethod.GET)
	public ModelAndView myBagPageView(@ModelAttribute("orderDTO") OrderDTO odto,HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/myBagPage/mybag");
		HttpSession session = request.getSession();
		List<OrderDTO> myOrderList = new ArrayList<OrderDTO>();
		myOrderList.add(odto);
		session.setAttribute("myOrderList", myOrderList);
		memberDTO = (MemberDTO)session.getAttribute("memberInfo");  //DTO정보 연결
		String memberId = memberDTO.getMemberId(); //아이디 저장
		int totalPrice = myBagService.totalPrice(memberId); // 총 가격
		int totalQTY =  myBagService.totalQTY(memberId); // 총 갯수
		mv.addObject("mbList", myBagService.myBagList(memberId));
		mv.addObject("totalPrice", totalPrice);
		mv.addObject("totalQTY", totalQTY);
		
		
		return mv;
	}
	@RequestMapping(value="/deleteMyBag.do",method = RequestMethod.GET)
	public String deleteMyBag(@RequestParam("bagGoodsId")int bagGoodsId,HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		Map<Object, Object> deleteInfo = new HashMap<Object, Object>();
		memberDTO = (MemberDTO)session.getAttribute("memberInfo");  //DTO정보 연결
		String memberId = memberDTO.getMemberId(); //아이디 저장
		deleteInfo.put("bagGoodsId", bagGoodsId);
		deleteInfo.put("memberId", memberId);
		
		
		
		myBagService.deleteMyBag(deleteInfo);
		
		return "redirect:/mybag/myBagPageView.do";
	}
	
	
	@RequestMapping(value="/bagGoodsQtyChage.do",method = RequestMethod.POST)
	public String bagGoodsQtyChage(@RequestParam("bagGoodsId")      int bagGoodsId,
							 	   @RequestParam("bagGoodsQty")   int bagGoodsQty,HttpServletRequest request) throws Exception {
		
			Map<Object, Object> chageInfo = new HashMap<Object, Object>();
			chageInfo.put("bagGoodsId", bagGoodsId);
			chageInfo.put("bagGoodsQty", bagGoodsQty);
		
		
			myBagService.chageBagGoodsQty(chageInfo);
			
		
			return "redirect:/mybag/myBagPageView.do";
		
	}
	
	@RequestMapping(value="/myBagOrder.do", method = RequestMethod.GET)
	public ModelAndView myBagOrder(HttpServletRequest request) throws Exception {
	
		
		ModelAndView mv = new ModelAndView();

		HttpSession session = request.getSession();
		int cnt = 0;
		MemberDTO memberInfo = (MemberDTO)session.getAttribute("memberInfo");
		String memberId = memberInfo.getMemberId(); //아이디 저장
		cnt = myBagService.selectCount(memberId);
		if(cnt ==0 ) {
			mv.setViewName("/mybagpage/callBack");
		}
		else {
			mv.setViewName("/myBagPage/myBagOrder");
			int goodsSalesPrice = 0;
			int totalPrice = myBagService.totalPrice(memberId); // 총 가격
			int totalQTY =  myBagService.totalQTY(memberId); // 총 갯수
			mv.addObject("mbList", myBagService.myBagList(memberId));
			mv.addObject("totalPrice", totalPrice);
			mv.addObject("totalQTY", totalQTY);
			mv.addObject("goodsSalesPrice", goodsSalesPrice);
			mv.addObject("orderer", memberInfo);
			
		}
		
		return mv;
	}
	
	@RequestMapping(value="/myBagOrderPro.do" , method = RequestMethod.POST)
	public ResponseEntity<Object> myBagOrderPro(@RequestParam Map<String, String> receiverMap ,HttpServletRequest request) throws Exception {
	
		
		HttpSession session = request.getSession();
		String message = "";
		message= "<script>";
		message += "alert('결제가 완료되었습니다. 마이페이지에서 확인이 가능합니다.');";
		message +=" location.href='"+request.getContextPath()+"/main/main.do';";
		message +="</script>";

		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("orderer");
		memberDTO = (MemberDTO)session.getAttribute("memberInfo");  //DTO정보 연결
		String memberId = memberDTO.getMemberId(); //아이디 저장
		int goodsId =Integer.parseInt(receiverMap.get("goodsId"));
		int cnt = myBagService.selectCount(memberId);
		String ordererHp = receiverMap.get("receiverHp1") + "-" + receiverMap.get("receiverHp2") + "-" + receiverMap.get("receiverHp3");
		List<OrderDTO> myOrderList=(List<OrderDTO>)session.getAttribute("myOrderList");
		String deliveryAddress = receiverMap.get("roadAddress") + receiverMap.get("jibunAddress") + receiverMap.get("namujiAddress");
		String payOrdererHpNum = receiverMap.get("payOrdererHpNum1") + receiverMap.get("payOrdererHpNum2") + receiverMap.get("payOrdererHpNum3");
		System.out.println(cnt);
		

			String goodsTitle = receiverMap.get("goodsTitle");
			if(cnt >1) {
				goodsTitle +=( "외"+" "+ (cnt-1)+"개");
			}
			OrderDTO orderDTO = (OrderDTO)myOrderList.get(0);
			orderDTO.setMemberId(memberId);
			orderDTO.setOrdererName(receiverMap.get("ordererName"));
			orderDTO.setGoodsTitle(goodsTitle);
			int orderGoodsQty =Integer.parseInt(receiverMap.get("orderGoodsQty"));
			int goodsSalesPrice =Integer.parseInt(receiverMap.get("goodsSalesPrice"));
			orderDTO.setGoodsQty(orderGoodsQty);
			orderDTO.setGoodsSalesPrice(goodsSalesPrice);
			orderDTO.setReceiverName(receiverMap.get("receiverName"));
			orderDTO.setReceiverHp1(receiverMap.get("receiverHp1"));
			orderDTO.setReceiverHp2(receiverMap.get("receiverHp2"));
			orderDTO.setReceiverHp3(receiverMap.get("receiverHp3"));
			orderDTO.setReceiverTel1(receiverMap.get("receiverTel1"));
			orderDTO.setReceiverTel2(receiverMap.get("receiverTel2"));
			orderDTO.setReceiverTel3(receiverMap.get("receiverTel3"));
			orderDTO.setGoodsId(goodsId);
			orderDTO.setDeliveryAddress(receiverMap.get(deliveryAddress));
			orderDTO.setDeliveryMessage(receiverMap.get("deliveryMessage"));
			orderDTO.setDeliveryMethod(receiverMap.get("deliveryMethod"));
			orderDTO.setGiftWrapping(receiverMap.get("giftWrapping"));
			orderDTO.setPayMethod(receiverMap.get("payMethod"));
			orderDTO.setCardComName(receiverMap.get("cardComName"));
			orderDTO.setCardPayMonth(receiverMap.get("cardPayMonth"));
			orderDTO.setPayOrdererHpNum(receiverMap.get(payOrdererHpNum));	
			orderDTO.setOrdererHp(ordererHp);	
			orderDTO.setDeliveryAddress(deliveryAddress);
			myOrderList.set(0, orderDTO); 
			myBagService.addNewOrder(myOrderList);
		
	

			return new ResponseEntity<Object>(message , responseHeaders , HttpStatus.OK);
	

	}	
	@RequestMapping(value="/my.do" )
	public String callback() {
		return "/member/callBack";
		
	}
	
	
}
