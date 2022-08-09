package com.bms.member.mybag.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("myBagDTO")
public class MyBagDTO {
	
	private int    bagGoodsId;
	private String memberId;
	private int    goodsId;
	private String bagGoodsTitle;
	private String bagGoodsWriter;
	private int    bagGoodsPrice;
	private String bagGoodsPublisher;
	private String bagGoodsSort;
	private int    bagGoodsQty;
	private int    bagGoodsTotalPrice;
	private int    bagGoodsTotalQty;
	
	public int getBagGoodsId() {
		return bagGoodsId;
	}
	public void setBagGoodsId(int bagGoodsId) {
		this.bagGoodsId = bagGoodsId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getBagGoodsTitle() {
		return bagGoodsTitle;
	}
	public void setBagGoodsTitle(String bagGoodsTitle) {
		this.bagGoodsTitle = bagGoodsTitle;
	}
	public String getBagGoodsWriter() {
		return bagGoodsWriter;
	}
	public void setBagGoodsWriter(String bagGoodsWriter) {
		this.bagGoodsWriter = bagGoodsWriter;
	}
	public int getBagGoodsPrice() {
		return bagGoodsPrice;
	}
	public void setBagGoodsPrice(int bagGoodsPrice) {
		this.bagGoodsPrice = bagGoodsPrice;
	}
	public String getBagGoodsPublisher() {
		return bagGoodsPublisher;
	}
	public void setBagGoodsPublisher(String bagGoodsPublisher) {
		this.bagGoodsPublisher = bagGoodsPublisher;
	}
	public String getBagGoodsSort() {
		return bagGoodsSort;
	}
	public void setBagGoodsSort(String bagGoodsSort) {
		this.bagGoodsSort = bagGoodsSort;
	}
	public int getBagGoodsQty() {
		return bagGoodsQty;
	}
	public void setBagGoodsQty(int bagGoodsQty) {
		this.bagGoodsQty = bagGoodsQty;
	}
	public int getBagGoodsTotalPrice() {
		return bagGoodsTotalPrice;
	}
	public void setBagGoodsTotalPrice(int bagGoodsTotalPrice) {
		this.bagGoodsTotalPrice = bagGoodsTotalPrice;
	}
	public int getBagGoodsTotalQty() {
		return bagGoodsTotalQty;
	}
	public void setBagGoodsTotalQty(int bagGoodsTotalQty) {
		this.bagGoodsTotalQty = bagGoodsTotalQty;
	}
	
	
	
}
