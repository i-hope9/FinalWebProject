package com.medirone.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.medirone.web.service.AgencyService;
import com.medirone.web.service.LoginResult;

@Controller
public class HomeController {
	@Autowired
	private AgencyService Aservice;

	@RequestMapping("/")
	public String home() {
		return "home/loginHome";
	}

	@RequestMapping("/loginHome")
	public String Logincheck(String error, Model model) {
		if (error != null) {
			if (error.equals("fail_mid")) {
				model.addAttribute("errorAgency_id", "* 아이디가 존재하지 않습니다.");
				System.out.println("아이디가 없다");
			} else if (error.equals("fail_mpassword")) {
				model.addAttribute("errorAgency_password", "* 패스워드가 틀립니다.");
				System.out.println("비밀번호가 없다");
			} else if (error.equals("fail_mrejected")) {
				model.addAttribute("errorAgency_password", "* 가입 승인 대기 중입니다.");
				System.out.println("비밀번호가 없다");
			}
		}
		return "home/loginHome";
	}

	@PostMapping("/login")
	public String Login(String agency_id, String agency_password, HttpSession session) {
		LoginResult result = Aservice.login(agency_id, agency_password);
		if (result == LoginResult.FAIL_MID) {
			return "redirect:/loginHome?error=fail_mid";
		} else if (result == LoginResult.FAIL_MPASSWORD) {
			return "redirect:/loginHome?error=fail_mpassword";
		} else if (result == LoginResult.FAIL_MREJECTED) {
			return "redirect:/loginHome?error=fail_mrejected";
		}
		session.setAttribute("agency_Id", agency_id);
		
		return "redirect:/request";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("agency_Id");
		return "redirect:/";
	}
	
	@RequestMapping("/error")
	public String error() {
		return "common/error";
	}
}

