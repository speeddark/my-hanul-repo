package com.hanul.iot;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import customer.CustomerVO;
import employee.EmployeeServiceImpl;
import employee.EmployeeVO;

@Controller
public class EmployeeController {
	@Autowired private EmployeeServiceImpl service;
	
	@RequestMapping("detail.hr")
	public String detail(int id, Model model) {
		
		model.addAttribute("vo", service.employee_detail(id));
		return "employee/detail";
	}
	
	@RequestMapping("list.hr")
	public String list(HttpSession session, Model model) {
		session.setAttribute("category", "hr");
		
		
		model.addAttribute("list", service.employee_list());
		
		
		
		return "employee/list";
	}
	
	
}
