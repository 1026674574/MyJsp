package com.cdvtc.contact.db;


import java.sql.*;
import java.util.ArrayList;

import com.cdvtc.contact.pojo.Contact;

public class DBConnection {
    Connection connection = null;
    ArrayList<Contact> list;

    public ArrayList<Contact> getList() {
        return list;
    }

    public Connection getConnection() {
        list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("JDBC:mysql:///contact?serverTimezone=GMT%2B8", "root", "6107015");


        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return connection;
    }
}
