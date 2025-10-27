package dao;

import model.Document;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {
    public static void init() throws SQLException {
        try (Connection c = DB.get(); Statement s = c.createStatement()) {
            s.execute("CREATE TABLE IF NOT EXISTS documents(id INTEGER PRIMARY KEY AUTOINCREMENT,project_id INTEGER NOT NULL,filename TEXT NOT NULL,original_name TEXT NOT NULL,uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(project_id) REFERENCES projects(id))");
        }
    }

    public static void add(int projectId, String filename, String original) throws SQLException {
        try (Connection c = DB.get(); PreparedStatement p = c.prepareStatement("INSERT INTO documents(project_id,filename,original_name) VALUES(?,?,?)")) {
            p.setInt(1, projectId);
            p.setString(2, filename);
            p.setString(3, original);
            p.executeUpdate();
        }
    }

    public static List<Document> listByProject(int projectId) throws SQLException {
        List<Document> list = new ArrayList<>();
        try (Connection c = DB.get(); PreparedStatement p = c.prepareStatement("SELECT id,project_id,filename,original_name FROM documents WHERE project_id=? ORDER BY id DESC")) {
            p.setInt(1, projectId);
            ResultSet rs = p.executeQuery();
            while (rs.next()) {
                Document d = new Document();
                d.setId(rs.getInt(1));
                d.setProjectId(rs.getInt(2));
                d.setFilename(rs.getString(3));
                d.setOriginalName(rs.getString(4));
                list.add(d);
            }
        }
        return list;
    }
}
