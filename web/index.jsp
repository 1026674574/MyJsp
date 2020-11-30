<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.cdvtc.contact.pojo.Contact" %>
<%@ page import="com.cdvtc.contact.dao.ContactDao" %>
<%@page import="com.cdvtc.contact.dao.ContactDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cdvtc.contact.pojo.Admin" %>
<%@ page import="com.cdvtc.contact.pojo.Classinfo" %>
<%@ page import="com.sun.xml.internal.bind.v2.model.core.ClassInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <STYLE type=text/css>#customers {
        WIDTH: 100%;
        FONT-FAMILY: "Trebuchet MS", Arial, Helvetica, sans-serif;
        BORDER-COLLAPSE: collapse
    }

    #customers TD {
        BORDER-RIGHT: #98bf21 1px solid;
        PADDING-RIGHT: 7px;
        BORDER-TOP: #98bf21 1px solid;
        PADDING-LEFT: 7px;
        FONT-SIZE: 1em;
        PADDING-BOTTOM: 2px;
        BORDER-LEFT: #98bf21 1px solid;
        PADDING-TOP: 3px;
        BORDER-BOTTOM: #98bf21 1px solid
    }

    #customers TH {
        BORDER-RIGHT: #98bf21 1px solid;
        PADDING-RIGHT: 7px;
        BORDER-TOP: #98bf21 1px solid;
        PADDING-LEFT: 7px;
        FONT-SIZE: 1em;
        PADDING-BOTTOM: 2px;
        BORDER-LEFT: #98bf21 1px solid;
        PADDING-TOP: 3px;
        BORDER-BOTTOM: #98bf21 1px solid
    }

    #customers TH {
        FONT-SIZE: 1.1em;
        PADDING-BOTTOM: 4px;
        COLOR: #ffffff;
        PADDING-TOP: 5px;
        BACKGROUND-COLOR: skyblue;
        TEXT-ALIGN: left
    }

    #customers TR.alt TD {
        COLOR: #000000;
        BACKGROUND-COLOR: lightblue
    }
    .page{
        width: 600px;
        margin: 0 auto;
        display:flex;
        justify-content: space-between;
    }
    .export{
        width: 150px;
        margin: 0 auto;
    }
    .export a{
        text-decoration: none;
    }
    </STYLE>
    <META content="MSHTML 6.00.2900.5726" name=GENERATOR>
</head>
<body>

<script type="text/javascript">


</script>
<script type="text/javascript">
    function firm(stuid,id)
    {//利用对话框返回的值 （true 或者 false）
        if(confirm("你确信要删除"+id+"该同学"))
        {//如果是true ，那么就把页面转向thcjp.cnblogs.com
            location.href="delete_deal.jsp?id="+id;
        }
        else
        {//
            location.href="index.jsp";
        }
    }
</script>

<DIV style="TEXT-ALIGN: right">通讯录 <A href="register.jsp">注册</A>

    <%
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
    %>
    管理员 <A href="login.jsp">登陆</A></DIV>
 <%}else {%>
管理员 <A href="logout.jsp">退出</A></DIV>

<%}%>
<%if (admin != null) {%>
<DIV><SPAN>当前用户:<%=admin.getAccount()%>[<%=admin.getName()%>]</SPAN></DIV>
<%}%>
<%
    String beginning = request.getParameter("beginning");
    if (beginning==null)
        beginning="0";
    int beg = Integer.parseInt(beginning);
    String name = request.getParameter("name");
    String sex = request.getParameter("sex");
    String classIdStr = request.getParameter("classId");
    int classId = 0;
    if (classIdStr != null && !classIdStr .equals("null")) {
        classId = Integer.parseInt(classIdStr);
    }

    if (name == null) {
        name = "";
    }
    ContactDao contactDao = new ContactDaoImpl();
    int i = contactDao.getAllContacts(name,sex,classId);
    List<Contact> allContacts = contactDao.getAllContacts(name,sex,classId,beg);
    List<Classinfo> allClassinfo = contactDao.getAllClassinfo();
%>

<script type="text/javascript">
    function fenye()
    {
            confirm("没有数据" )
    }
