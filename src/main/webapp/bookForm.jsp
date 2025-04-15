<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${action == 'edit' ? 'Edit Book' : 'Add New Book'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 2rem;
        }
        .book-form-card {
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border: none;
        }
        .card-header {
            background-color: #4e73df;
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.5rem;
        }
        .form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }
        .btn-primary {
            background-color: #4e73df;
            border-color: #4e73df;
            padding: 0.5rem 1.5rem;
        }
        .btn-primary:hover {
            background-color: #2e59d9;
            border-color: #2653d4;
        }
        .btn-outline-secondary {
            padding: 0.5rem 1.5rem;
        }
        .form-text {
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card book-form-card">
                    <div class="card-header">
                        <h3 class="mb-0">
                            <i class="fas fa-book me-2"></i>
                            ${action == 'edit' ? 'Edit Book' : 'Add New Book'}
                        </h3>
                    </div>
                    <div class="card-body p-4">
                        <!-- Error Message Display -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show mb-4">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <form action="books" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="${action}">
                            
                            <c:if test="${action == 'edit'}">
                                <input type="hidden" name="id" value="${book.bookId}">
                            </c:if>
                            
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label for="title" class="form-label">
                                        <i class="fas fa-heading me-1"></i> Title
                                    </label>
                                    <input type="text" class="form-control" id="title" name="title" 
                                           value="${not empty book.title ? book.title : ''}" required>
                                    <div class="invalid-feedback">
                                        Please provide a book title.
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="author" class="form-label">
                                        <i class="fas fa-user-edit me-1"></i> Author
                                    </label>
                                    <input type="text" class="form-control" id="author" name="author" 
                                           value="${not empty book.author ? book.author : ''}" required>
                                    <div class="invalid-feedback">
                                        Please provide the author's name.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label for="isbn" class="form-label">
                                        <i class="fas fa-barcode me-1"></i> ISBN
                                    </label>
                                    <input type="text" class="form-control" id="isbn" name="isbn" 
                                           value="${not empty book.isbn ? book.isbn : ''}" 
                                           pattern="\d{3}-\d-\d{2}-\d{6}-\d" required>
                                    <div class="form-text">
                                        Format: 999-9-99-999999-9
                                    </div>
                                    <div class="invalid-feedback">
                                        Please provide a valid ISBN number.
                                    </div>
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="publicationYear" class="form-label">
                                        <i class="fas fa-calendar-alt me-1"></i> Publication Year
                                    </label>
                                    <input type="number" class="form-control" id="publicationYear" name="publicationYear" 
                                           value="${not empty book.publicationYear ? book.publicationYear : ''}" 
                                           min="1000" max="2099" required>
                                    <div class="invalid-feedback">
                                        Please provide a valid year between 1000 and 2099.
                                    </div>
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="quantity" class="form-label">
                                        <i class="fas fa-copy me-1"></i> Quantity
                                    </label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" 
                                           value="${not empty book.quantity ? book.quantity : 1}" 
                                           min="1" required>
                                    <div class="invalid-feedback">
                                        Quantity must be at least 1.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="books" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i> Back to List
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i> Save Book
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Client-side form validation
        (function() {
            'use strict';
            
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation');
            
            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>