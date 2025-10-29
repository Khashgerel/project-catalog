package servlet;

import dao.DocumentDAO;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int projectId = Integer.parseInt(req.getParameter("projectId"));
            Part filePart = req.getPart("file");
            String original = filePart.getSubmittedFileName();
            String uploadDir = (String) req.getServletContext().getAttribute("uploadDir");
            String stored = System.currentTimeMillis() + "_" + original.replaceAll("\\s+", "_");
            File out = new File(uploadDir, stored);
            try (InputStream in = filePart.getInputStream(); FileOutputStream fos = new FileOutputStream(out)) {
                byte[] buf = new byte[8192];
                int len;
                while ((len = in.read(buf)) > 0) fos.write(buf, 0, len);
            }
            DocumentDAO.add(projectId, stored, original);
            resp.sendRedirect(req.getContextPath() + "/projects");
        } catch (Exception e) {
            resp.sendError(500, e.getMessage());
        }
    }
}

