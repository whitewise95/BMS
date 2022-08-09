package com.bms.member.service;

import java.util.List;
import java.util.Map;

import com.bms.member.dto.MemberDTO;

public interface MemberService {
	
	public MemberDTO login(Map<String,String> loginMap) throws Exception;
	public void addMember(MemberDTO memberDTO) throws Exception;
	public String overlapped(String id) throws Exception;
	public List<MemberDTO> FindId(MemberDTO memberDTO) throws Exception;
	public boolean FindPw(MemberDTO memberDTO) throws Exception;
	public void passwordChage(Map<Object, Object> ListInfo) throws Exception;
	public void cacaoJoin(MemberDTO memberDTO)throws Exception;
	public MemberDTO cacaoIdCheck(String memberId)throws Exception;
	public boolean naverIdCheck(MemberDTO memberDTO)throws Exception;

}
