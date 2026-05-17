package com.lms.pojo;

import java.time.LocalDate;
import java.util.Date;

public class BookIssued {

	private int issueId;
	private Book book;
	private User user;
	private Date issueDate;
	private LocalDate dueDate;
	private LocalDate returnDate;
	private String status;
	private String bookCondition;
	private String assessmentNotes;
	private String returnNotes;
	private String issuedStatus;
	public String getIssuedStatus() {
		return issuedStatus;
	}
	public void setIssuedStatus(String issuedStatus) {
		this.issuedStatus = issuedStatus;
	}
	public String getAssessmentNotes() {
		return assessmentNotes;
	}
	public int getIssueId() {
		return issueId;
	}
	public void setIssueId(int issueId) {
		this.issueId = issueId;
	}
	public int getIssuedId() {
		return issueId;
	}
	public void setIssuedId(int issuedId) {
		this.issueId = issuedId;
	}
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}
	public LocalDate getDueDate() {
		return dueDate;
	}
	public void setDueDate(LocalDate dueDate) {
		this.dueDate = dueDate;
	}
	public LocalDate getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(LocalDate returnDate) {
		this.returnDate = returnDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBookCondition() {
		return bookCondition;
	}
	public void setBookCondition(String bookCondition) {
		this.bookCondition = bookCondition;
	}
	public String getAssessmentNotes(String assignmentNotes) {
		return assessmentNotes;
	}
	public void setAssessmentNotes(String assessmentNotes) {
		this.assessmentNotes = assessmentNotes;
	}
	public String getReturnNotes() {
		return returnNotes;
	}
	public void setReturnNotes(String returnNotes) {
		this.returnNotes = returnNotes;
	}
}