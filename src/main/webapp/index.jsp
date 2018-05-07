<%--
  User: ming
  Date: 2018/5/5
  Time: 23:41
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表的页面</title>

    <!-- Bootstrap引入样式 -->
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 员工添加的模态框  -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@maang.com">
                            <span class="help-block"></span>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_man" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_femme" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <%-- 只需要提交部门id即可 --%>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改的模态框  -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@maang.com">
                            <span class="help-block"></span>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_man" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_femme" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <%-- 只需要提交部门id即可 --%>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<%-- 搭建显示的页面 --%>
<div class="container">
    <%-- 标题 --%>
    <div class="row">
        <div class="col-md-12">
            <h1>ssm-CRUD</h1>
        </div>
    </div>

    <%-- 按钮 --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-bg" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger btn-bg" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <%-- 显示表格数据 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>department</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>

            </table>
        </div>
    </div>

    <%-- 显示分页信息 --%>
    <div class="row">

        <%-- 分页信息 --%>
        <div class="col-md-6" id="page_info_area">

        </div>

        <div class="col-md-6" id="page_nav_area">
            <%-- 分页条--%>

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage;
    <%-- 1.页面加载完毕以后,直接发送一个Ajax请求 得到分页数据 --%>
    $(function () {

        //去首页
        to_page(1);
    });
        //去某一页封装的方法
        function to_page(pn) {
            $.ajax({
                url: "${pageContext.request.contextPath}/emps",
                data: "pn=" + pn,
                type: "GET",
                success: function (data) {
                    //console.log(data);
                    //1.解析并显示员工数据
                    build_emps_table(data);
                    //2.解析并显示分页信息
                    build_page_info(data);
                    //3.解析显示分页条
                    build_page_nav(data);
                }
            });
        }

        //解析显示员工数据
        function build_emps_table(data) {
            //清空table
            $("#emp_table tbody").empty();

            var emps = data.extend.pageInfo.list;
            $.each(emps, function (index, item) {
                //alert(item.empName);
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var gender = item.gender == "M" ? "男" : "女";
                var genderTd = $("<td></td>").append(gender);
                var emailTd = $("<td></td>").append(item.email);
                var deptNametTd = $("<td></td>").append(item.department.deptName);

                /**
                 * <button class="btn btn-info btn-sm">
                 <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
                 编辑
                 </button>
                 <button class="btn btn-danger btn-sm">
                 <span class="glyphicon glyphicon-trash " aria-hidden="true"></span>
                 删除
                 </button>
                 */

                var editBtn = $("<button></button>")
                    .addClass("btn btn-info btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("编辑");
                //为编辑按钮添加自定义的属性,来表示当前员工的id
                editBtn.attr("edit_id",item.empId);
                var delBtn = $("<button></button>")
                    .addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");
                //为删除按钮添加自定义的属性,来表示当前员工的id
                delBtn.attr("delete_id", item.empId);

                var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完以后还是返回原来的元素
                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNametTd)
                    .append(btn)
                    .appendTo("#emp_table tbody");
            })
        }

        //解析显示分页信息
        function build_page_info(data) {
            //清空区域
            $("#page_info_area").empty();
            $("#page_info_area").append("当前" + data.extend.pageInfo.pageNum + "页,总共"
                + data.extend.pageInfo.pages + "页,总共有"
                + data.extend.pageInfo.total + " 条记录");
            totalRecord = data.extend.pageInfo.total;
            currentPage=data.extend.pageInfo.pageNum;
        }

        //解析显示分页条
        function build_page_nav(data) {

            //清空区域
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");
            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if (data.extend.pageInfo.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                //为元素添加点击事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(data.extend.pageInfo.pageNum - 1);
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
            if (data.extend.pageInfo.hasNextPage == false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                nextPageLi.click(function () {
                    to_page(data.extend.pageInfo.pageNum + 1);
                });
                lastPageLi.click(function () {
                    to_page(data.extend.pageInfo.pages);
                });
            }


            //1.添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);
            //2.遍历给ul添加页码
            $.each(data.extend.pageInfo.navigatepageNums, function (index, num) {

                var numLi = $("<li></li>").append($("<a></a>").append(num));
                if (data.extend.pageInfo.pageNum == num) {
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(num);
                });
                ul.append(numLi);
            });
            //3.添加下一页页和末页
            ul.append(nextPageLi).append(lastPageLi);
            //4.将ul添加到nav中
            var navEle = $("<nav></nav>").append(ul);
            //5.将nav添加到导航条里面
            navEle.appendTo("#page_nav_area");
        }

        //清除表单数据(不仅清除表单的数据还要清除表单的样式)
        function reset_form(ele){
            //清除表单内容
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //给添加按钮绑定事件,打开模态框添加员工
        $("#emp_add_modal_btn").click(function () {

            //清除表单数据(不仅清除表单的数据还要清除表单的样式)
            reset_form("#empAddModal form");

            //发送Ajax请求,查询部门信息,显示在下拉列表中
            getDepts("#empAddModal select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop: "static"
            });
        });

        //查出所有的部门信息,并显示在下拉列表中
        function getDepts(ele) {
            //清空下拉列表的数据
            $(ele).empty();
            $.ajax({
                url: "${pageContext.request.contextPath}/depts",
                type: "GET",
                success: function (data) {
                    //部门数据
                    // {"code":100,"msg":"处理成功!","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                    //console.log(data);
                    //显示部门信息在下拉列表中
                    //$("#empAddModal select").append("")
                    $.each(data.extend.depts, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo(ele);
                    })
                }
            });
        }

        //模态框里面的保存按钮添加点击事件
        $("#emp_save_btn").click(function () {

            //对要提交数据库的数据进行校验
            if (!validate_add_form()) {
                return;
            }
            //判断之前的Ajax用户名校验是否成功,如果成功才可以提交
            if ($(this).attr("ajax-va")=="error") {
                return;
            }

            //1.将模态框里面的数据发送给服务器保存
            $.ajax({
                url: "${pageContext.request.contextPath}/emp",
                type: "post",
                data: $("#empAddModal form").serialize(),
                success: function (data) {
                    //alert(data);
                    if (data.code ==100) {
                        //当员工保存成功
                        //1.关闭模态框
                        $("#empAddModal").modal("hide");
                        //2.来到最后一页,显示刚才保存的数据
                        //发送Ajax请求显示最后一页数据即可 因为pageHelper里面只要请求大于当前的总页数,就会自动请求最后一页
                        //to_page(new Date().getUTCMilliseconds());
                        to_page(totalRecord);
                    } else {
                        //显示失败信息
                        // console.log(data);
                        //有哪个字段的错误信息就显示哪个字段的
                        if (undefined != data.extend.errorFields.email){
                            //显示邮箱错误信息
                            show_validate_msg("#email_add_input","error",data.extend.errorFields.email)

                        }
                        if (undefined != data.extend.errorFields.empName){
                            //显示员工名字的错误信息
                            show_validate_msg("#empName_add_input","error",data.extend.errorFields.empName)
                        }
                    }
                }
            });
        });

        //用户名的校验是否可用 如果数据库中已经存在,不可保存成功
        $("#empName_add_input").change(function () {
            var empName = this.value;
            //发送Ajax请求去查询数据库,校验用户名是否可用
            $.ajax({
                url:"${pageContext.request.contextPath}/checkUsername",
                data:"empName="+empName,
                type:"POST",
                success:function (data) {
                    if (data.code==100){
                        show_validate_msg("#empName_add_input", "success", "用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    } else {
                        show_validate_msg("#empName_add_input", "error", data.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            });

        });

        //校验表单数据
        function validate_add_form() {
            //1.拿到要校验的数据,用正则表达式
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regName.test(empName)) {
                //alert("用户可以是2-5位中文,或者6-16位英文字母和数字的组合");
                show_validate_msg("#empName_add_input","error","用户可以是2-5位中文,或者6-16位英文字母和数字的组合");
                return false
            }else {
                show_validate_msg("#empName_add_input","success","");
            }

            //2.校验邮箱
            var email = $("#email_add_input").val();
            var regName = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regName.test(email)) {
                //alert("邮箱格式不正确");
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false
            } else {
                show_validate_msg("#email_add_input","success","");
            }
            return true;
        }

        //表格校验方法抽取
        function show_validate_msg(ele,status,msg) {
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if ("success" == status) {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            } else if ("error" == status) {

                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //给编辑按钮绑定事件,因为按钮是创建之前绑定的,使用.live(),但是jQuery新版本中没有这个方法,使用on替代
        $(document).on("click",".edit_btn",function () {
            //alert("edit");
            //0.查出员工信息
            //1.查出部门信息,显示部门列表
            getEmp($(this).attr("edit_id"));
            //发送Ajax请求,查询部门信息,显示在下拉列表中
            getDepts("#empupdateModal select");
            //2.把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
            //3.弹出模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });

        //查询员工信息
        function getEmp(id) {
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/"+id,
                type:"GET",
                success:function (data) {
                    //console.log(data);
                    var empData = data.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //点击更新,更新员工
        $("#emp_update_btn").click(function () {
            //1.验证邮箱信息是否合法
            var email = $("#email_update_input").val();
            var regName = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regName.test(email)) {
                //alert("邮箱格式不正确");
                show_validate_msg("#email_update_input","error","邮箱格式不正确");
                return false
            } else {
                show_validate_msg("#email_update_input","success","");
            }
            //2.发送Ajax请求保存信息
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/"+$(this).attr("edit_id"),
                // type:"POST",
                // data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (data) {
                    //alert(data.msg);
                    //1、关闭对话框
					$("#empUpdateModal").modal("hide");
					//2、回到本页面
					to_page(currentPage);
                }
            });
        });

        //单个删除,给删除按钮绑定点击事件
        $(document).on("click",".delete_btn",function () {

            //1.弹出是否删除的弹框
            // alert($(this).parents("tr").find("td:eq(1)").text());
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("delete_id");
            if (confirm("确认删除["+empName+"]吗?")){
                //确认后发送Ajax请求
                $.ajax({
                    url:"${pageContext.request.contextPath}/emp/"+empId,
                    type:"DELETE",
                    success:function (data) {
                        // alert(data.msg);
                        //回到本页
                        to_page(currentPage);
                    }
                });
            }
        });


    //完成全选/全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        //
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            //this
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除empNames多余的,
        empNames = empNames.substring(0, empNames.length - 1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            //发送ajax请求删除
            $.ajax({
                url: "${pageContext.request.contextPath}/emp/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
