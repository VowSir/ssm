package com.maang.crud.service.impl;

import com.maang.crud.dao.EmployeeMapper;
import com.maang.crud.entity.Employee;
import com.maang.crud.entity.EmployeeExample;
import com.maang.crud.entity.EmployeeExample.Criteria;
import com.maang.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 描述:
 *
 * @outhor ming
 * @create 2018-05-05 23:55
 */
@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public List<Employee> findAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
    /** 〈员工的保存〉*/
    @Override
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /** 〈检验用户名是否可用  true代表可用 false代表不可用〉*/
    @Override
    public boolean checkUsername(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        int count = employeeMapper.countByExample(example);
        return count==0;
    }

    /** 〈按照员工的id查询员工〉*/
    @Override
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /** 〈员工的更新方法〉*/
    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /** 〈按照id删除员工〉*/
    @Override
    public void deleteEmp(Integer id) {

        employeeMapper.deleteByPrimaryKey(id);
    }

    /** 〈批量删除〉*/
    @Override
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
    }
}
