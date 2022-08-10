package com.bms.admin.member.dao;

import com.bms.member.dto.MemberDTO;
import org.springframework.dao.DataAccessException;

import java.util.*;

public interface AdminMemberDAO {

    public List<MemberDTO> listMember(Map<String, Object> condMap) throws DataAccessException;

    public MemberDTO memberDetail(String memberId) throws DataAccessException;

    public void modifyMemberInfo(Map<String, String> memberMap) throws DataAccessException;

}
