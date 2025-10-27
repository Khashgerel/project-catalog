package servlet;

import dao.ProjectDAO;
import model.Project;
import jakarta.servlet.http.*;
import java.io.IOException;

public class UpdateProjectServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String name_en = req.getParameter("name_en");
            String owner = req.getParameter("owner");
            String github = req.getParameter("github");
            String notes = req.getParameter("notes");
            Project p = new Project();
            p.setId(id);
            p.setName(name);
            p.setNameEN(name_en);
            p.setOwner(owner);
            p.setGithub(github);
            p.setNotes(notes);
            ProjectDAO.update(p);
            resp.sendRedirect(req.getContextPath() + "/projects");
        } catch (Exception e) {
            resp.sendError(500, e.getMessage());
        }
    }
}
