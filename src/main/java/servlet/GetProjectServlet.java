package servlet;

import dao.DocumentDAO;
import dao.ProjectDAO;
import model.Document;
import model.Project;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class GetProjectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Project p = ProjectDAO.get(id);
            if (p == null) {
                resp.sendError(404);
                return;
            }
            List<Document> docs = DocumentDAO.listByProject(id);
            req.setAttribute("project", p);
            req.setAttribute("documents", docs);
            try {
                req.getRequestDispatcher("/modal.jsp").forward(req, resp);
            } catch (Exception ex) {
                throw new IOException(ex);
            }
        } catch (Exception e) {
            resp.sendError(500, e.getMessage());
        }
    }
}
