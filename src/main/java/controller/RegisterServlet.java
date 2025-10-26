package controller;
import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String plainPassword = req.getParameter("password");
            String hashedPassword = PasswordUtil.hashPassword(plainPassword);

            User user = new User();
            user.setName(req.getParameter("name"));
            user.setEmail(req.getParameter("email"));
            user.setPassword(hashedPassword);
            user.setRole(req.getParameter("role")); // role from dropdown

            new UserDAO().register(user);
            res.sendRedirect("login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
