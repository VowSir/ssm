package com.maang.crud.service.impl;

import com.maang.crud.dao.DepartmentMapper;
import com.maang.crud.entity.Department;
import com.maang.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 描述:
 *
 * @outhor ming
 * @create 2018-05-06 14:34
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
