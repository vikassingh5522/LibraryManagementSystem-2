<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --accent-color: #f6c23e;
            --dark-color: #5a5c69;
            --light-color: #f8f9fc;
        }
        
        body {
            background-color: var(--light-color);
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, sans-serif;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
            color: white;
            padding: 2rem;
            border-radius: 0.35rem;
            margin-bottom: 2rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .card {
            border: none;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: all 0.3s;
            margin-bottom: 1.5rem;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid #e3e6f0;
            font-weight: 600;
            color: var(--dark-color);
            padding: 1rem 1.35rem;
            border-radius: 0.35rem 0.35rem 0 0 !important;
        }
        
        .list-group-item {
            border-left: 0;
            border-right: 0;
            padding: 1rem 1.35rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .list-group-item:first-child {
            border-top: 0;
        }
        
        .book-title {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .due-date {
            background-color: var(--light-color);
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.85rem;
        }
        
        .btn-action {
            border-radius: 0.25rem;
            font-weight: 600;
            padding: 0.75rem;
            transition: all 0.3s;
        }
        
        .btn-browse {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .btn-transactions {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--dark-color);
        }
        
        .welcome-message {
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .welcome-icon {
            background-color: rgba(255, 255, 255, 0.2);
            width: 3rem;
            height: 3rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin-right: 1rem;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="dashboard-header">
            <div class="d-flex align-items-center">
                <div class="welcome-icon">
                    <i class="fas fa-user fa-lg"></i>
                </div>
                <div>
                    <h1 class="welcome-message mb-1">Welcome, ${user.username}!</h1>
                    <p class="mb-0"><i class="fas fa-calendar-alt mr-2"></i>Today is <%= new java.text.SimpleDateFormat("EEEE, MMMM d").format(new java.util.Date()) %></p>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-book-open mr-2"></i>My Borrowed Books</h5>
                        <span class="badge bg-primary">${not empty borrowedBooks ? borrowedBooks.size() : 0} items</span>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty borrowedBooks}">
                            <div class="text-center py-4">
                                <i class="fas fa-book fa-3x mb-3" style="color: #dddfeb;"></i>
                                <h5 class="text-muted">No Books Borrowed</h5>
                                <p class="text-muted">You haven't borrowed any books yet</p>
                                <a href="books" class="btn btn-primary">Browse Books</a>
                            </div>
                        </c:if>
                        <c:if test="${not empty borrowedBooks}">
                            <div class="list-group">
                                <c:forEach var="book" items="${borrowedBooks}">
                                    <div class="list-group-item">
                                        <div>
                                            <div class="book-title">${book.title}</div>
                                            <small class="text-muted">by ${book.author}</small>
                                        </div>
                                        <div class="due-date">
                                            <i class="fas fa-clock mr-1"></i>Due: ${book.dueDate}
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <a href="transactions" class="btn btn-outline-primary mt-3 w-100">
                                <i class="fas fa-list mr-2"></i>View All Transactions
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-bolt mr-2"></i>Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <a href="books" class="btn btn-action btn-browse btn-block mb-3">
                            <i class="fas fa-search mr-2"></i>Browse Books
                        </a>
                        <a href="transactions" class="btn btn-action btn-transactions btn-block mb-3">
                            <i class="fas fa-exchange-alt mr-2"></i>My Transactions
                        </a>
                        <a href="logout" class="btn btn-secondary btn-block">
                            <i class="fas fa-sign-out-alt mr-2"></i>Logout
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-chart-pie mr-2"></i>Reading Stats</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6 class="text-muted mb-2">Books Borrowed</h6>
                            <h4 class="font-weight-bold">${not empty borrowedBooks ? borrowedBooks.size() : 0}</h4>
                        </div>
                        <div class="mb-3">
                            <h6 class="text-muted mb-2">Favorites</h6>
                            <h4 class="font-weight-bold">5</h4>
                        </div>
                        <div class="progress mb-3" style="height: 10px;">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 65%"></div>
                        </div>
                        <small class="text-muted">65% of monthly reading goal</small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>