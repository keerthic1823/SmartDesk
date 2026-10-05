package com.smartdesk.model;

public class Comment {
    private int commentId, ticketId, userId;
    private String userName, comment, createdAt;

    public int getCommentId(){return commentId;}
    public void setCommentId(int v){commentId=v;}
    public int getTicketId(){return ticketId;}
    public void setTicketId(int v){ticketId=v;}
    public int getUserId(){return userId;}
    public void setUserId(int v){userId=v;}
    public String getUserName(){return userName;}
    public void setUserName(String v){userName=v;}
    public String getComment(){return comment;}
    public void setComment(String v){comment=v;}
    public String getCreatedAt(){return createdAt;}
    public void setCreatedAt(String v){createdAt=v;}
}
