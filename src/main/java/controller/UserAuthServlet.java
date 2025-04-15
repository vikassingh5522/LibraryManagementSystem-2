package controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/user_auth")
public class UserAuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database connection parameters (configure these for your environment)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Userlibrary_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Vikas@9156";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegistration(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid action");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Establish database connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Prepare SQL query to check user credentials
            String sql = "SELECT id, username, email, password FROM users WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                
                // In a real application, you should use proper password hashing like BCrypt
                // This is a simplified example - NEVER store plain text passwords in production!
                if (password.equals(storedPassword)) {
                    // Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("email", rs.getString("email"));
                    
                    // Set session timeout (30 minutes)
                    session.setMaxInactiveInterval(30 * 60);
                    
                    // If "Remember Me" is checked, set a longer-lasting cookie
                    if ("on".equals(rememberMe)) {
                        // You might want to implement a remember me token system here
                    }
                    
                    // Redirect to dashboard or home page
                    response.sendRedirect("dashboard.jsp");
                    return;
                } else {
                    // Invalid password
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.setAttribute("email", email);
                    request.setAttribute("rememberMe", rememberMe);
                }
            } else {
                // User not found
                request.setAttribute("errorMessage", "User not found");
                request.setAttribute("email", email);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
        // Forward back to login page with error message
        request.setAttribute("action", "login");
        request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
    }
    
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Basic validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            forwardToSignup(request, response, username, email);
            return;
        }
        
        if (password.length() < 8) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters");
            forwardToSignup(request, response, username, email);
            return;
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement checkStmt = null;
        ResultSet rs = null;
        
        try {
            // Establish database connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // First check if email already exists
            String checkSql = "SELECT id FROM users WHERE email = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("errorMessage", "Email already registered");
                forwardToSignup(request, response, username, email);
                return;
            }
            
            // Check if username is taken
            checkSql = "SELECT id FROM users WHERE username = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, username);
            rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("errorMessage", "Username already taken");
                forwardToSignup(request, response, username, email);
                return;
            }
            
            // Insert new user
            String insertSql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password); // In production, hash the password!
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Registration successful - redirect to login with success parameter
                response.sendRedirect("login.jsp?success=true");
                return;
            } else {
                request.setAttribute("errorMessage", "Registration failed");
                forwardToSignup(request, response, username, email);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            forwardToSignup(request, response, username, email);
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (checkStmt != null) checkStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    
    private void forwardToSignup(HttpServletRequest request, HttpServletResponse response, 
            String username, String email) throws ServletException, IOException {
        request.setAttribute("action", "register");
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}