<%@ page import="com.cdvtc.contact.pojo.Contact" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.pojo.Classinfo" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/9
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <STYLE>BODY {
        TEXT-ALIGN: center
    }
    #register {
        PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; WIDTH: 600px; PADDING-TOP: 10px; BACKGROUND-COLOR: lightblue;
        margin: 0 auto;
    }
    </STYLE>
</head>
<body>
<H3>注册个人通讯录 </H3>
<DIV id=register>
    <FORM action=register_deal.jsp?action=register method=get>
        <TABLE>
            <TBODY>
            <TR>
                <TD align=right>姓名： </TD>
                <TD><INPUT name=name <%if (request.getParameter("name")!=null){%> value="<%request.getParameter("name");}%>"> </TD>
            <td><%if (request.getAttribute("error_name")!=null){%>
                <%=request.getAttribute("error_name")%>
                <%}%>
            </td>
            </TR>
            <TR>
                <TD align=right>性别： </TD>
                <TD>男 <INPUT type=radio value=M name=sex> 女 <INPUT type=radio value=F name=sex> </TD></TR>
            <TR>
                <TD align=right>学号： </TD>
                <TD><INPUT name=stuid> </TD>
                <td><%if (request.getAttribute("error_stuid")!=null){%>
                    <%=request.getAttribute("error_stuid")%>
                    <%}%></td>
            </TR>
            <TR>
                <TD align=right>班级： </TD>
                <TD><SELECT name=classId>
                    <%ContactDaoImpl contact = new ContactDaoImpl();
                        List<Classinfo> allClassinfo = contact.getAllClassinfo();
                        for (Classinfo classinfo : allClassinfo) {
                    %>
                    <OPTION value=<%=classinfo.getId()%>><%=classinfo.getName()%></OPTION>
                    <%}%>
                </SELECT>
                </TD></TR>
            <TR>
                <TD align=right>手机号码： </TD>
                <TD><INPUT name=mobile"> </TD>
                <td><%if(request.getAttribute("error_mobile")!=null){%>
                    <%=request.getAttribute("error_mobile")%>
                    <%}%>
                </td>
            </TR>
            <TR>
                <TD align=right>电子邮件： </TD>
                <TD><INPUT name=email> </TD></TR>
            <TR>
                <TD align=right>QQ号码： </TD>
                <TD><INPUT name=qq > </TD></TR>
            <TR>
            <TR>
                <TD align="right">政治面貌</TD>
                <TD><INPUT name=politics> </TD></TR>
            <TR>
            <TR>
                <TD align="right">家庭住址</TD>
                <TD><INPUT name=home> </TD></TR>
            <TR>
                <TD></TD>
                <TD><INPUT type=submit value=注册> <INPUT type=reset value=重置>
                </TD></TR></TBODY></TABLE></FORM></DIV>
<DIV>返回 <A href="index.jsp">主页面</A>
</DIV>
</body>
</html>
