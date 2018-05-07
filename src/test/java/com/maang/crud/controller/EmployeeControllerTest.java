package com.maang.crud.controller;

import com.github.pagehelper.PageInfo;
import com.maang.crud.entity.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;
/** 〈spring4测试的时候,需要servlet3.0的支持 依赖需要使用〉*/
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext-dao.xml","classpath:applicationContext-service.xml","classpath:applicationContext-trans.xml","classpath:spring-mvc.xml"})
public class EmployeeControllerTest {

    //传入springmvc的ioc
    @Autowired
    WebApplicationContext applicationContext;

    //虚拟mvc请求,获取处理结果
    MockMvc mockMvc;

    @Before
    public void init() {
         mockMvc = MockMvcBuilders.webAppContextSetup(applicationContext).build();
    }

    @Test
    public void testPage() throws Exception {

        //模拟请求拿到返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
        //请求成功后,请求域中会有pageInfo,我们可以取出进行验证
        PageInfo pageInfo = (PageInfo) mvcResult.getRequest().getAttribute("pageInfo");
        System.out.println("当前页码:"+pageInfo.getPageNum()+"  总页码:"+pageInfo.getPages());
        System.out.println("总记录数:"+pageInfo.getTotal()+"  在页面需要连续显示的页码:");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.print(" "+num);
        }
        System.out.println();
        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println("id:"+employee.getEmpId()+"====>name:"+employee.getEmpName());
        }


    }
}