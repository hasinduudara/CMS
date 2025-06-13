package lk.ijse.gdse.cms.model;

public class User {
    private int id;
    private String username;
    private String password;
    private Role role;

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getUsername() { return username; }

    public String getPassword() { return password; }

    public Role getRole() { return role; }

    public int getId() { return id; }
}
