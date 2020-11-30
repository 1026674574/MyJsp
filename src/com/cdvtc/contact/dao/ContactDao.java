package com.cdvtc.contact.dao;


import com.cdvtc.contact.pojo.Admin;
import com.cdvtc.contact.pojo.Classinfo;
import com.cdvtc.contact.pojo.Contact;

import java.util.List;

public interface ContactDao {


    List<Contact> getAllContacts(String classid,String sex,int guanjianzi, int beg);
    int getAllContacts(String classid,String sex,int guanjianzi);
    Classinfo getClassinfo(int classId);
    int setContacts(Contact contact);
    List<Classinfo> getAllClassinfo();
    boolean isContactExisted(String stuid);
    Admin login(Admin admin);
    int ChangeContact(Contact contact);
    Contact selectContact(String stuid);
    void DeleteContact(Integer id);
}
