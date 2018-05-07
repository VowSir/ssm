package com.maang.crud.service;

import com.maang.crud.entity.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> findAll();

    void saveEmp(Employee employee);

    boolean checkUsername(String empName);

    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    void deleteEmp(Integer id);

    void deleteBatch(List<Integer> del_ids);
}
