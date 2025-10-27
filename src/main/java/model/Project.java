package model;

public class Project {
    private int id;
    private String name;
    private String name_en;
    private String owner;
    private String github;
    private String notes;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getNameEN() {return name_en;}
    public void setNameEN(String name_en) {this.name_en = name_en;}
    public String getOwner() { return owner; }
    public void setOwner(String owner) { this.owner = owner; }
    public String getGithub() { return github; }
    public void setGithub(String github) { this.github = github; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}

