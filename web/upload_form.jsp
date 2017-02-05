<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.Db_Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload CVS</title>
    </head>
    
    <body>
        <form method="post" action="UploadFileController" enctype="multipart/form-data">
            <center>
                <table border="1" width="50%" cellpadding="5">
                    <thead> 
                            <th colspan="3">Upload CVs</th>        
                    </thead>
                    <tbody>
                        <tr>    
                            <td>Title : </td>
                            <td><input type="text" name="title" size="30"></td>
                        </tr>
                        <tr>    
                            <td>Name : </td>
                            <td><input type="text" name="name" size="30"></td>
                        </tr>
                        <tr>    
                            <td>Telephone : </td>
                            <td><input type="text" name="telephone" size="30"></td>
                        </tr>
                        <tr>    
                            <td>Positions going to apply : </td>
                            <td><input type="text" name="positions" size="30"></td>
                        </tr>
                        <tr>    
                            <td>Categories going to apply : </td>
                            <td><input type="text" name="categories" size="30"></td>
                        </tr>
                        <tr>    
                            <td>Contries going to apply : </td>
                            <td><input type="text" name="country" size="30"></td>
                        </tr>
                        <tr>    
                            <td>Sent to Nanadika(Y,N) : </td>
                            <td><input type="text" name="sent" size="30"></td>
                        </tr>
                        <tr>
                            <td>Choose File CV : </td>
                            <td><input type="file" name="file_uploaded" /></td>
                        </tr>
                        <tr>
                            <td colspan="3"><center><input type="submit" value="Upload"></center></td>
                        </tr>
                    </tbody>             
                </table>
            </center>
        </form>
        
        <br>
        <div>
            <form method="post" action="SearchBy">
                Search CVs: 
                Enter Category/Position Name : <input type="text" name="searchText" />
                <select name="SearchBy">
                    <option>Category</option>
                    <option>Position</option>
                    <option>Send to nandika</option>
                    <option>Not Send to nandika</option>
                </select>
                <input type="submit" value="search">
            </form>
        </div>
        <br>
        
        <br><br>
        
        <table border="1" width="25%" cellpadding="5">
            <thead> 
               <th colspan="3">Uploaded Files</th>        
            </thead>
                <tbody>
                    <tr>
                        <td><center><b>Id</b></center><td><center><b>Name</b></center></td>
                            <td><center><b>Telephone</b></center></td>
                            <td><center><b>Position</b></center></td>
                            <td><center><b>Category</b></center></td>
                            <td><center><b>Country</b></center></td>
                            <td><center><b>Nandika Got</b></center></td>
                            <td><center><b>File</b></center></td>
                    </tr>
                    
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
                                        <td><center><%out.print(rs.getString("country")); %></center></td>
                                        <td><center><%out.print(rs.getString("sent")); %></center></td>
                                        <td><center><a href="view_file.jsp?id=<%out.print(rs.getString("id"));%>">View</a></center></td>
                                    </tr>
                            <%
                                }
                            %>
                            
                </tbody> 
        </table>
                            
                            <%
                                rs.close();
                                myStatement.close();
                                myconnection.close();
                        }catch(Exception e){e.printStackTrace();}    
                        
                    %>
        
        <div style="position: relative">
            <div style="position: fixed ; bottom: 0 ; width:100% ; text-align:center ">
               
            </div>
        </div>  
  
    </body>
</html>