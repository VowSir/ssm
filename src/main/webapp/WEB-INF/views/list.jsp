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
            <button class="btn btn-primary btn-bg">新增</button>
            <button class="btn btn-danger btn-bg">删除</button>
        </div>
    </div>

    <%-- 显示表格数据 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>department</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender=="M"?"男":"女"}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.deptName}</td>
                        <td>
                            <button class="btn btn-info btn-sm">
                                <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash " aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <%-- 显示分页信息 --%>
    <div class="row">

        <%-- 分页信息 --%>
        <div class="col-md-6">
            当前${pageInfo.pageNum}页,总共${pageInfo.pages}页,总共有${pageInfo.total}条记录
        </div>

        <div class="col-md-6">
            <%-- 分页条--%>
            <nav aria-label="...">
                <ul class="pagination">
                    <li><a href="${pageContext.request.contextPath}/emps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum-1}"
                                                aria-label="Previous"><span aria-hidden="true">«</span></a></li>
                    </c:if>

                    <%-- 连续要显示的页面 --%>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                        <c:if test="${page_num==pageInfo.pageNum}">
                            <li class="active"><a
                                    href="${pageContext.request.contextPath}/emps?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                        <c:if test="${page_num!=pageInfo.pageNum}">
                            <li><a href="${pageContext.request.contextPath}/emps?pn=${page_num}">${page_num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum+1}"
                               aria-label="Next"><span aria-hidden="true">»</span></a></li>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pages}">尾页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
