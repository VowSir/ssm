package com.maang.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.maang.crud.entity.Employee;
import com.maang.crud.entity.Msg;
import com.maang.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 描述:
 * 处理员工的crud请求
 *
 * @outhor ming
 * @create 2018-05-05 23:40
 */
@Controller
public class EmployeeController {


    @Autowired
    EmployeeService employeeService;


    /**
	 * 单个批量二合一
	 * 批量删除：1-2-3
	 * 单个删除：1
	 *
	 *
	 *
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}



//    /** 〈根据id删除员工〉*/
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    @ResponseBody
//    public Msg deleteEmpById(@PathVariable("id") Integer id){
//        employeeService.deleteEmp(id);
//        return Msg.success();
//    }

    /**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee
	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
	 *
	 * 问题：
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 *
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters() (3111);
	 *
	 * protected String parseBodyMethods = "POST";
	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
                success = true;
                return;
            }
	 *
	 *
	 * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     *
     * */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        System.out.println("将要更新的员工数据" + employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /** 〈查询员工〉*/
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){

        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /** 〈检验用户名是否可用〉 */
    @RequestMapping("/checkUsername")
    @ResponseBody
    public Msg checkUsername(String empName) {

        //判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户可以是2-5位中文,或者6-16位英文字母和数字的组合,后台信息");
        }
        boolean flag = employeeService.checkUsername(empName);
        if (flag) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");

        }
    }

    /**
     *
     * 〈员工的保存〉
     *   1.支持jsr303校验
     *   2.导入Hibernate-Validator
     * */
    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败,应该返回失败,在模态框中显示校验失败的信息
            Map<String, Object> map = new HashMap<>();

            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段名:" + fieldError.getField());
                System.out.println("错误的信息:" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /** 〈查询员工数据,分页查询 基于Ajax 〉 */
    @ResponseBody   //使用这个注解需要导入jackson包
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        //引入PageHelper分页插件
        //在查询之前只需要调用下面的方法  传入页数以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> employeeList = employeeService.findAll();
        //使用PageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的页面信息,包括了我们查询出来的信息, 传入连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(employeeList, 5);
        return Msg.success().add("pageInfo", page);
    }


    /** 〈查询员工数据,分页查询〉 */
    //@RequestMapping("/emps")  同步的请求
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        //引入PageHelper分页插件
        //在查询之前只需要调用下面的方法  传入页数以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> employeeList = employeeService.findAll();
        //使用PageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的页面信息,包括了我们查询出来的信息, 传入连续显示的页数
        PageInfo<Employee> info = new PageInfo<>(employeeList, 5);
        model.addAttribute("pageInfo", info);
        return "list";
    }


}
