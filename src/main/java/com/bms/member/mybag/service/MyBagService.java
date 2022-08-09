package com.bms.member.mybag.service;

import java.util.List;
import java.util.Map;

import com.bms.goods.dto.GoodsDTO;
import com.bms.member.dto.MemberDTO;
import com.bms.member.mybag.dto.MyBagDTO;
import com.bms.order.dto.OrderDTO;

public interface MyBagService {

	public void mybagIn(Map<Object, Object> myBagInfo)throws Exception; 
	public GoodsDTO selectGoods(int goodsId)throws Exception; 
	public List<MyBagDTO> myBagList(String memberId)throws Exception; 
	public int totalPrice(String memberId)throws Exception; 
	public int totalQTY(String memberId)throws Exception; 
	public void deleteMyBag(Map<Object, Object> deleteInfo)throws Exception;
	public void chageBagGoodsQty(Map<Object, Object> chageInfo)throws Exception;
//	public void finallyOrder(Map<Object, Object> orderInfo)throws Exception;
	public GoodsDTO selectGoodsPro(int goodsId)throws Exception;
	public void addNewOrder(List<OrderDTO> myOrderList)throws Exception;
	public int selectCount(String memberId)throws Exception;
	
	
}
