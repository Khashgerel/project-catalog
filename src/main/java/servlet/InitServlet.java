package servlet;


import dao.DB;
import dao.ProjectDAO;
import dao.DocumentDAO;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServlet;
import java.io.File;

public class InitServlet extends HttpServlet {
    @Override
    public void init(ServletConfig config) {
        try {
            Class.forName("org.sqlite.JDBC");
            ServletContext ctx = config.getServletContext();
            String dbPath = ctx.getInitParameter("dbPath");
            String resolvedDbPath = dbPath.replace("${catalina.base}", System.getProperty("catalina.base"));
            File dbFile = new File(resolvedDbPath).getParentFile();
            if (dbFile != null && !dbFile.exists()) dbFile.mkdirs();
            DB.configure(resolvedDbPath);
            ProjectDAO.init();
            DocumentDAO.init();
            String up = ctx.getInitParameter("uploadDir").replace("${catalina.base}", System.getProperty("catalina.base"));
            File upDir = new File(up);
            if (!upDir.exists()) upDir.mkdirs();
            ctx.setAttribute("uploadDir", up);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
