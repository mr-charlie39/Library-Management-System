package com.lms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.lms.pojo.User;
import com.lms.service.UserService;
import com.lms.servicelmpl.UserServiceImpl;
import jakarta.servlet.annotation.WebServlet;


public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── helpers ──────────────────────────────────────────────────────────────

    private Long parseUserId(String userIdStr) {
        if (userIdStr == null || userIdStr.isBlank()) return null;
        try {
            return Long.parseLong(userIdStr.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private void forwardUserListWithError(HttpServletRequest request,
                                          HttpServletResponse response,
                                          String message)
            throws ServletException, IOException {
        UserService userService = new UserServiceImpl();
        List<User> users = userService.getAllUsersList();
        if (users == null) users = new ArrayList<>();
        request.setAttribute("errorMessage", message);
        request.setAttribute("userlist", users);
        request.getRequestDispatcher("/jsp/userlist.jsp").forward(request, response);
    }

    private boolean isStrongPassword(String password) {
        if (password == null) return false;
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasDigit = password.matches(".*\\d.*");
        boolean hasSpecial = password.matches(".*[^a-zA-Z0-9].*");
        return password.length() >= 8 && hasLower && hasUpper && hasDigit && hasSpecial;
    }

    // ── routing ───────────────────────────────────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "showAddUser";

        switch (action) {

            // ── show add-user form ────────────────────────────────────────────
            case "showAddUser":
                request.getRequestDispatcher("/jsp/addUser.jsp").forward(request, response);
                break;

            // ── show user list ────────────────────────────────────────────────
            case "showUserList": {
                UserService svc = new UserServiceImpl();
                List<User> users = svc.getAllUsersList();
                if (users == null) users = new ArrayList<>();
                System.out.println("UserController: showUserList users=" + users.size());
                request.setAttribute("userlist", users);
                request.getRequestDispatcher("/jsp/userlist.jsp").forward(request, response);
                break;
            }

            // ── add new user (GET – legacy; consider moving to POST-only) ─────
            case "addUser": {
                handleAddUser(request, response);
                break;
            }

            // ── admin signup ───────────────────────────────────────────────────
            case "signupAdmin": {
                handleSignupAdmin(request, response);
                break;
            }

            // ── view / edit user form ─────────────────────────────────────────
            case "viewUser": {
                Long userId = parseUserId(request.getParameter("userId"));
                if (userId == null) {
                    forwardUserListWithError(request, response, "Invalid user ID.");
                    return;
                }
                UserService svc = new UserServiceImpl();
                User user = svc.getUserById(userId);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/jsp/viewUser.jsp").forward(request, response);
                } else {
                    forwardUserListWithError(request, response, "User not found with ID: " + userId);
                }
                break;
            }

            // ── update user ───────────────────────────────────────────────────
            case "updateUser": {
                handleUpdateUser(request, response);
                break;
            }

            default:
                forwardUserListWithError(request, response, "Unknown action: " + action);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    // ── private handlers ──────────────────────────────────────────────────────

    private void handleAddUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName     = request.getParameter("firstName");
        String lastName      = request.getParameter("lastName");
        String email         = request.getParameter("email");
        String password      = request.getParameter("password");
        String role          = request.getParameter("role");
        String phoneNo       = request.getParameter("phoneNo");
        String address       = request.getParameter("address");
 

       

        UserService svc = new UserServiceImpl();
        if (email != null && !email.isBlank() && svc.emailExists(email)) {
            request.setAttribute("errorMessage", "Email is already registered.");
            request.getRequestDispatcher("/jsp/addUser.jsp").forward(request, response);
            return;
        }

        if (role != null && ("admin".equalsIgnoreCase(role) || "librarian".equalsIgnoreCase(role))
                && !isStrongPassword(password)) {
            request.setAttribute("errorMessage", "Password must be 8+ characters with upper, lower, number, and symbol.");
            request.getRequestDispatcher("/jsp/addUser.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role == null || role.isBlank() ? "member" : role);
        user.setPhoneNo(phoneNo);
        user.setAddress(address);

        user.setCreatedAt(LocalDateTime.now());

        if (svc.addUser(user)) {
            request.getSession().setAttribute("flashSuccess", "User added successfully.");
            response.sendRedirect(request.getContextPath() + "/UserController?action=showUserList");
        } else {
            request.setAttribute("errorMessage", "Failed to add user. Please try again.");
            request.getRequestDispatcher("/jsp/addUser.jsp").forward(request, response);
        }
    }

    private void handleSignupAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNo = request.getParameter("phoneNo");
        String address = request.getParameter("address");

        if (firstName == null || firstName.isBlank()
                || lastName == null || lastName.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()) {
            request.setAttribute("errorMessage", "All required fields must be filled.");
            request.getRequestDispatcher("/jsp/includes/signup.jsp").forward(request, response);
            return;
        }

        UserService svc = new UserServiceImpl();
        if (svc.emailExists(email)) {
            request.setAttribute("errorMessage", "Email is already registered.");
            request.getRequestDispatcher("/jsp/includes/signup.jsp").forward(request, response);
            return;
        }

        if (!isStrongPassword(password)) {
            request.setAttribute("errorMessage", "Password must be 8+ characters with upper, lower, number, and symbol.");
            request.getRequestDispatcher("/jsp/includes/signup.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFirstName(firstName.trim());
        user.setLastName(lastName.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setRole("Admin");
        user.setPhoneNo(phoneNo != null ? phoneNo.trim() : "");
        user.setAddress(address != null ? address.trim() : "");
        user.setCreatedAt(LocalDateTime.now());

        if (svc.addUser(user)) {
            request.getSession().setAttribute("flashSuccess", "Account created. Please sign in.");
            response.sendRedirect(request.getContextPath() + "/BookController?action=showLogin");
        } else {
            request.setAttribute("errorMessage", "Failed to create account. Please try again.");
            request.getRequestDispatcher("/jsp/includes/signup.jsp").forward(request, response);
        }
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Validate userId
        Long userId = parseUserId(request.getParameter("userId"));
        if (userId == null) {
            forwardUserListWithError(request, response, "Invalid user ID.");
            return;
        }

        // 2. Read all form parameters
        String firstName      = request.getParameter("firstName");
        String lastName       = request.getParameter("lastName");
        String email          = request.getParameter("email");
        String phoneNo        = request.getParameter("phoneNo");
        String address        = request.getParameter("address");
        String role           = request.getParameter("role");
        

        // 3. Parse date
       
        

        // 4. Load existing user
        UserService svc = new UserServiceImpl();
        User user = svc.getUserById(userId);
        if (user == null) {
            forwardUserListWithError(request, response, "User not found with ID: " + userId);
            return;
        }

        // 5. Apply every field — no silent skips
        user.setFirstName(firstName != null ? firstName.trim() : "");
        user.setLastName(lastName   != null ? lastName.trim()   : "");
        user.setEmail(email         != null ? email.trim()       : user.getEmail());
        user.setPhoneNo(phoneNo     != null ? phoneNo.trim()     : "");
        user.setAddress(address     != null ? address.trim()     : "");
        user.setRole(role != null && !role.isBlank() ? role : user.getRole());
        

        // 6. Persist
        if (svc.updateUser(user)) {
            request.getSession().setAttribute("flashSuccess", "User updated successfully.");
            // PRG – redirect so a page-refresh doesn't resubmit
            response.sendRedirect(request.getContextPath() + "/UserController?action=showUserList");
        } else {
            request.setAttribute("errorMessage", "Failed to update user. Please try again.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/jsp/viewUser.jsp").forward(request, response);
        }
    }
}
