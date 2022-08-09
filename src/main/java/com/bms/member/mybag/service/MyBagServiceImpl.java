package com.bms.member.mybag.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bms.goods.dto.GoodsDTO;
import com.bms.member.dto.MemberDTO;
import com.bms.member.mybag.dao.MyBagDAO;
import com.bms.member.mybag.dto.MyBagDTO;
import com.bms.order.dto.OrderDTO;

@Service
public class MyBagServiceImpl implements MyBagService {

	@Autowired
	private MyBagDAO myBagDAO;

	@Override
	public void mybagIn(Map<Object, Object> myBagInfo) throws Exception {
		
		myBagDAO.insertMyBag(myBagInfo);
		myBagDAO.updateMyBag(myBagInfo);
		String memberId=(String)myBagInfo.get("memberId");
		myBagDAO.updateMyBagCount(memberId);
	}

	@Override
	public GoodsDTO selectGoods(int goodsId) throws Exception {
		return myBagDAO.selectGoods(goodsId);
	}

	@Override
	public List<MyBagDTO> myBagList(String memberId) throws Exception {
		
		return myBagDAO.selectMyBagList(memberId);
	}

	@Override
	public int totalPrice(String memberId) throws Exception {
		int totalPric= 0;
		List<MyBagDTO> mbdt= myBagDAO.selectMyBagList(memberId);
		for (int i = 0; i < mbdt.size(); i++) {
			totalPric += mbdt.get(i).getBagGoodsTotalPrice();
			
		}
		
		return totalPric;
	}

	@Override
	public int totalQTY(String memberId) throws Exception {
		int totalQTY= 0;
		List<MyBagDTO> mbdt= myBagDAO.selectMyBagList(memberId);
		for (int i = 0; i < mbdt.size(); i++) {
			totalQTY += mbdt.get(i).getBagGoodsQty();
			
		}
		return totalQTY;
	}



	@Override
	public void chageBagGoodsQty(Map<Object, Object> chageInfo) throws Exception {
		myBagDAO.UpdateGoodsQty(chageInfo);
		
	}

//	@Override
//	public void finallyOrder(Map<Object, Object> orderInfo) throws Exception {
//		myBagDAO.insertOrder(orderInfo);
//		
//	}

	@Override
	public GoodsDTO selectGoodsPro(int goodsId) throws Exception {
		return myBagDAO.selectGoodsPro(goodsId);
	}

	@Override
	public void addNewOrder(List<OrderDTO> myOrderList) throws Exception{
		myBagDAO.insertNewOrder(myOrderList);
	}

	@Override
	public void deleteMyBag(Map<Object, Object> deleteInfo) throws Exception {
		myBagDAO.deleteMyBag(deleteInfo);
		
		
	}

	@Override
	public int selectCount(String memberId) throws Exception {
		return myBagDAO.selectCount(memberId);
	}


	
}
