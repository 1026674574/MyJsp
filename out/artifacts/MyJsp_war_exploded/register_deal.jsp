<%@ page import="com.cdvtc.contact.pojo.Contact" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %><%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/9
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Contact contact = new Contact();
    ContactDao contactDao = new ContactDaoImpl();
    String name = request.getParameter("name");
    String sex = request.getParameter("sex");
    String stuid = request.getParameter("stuid");
    int classId = Integer.parseInt(request.getParameter("classId"));
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");
    String qq = request.getParameter("qq");
    request.getParameter("politics");
    String home = request.getParameter("home");

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
    if (dao.isContactExisted(stuid))
    {
        error_stuid = "学号重复";
    }

    if (Errol_name != null || error_mobile != null || error_stuid !=null) {
        request.setAttribute("error_name", Errol_name);
        request.setAttribute("error_mobile", error_mobile);
        request.setAttribute("error_stuid", error_stuid);
        request.getRequestDispatcher("register.jsp").forward(request, response);//把当前的请求和响应，前转
    }
    
    contact.setName(name);
    contact.setSex(sex);
    contact.setStuid(stuid);
    contact.setClassinfo(contactDao.getClassinfo(classId));
    contact.setMobile(mobile);
    contact.setEmail(email);
    contact.setQq(qq);
    contact.setPolitics(qq);
    contact.setAddress(home);
    int i = contactDao.setContacts(contact);
    response.sendRedirect("index.jsp");

%>
