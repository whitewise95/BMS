package com.bms.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bms.common.util.CommonUtil;
import com.bms.goods.dto.GoodsDTO;
import com.bms.goods.service.GoodsService;

@Controller("mainController")
@EnableAspectJAutoProxy
public class MainController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value= "/")
	public ModelAndView home() throws Exception{
		return new ModelAndView("redirect:/main/main.do");
	}
	
	
	@RequestMapping(value= "/main/main.do")
	public ModelAndView main(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/main/main");
		
		HttpSession session = request.getSession();
		session.setAttribute("side_menu", "user");
		
		Map<String,List<GoodsDTO>> goodsMap = goodsService.listGoods();
		mv.addObject("goodsMap", goodsMap);
		
		return mv;
		
	}
	
	@RequestMapping(value= "/main/detailGoodsSort.do")
	public ModelAndView detailGoodsSort(@RequestParam("goodsSort")String goodsSort,HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/main/detailSort");
		
		mv.addObject("goodsList",sqlSession.selectList("mapper.goods.SelectDetailGoodsSort", goodsSort));
		mv.addObject("goodsSort",goodsSort);
		
		
		return mv;
	}
	
	@RequestMapping(value= "/main/detailGoodsStatus.do")
	public ModelAndView detailGoodsStatus(@RequestParam("goodsStatus")String goodsStatus,HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/main/detailStatus");
		
		mv.addObject("goodsList",sqlSession.selectList("mapper.goods.SelectDetailGoodsStatus", goodsStatus ));
		mv.addObject("goodsStatus",goodsStatus);
		
		return mv;
	}
	
	@RequestMapping(value= "/main/notice.do")
	public ModelAndView notice(@RequestParam("subject")String subject) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/main/notice");
		mv.addObject("subject",subject);
		
		
		return mv;
	}
}
