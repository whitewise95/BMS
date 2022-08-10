package com.bms.admin.member.service;

import com.bms.admin.member.dao.AdminMemberDAO;
import com.bms.member.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.*;

import java.util.*;

@Service("adminMemberService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminMemberServiceImpl implements AdminMemberService {

    @Autowired
    private AdminMemberDAO adminMemberDAO;

    public List<MemberDTO> listMember(Map<String, Object> condMap) throws Exception {
        return adminMemberDAO.listMember(condMap);
    }

    public MemberDTO memberDetail(String memberId) throws Exception {
        return adminMemberDAO.memberDetail(memberId);
    }

    public void modifyMemberInfo(Map<String, String> memberMap) throws Exception {
        adminMemberDAO.modifyMemberInfo(memberMap);
    }

}
