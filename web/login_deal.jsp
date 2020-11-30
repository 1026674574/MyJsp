<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.pojo.Admin" %><%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/19
  Time: 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String account = request.getParameter("account");//将管理员信息保存在session中
    String password = request.getParameter("password");
    boolean flag = Boolean.parseBoolean(request.getParameter("flag"));
    ContactDao dao = new ContactDaoImpl();
    Admin admin = new Admin(account, password);
    Cookie cookie = new Cookie("username", account);
    Cookie cookie1 = new Cookie("password",password);
    if (dao.login(admin) != null) {
        if (!flag) {
            cookie.setMaxAge(0);
            cookie1.setMaxAge(0);
        }
        else {
            response.addCookie(cookie);
            response.addCookie(cookie1);
        }
        session.setAttribute("admin", admin);
        response.sendRedirect("index.jsp");
    } else {
        request.setAttribute("error", "账号或密码输入有误");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>
</body>
</html>
