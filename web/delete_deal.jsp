<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/28
  Time: 22:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
   int id = Integer.parseInt(request.getParameter("id"));
   ContactDao dao = new ContactDaoImpl();
   dao.DeleteContact(id);
   response.sendRedirect("index.jsp");
%>
