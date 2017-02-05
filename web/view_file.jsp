<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="database.Db_Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View File</title>
    </head>
    <body>
        
        <%  
            String id=(request.getParameter("id"));
            
            Blob file = null;
            byte[ ] fileData = null ;

            try
            {   
                String fileType = "application/pdf";
                Db_Connection dbconn=new Db_Connection();
                Connection conn= dbconn.Connection();
            
                String sqlString = "SELECT file,fileType FROM files WHERE id = '"+id+"'";
                Statement myStatement = conn.createStatement();
                
                ResultSet rs=myStatement.executeQuery(sqlString);
                
                if (rs.next()) 
                {
                    fileType = rs.getString("fileType");
                    file = rs.getBlob("file");
                    fileData = file.getBytes(1,(int)file.length());
                } else 
                {
                    out.println("file not found!");
                    return;
                }
                
                response.setContentType(fileType);
                response.setHeader("Content-Disposition", "inline");
                response.setContentLength(fileData.length);
                
                OutputStream output = response.getOutputStream();
                output.write(fileData);
                
                output.flush();
                
            } catch (SQLException ex) {Logger.getLogger(Logger.class.getName()).log(Level.SEVERE, null, ex);} 
        %>
        
        <br><br>
        <a href="upload_form.jsp">Go to Main Page...</a>        
                
        <div style="position: relative">
        </div>
        
    </body>
</html>