package com.cdvtc.contact.dao;

import com.cdvtc.contact.pojo.Admin;
import com.cdvtc.contact.pojo.Classinfo;
import com.cdvtc.contact.pojo.Contact;
import com.cdvtc.contact.db.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDaoImpl implements ContactDao {
    DBConnection db = new DBConnection();


    @Override
    public List<Contact> getAllContacts(String name, String sex, int classId,int beg) {

        List<Contact> list = new ArrayList<Contact>();
        if (beg < 0)
            return list;
        try {

            String sql = "select * from contact where (name like ? or stuid like ? or mobile like ? or qq like ? or email like ?)";
            if("m".equals(sex) || "f".equals(sex)){
                sql += " and sex='"+sex+"'";
            }
            if(classId > 0){
                sql += " and classId="+classId;
            }
            sql+=" limit ?,10";
            Connection connection = db.getConnection();
            PreparedStatement pst =  connection.prepareStatement(sql);
            String filterStr = "%" + name + "%";
            pst.setString(1, filterStr);
            pst.setString(2, filterStr);
            pst.setString(3, filterStr);
            pst.setString(4, filterStr);
            pst.setString(5, filterStr);
            pst.setInt(6,beg);
            ResultSet resultSet = pst.executeQuery();
            while (resultSet.next()) {
                Contact contact = new Contact();
                contact.setId(resultSet.getInt(1));
                contact.setName(resultSet.getString(2));
                contact.setStuid(resultSet.getString(3));
                contact.setSex(resultSet.getString(4));
                contact.setClassinfo(getClassinfo(resultSet.getInt(5)));
                contact.setMobile(resultSet.getString(6));
                contact.setEmail(resultSet.getString(7));
                contact.setQq(resultSet.getString(8));
                contact.setAddress(resultSet.getString(9));
                contact.setPolitics(resultSet.getString(10));
                list.add(contact);
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return null;
    }

    @Override
    public int getAllContacts(String name, String sex, int classId) {
        int i = 0;
        Connection connection = db.getConnection();
        try {
            String sql = "select count(*) from contact where (name like ? or stuid like ? or mobile like ? or qq like ? or email like ?)";
            if("m".equals(sex) || "f".equals(sex)){
                sql += " and sex='"+sex+"'";
            }
            if(classId > 0){
                sql += " and classId="+classId;
            }
            PreparedStatement pst = connection.prepareStatement(sql);
            String filterStr = "%" + name + "%";
            pst.setString(1, filterStr);
            pst.setString(2, filterStr);
            pst.setString(3, filterStr);
            pst.setString(4, filterStr);
            pst.setString(5, filterStr);
            ResultSet resultSet = pst.executeQuery();
            if (resultSet.next())
            {
                i=resultSet.getInt("count(*)");
            }
           return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }

    public Classinfo getClassinfo(int classId) {
        Classinfo classinfo = new Classinfo();
        Connection connection = db.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from classinfo where id =" + classId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                classinfo.setId(resultSet.getInt("id"));
                classinfo.setName(resultSet.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return classinfo;
    }

    @Override
    public int setContacts(Contact contact) {
        Connection connection = db.getConnection();
        int i = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("insert into contact values(null,?,?,?,?,?,?,?,?,?)");
            preparedStatement.setString(1, contact.getName());
            preparedStatement.setString(2, contact.getStuid());
            preparedStatement.setString(3, contact.getSex());
            preparedStatement.setInt(4, contact.getClassinfo().getId());
            preparedStatement.setString(5, contact.getMobile());
            preparedStatement.setString(6, contact.getEmail());
            preparedStatement.setString(7, contact.getQq());
            preparedStatement.setString(8, contact.getAddress());
            preparedStatement.setString(9, contact.getPolitics());
            i = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return i;
    }

    @Override
    public List<Classinfo> getAllClassinfo() {
        List<Classinfo> list = new ArrayList<Classinfo>();
        Connection connection = db.getConnection();
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement("select * from classinfo");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Classinfo classinfo = new Classinfo();
                classinfo.setId(resultSet.getInt(1));
                classinfo.setName(resultSet.getString(2));
                list.add(classinfo);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * @param stuid 学号值
     * @return 返回boole类型
     **/
    @Override
    public boolean isContactExisted(String stuid) {
        Connection connection = db.getConnection();
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement("select * from contact where stuid = ?");
            preparedStatement.setString(1, stuid);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next())
                resultSet.close();
            preparedStatement.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * @param admin 管理员信息
     * @implNote 管理员登录
     **/
    @Override
    public Admin login(Admin admin) {
        Connection connection = db.getConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement("select * from admin where account = ? and password = ?");
            preparedStatement.setString(1, admin.getAccount());
            preparedStatement.setString(2, admin.getPassword());
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                admin.setId(resultSet.getInt(1));
                admin.setName(resultSet.getString(4));
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                assert resultSet != null;
                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public int ChangeContact(Contact contact) {
        Connection connection = db.getConnection();
        int i = 0;
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement("update Contact set  name = ?,stuid = ?, sex = ?, classid = ?, mobile = ?, email = ?," +
                    "qq= ?,address = ?,politics = ? where id = ? ");
            preparedStatement.setString(1, contact.getName());
            preparedStatement.setString(2, contact.getStuid());
            preparedStatement.setString(3, contact.getSex());
            preparedStatement.setInt(4, contact.getClassinfo().getId());
            preparedStatement.setString(5, contact.getMobile());
            preparedStatement.setString(6, contact.getEmail());
            preparedStatement.setString(7, contact.getQq());
            preparedStatement.setString(8, contact.getAddress());
            preparedStatement.setString(9, contact.getPolitics());
            preparedStatement.setInt(10, contact.getId());
            i = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        return i;
    }

    @Override
    public Contact selectContact(String stuid) {
        Contact contact = new Contact();
        Connection connection = db.getConnection();
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement("select * from contact where stuid = ?");
            preparedStatement.setString(1, stuid);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                contact.setId(resultSet.getInt("id"));
                contact.setName(resultSet.getString("name"));
                contact.setStuid(resultSet.getString("stuid"));
                contact.setSex(resultSet.getString("sex"));
                contact.setClassinfo(getClassinfo(resultSet.getInt("classid")));
                contact.setEmail(resultSet.getString("email"));
                contact.setQq(resultSet.getString("qq"));
                contact.setAddress(resultSet.getString("address"));
                contact.setPolitics(resultSet.getString("politics"));
                contact.setMobile(resultSet.getString("mobile"));
                resultSet.close();
                preparedStatement.close();
                connection.close();
                return contact;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void DeleteContact(Integer id) {
        Connection connection = db.getConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement("delete from contact where id = ? ");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                preparedStatement.close();
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }
}