</script>
<H3>通讯录列表 </H3>
<form action=index.jsp?action=index method="get">
    <select name="classId" style="border: black 1px solid">
        <% for (Classinfo classinfo : allClassinfo) {
           %>
        <option value=<%=classinfo.getId()%>  <%=classinfo.getId() == classId ? "selected" : ""%> > <%=classinfo.getName()%></option>
        <%}%>
        <option value="0" selected >所有</option>
    </select>
    <select name="sex" style="border: black 1px solid">
        <option value=m <%="m".equals(sex) ? "selected" : ""%>>男</option>
        <option value=f <%="f".equals(sex) ? "selected" : ""%>>女</option>
        <option value="" selected >所有</option>
    </select>
    <input  name="name" placeholder="请输入姓名、学号、电话号码等关键字" value="<%=name%>">
    <input type="submit" value="查询">
</form>
</DIV>
<TABLE id="customers">
    <THEAD>
    <TR>
        <TH witdh="5%">姓名</TH>
        <TH witdh="5%">性别</TH>
        <TH witdh="15%">学号</TH>
        <TH witdh="15%">班级</TH>
        <TH witdh="10%">手机号码</TH>
        <TH witdh="20%">电子邮件</TH>
        <TH witdh="10%">QQ号码</TH>
        <TH witdh="10%">政治面貌</TH>
        <TH witdh="20%">家庭住址</TH>
        <%if (admin != null){ %>
        <TH witdh="30%">編輯</TH>
        <%}%>
    </TR>
    </THEAD>
    <TBODY>

        <%
        boolean alt = true;
        for (Contact contact : allContacts) {
    %>
    <TR <%if (alt) { %> class="alt"<%}%>>
        <TD><%=contact.getName()%>
        </TD>
        <TD><%=contact.getSex() == null ? "" : (contact.getSex().equals("m") ? "男" : "女")%>
        </TD>
        <TD><%=contact.getStuid()%>
        </TD>
        <TD><%=contact.getClassinfo().getName()%>
        </TD>
        <TD><%=contact.getMobile()%>
        </TD>
        <TD><%=contact.getEmail()%>
        </TD>
        <TD><%=contact.getQq()%>
        </TD>
        <TD><%=contact.getPolitics()%>
        </TD>
        <TD><%=contact.getAddress()%>
        </TD>
        <%if (admin != null) {%>
        <TD><A href="edit.jsp?id=<%=contact.getStuid()%>">编辑</A> <A
                href="javascript:void(0)" onclick="firm(<%=contact.getId()%>, <%=contact.getStuid()%>)">删除</A> </TD>
        <%}%>
    </TR>
    <%
            alt = !alt;
        } %>

    </TBODY>

</TABLE>
<div class="page">
    <p><a href="index.jsp?beginning=0">首页</a></p>
    <p>总页数[<%=i/10%>]</p>

    <p>当前页数[<%=beg == 0 ? 1 : beg/10+1%>]</p>
    <%if (beg-10<0) {%>
    <p>这已经是第一页了</p>
    <% }else { %>
    <p><a href="index.jsp?beginning=<%=beg-10%>&classId=<%=classIdStr%>&sex=<%=sex%>&name=<%=name%>">上一页</a></p>
    <%}%>
    <%if (i==0) {%>
    <p>这是最后一页了</p>
    <% }else { %>
    <p><a href="index.jsp?beginning=<%=beg+10%>&classId=<%=classIdStr%>&sex=<%=sex%>&name=<%=name%>">下一页</a></p>
    <%}%>
</div>
<p class="export"><a href="#" onclick="tableToExcel('customers','导出表格')">导出当前页面数据</a></p>
<script>
    var tableToExcel = (function() {

        var uri = 'data:application/vnd.ms-excel;base64,',

            template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',

            base64 = function(s) {

                return window.btoa(unescape(encodeURIComponent(s)))

            },

            format = function(s, c) {

                return s.replace(/{(\w+)}/g, function(m, p) {

                    return c[p];

                })

            }

        return function(table, name) {

            if (!table.nodeType) table = document.getElementById(table);

            var ctx = {

                worksheet: name || 'Worksheet',

                table: table.innerHTML

            };

            window.location.href = uri + base64(format(template, ctx));

        }

    })();

</script>
</body>
</html>
