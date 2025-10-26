package controller;
import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String plainPassword = req.getParameter("password");
        try {
            User user = new UserDAO().findByEmail(email);
            if (user != null && PasswordUtil.verifyPassword(plainPassword, user.getPassword())) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                // --- Set cookies after successful login ---
                Cookie emailCookie = new Cookie("userEmail", email);
                emailCookie.setMaxAge(60*60*24); // 7 days
                emailCookie.setHttpOnly(true);      // can't be read by JS (for security)
                emailCookie.setPath("/");           // available everywhere in app
                res.addCookie(emailCookie);

                Cookie roleCookie = new Cookie("userRole", user.getRole());
                roleCookie.setMaxAge(60*60*24*7);
                roleCookie.setHttpOnly(true);
                roleCookie.setPath("/");
                res.addCookie(roleCookie);

                String contextPath = req.getContextPath();

                if ("admin".equals(user.getRole())) {
                    res.sendRedirect(contextPath + "/admin/adminDashboard.jsp");
                } else if ("customer".equals(user.getRole())) {
                    res.sendRedirect(contextPath + "/customer/customerDashboard.jsp");
                } else {
                    // Unrecognized role
                    res.sendRedirect(contextPath + "/login.jsp?error=RoleNotRecognized");
                }
            } else {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=Invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=ServerError");
        }
    }
}
