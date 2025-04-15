<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Transactions</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1 class="my-4">My Transactions</h1>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Book ID</th>
                    <th>Borrow Date</th>
                    <th>Due Date</th>
                    <th>Return Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="transaction" items="${transactions}">
                    <tr>
                        <td>${transaction.transactionId}</td>
                        <td>${transaction.bookId}</td>
                        <td>${transaction.borrowDate}</td>
                        <td>${transaction.dueDate}</td>
                        <td>${transaction.returnDate}</td>
                        <td>${transaction.status}</td>
                        <td>
                            <c:if test="${transaction.status == 'approved'}">
                                <a href="transactions?action=return&transactionId=${transaction.transactionId}" 
                                   class="btn btn-primary">Return</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <a href="books" class="btn btn-primary">Back to Books</a>
        <a href="logout" class="btn btn-secondary">Logout</a>
    </div>
</body>
</html>