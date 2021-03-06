package employee;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired private EmployeeDAO dao;
	@Override
	public List<EmployeeVO> employee_list() {
		
		return dao.employee_list();
	}

	@Override
	public EmployeeVO employee_detail(int id) {
		// TODO Auto-generated method stub
		return dao.employee_detail(id);
	}

}
