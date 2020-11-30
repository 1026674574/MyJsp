<%@ page import="com.cdvtc.contact.pojo.Contact" %>
<%@ page import="com.sun.xml.internal.bind.v2.model.core.ClassInfo" %>
<%@ page import="com.cdvtc.contact.pojo.Classinfo" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/26
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //获取参数
    request.setCharacterEncoding("UTF-8"); //设置编码，只针对POST提交有效
    String name = request.getParameter("name");
    String sex = request.getParameter("sex");
    String stuid = request.getParameter("stuid");
    int classid = Integer.parseInt(request.getParameter("classid"));
    String mobile = request.getParameter("mobile");
    String qq = request.getParameter("qq");
    String email = request.getParameter("email");
    String address = request.getParameter("home");
    String politics = request.getParameter("politics");
    int id = Integer.parseInt(request.getParameter("id"));
    //数据验证（略）
    String Errol_name = null;
    String error_mobile = null;
    String error_stuid = null;
    if (name == null || name.length() < 2) {
        Errol_name = "姓名输入有误";
    }
    if (mobile == null || mobile.length() < 11) {
        error_mobile = "手机输入有误";
    }

    //检验学号是否存在
    ContactDao dao = new ContactDaoImpl();


    if (Errol_name != null || error_mobile != null ) {
        request.setAttribute("error_name", Errol_name);
        request.setAttribute("error_mobile", error_mobile);
        request.setAttribute("error_stuid", error_stuid);
        request.getRequestDispatcher("edit.jsp").forward(request, response);//把当前的请求和响应，前转
    }

    //调用DAO
    Contact contact = new Contact();
    contact.setId(id);
    contact.setSex(sex);
    contact.setQq(qq);
    contact.setName(name);
    contact.setMobile(mobile);
    contact.setStuid(stuid);
    contact.setEmail(email);
    contact.setAddress(address);
    contact.setPolitics(politics);
    Classinfo classInfo = new Classinfo();
    classInfo.setId(classid);
    contact.setClassinfo(classInfo);
    dao.ChangeContact(contact);
    //页面跳转
    response.sendRedirect("index.jsp");
%>

