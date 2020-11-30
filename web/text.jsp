<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%--
  Created by IntelliJ IDEA.
  User: asus1
  Date: 2020/10/29
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:out value="sss">

</c:out>
<c:if test="${5>4}">
55555555
</c:if>
<%
int i=0;

i = i+1;

%>
<%=i%>
<%--<jsp:setProperty name = "box" property = "perimeter" value = "100"/>--%>
<%--<jsp:setProperty name = "box" property = "perimeter"--%>
<%--                 value = "${2*box.width+2*box.height}"/>--%>
<%--<jsp:text>--%>
<%--    Box Perimeter is: ${2*box.width + 2*box.height}--%>
<%--</jsp:text>--%>
