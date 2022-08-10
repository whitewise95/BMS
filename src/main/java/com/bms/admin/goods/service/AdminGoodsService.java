package com.bms.admin.goods.service;

import com.bms.goods.dto.*;

import java.util.*;

public interface AdminGoodsService {

    public int addNewGoods(Map<String, Object> newGoodsMap) throws Exception;

    public List<GoodsDTO> listNewGoods(Map<String, Object> condMap) throws Exception;

    public Map<String, Object> goodsDetail(int goodsId) throws Exception;

    public List<ImageFileDTO> goodsImageFile(int goodsId) throws Exception;

    public void modifyGoodsInfo(Map<String, String> goodsMap) throws Exception;

    public void modifyGoodsImage(List<ImageFileDTO> imageFileList) throws Exception;

    public void removeGoodsImage(int image_id) throws Exception;

    public void addNewGoodsImage(List<ImageFileDTO> imageFileList) throws Exception;

}
