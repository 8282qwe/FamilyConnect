package model.dao;

import model.dto.calendarDto;
import model.mydbconnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class calendarDao {
    mydbconnect mydb = new mydbconnect();

    public List<calendarDto> searchAllByUserIdNotGroupidToday(int userId,String groupid) throws SQLException {
        Connection conn = mydb.getConnection();
        List<calendarDto> calendarDtoList = null;
        String sql = "select * from Schedule where (userid=? or groupid=?) and ((startdt>=curdate()) and (startdt<date_add(curdate(),interval 1 day ))) order by startdt";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2,groupid == null?" ":groupid);
        ResultSet rs = ps.executeQuery();
        calendarDtoList = new ArrayList<calendarDto>();
        while (rs.next()) {
            calendarDto dto = new calendarDto();
            dto.setScheduledid(rs.getInt("scheduledid"));
            dto.setTitle(rs.getString("title"));
            dto.setDescription(rs.getString("description"));
            dto.setStartdt(rs.getString("startdt"));
            dto.setEnddt(rs.getString("enddt"));
            calendarDtoList.add(dto);
        }
        return calendarDtoList;
    }

    public List<calendarDto> searchAllByUserIdNotGroupidTomorrow(int userId,String groupid) throws SQLException {
        Connection conn = mydb.getConnection();
        List<calendarDto> calendarDtoList = null;
        String sql = "select * from Schedule where (userid=? or groupid=?) and ((startdt>=date_add(curdate(),interval 1 day )) and (startdt<date_add(curdate(),interval 2 day ))) order by startdt";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2,groupid == null?" ":groupid);
        ResultSet rs = ps.executeQuery();
        calendarDtoList = new ArrayList<calendarDto>();
        while (rs.next()) {
            calendarDto dto = new calendarDto();
            dto.setScheduledid(rs.getInt("scheduledid"));
            dto.setTitle(rs.getString("title"));
            dto.setDescription(rs.getString("description"));
            dto.setStartdt(rs.getString("startdt"));
            dto.setEnddt(rs.getString("enddt"));
            calendarDtoList.add(dto);
        }
        return calendarDtoList;
    }

    public List<calendarDto> searchAllByUserIdNotGroupidNextWeek(int userId,String groupid) throws SQLException {
        Connection conn = mydb.getConnection();
        List<calendarDto> calendarDtoList = null;
        String sql = "select * from Schedule where (userid=? or groupid=?) and ((startdt>=date_add(curdate(),interval 7 day )) and (startdt<date_add(curdate(),interval 15 day ))) order by startdt";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2,groupid == null?" ":groupid);
        ResultSet rs = ps.executeQuery();
        calendarDtoList = new ArrayList<calendarDto>();
        while (rs.next()) {
            calendarDto dto = new calendarDto();
            dto.setScheduledid(rs.getInt("scheduledid"));
            dto.setTitle(rs.getString("title"));
            dto.setDescription(rs.getString("description"));
            dto.setStartdt(rs.getString("startdt"));
            dto.setEnddt(rs.getString("enddt"));
            calendarDtoList.add(dto);
        }
        return calendarDtoList;
    }

    public boolean insertSchedule(calendarDto calendarDto,String userid, String groupid) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "insert into Schedule values(NULL,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, calendarDto.getTitle());
        ps.setString(2, calendarDto.getDescription());
        String[] buf = calendarDto.getStartdt().split("T");
        String[] buf2 = calendarDto.getEnddt().split("T");
        ps.setTimestamp(3, Timestamp.valueOf(buf[0]+" "+buf[1]+":00"));
        ps.setTimestamp(4, Timestamp.valueOf(buf2[0]+" "+buf2[1]+":00"));
        ps.setString(5, userid);
        ps.setString(6, groupid);
        return ps.executeUpdate()>0;
    }

    public List<calendarDto> searchAlluserid(String userid) throws SQLException {
        Connection conn = mydb.getConnection();
        List<calendarDto> calendarDtoList = new ArrayList<>();
        String sql = "select * from Schedule where userid=? and groupid IS NULL";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(userid));
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            calendarDto dto = new calendarDto();
            dto.setScheduledid(rs.getInt("scheduledid"));
            dto.setTitle(rs.getString("title"));
            dto.setDescription(rs.getString("description"));
            dto.setStartdt(rs.getString("startdt"));
            dto.setEnddt(rs.getString("enddt"));
            calendarDtoList.add(dto);
        }
        return calendarDtoList;
    }

    public List<calendarDto> searchAlluserid(String userid,String groupid) throws SQLException {
        Connection conn = mydb.getConnection();
        List<calendarDto> calendarDtoList = new ArrayList<>();
        String sql = "select * from Schedule where groupid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, groupid);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            calendarDto dto = new calendarDto();
            dto.setScheduledid(rs.getInt("scheduledid"));
            dto.setTitle(rs.getString("title"));
            dto.setDescription(rs.getString("description"));
            dto.setStartdt(rs.getString("startdt"));
            dto.setEnddt(rs.getString("enddt"));
            dto.setUserid(rs.getInt("userid"));
            calendarDtoList.add(dto);
        }
        return calendarDtoList;
    }

    public boolean updateSchedule(calendarDto calendarDto) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "update Schedule set title=?, description=?, startdt=?, enddt=? where scheduledid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, calendarDto.getTitle());
        ps.setString(2, calendarDto.getDescription());
        String[] buf = calendarDto.getStartdt().split("T");
        String[] buf2 = calendarDto.getEnddt().split("T");
        ps.setTimestamp(3, Timestamp.valueOf(buf[0]+" "+buf[1]+":00"));
        ps.setTimestamp(4, Timestamp.valueOf(buf2[0]+" "+buf2[1]+":00"));
        ps.setInt(5, calendarDto.getScheduledid());
        return ps.executeUpdate()>0;
    }

    public boolean deleteSchedule(int scheduledid) throws SQLException {
        Connection conn = mydb.getConnection();
        String sql = "delete from Schedule where scheduledid=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, scheduledid);
        return ps.executeUpdate()>0;

    }
}
