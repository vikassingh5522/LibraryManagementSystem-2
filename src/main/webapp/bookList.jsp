

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management System</title>
    
    <!-- CSS Resources -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #4e73df;
            --success: #1cc88a;
            --danger: #e74a3b;
            --warning: #f6c23e;
            --dark: #5a5c69;
            --light: #f8f9fc;
        }
        
        body {
            background-color: var(--light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .book-management-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .book-card {
            border: none;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            overflow: hidden;
        }
        
        .book-header {
            background-color: white;
            padding: 1.5rem;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .book-table {
            margin-bottom: 0;
            width: 100%;
        }
        
        .book-table th {
            background-color: #f8f9fa;
            color: var(--dark);
            font-weight: 600;
            padding: 1rem;
            position: sticky;
            top: 0;
        }
        
        .book-table td {
            padding: 1rem;
            vertical-align: middle;
            border-top: 1px solid #e3e6f0;
        }
        
        .action-btn {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
        .btn-add {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
            transition: all 0.2s;
        }
        
        .btn-add:hover {
            background-color: #2e59d9;
            transform: translateY(-1px);
        }
        
        .btn-edit {
            background-color: var(--warning);
            color: var(--dark);
        }
        
        .btn-delete {
            background-color: var(--danger);
            color: white;
        }
        
        .status-badge {
            padding: 0.35rem 0.65rem;
            border-radius: 50rem;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .status-available {
            background-color: rgba(28, 200, 138, 0.1);
            color: var(--success);
        }
        
        .status-unavailable {
            background-color: rgba(231, 74, 59, 0.1);
            color: var(--danger);
        }
        
        .empty-state {
            padding: 3rem 0;
            text-align: center;
        }
        
        .empty-state-icon {
            font-size: 3rem;
            color: #dddfeb;
            margin-bottom: 1rem;
        }
        
        .search-container {
            max-width: 300px;
        }
        
        @media (max-width: 768px) {
            .book-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .search-container {
                max-width: 100%;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4 book-management-container">
        <div class="book-card">
            <!-- Header with title and actions -->
            <div class="book-header">
                <h2 class="mb-0">
                    <i class="fas fa-book me-2"></i>Book Management
                </h2>
                
                <div class="d-flex align-items-center gap-3">
                    <div class="search-container">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search books..." id="searchInput">
                            <button class="btn btn-outline-secondary" type="button" id="searchButton">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <a href="books?action=new" class="btn btn-add">
                        <i class="fas fa-plus me-2"></i>Add Book
                    </a>
                </div>
            </div>
            
            <!-- Main content area -->
            <div class="card-body p-0">
                <!-- Success/Error messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Books table -->
                <div class="table-responsive">
                    <table class="book-table table table-hover" id="booksTable">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Author</th>
                                <th>ISBN</th>
                                <th>Year</th>
                                <th>Quantity</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                         
                         <c:choose>
    <c:when test="${not empty books}">
        <c:forEach items="${books}" var="book">
            <tr>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.isbn}</td>
                <td>${book.publicationYear}</td>
                <td>${book.quantity}</td>
                <td>
                    <span class="status-badge ${book.quantity > 0 ? 'status-available' : 'status-unavailable'}">
                        ${book.quantity > 0 ? 'Available' : 'Out of Stock'}
                    </span>
                </td>
                <td>
                    <div class="d-flex gap-2">
                        <a href="books?action=edit&id=${book.bookId}" 
                           class="btn btn-sm btn-edit action-btn" title="Edit">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="books?action=delete&id=${book.bookId}" 
                           class="btn btn-sm btn-delete action-btn" title="Delete"
                           onclick="return confirm('Are you sure you want to delete this book?')">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <!-- Empty state remains the same -->
    </c:otherwise>
</c:choose>
                         
                         
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Resources -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Search functionality
            $('#searchButton').click(function() {
                filterBooks();
            });
            
            $('#searchInput').keyup(function(e) {
                if (e.key === 'Enter') {
                    filterBooks();
                }
            });
            
            function filterBooks() {
                const searchText = $('#searchInput').val().toLowerCase();
                $('#booksTable tbody tr').each(function() {
                    const rowText = $(this).text().toLowerCase();
                    $(this).toggle(rowText.includes(searchText));
                });
            }
            
            // Auto-focus search input
            $('#searchInput').focus();
        });
    </script>
</body>
</html>