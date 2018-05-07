package com.maang.crud;

import com.maang.crud.dao.DepartmentMapper;
import com.maang.crud.dao.EmployeeMapper;
import com.maang.crud.entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 描述:
 * 测试
 *
 * @outhor ming
 * @create 2018-05-05 21:45
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext-dao.xml","classpath:applicationContext-service.xml","classpath:applicationContext-trans.xml"})
public class daoTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /** 〈测试DepartmentMapper〉*/
    @Test
    public void testCRUD() {

        System.out.println(departmentMapper);

        //1.插入几个部门

//        Department department = new Department(null,"开发部");
//        departmentMapper.insertSelective(department);
//        departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.插入员工
       // employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "jerry@maang.com", 1));

        //3.批量插入员工数据  使用可以执行批量操作的sqlSession
        EmployeeMapper sessionMapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            employeeMapper.insertSelective(new Employee(null, uid, "M", uid+"@maang.com", 1));
        }
        System.out.println("批量完成");
    }

}
