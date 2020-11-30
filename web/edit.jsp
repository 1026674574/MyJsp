<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@ page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="com.cdvtc.contact.pojo.Contact" %>
<%@ page import="com.sun.xml.internal.bind.v2.model.core.ClassInfo" %>
<%@ page import="com.cdvtc.contact.pojo.Classinfo" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/26
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改</title>
    <STYLE>BODY {
        TEXT-ALIGN: center
    }
    #register {
        PADDING-RIGHT: 10px;
        PADDING-LEFT: 10px;
        PADDING-BOTTOM: 10px;
        WIDTH: 600px;
        PADDING-TOP: 10px;
        BACKGROUND-COLOR: lightblue;
        margin: 0 auto;
    }
        .error{
            color: red;
        }
    </STYLE>
</head>
<body>



<DIV id=register>
    <%ContactDao dao = new ContactDaoImpl();
    Contact contact = dao.selectContact(request.getParameter("id"));
    List<Classinfo>  classInfoList = dao.getAllClassinfo();

%>
    <FORM action=edit_deal.jsp?action=edit method=post>


        <input type="hidden" name=id value=<%=contact.getId()%>>
        <input type="hidden" name=stuid value=<%=contact.getStuid()%>>

        <TABLE>
            <TBODY>
            <TR>
                <TD align=right>姓名：</TD>
                <TD><label>
                    <INPUT value=<%=contact.getName()%> name=name>
                </label></TD>
                <c:set var="error_name"  value="${requestScope.error_name}"/>

                <c:if test="${error_name != null}">
                    <td class="error"><c:out value="${error_name}"/></td>
                </c:if>

            </TR>
            <tr>
                <td align=right>性别：</td>
                <td>男 <input type=radio <%="M".equalsIgnoreCase(contact.getSex())?"checked":""%> value=m name=sex>
                    女<input type=radio <%="F".equalsIgnoreCase(contact.getSex())?"checked":""%> name=sex value=f name=sex>
                </td>
            </tr>
            <tr>
                <td align=right>班级：</td>
                <td><select name=classid>
                        <% for(Classinfo classInfo: classInfoList){ %>
                    <option value=<%=classInfo.getId()%> <%=classInfo.getId().equals(contact.getClassinfo().getId()) ?"selected":""%>>
                        <%=classInfo.getName()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <TR>
                <TD align=right>手机号码：</TD>
                <TD><INPUT value=<%=contact.getMobile()%> name=mobile></TD>
            </TR>
            <TR>
                <TD align=right>电子邮件：</TD>
                <TD><INPUT value=<%=contact.getEmail()%> name=email></TD>
            </TR>
            <TR>
                <TD align=right>QQ号码：</TD>
                <TD><INPUT value=<%=contact.getQq()%> name=qq></TD>
            </TR>
            <TR>
            <tr>
                <td align="right">政治面貌</td>
                <td><input name=politics value=<%=contact.getPolitics()%>></td>
            </tr>
            <TR>
                <TD align=right>家庭住址</TD>
                <TD><INPUT name=home value=<%=contact.getAddress()%>></TD>
            </TR>
            <TR>
                <TD></TD>
                <TD><INPUT type=submit value=编辑> <INPUT type=reset value=重置>
                </TD>
            </TR>
            </TBODY>
        </TABLE>
    </FORM>
</DIV>
<DIV>返回 <A href="index.jsp">主页面</A>
</DIV>
</body>
</html>
