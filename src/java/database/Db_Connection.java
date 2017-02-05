package database;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Db_Connection 
{
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
    static final String DB_URL = "jdbc:mysql://localhost/techworld3g_2";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "@apiitA+";
    public Connection Connection()
    {
        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection myConnection = DriverManager.getConnection(DB_URL,USER,PASS);;
            
            return myConnection;
        } catch (ClassNotFoundException | SQLException ex) {Logger.getLogger(Db_Connection.class.getName()).log(Level.SEVERE, null, ex);}
        return null;
    }
}
