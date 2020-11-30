<%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/19
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
//销毁session对象
    session.invalidate();
//跳转页面到首页
    response.sendRedirect("index.jsp");
%>
