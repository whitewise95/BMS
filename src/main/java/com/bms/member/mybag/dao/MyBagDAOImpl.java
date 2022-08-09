package com.bms.member.mybag.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bms.goods.dto.GoodsDTO;
import com.bms.member.dto.MemberDTO;
import com.bms.member.mybag.dto.MyBagDTO;
import com.bms.order.dto.OrderDTO;

@Repository
public class MyBagDAOImpl implements MyBagDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertMyBag(Map<Object, Object> myBagInfo) throws Exception {
		sqlSession.insert("mapper.mybag.insertMyBag",myBagInfo);
		
		
	}

	@Override
	public GoodsDTO selectGoods(int goodsId) throws Exception {
		return sqlSession.selectOne("mapper.mybag.selectGoods",goodsId);
	}

	@Override
	public List<MyBagDTO> selectMyBagList(String memberId) throws Exception {
		
		return sqlSession.selectList("mapper.mybag.selectMyBagList",memberId );
	}

	@Override
	public void updateMyBag(Map<Object, Object> myBagInfo) throws Exception {
		sqlSession.insert("mapper.mybag.updatetMyBag",myBagInfo);
		
	}

	@Override
	public void deleteMyBag(Map<Object, Object> deleteInfo) throws Exception {
		String memberId = (String)deleteInfo.get("memberId");
		int bagGoodsId = Integer.parseInt((String) deleteInfo.get("bagGoodsId"));
		
		sqlSession.delete("mapper.mybag.deleteMyBag",bagGoodsId);
		sqlSession.update("mapper.mybag.updateMyBagCountDoun",memberId);
	}

	@Override
	public void UpdateGoodsQty(Map<Object, Object> chageInfo) {
		sqlSession.update("mapper.mybag.UpdateGoodsQty",chageInfo);
		
	}

//	@Override
//	public void insertOrder(Map<Object, Object> orderInfo) throws Exception {
//		sqlSession.insert("mapper.mybag.InsertOrder",orderInfo);
//		
//	}

	@Override
	public GoodsDTO selectGoodsPro(int goodsId) throws Exception {
		
		return sqlSession.selectOne("mapper.mybag.selectGoods",goodsId);
	}

	@Override
	public void insertNewOrder(List<OrderDTO> myOrderList) throws Exception {
		int orderId = selectOrderID();
		for(int i=0; i<myOrderList.size(); i++){
			OrderDTO orderDTO = (OrderDTO)myOrderList.get(i);
			System.out.println(orderDTO.getGoodsId());
			orderDTO.setOrderId(orderId);
			sqlSession.insert("mapper.mybag.insertNewOrder",orderDTO);
			sqlSession.update("mapper.mybag.resetCount",orderDTO );
			sqlSession.delete("mapper.mybag.oraderAfterMyBag",orderDTO );
		}
	
		
	}

	@Override
	public int selectOrderID() throws Exception {
		return sqlSession.selectOne("mapper.order.selectOrderID");
	}

	@Override
	public void updateMyBagCount(String memberId) throws Exception {
		sqlSession.update("mapper.mybag.updateMyBagCountUp" ,memberId );
		
	}

	@Override
	public int selectCount(String memberId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.mybag.selectCount",memberId );
	}







}
