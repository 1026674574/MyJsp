package com.cdvtc.contact.servlet;

import com.cdvtc.contact.dao.ContactDao;
import com.cdvtc.contact.dao.ContactDaoImpl;
import com.cdvtc.contact.pojo.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet",urlPatterns = "/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");//将管理员信息保存在session中
        String password = request.getParameter("password");
        boolean flag = Boolean.parseBoolean(request.getParameter("flag"));
        ContactDao dao = new ContactDaoImpl();
        Admin admin = new Admin(account, password);
        Cookie cookie = new Cookie("username", account+"&&"+password);
        if (dao.login(admin) != null) {
            if (!flag) {
                cookie.setMaxAge(0);
            }
            else {
                response.addCookie(cookie);
            }
            HttpSession session = request.getSession();//通过request获取seesion
            session.setAttribute("admin", admin);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "账号或密码输入有误");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
