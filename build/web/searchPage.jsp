<%-- 
    Document   : searchPage
    Created on : Jan 14, 2017, 4:23:51 PM
    Author     : hansa
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="database.Db_Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <h1><a href="upload_form.jsp" >GO to Home Page</a></h1>
        
        
        <%
            try
            {
                    Db_Connection dbconn=new Db_Connection();
                    Connection myconnection= dbconn.Connection();

                    String sqlString = "SELECT * FROM files";
                    Statement myStatement = myconnection.createStatement();
                    ResultSet rs=myStatement.executeQuery(sqlString);

                    if(!rs.isBeforeFirst())
                    {
                        %>
                            <tr>
                            <td colspan="3"><center><%out.print("No Files!"); %></center></td>
                            </tr>
                        <%
                    }    

                    while(rs.next())
                    {   
                %>
                        <tr>
                            <td><center><%out.print(rs.getString("id")); %></center></td>
                            <td><center><%out.print(rs.getString("namef")); %></center></td>
                            <td><center><%out.print(rs.getString("telephone")); %></center></td>
                            <td><center><%out.print(rs.getString("positions")); %></center></td>
                            <td><center><%out.print(rs.getString("categories")); %></center></td>
                            <td><center><a href="view_file.jsp?id=<%out.print(rs.getString("id"));%>">View</a></center></td>
                        </tr>
                <%
                    }
                %>
                <%
                                rs.close();
                                myStatement.close();
                                myconnection.close();
                        }catch(Exception e){e.printStackTrace();}    
                        
                    %>
    </body>
</html>
