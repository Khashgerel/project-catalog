package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Project;

public class ProjectDAO {
	public static void init() throws SQLException {
		try (Connection c = DB.get(); Statement s = c.createStatement()) {
			s.execute(
					"CREATE TABLE IF NOT EXISTS projects(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL, name_en TEXT NOT NULL, owner TEXT NOT NULL,github TEXT NOT NULL,notes TEXT,created_at DATETIME DEFAULT CURRENT_TIMESTAMP)");
		}
	}

	public static List<Project> list() throws SQLException {
		List<Project> list = new ArrayList<>();
		try (Connection c = DB.get();
				PreparedStatement p = c.prepareStatement(
						"SELECT id,name,name_en,owner,github,notes FROM projects ORDER BY id DESC")) {
			ResultSet rs = p.executeQuery();
			while (rs.next()) {
				Project pr = new Project();
				pr.setId(rs.getInt(1));
				pr.setName(rs.getString(2));
				pr.setNameEN(rs.getString(3));
				pr.setOwner(rs.getString(4));
				pr.setGithub(rs.getString(5));
				pr.setNotes(rs.getString(6));
				list.add(pr);
			}
		}
		return list;
	}

	public static int create(String name, String name_en, String owner, String github) throws SQLException {
		try (Connection c = DB.get();
				PreparedStatement p = c.prepareStatement(
						"INSERT INTO projects(name,name_en,owner,github) VALUES(?,?,?,?)",
						Statement.RETURN_GENERATED_KEYS)) {
			p.setString(1, name);
			p.setString(2, name_en);
			p.setString(3, owner);
			p.setString(4, github);
			p.executeUpdate();
			ResultSet rs = p.getGeneratedKeys();
			if (rs.next())
				return rs.getInt(1);
			return 0;
		}
	}

	public static Project get(int id) throws SQLException {
		try (Connection c = DB.get();
				PreparedStatement p = c.prepareStatement(
						"SELECT id,name,name_en,owner,github,notes FROM projects WHERE id=?")) {
			p.setInt(1, id);
			ResultSet rs = p.executeQuery();
			if (rs.next()) {
				Project pr = new Project();
				pr.setId(rs.getInt(1));
				pr.setName(rs.getString(2));
				pr.setNameEN(rs.getString(3));
				pr.setOwner(rs.getString(4));
				pr.setGithub(rs.getString(5));
				pr.setNotes(rs.getString(6));
				return pr;
			}
			return null;
		}
	}

	public static void update(Project pr) throws SQLException {
		try (Connection c = DB.get();
				PreparedStatement p = c.prepareStatement(
						"UPDATE projects SET name=?,name_en=?,owner=?,github=?,notes=? WHERE id=?")) {
			p.setString(1, pr.getName());
			p.setString(2, pr.getNameEN());
			p.setString(3, pr.getOwner());
			p.setString(4, pr.getGithub());
			p.setString(5, pr.getNotes());
			p.setInt(6, pr.getId());
			p.executeUpdate();
		}
	}
}
