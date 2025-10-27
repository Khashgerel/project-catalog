package servlet;

import dao.ProjectDAO;
import model.Project;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ListProjectsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            List<Project> projects = ProjectDAO.list();
            req.setAttribute("projects", projects);
            try {
                req.getRequestDispatcher("/index.jsp").forward(req, resp);
            } catch (Exception ex) {
                throw new IOException(ex);
            }
        } catch (Exception e) {
            resp.sendError(500, e.getMessage());
        }
    }
}