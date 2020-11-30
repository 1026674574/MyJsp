<%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/19
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>login</title>
    <style>
        body {
            text-align: center;
            margin: 0;
        }

        #login {
            margin: 0 auto;
            width: 300px;
            background-color: lightblue;
        }
        .color{
            color:red;
        }
    </style>

</head>
<body>
<%
    String value = null;
    String password = null;
    Cookie[] cookies = request.getCookies();
    if (cookies!=null){
        for (Cookie cookie : cookies) {
            String name = cookie.getName();
            if ("username".equals(name)){
                 value = cookie.getValue();
                String[] split = value.split("&&");
                value = split[0];
                password = split[1];
                break;
            }
        }
    }
%>
<div id="login">
    <H3>系统登陆 </H3>
    <FORM action=${pageContext.request.contextPath}/loginServlet?method=login method=post>
        <TABLE align="center">
            <TBODY>
            <TR>
                <TD align=right>账号：</TD>
                <TD><INPUT style="WIDTH: 160px; HEIGHT: 26px" value=<%=cookies!=null ? value :"" %> name=account required></TD>
            </TR>
            <TR>
                <TD align=right>密码：</TD>
                <TD><INPUT style="WIDTH: 160px; HEIGHT: 26px" value=<%=cookies!=null ? password :""%> type=password name=password required>
                </TD>
            </TR>
            <TR>
                <TD></TD>
                <TD > <INPUT  type=checkbox name=flag value=true checked>是否记住账号</TD>
            </TR>
            <TR>
                <TD></TD>
                <TD><INPUT type=submit value=登陆> <INPUT type=reset value=重置>
                </TD>
            </TR>
            <%if (request.getAttribute("error") != null) {%>
            <tr class="color">
                <%=(request.getAttribute("error"))%>
            </tr>
<%}%>
            </TBODY>
        </TABLE>
        <DIV>返回 <A href="index.jsp">主页面</A>
        </DIV>
    </FORM>
</div>

</body>
</html>
