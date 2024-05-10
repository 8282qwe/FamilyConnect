package model.dao;

import model.dto.userDto;
import model.mydbconnect;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.UUID;

public class userDao {
    mydbconnect mydb = new mydbconnect();

    public boolean insertUser(userDto user) throws SQLException, ParseException {
        Connection conn = mydb.getConnection();
        String sql = "insert into user values(NULL,?,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getName());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPhone());
        ps.setDate(4, Date.valueOf(user.getBirthday()));
        ps.setString(5, user.getPassword());
        ps.setString(6, user.getGroupid().isBlank()? String.valueOf(UUID.randomUUID()) :user.getGroupid());
        ps.setString(7, user.getProfile()==null? "" :user.getProfile());
        return ps.executeUpdate()>0;
    }

    public boolean searchByEmail(String email) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "select * from user where email=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            return true;
        }
        return false;
    }

    public String searchForPassword(String email) throws SQLException, ParseException {
        Connection conn = mydb.getConnection();
        String sql = "select * from user where email=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            return rs.getString("password");
        }
        return null;
    }

    public userDto searchByEmailAndPassword(String email, String password) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "select * from user where email=? and password=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            userDto user = new userDto();
            user.setUserid(rs.getInt("userid"));
            user.setName(rs.getString("name"));
            user.setGroupid(rs.getString("groupid"));
            return user;
        }
        return null;
    }

    public userDto searchByUserid(int userid) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "select * from user where userid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userid);
        ResultSet rs = ps.executeQuery();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(rs.next()){
            userDto user = new userDto();
            user.setUserid(rs.getInt("userid"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
            user.setPassword(rs.getString("password"));
            user.setGroupid(rs.getString("groupid"));
            user.setProfile(rs.getString("profile"));
            user.setBirthday(dateFormat.format(rs.getDate("birthday")));
            return user;
        }
        return null;
    }

    public boolean updateByuserid(int userid,userDto userDto) throws SQLException, ParseException {
        Connection conn = mydb.getConnection();
        String sql = "update user set password=?, phone=?, birthday=?, profile=?,groupid=? where userid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, userDto.getPassword());
        ps.setString(2, userDto.getPhone());
        ps.setDate(3,Date.valueOf(userDto.getBirthday()));
        ps.setString(4, userDto.getProfile());
        ps.setString(5, userDto.getGroupid());
        ps.setInt(6, userid);
        return ps.executeUpdate()>0;
    }

    public boolean deleteByuserid(int userid) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "delete from user where userid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userid);
        return ps.executeUpdate()>0;
    }

    public String searchByIdForUsername(int id) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "select * from user where userid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            return rs.getString("name");
        }
        return null;
    }
}
