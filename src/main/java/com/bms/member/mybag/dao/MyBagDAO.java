package com.bms.member.mybag.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bms.goods.dto.GoodsDTO;
import com.bms.member.dto.MemberDTO;
import com.bms.member.mybag.dto.MyBagDTO;
import com.bms.order.dto.OrderDTO;

public interface MyBagDAO {

	public void insertMyBag(Map<Object, Object> myBagInfo)	throws Exception;
	public void updateMyBag(Map<Object, Object> myBagInfo)	throws Exception;
	public GoodsDTO selectGoods(int goodsId)	throws Exception;
	public List<MyBagDTO> selectMyBagList(String memberId)throws Exception;
	public void deleteMyBag(Map<Object, Object> deleteInfo)throws Exception;
	public void UpdateGoodsQty(Map<Object, Object> chageInfo)throws Exception;
//	public void insertOrder(Map<Object, Object> orderInfo)throws Exception;
	public GoodsDTO selectGoodsPro(int goodsId)throws Exception;
	public void insertNewOrder(List<OrderDTO> myOrderList)throws Exception; 
	public int selectOrderID()throws Exception;
	public void updateMyBagCount(String memberId) throws Exception;
	public int selectCount(String memberId)throws Exception;
}
