package com.lms.daolmpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.lms.dao.UserDao;
import com.lms.pojo.Book;
import com.lms.pojo.User;
import com.lms.util.DBUtil;

public class UserDaolmpl implements UserDao {

	private User mapUserFromSnakeCase(ResultSet rs) throws SQLException {
		User user = new User();
		user.setUserId(rs.getLong("user_id"));
		user.setFirstName(rs.getString("first_name"));
		user.setLastName(rs.getString("last_name"));
		user.setEmail(rs.getString("email"));
		user.setPassword(rs.getString("password"));
		user.setAddress(rs.getString("address"));
		user.setPhoneNo(rs.getString("phone_no"));
		user.setRole(rs.getString("role"));
		Timestamp createdAt = rs.getTimestamp("created_at");
		if (createdAt != null) {
			user.setCreatedAt(createdAt.toLocalDateTime());
		}
		
		
		return user;
	}

	private User mapUserFromLegacyCase(ResultSet rs) throws SQLException {
		User user = new User();
		user.setUserId(rs.getLong("userId"));
		user.setFirstName(rs.getString("firstName"));
		user.setLastName(rs.getString("lastName"));
		user.setEmail(rs.getString("email"));
		user.setPassword(rs.getString("password"));
		user.setAddress(rs.getString("address"));
		user.setPhoneNo(rs.getString("phone_no"));
		user.setRole(rs.getString("role"));
		Timestamp createdAt = rs.getTimestamp("created_at");
		if (createdAt != null) {
			user.setCreatedAt(createdAt.toLocalDateTime());
		}
		return user;
	}

