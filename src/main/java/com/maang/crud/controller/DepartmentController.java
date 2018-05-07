package com.maang.crud.controller;

import com.maang.crud.entity.Department;
import com.maang.crud.entity.Msg;
import com.maang.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 描述:
 * 处理和部门相关的
 *
 * @outhor ming
 * @create 2018-05-06 14:30
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /** 〈返回所有的部门信息〉*/
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts() {

        List<Department> departmentList = departmentService.getDepts();
        return Msg.success().add("depts",departmentList);
    }

}
