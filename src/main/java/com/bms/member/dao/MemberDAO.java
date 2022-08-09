package com.bms.member.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bms.member.dto.MemberDTO;

public interface MemberDAO {
	
	public MemberDTO login(Map<String,String> loginMap) throws DataAccessException;
	public void insertNewMember(MemberDTO memberDTO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public List<MemberDTO> selectId(MemberDTO memberDTO) throws DataAccessException;
	public String selectPw(MemberDTO memberDTO) throws DataAccessException;
	public void updatePassword(Map<Object, Object> listInfo) throws DataAccessException;
	public void insertCacaoId(MemberDTO memberDTO)throws DataAccessException;
	public MemberDTO selectCacaoId(String memberId)throws DataAccessException;
	public String selectNaverId(String memberId)throws DataAccessException;

}
