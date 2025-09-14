package com.kedu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;

@RequestMapping("/members")
@Repository
public class MembersController {
	
	@Autowired
	MembersDAO dao;
	
	
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public String toregist() {
		return "/members/regist";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(MembersDTO dto) throws Exception  {
		dao.insert(dto);
		
		//아이디 추가
		return "redirect:/";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String tologin(MembersDTO dto , HttpSession session ) throws Exception {
		
		MembersDTO user = dao.selectUser(dto);
		if(user != null) { // 로그인 성공하면
			 session.setAttribute("loginUser", user); //여기에 id pw 밖에없음 
			 System.out.println("로그인 한 유저 데이터: " + user.getId() + user.getName());
			 return "members/login";
		}else {
			return "redirect:/error";
		}
		
		
	}
	
	@RequestMapping(value = "/logout")
	public String tologout(HttpSession session) {
		
		//아이디 로그아웃
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "/withdraw")
	public String towithdraw(HttpSession session) throws Exception {
		
		
		 MembersDTO loginUser = (MembersDTO) session.getAttribute("loginUser");
		    if (loginUser != null) {
		        String userId = loginUser.getId();

		        // DAO 호출해서 회원 탈퇴 처리 (예: delete)
		        dao.delete(userId);
		    }

		    // 세션 무효화(로그아웃 효과)
		    session.invalidate();
		
		
		return "redirect:/";
	}
	
	
	
	
	@ResponseBody //forward X redirect X 그대로 보냅니다
	@RequestMapping(value ="/ajax" ,produces = "application/json; charset=UTF-8")
	public boolean ajax(@RequestParam("userId") String userId) throws Exception {
		System.out.println("ajax 요청 들어옴: " + userId);
		return dao.checkId(userId);
	}
	
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "redirect:/error";
	}
}
