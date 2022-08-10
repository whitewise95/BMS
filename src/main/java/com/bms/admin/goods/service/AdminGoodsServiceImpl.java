package com.bms.admin.goods.service;

import com.bms.admin.goods.dao.AdminGoodsDAO;
import com.bms.goods.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.*;

import java.util.*;


@Service("adminGoodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService {
	
	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	
	
	@Override
	public int addNewGoods(Map<String,Object> newGoodsMap) throws Exception{
		System.out.println("service1: "+newGoodsMap.get("goodsId"));
		int goodsId = adminGoodsDAO.insertNewGoods(newGoodsMap);
		System.out.println("service2: "+goodsId);
		ArrayList<ImageFileDTO> imageFileList = (ArrayList)newGoodsMap.get("imageFileList");
		
		for (ImageFileDTO imageFileDTO : imageFileList) {
			imageFileDTO.setGoodsId(goodsId);
		}
		
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
		
		return goodsId;
		
	}
	
	
	@Override
	public List<GoodsDTO> listNewGoods(Map<String,Object> condMap) throws Exception{
		return adminGoodsDAO.selectNewGoodsList(condMap);
	}
	
	
	@Override
	public Map<String,Object> goodsDetail(int goodsId) throws Exception {
		
		Map<String,Object> goodsMap = new HashMap<String,Object>();
		
		goodsMap.put("goods", adminGoodsDAO.selectGoodsDetail(goodsId));
		goodsMap.put("imageFileList", adminGoodsDAO.selectGoodsImageFileList(goodsId));
		
		return goodsMap;
		
	}
	
	
	@Override
	public List<ImageFileDTO> goodsImageFile(int goodsId) throws Exception{
		return adminGoodsDAO.selectGoodsImageFileList(goodsId);
	}
	
	
	@Override
	public void modifyGoodsInfo(Map<String,String> goodsMap) throws Exception{
		adminGoodsDAO.updateGoodsInfo(goodsMap);
		
	}	
	
	
	@Override
	public void modifyGoodsImage(List<ImageFileDTO> imageFileList) throws Exception{
		adminGoodsDAO.updateGoodsImage(imageFileList); 
	}
	
	
	@Override
	public void removeGoodsImage(int image_id) throws Exception{
		adminGoodsDAO.deleteGoodsImage(image_id);
	}
	
	
	@Override
	public void addNewGoodsImage(List<ImageFileDTO> imageFileList) throws Exception{
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
	}
	
}
