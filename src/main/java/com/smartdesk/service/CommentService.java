package com.smartdesk.service;
import java.util.List;import com.smartdesk.dao.CommentDAO;import com.smartdesk.model.Comment;
public class CommentService{private final CommentDAO dao=new CommentDAO();public boolean add(Comment c){return dao.add(c);}public List<Comment> get(int id){return dao.get(id);}}