	private boolean addUserLegacy(User user) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "INSERT INTO users (firstName, lastName, email, password, role, phone_no, address, created_at) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, user.getFirstName());
			ps.setString(2, user.getLastName());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getPassword());
			ps.setString(5, user.getRole());
			ps.setString(6, user.getPhoneNo());
			ps.setString(7, user.getAddress());
			ps.setTimestamp(8, Timestamp.valueOf(user.getCreatedAt()));
			return ps.executeUpdate() > 0;
		} finally {
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	private boolean updateUserLegacy(User user) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "Update users set firstName = ?, lastName = ?, phone_no = ?, address = ?, email = ?, role = ? where userId = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, user.getFirstName());
			ps.setString(2, user.getLastName());
			ps.setString(3, user.getPhoneNo());
			ps.setString(4, user.getAddress());
			ps.setString(5, user.getEmail());
			ps.setString(6, user.getRole());
			ps.setLong(7, user.getUserId());
			return ps.executeUpdate() > 0;
		} finally {
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	private boolean deleteUserLegacy(Long userId) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String query = "DELETE FROM users WHERE userId = ?";
			ps = conn.prepareStatement(query);
			ps.setLong(1, userId);
			return ps.executeUpdate() > 0;
		} finally {
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	@Override
	public User checkLogin(String username, String password) {
		
		ResultSet rs = null;
		PreparedStatement pstm = null;
		Connection con = null;

		try {
			try {
				con = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Database Connection: SUCCESS");
			System.out.println("Login attempt - Email: " + username + ", Password: " + password);
			
			// Query to find user by email and password from users table
			String query = "SELECT * FROM users WHERE email = ? AND password = ?";
			System.out.println("Executing query: " + query);
			
			pstm = con.prepareStatement(query);
			pstm.setString(1, username);
			pstm.setString(2, password);
			
			System.out.println("Query Parameters - Email: " + username + ", Password: " + password);
			
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				System.out.println("✓ User Found in Database!");
				User user = mapUserFromSnakeCase(rs);
				System.out.println("✓ User successfully loaded: " + user.getEmail());
				System.out.println("  - User ID: " + user.getUserId());
				System.out.println("  - Name: " + user.getFirstName() + " " + user.getLastName());
				System.out.println("  - Role: " + user.getRole());
				return user;
			} else {
				System.out.println("✗ No matching user found in database!");
				System.out.println("Database check: Email='" + username + "' and Password='" + password + "'");
			}
		} catch (SQLException e) {
			System.out.println("✗ Database Connection Error: " + e.getMessage());
			e.printStackTrace();
			return checkLoginLegacy(username, password);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstm != null) pstm.close();
				if(con != null) con.close();
				System.out.println("Database resources closed");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	private User checkLoginLegacy(String username, String password) {
		ResultSet rs = null;
		PreparedStatement pstm = null;
		Connection con = null;
		try {
			try {
				con = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "SELECT * FROM users WHERE email = ? AND password = ?";
			pstm = con.prepareStatement(query);
			pstm.setString(1, username);
			pstm.setString(2, password);
			rs = pstm.executeQuery();
			if (rs.next()) {
				return mapUserFromLegacyCase(rs);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstm != null) pstm.close();
				if (con != null) con.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public boolean addUser(User user) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Database Connection: SUCCESS");
			
			String query = "INSERT INTO users (first_name, last_name, email, password, role, phone_no, address, created_at) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"; 
			System.out.println("SQL Query: " + query);

			ps = conn.prepareStatement(query);
			ps.setString(1, user.getFirstName());
			ps.setString(2, user.getLastName());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getPassword());
			ps.setString(5, user.getRole());
			ps.setString(6, user.getPhoneNo());
			ps.setString(7, user.getAddress());
			ps.setTimestamp(8, Timestamp.valueOf(user.getCreatedAt()));
		

            System.out.println("User Details - First Name: " + user.getFirstName() + ", Last Name: " + user.getLastName() + 
					", Email: " + user.getEmail() + ", Role: " + user.getRole() + ", Phone No: " + user.getPhoneNo() + 
					", Address: " + user.getAddress() + ", Created At: " + user.getCreatedAt());
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				System.out.println("✓ User added successfully to database!");
				return true;
			} else {
				System.out.println("✗ No rows affected. User insertion failed.");
			}
			
		}catch(SQLException e) {
			System.out.println("✗ Error adding User: " + e.getMessage());
			try {
				boolean legacyResult = addUserLegacy(user);
				if (legacyResult) {
					System.out.println("✓ User added successfully using legacy schema.");
					return true;
				}
			} catch (SQLException legacyEx) {
				legacyEx.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	public List<User> getAllUsersList() {
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement countPs = null;
		ResultSet rs = null;
		ResultSet countRs = null;
		
			ArrayList<User> usersList = new ArrayList<>();
			
			try 
			{
				try {
					conn = DBUtil.getConnection();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String countQuery = "SELECT COUNT(*) AS total, SUM(CASE WHEN LOWER(TRIM(role)) = 'member' THEN 1 ELSE 0 END) AS members FROM users";
				countPs = conn.prepareStatement(countQuery);
				countRs = countPs.executeQuery();
				if (countRs.next()) {
					System.out.println("Users in DB: total=" + countRs.getInt("total") + ", members=" + countRs.getInt("members"));
				}
				
				String query = "SELECT * FROM users ORDER BY created_at DESC";
				System.out.println("Database Connection: SUCCESS");
				
				ps = conn.prepareStatement(query);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					User user = mapUserFromSnakeCase(rs);
					usersList.add(user);
				}
				
				System.out.println("Users fetched: " + usersList.size());
				
			} catch(SQLException e) {
				System.out.println("✗ Error fetching users: " + e.getMessage());
				e.printStackTrace();
				return getAllUsersListLegacy();
			}
				
		finally {
			try {
				if(countRs != null) countRs.close();
				if(countPs != null) countPs.close();
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return usersList;
	}

	private List<User> getAllUsersListLegacy() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<User> usersList = new ArrayList<>();
		try {
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "SELECT * FROM users ORDER BY created_at DESC";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				User user = mapUserFromLegacyCase(rs);
				usersList.add(user);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return usersList;
	}


	@Override
	public User getUserById(Long userId) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "SELECT * FROM users WHERE user_id = ?";
			System.out.println("Database Connection: SUCCESS");
			
			ps = conn.prepareStatement(query);
			ps.setLong(1, userId);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				User user = mapUserFromSnakeCase(rs);
				System.out.println("✓ User successfully loaded: " + user.getEmail());
				System.out.println("  - User ID: " + user.getUserId());
				System.out.println("  - Name: " + user.getFirstName() + " " + user.getLastName());
				System.out.println("  - Role: " + user.getRole ());
				return user;
				}
			
		}catch(SQLException e) {
			System.out.println("✗ Error fetching user by ID: " + e.getMessage());
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (SQLException closeEx) {
				closeEx.printStackTrace();
			}
			return getUserByIdLegacy(userId);
			} finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(conn != null) conn.close();
					} catch(Exception e) {
						e.printStackTrace();
						
				}
		}
		return null;
			
	}

	private User getUserByIdLegacy(Long userId) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			try {
				conn = DBUtil.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String query = "SELECT * FROM users WHERE userId = ?";
			ps = conn.prepareStatement(query);
			ps.setLong(1, userId);
			rs = ps.executeQuery();
			if (rs.next()) {
				User user = mapUserFromLegacyCase(rs);
				return user;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return null;
	}

	@Override

		public boolean updateUser(User user) {

		    Connection conn = null;
		    PreparedStatement ps = null;

		    try {

		        // =========================
		        // DATABASE CONNECTION
		        // =========================

		        conn = DBUtil.getConnection();

		        System.out.println("Database Connection: SUCCESS");

		        // =========================
		        // UPDATE QUERY
		        // =========================

		        String query =
		                "UPDATE users " +
		                "SET first_name=?, " +
		                "last_name=?, " +
		                "phone_no=?, " +
		                "address=?, " +
		                "email=?, " +
		                "role=? " +
		                "WHERE user_id=?";

		        System.out.println("SQL Query: " + query);

		        // =========================
		        // PREPARE STATEMENT
		        // =========================

		        ps = conn.prepareStatement(query);

		        ps.setString(1, user.getFirstName());
		        ps.setString(2, user.getLastName());
		        ps.setString(3, user.getPhoneNo());
		        ps.setString(4, user.getAddress());
		        ps.setString(5, user.getEmail());
		        ps.setString(6, user.getRole());

		     

		        // WHERE user_id=?
		        ps.setLong(7, user.getUserId());

		        // =========================
		        // DEBUGGING
		        // =========================

		        System.out.println(
		            "Updating User -> ID: " + user.getUserId()
		            + ", Name: " + user.getFirstName()
		            + " " + user.getLastName()
		        );

		        // =========================
		        // EXECUTE UPDATE
		        // =========================

		        int result = ps.executeUpdate();

		        System.out.println("Rows Updated: " + result);

		        // =========================
		        // RESULT CHECK
		        // =========================

		        if (result > 0) {

		            System.out.println("✓ User updated successfully!");

		            return true;

		        } else {

		            System.out.println("✗ No rows affected.");

		            return false;
		        }

		    } catch (SQLException e) {

		        System.out.println("✗ Error updating user: " + e.getMessage());

		        e.printStackTrace();

		        // =========================
		        // OPTIONAL LEGACY FALLBACK
		        // =========================

		        try {

		            boolean legacyResult = updateUserLegacy(user);

		            if (legacyResult) {

		                System.out.println("✓ Updated using legacy schema.");

		                return true;
		            }

		        } catch (SQLException legacyEx) {

		            legacyEx.printStackTrace();
		        }

		    } catch (Exception e) {

		        e.printStackTrace();

		    } finally {

		        // =========================
		        // CLOSE RESOURCES
		        // =========================

		        try {

		            if (ps != null) {
		                ps.close();
		            }

		            if (conn != null) {
		                conn.close();
		            }

		        } catch (Exception e) {

		            e.printStackTrace();
		        }
		    }

		    return false;
		}

	@Override
	public boolean deleteUser(Long userId) {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBUtil.getConnection();

			String query = "DELETE FROM users WHERE user_id = ?";
			ps = conn.prepareStatement(query);
			ps.setLong(1, userId);

			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.out.println("✗ Error deleting user: " + e.getMessage());
			e.printStackTrace();
			try {
				boolean legacyResult = deleteUserLegacy(userId);
				if (legacyResult) {
					System.out.println("✓ Deleted using legacy schema.");
					return true;
				}
			} catch (SQLException legacyEx) {
				legacyEx.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	@Override
	public boolean emailExists(String email) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBUtil.getConnection();
			String query = "SELECT 1 FROM users WHERE LOWER(email) = LOWER(?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, email);
			rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			System.out.println("✗ Error checking email: " + e.getMessage());
			e.printStackTrace();
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
