package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import database.Db_Connection;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.RequestDispatcher;

@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215)

public class UploadFileController extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
        
                InputStream inputStream = null;

                Random rand = new Random();
                int  n = rand.nextInt(9999) + 1;
                String idTemp=(String.valueOf(n));

                
                String title=(request.getParameter("title"));
                String name=(request.getParameter("name"));
                String telephone=(request.getParameter("telephone"));
                String positions=(request.getParameter("positions"));
                String categories=(request.getParameter("categories"));
                String sent=(request.getParameter("sent"));
                String country = (request.getParameter("country"));
                String fileType = "application/pdf";
                Part filePart = request.getPart("file_uploaded");
                
                if (filePart != null) 
                {
                    System.out.println(filePart.getName());
                    System.out.println(filePart.getSize());
                    System.out.println(filePart.getContentType());
                    fileType = filePart.getContentType();

                    inputStream = filePart.getInputStream();
                }
        
                try 
                {
                    Db_Connection dbconn=new Db_Connection();
                    Connection conn= dbconn.Connection();
                    
                    String sql = "INSERT INTO files (id, title,namef,telephone,positions,categories,sent,fileType, file,country) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, idTemp);
                    statement.setString(2, title);
                    statement.setString(3, name);
                    statement.setString(4, telephone);
                    statement.setString(5, positions);
                    statement.setString(6, categories);
                    statement.setString(7, sent);
                    statement.setString(8, fileType);
             
                    if (inputStream != null) 
                    {
                        statement.setBinaryStream(9, inputStream, (int) filePart.getSize());
                    }
                    
                    statement.setString(10, country);
                    int row = statement.executeUpdate();
                    if (row > 0) 
                    {
                        out.println("File uploaded!!!");
                        
                        conn.close();
                        
                        RequestDispatcher rs = request.getRequestDispatcher("upload_form.jsp");
                        rs.include(request, response);
                    }
                    else
                    {
                        out.println("Couldn't upload your file!!!");
                        
                        conn.close();
                        
                        RequestDispatcher rs = request.getRequestDispatcher("upload_form.jsp");
                        rs.include(request, response);
                    }    

                }catch(Exception e){e.printStackTrace();}     
    }   
}