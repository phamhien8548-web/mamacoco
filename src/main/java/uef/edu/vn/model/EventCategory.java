package uef.edu.vn.model;

public class EventCategory {

    private int id;
    private String categoryName;
    private String description;
    private String status;

    public EventCategory() {
    }

    public EventCategory(int id, String categoryName, String description, String status) {
        this.id = id;
        this.categoryName = categoryName;
        this.description = description;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
