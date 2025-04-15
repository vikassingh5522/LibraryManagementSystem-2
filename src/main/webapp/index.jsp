																																																																											<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookVerse - Dynamic Book Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #6c5ce7;
            --secondary-color: #a29bfe;
            --accent-color: #fd79a8;
            --dark-color: #2d3436;
            --light-color: #f5f6fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: var(--dark-color);
            min-height: 100vh;
            position: relative;
        }
        
        /* Navbar Styles */
        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: white !important;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
        }
        
        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            margin: 0 8px;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: white;
            transition: width 0.3s ease;
        }
        
        .nav-link:hover::after {
            width: 100%;
        }
        
        /* Section Styles */
        .section {
            padding: 80px 0;
            min-height: 100vh;
            display: none;
        }
        
        .section.active {
            display: block;
            animation: fadeIn 0.8s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .section-title {
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 40px;
            position: relative;
            display: inline-block;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 50%;
            height: 4px;
            background: var(--accent-color);
            border-radius: 2px;
        }
        
        /* Book Card Styles */
        .book-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            margin-bottom: 25px;
            border: none;
        }
        
        .book-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .book-cover {
            height: 250px;
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .book-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: var(--accent-color);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .book-body {
            padding: 20px;
        }
        
        .book-title {
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 10px;
        }
        
        .book-author {
            color: #636e72;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .book-description {
            color: #636e72;
            font-size: 0.85rem;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .book-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .book-price {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 1.2rem;
        }
        
        /* Form Styles */
        .form-container {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .form-control, .form-select {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 12px 15px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(108, 92, 231, 0.25);
        }
        
        .btn-custom {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(108, 92, 231, 0.3);
        }
        
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 92, 231, 0.4);
            color: white;
        }
        
        /* Login/Admin Styles */
        .login-container, .admin-container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            transform-style: preserve-3d;
        }
        
        .login-container::before, .admin-container::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            z-index: -1;
            border-radius: 15px;
            opacity: 0.7;
            transform: translateZ(-1px);
        }
        
        /* About Page Styles */
        .about-content {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .feature-box {
            text-align: center;
            padding: 30px 20px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.8);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .feature-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background: white;
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        /* Footer Styles */
        .footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 40px 0 20px;
            position: relative;
        }
        
        .footer::before {
            content: '';
            position: absolute;
            top: -20px;
            left: 0;
            right: 0;
            height: 20px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1200 120" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none"><path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" fill="%23f5f7fa" opacity=".25"/><path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" fill="%23f5f7fa" opacity=".5"/><path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" fill="%23f5f7fa"/></svg>');
            background-size: cover;
        }
        
        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            margin-bottom: 8px;
        }
        
        .footer-links a:hover {
            color: white;
            transform: translateX(5px);
        }
        
        .social-icons a {
            display: inline-block;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            text-align: center;
            line-height: 40px;
            color: white;
            margin-right: 10px;
            transition: all 0.3s ease;
        }
        
        .social-icons a:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-5px);
        }
        
        /* Scroll to Top Button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            z-index: 999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        
        .scroll-top.active {
            opacity: 1;
            visibility: visible;
        }
        
        .scroll-top:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }
        
        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.5rem;
            }
            
            .section {
                padding: 60px 0;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .form-container, .login-container, .admin-container, .about-content {
                padding: 25px;
            }
        }
        
        /* Animation Classes */
        .animate-pop {
            animation: popIn 0.5s ease;
        }
        
        @keyframes popIn {
            0% { transform: scale(0.8); opacity: 0; }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); opacity: 1; }
        }
        
        .animate-float {
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#" data-section="books">BookVerse</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#" data-section="books">Books</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-section="about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp" data-section="admin">Admin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user.jsp" data-section="login">User Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Books Section -->
    <section id="books" class="section active">
        <div class="container">
            <h2 class="text-center section-title animate__animated animate__fadeIn">Our Book Collection</h2>
            
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search books...">
                        <button class="btn btn-custom" type="button" id="searchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-6 text-md-end">
                    <button class="btn btn-custom" id="addBookBtn">
                        <i class="fas fa-plus"></i> Add New Book
                    </button>
                </div>
            </div>
            
            <div class="row" id="booksContainer">
                <!-- Books will be loaded here dynamically -->
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="section">
        <div class="container">
            <h2 class="text-center section-title">About BookVerse</h2>
            
            <div class="about-content animate__animated animate__fadeIn">
                <div class="row mb-5">
                    <div class="col-lg-6">
                        <h3 class="mb-4">Our Story</h3>
                        <p class="lead">BookVerse is a dynamic book management system designed to help book lovers organize, discover, and manage their favorite reads.</p>
                        <p>Founded in 2023, our mission is to create a seamless experience for book enthusiasts to catalog their collections, discover new titles, and connect with other readers.</p>
                    </div>
                    <div class="col-lg-6">
                        <img src="https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80" alt="Library" class="img-fluid rounded shadow">
                    </div>
                </div>
                
                <h3 class="text-center mb-5">Why Choose BookVerse?</h3>
                
                <div class="row">
                    <div class="col-md-4">
                        <div class="feature-box animate__animated animate__fadeInUp" style="animation-delay: 0.1s;">
                            <div class="feature-icon">
                                <i class="fas fa-book-open"></i>
                            </div>
                            <h4>Extensive Collection</h4>
                            <p>Access thousands of books across all genres, from classics to contemporary bestsellers.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-box animate__animated animate__fadeInUp" style="animation-delay: 0.3s;">
                            <div class="feature-icon">
                                <i class="fas fa-user-friends"></i>
                            </div>
                            <h4>Community Driven</h4>
                            <p>Connect with fellow book lovers, share reviews, and get personalized recommendations.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-box animate__animated animate__fadeInUp" style="animation-delay: 0.5s;">
                            <div class="feature-icon">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <h4>Mobile Friendly</h4>
                            <p>Access your book collection anytime, anywhere with our responsive design.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Admin Section -->
    <section id="admin" class="section">
        <div class="container">
            <h2 class="text-center section-title">Admin Dashboard</h2>
            
            <div class="admin-container animate__animated animate__fadeIn">
                <div class="alert alert-info">
                    <i class="fas fa-lock"></i> Admin area - Please login to access full features
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-body text-center">
                                <h3><i class="fas fa-book text-primary"></i> <span id="totalBooks">0</span></h3>
                                <p class="mb-0">Total Books</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-body text-center">
                                <h3><i class="fas fa-users text-success"></i> <span id="totalUsers">0</span></h3>
                                <p class="mb-0">Registered Users</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <h4 class="mb-3">Recent Activity</h4>
                <div class="list-group mb-4" id="recentActivity">
                    <div class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>System initialized</span>
                            <small class="text-muted">Just now</small>
                        </div>
                    </div>
                </div>
                
                <button class="btn btn-custom w-100" id="refreshStats">
                    <i class="fas fa-sync-alt"></i> Refresh Statistics
                </button>
            </div>
        </div>
    </section>

    <!-- Login Section -->
    <section id="login" class="section">
        <div class="container">
            <h2 class="text-center section-title">Login to BookVerse</h2>
            
            <div class="login-container animate__animated animate__fadeIn">
                <form id="loginForm">
                    <div class="mb-4 text-center">
                        <i class="fas fa-user-circle fa-5x text-primary mb-3"></i>
                        <h3>Welcome Back</h3>
                        <p class="text-muted">Please enter your credentials to login</p>
                    </div>
                    
                    <div class="mb-3">
                        <label for="loginEmail" class="form-label">Email address</label>
                        <input type="email" class="form-control" id="loginEmail" required>
                    </div>
                    
                    <div class="mb-4">
                        <label for="loginPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="loginPassword" required>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <a href="#" class="text-primary">Forgot password?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-custom w-100 mb-3">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </button>
                    
                    <div class="text-center">
                        <p class="mb-0">Don't have an account? <a href="#" class="text-primary">Sign up</a></p>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Add/Edit Book Modal -->
    <div class="modal fade" id="bookModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                
                <div class="modal-body">
                    <form id="bookForm">
                        <input type="hidden" id="bookId">
                        <div class="mb-3">
                            <label for="bookTitle" class="form-label">Title</label>
                            <input type="text" class="form-control" id="bookTitle" required>
                        </div>
                        <div class="mb-3">
                            <label for="bookAuthor" class="form-label">Author</label>
                            <input type="text" class="form-control" id="bookAuthor" required>
                        </div>
                        <div class="mb-3">
                            <label for="bookGenre" class="form-label">Genre</label>
                            <select class="form-select" id="bookGenre" required>
                                <option value="">Select Genre</option>
                                <option value="Fiction">Fiction</option>
                                <option value="Non-Fiction">Non-Fiction</option>
                                <option value="Science Fiction">Science Fiction</option>
                                <option value="Fantasy">Fantasy</option>
                                <option value="Mystery">Mystery</option>
                                <option value="Romance">Romance</option>
                                <option value="Biography">Biography</option>
                                <option value="History">History</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="bookYear" class="form-label">Publication Year</label>
                            <input type="number" class="form-control" id="bookYear" min="1000" max="2025">
                        </div>
                        <div class="mb-3">
                            <label for="bookPrice" class="form-label">Price ($)</label>
                            <input type="number" step="0.01" class="form-control" id="bookPrice">
                        </div>
                        <div class="mb-3">
                            <label for="bookDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="bookDescription" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="bookCover" class="form-label">Cover Image URL</label>
                            <input type="url" class="form-control" id="bookCover" placeholder="https://example.com/image.jpg">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-custom" id="saveBookBtn">Save Book</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h4 class="text-white mb-4">BookVerse</h4>
                    <p>A dynamic book management system for book lovers and collectors. Organize, discover, and enjoy your reading journey with us.</p>
                    <div class="social-icons mt-4">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-4">Quick Links</h5>
                    <div class="footer-links">
                        <a href="#" data-section="books">Books</a>
                        <a href="#" data-section="about">About</a>
                        <a href="#" data-section="admin">Admin</a>
                        <a href="#" data-section="login">Login</a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-4">Categories</h5>
                    <div class="footer-links">
                        <a href="#">Fiction</a>
                        <a href="#">Non-Fiction</a>
                        <a href="#">Science Fiction</a>
                        <a href="#">Fantasy</a>
                        <a href="#">Mystery</a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12">
                    <h5 class="text-white mb-4">Newsletter</h5>
                    <p>Subscribe to our newsletter for the latest books and updates.</p>
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" placeholder="Your Email">
                        <button class="btn btn-light" type="button">Subscribe</button>
                    </div>
                </div>
            </div>
            <hr class="mt-5 mb-4" style="border-color: rgba(255, 255, 255, 0.1);">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2023 BookVerse. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-0">
                        <a href="#" class="text-white">Privacy Policy</a> | 
                        <a href="#" class="text-white">Terms of Service</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scroll to Top Button -->
    <div class="scroll-top">
        <i class="fas fa-arrow-up"></i>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JavaScript -->
    <script>
        $(document).ready(function() {
            // Sample book data
            let books = [
                {
                    id: 1,
                    title: "The Great Gatsby",
                    author: "F. Scott Fitzgerald",
                    genre: "Fiction",
                    year: 1925,
                    price: 12.99,
                    description: "A story of wealth, love, and the American Dream in the 1920s.",
                    cover: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
                    featured: true
                },
                {
                    id: 2,
                    title: "To Kill a Mockingbird",
                    author: "Harper Lee",
                    genre: "Fiction",
                    year: 1960,
                    price: 10.50,
                    description: "A powerful story of racial injustice and moral growth in the American South.",
                    cover: "https://images.unsplash.com/photo-1589998059171-988d887df646?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                },
                {
                    id: 3,
                    title: "1984",
                    author: "George Orwell",
                    genre: "Science Fiction",
                    year: 1949,
                    price: 9.99,
                    description: "A dystopian novel about totalitarianism, surveillance, and thought control.",
                    cover: "https://images.unsplash.com/photo-1531346878377-a5be20888e57?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                },
                {
                    id: 4,
                    title: "Pride and Prejudice",
                    author: "Jane Austen",
                    genre: "Romance",
                    year: 1813,
                    price: 8.75,
                    description: "A romantic novel about the emotional development of Elizabeth Bennet.",
                    cover: "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
                    featured: true
                },
                {
                    id: 5,
                    title: "The Hobbit",
                    author: "J.R.R. Tolkien",
                    genre: "Fantasy",
                    year: 1937,
                    price: 14.25,
                    description: "A fantasy novel about the quest of home-loving Bilbo Baggins.",
                    cover: "https://images.unsplash.com/photo-1600189261867-30e5ffe7b8da?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                },
                {
                    id: 6,
                    title: "The Catcher in the Rye",
                    author: "J.D. Salinger",
                    genre: "Fiction",
                    year: 1951,
                    price: 11.20,
                    description: "A story about teenage rebellion and alienation in post-war America.",
                    cover: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                }
            ];
            
            // Initialize the page
            initPage();
            
            // Navigation between sections
            $('[data-section]').on('click', function(e) {
                e.preventDefault();
                const sectionId = $(this).data('section');
                
                // Update active nav link
                $('.nav-link').removeClass('active');
                $(this).addClass('active');
                
                // Hide all sections and show the selected one
                $('.section').removeClass('active');
                $(`#${sectionId}`).addClass('active');
                
                // Scroll to top
                $('html, body').animate({ scrollTop: 0 }, 300);
                
                // Update admin stats if needed
                if (sectionId === 'admin') {
                    updateAdminStats();
                }
            });
            
            // Add book button click
            $('#addBookBtn').on('click', function() {
                $('#bookForm')[0].reset();
                $('#bookId').val('');
                $('#modalTitle').text('Add New Book');
                $('#bookModal').modal('show');
            });
            
            // Save book
            $('#saveBookBtn').on('click', function() {
                const bookId = $('#bookId').val();
                const bookData = {
                    title: $('#bookTitle').val(),
                    author: $('#bookAuthor').val(),
                    genre: $('#bookGenre').val(),
                    year: $('#bookYear').val(),
                    price: parseFloat($('#bookPrice').val()),
                    description: $('#bookDescription').val(),
                    cover: $('#bookCover').val()
                };
                
                if (bookId) {
                    // Update existing book
                    const index = books.findIndex(book => book.id == bookId);
                    if (index !== -1) {
                        books[index] = { ...books[index], ...bookData };
                        addActivity(`Updated book: ${bookData.title}`);
                    }
                } else {
                    // Add new book
                    const newId = books.length > 0 ? Math.max(...books.map(book => book.id)) + 1 : 1;
                    const newBook = { id: newId, ...bookData };
                    books.push(newBook);
                    addActivity(`Added new book: ${bookData.title}`);
                }
                
                // Refresh books display
                displayBooks(books);
                $('#bookModal').modal('hide');
                updateAdminStats();
            });
            
           														