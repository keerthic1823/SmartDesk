package com.smartdesk.model;

public class Ticket {
    private int ticketId, createdBy, assignedTo;
    private String title, description, category, priority, status, createdAt, updatedAt;
    private String creatorName, assigneeName;

    public int getTicketId(){return ticketId;}
    public void setTicketId(int v){ticketId=v;}
    public int getCreatedBy(){return createdBy;}
    public void setCreatedBy(int v){createdBy=v;}
    public int getAssignedTo(){return assignedTo;}
    public void setAssignedTo(int v){assignedTo=v;}
    public String getTitle(){return title;}
    public void setTitle(String v){title=v;}
    public String getDescription(){return description;}
    public void setDescription(String v){description=v;}
    public String getCategory(){return category;}
    public void setCategory(String v){category=v;}
    public String getPriority(){return priority;}
    public void setPriority(String v){priority=v;}
    public String getStatus(){return status;}
    public void setStatus(String v){status=v;}
    public String getCreatedAt(){return createdAt;}
    public void setCreatedAt(String v){createdAt=v;}
    public String getUpdatedAt(){return updatedAt;}
    public void setUpdatedAt(String v){updatedAt=v;}
    public String getCreatorName(){return creatorName;}
    public void setCreatorName(String v){creatorName=v;}
    public String getAssigneeName(){return assigneeName;}
    public void setAssigneeName(String v){assigneeName=v;}
}
