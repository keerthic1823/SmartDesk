package com.smartdesk.model;

public class Ticket {


	    private int ticketId;

	    private String title;

	    private String description;

	    private String category;

	    private String priority;

	    private String status;

	    private int createdBy;

	    private int assignedTo;

	    private String createdAt;

	    private String updatedAt;


	    // ticketId
	    public int getTicketId() {
	        return ticketId;
	    }

	    public void setTicketId(int ticketId) {
	        this.ticketId = ticketId;
	    }


	   
	    public String getTitle() {
	        return title;
	    }

	    public void setTitle(String title) {
	        this.title = title;
	    }


	   
	    public String getDescription() {
	        return description;
	    }

	    public void setDescription(String description) {
	        this.description = description;
	    }


	   
	    public String getCategory() {
	        return category;
	    }

	    public void setCategory(String category) {
	        this.category = category;
	    }


	   
	    public String getPriority() {
	        return priority;
	    }

	    public void setPriority(String priority) {
	        this.priority = priority;
	    }


	    
	    public String getStatus() {
	        return status;
	    }

	    public void setStatus(String status) {
	        this.status = status;
	    }


	    public int getCreatedBy() {
	        return createdBy;
	    }

	    public void setCreatedBy(int createdBy) {
	        this.createdBy = createdBy;
	    }


	    
	    public int getAssignedTo() {
	        return assignedTo;
	    }

	    public void setAssignedTo(int assignedTo) {
	        this.assignedTo = assignedTo;
	    }


	    public String getCreatedAt() {
	        return createdAt;
	    }

	    public void setCreatedAt(String createdAt) {
	        this.createdAt = createdAt;
	    }


	    
	    public String getUpdatedAt() {
	        return updatedAt;
	    }

	    public void setUpdatedAt(String updatedAt) {
	        this.updatedAt = updatedAt;
	    }


	    @Override
	    public String toString() {

	        return "Ticket{" +
	                "ticketId=" + ticketId +
	                ", title='" + title + '\'' +
	                ", description='" + description + '\'' +
	                ", category='" + category + '\'' +
	                ", priority='" + priority + '\'' +
	                ", status='" + status + '\'' +
	                ", createdBy=" + createdBy +
	                ", assignedTo=" + assignedTo +
	                ", createdAt='" + createdAt + '\'' +
	                ", updatedAt='" + updatedAt + '\'' +
	                '}';

	    }
	}
