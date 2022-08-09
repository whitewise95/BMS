package com.bms.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bms.member.dto.MemberDTO;

@Repository("memberDAO")
public class MemberDAOImpl  implements MemberDAO{
	@Autowired
	private SqlSession sqlSession;	
	
	@Override
	public MemberDTO login(Map<String,String> loginMap) throws DataAccessException{
	   return sqlSession.selectOne("mapper.member.login",loginMap);
	}
	
	@Override
	public void insertNewMember(MemberDTO memberDTO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewMember",memberDTO);
	}

	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.selectOverlappedID",id);
	}

	@Override
	public List<MemberDTO> selectId(MemberDTO memberDTO) throws DataAccessException {
		return sqlSession.selectList("mapper.member.selectId",memberDTO);
		
	}

	@Override
	public String selectPw(MemberDTO memberDTO) throws DataAccessException {
		
		return sqlSession.selectOne("mapper.member.selectPw",memberDTO);
	}

	@Override
	public void updatePassword(Map<Object, Object> listInfo) throws DataAccessException {
		sqlSession.update("mapper.member.updatePassword", listInfo);
		
	}

	@Override
	public void insertCacaoId(MemberDTO memberDTO) throws DataAccessException {
		sqlSession.insert("mapper.member.insertNewMember",memberDTO);
		
	}

	@Override
	public MemberDTO selectCacaoId(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.selectCacaoId",memberId);
		
	}

	@Override
	public String selectNaverId(String memberId) throws DataAccessException {
		
		return sqlSession.selectOne("mapper.member.selectNaverId",memberId);
	}
	
	
}
