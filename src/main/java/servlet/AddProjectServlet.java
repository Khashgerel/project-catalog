package servlet;

import dao.ProjectDAO;

import jakarta.servlet.http.*;
import java.io.IOException;

public class AddProjectServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String name = req.getParameter("name");
            String name_en = req.getParameter("name_en");
            String owner = req.getParameter("owner");
            String github = req.getParameter("github");
            ProjectDAO.create(name, name_en, owner, github);
            resp.sendRedirect(req.getContextPath() + "/projects");
        } catch (Exception e) {
            resp.sendError(500, e.getMessage());
        }
    }
}