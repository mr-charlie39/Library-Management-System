package com.lms.daolmpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.lms.pojo.DashboardStats;
import com.lms.util.DBUtil;

public class DashboardDaolmpl implements com.lms.dao.DashboardDao {

    private final String TOTAL_BOOKS = "SELECT COUNT(*) FROM books";
    private final String TOTAL_USERS = "SELECT COUNT(*) FROM users";
    private final String BOOK_STATUS = "SELECT COUNT(*) FROM book_issued WHERE status = ?";


    private int fetchCount(String query) {
        return fetchCount(query, null);
    }

    private int fetchCount(String query, String status) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(query);

            if (status != null) {
                ps.setString(1, status);
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1); // ✅ Fixed: use column index instead of "count"
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close(); // ✅ Fixed: close ResultSet
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    @Override
    public DashboardStats fetchDashboardStats() {
        int totalBooks    = fetchCount(TOTAL_BOOKS);
        int totalUsers    = fetchCount(TOTAL_USERS);
        int bookAssigned  = fetchCount(BOOK_STATUS, "Issued");
        int bookReturned  = fetchCount(BOOK_STATUS, "Returned");

        DashboardStats stats = new DashboardStats();
        stats.setTotalBooks(totalBooks);
        stats.setTotalUsers(totalUsers);
        stats.setBookAssigned(bookAssigned);
        stats.setBookReturned(bookReturned);

        return stats;
    }

}