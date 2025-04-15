<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Authentication</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: var(--dark-color);
        }
        
        .auth-container {
            width: 100%;
            max-width: 1200px;
            margin: 20px;
        }
        
        .auth-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            display: flex;
            min-height: 600px;
        }
        
        .auth-hero {
            flex: 1;
            background: linear-gradient(rgba(108, 92, 231, 0.8), rgba(253, 121, 168, 0.8)), 
                        url('https://images.unsplash.com/photo-1589998059171-988d887df646?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: white;
            text-align: center;
        }
        
        .auth-hero img {
            max-width: 200px;
            margin-bottom: 30px;
        }
        
        .auth-hero h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
        }
        
        .auth-hero p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .auth-form-section {
            flex: 1;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .auth-form-container {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
        
        .auth-logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .auth-logo img {
            height: 60px;
        }
        
        .auth-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .form-floating label {
            color: #636e72;
        }
        
        .form-control {
            border-radius: 8px;
            padding: 16px 20px;
            border: 2px solid #dfe6e9;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(108, 92, 231, 0.25);
        }
        
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #636e72;
        }
        
        .password-toggle:hover {
            color: var(--primary-color);
        }
        
        .btn-auth {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s;
        }
        
        .btn-auth:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            color: white;
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 20px;
            color: #636e72;
        }
        
        .auth-footer a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
        }
        
        .auth-footer a:hover {
            text-decoration: underline;
        }
        
        .alert-message {
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            display: none;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .remember-me input {
            margin-right: 10px;
        }
        
        .forgot-password {
            text-align: right;
            margin-bottom: 15px;
        }
        
        .forgot-password a {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 992px) {
            .auth-card {
                flex-direction: column;
            }
            
            .auth-hero {
                padding: 30px;
                min-height: 300px;
            }
            
            .auth-form-section {
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <!-- Hero Section -->
            <div class="auth-hero">
                <img src="https://img.freepik.com/free-vector/hand-drawn-flat-design-library-logo_23-2149324866.jpg" 
                     alt="Library Logo" class="img-fluid">
                <h1>Library Management System</h1>
                <p>Access thousands of books, manage your account, and explore our digital collection</p>
            </div>
            
            <!-- Form Section -->
            <div class="auth-form-section">
                <div class="auth-form-container">
                    <!-- Login Form (default) -->
                    <div id="loginContainer">
                        <div class="auth-logo">
                            <img src="https://img.freepik.com/free-vector/hand-drawn-flat-design-library-logo_23-2149324866.jpg" 
                                 alt="Library Logo" height="50">
                        </div>
                        <h2 class="auth-title">User Login</h2>
                        
                        <!-- Error Message -->
                        <div id="loginError" class="alert-message alert-error"></div>
                        
                        <!-- Success Message (for registration redirect) -->
                        <% if (request.getParameter("success") != null && request.getParameter("success").equals("true")) { %>
                            <div class="alert-message alert-success">
                                Registration successful! Please login with your credentials.
                            </div>
                            <script>
                                document.querySelector('.alert-success').style.display = 'block';
                            </script>
                        <% } %>
                        
                        <form id="loginForm" action="user_auth" method="POST">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="loginEmail" name="email" 
                                       placeholder="name@example.com" required
                                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                <label for="loginEmail">Email address</label>
                            </div>
                            
                            <div class="form-floating mb-3 position-relative">
                                <input type="password" class="form-control" id="loginPassword" name="password" 
                                       placeholder="Password" required>
                                <label for="loginPassword">Password</label>
                                <span class="password-toggle" onclick="togglePassword('loginPassword')">
                                    <i class="far fa-eye"></i>
                                </span>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="remember-me">
                                    <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe"
                                           <%= request.getParameter("rememberMe") != null ? "checked" : "" %>>
                                    <label class="form-check-label" for="rememberMe">Remember me</label>
                                </div>
                                <div class="forgot-password">
                                    <a href="forgot-password.jsp">Forgot password?</a>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-auth mb-3">
                                <i class="fas fa-sign-in-alt me-2"></i> Login
                            </button>
                            
                            <div class="auth-footer">
                                Don't have an account? <a href="#" id="showSignup">Sign up here</a>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Signup Form (hidden by default) -->
                    <div id="signupContainer" style="display: none;">
                        <div class="auth-logo">
                            <img src="https://img.freepik.com/free-vector/hand-drawn-flat-design-library-logo_23-2149324866.jpg" 
                                 alt="Library Logo" height="50">
                        </div>
                        <h2 class="auth-title">Create Account</h2>
                        
                        <!-- Error Message -->
                        <div id="signupError" class="alert-message alert-error"></div>
                        
                        <form id="signupForm" action="user_auth" method="POST">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="signupUsername" name="username" 
                                       placeholder="Username" required
                                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                                <label for="signupUsername">Username</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="signupEmail" name="email" 
                                       placeholder="name@example.com" required
                                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                <label for="signupEmail">Email address</label>
                            </div>
                            
                            <div class="form-floating mb-3 position-relative">
                                <input type="password" class="form-control" id="signupPassword" name="password" 
                                       placeholder="Password" required>
                                <label for="signupPassword">Password (min 8 characters)</label>
                                <span class="password-toggle" onclick="togglePassword('signupPassword')">
                                    <i class="far fa-eye"></i>
                                </span>
                            </div>
                            
                            <div class="form-floating mb-4 position-relative">
                                <input type="password" class="form-control" id="signupConfirmPassword" 
                                       name="confirmPassword" placeholder="Confirm Password" required>
                                <label for="signupConfirmPassword">Confirm Password</label>
                                <span class="password-toggle" onclick="togglePassword('signupConfirmPassword')">
                                    <i class="far fa-eye"></i>
                                </span>
                            </div>
                            
                            <button type="submit" class="btn btn-auth mb-3">
                                <i class="fas fa-user-plus me-2"></i> Create Account
                            </button>
                            
                            <div class="auth-footer">
                                Already have an account? <a href="#" id="showLogin">Login here</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Initialize form states
        document.addEventListener('DOMContentLoaded', function() {
            // Check URL parameters to determine which form to show
            const urlParams = new URLSearchParams(window.location.search);
            
            // Show signup form if requested
            if (urlParams.has('show') && urlParams.get('show') === 'signup') {
                showSignupForm();
            }
            
            // Display error messages if they exist
            <% if (request.getAttribute("errorMessage") != null) { %>
                const errorMessage = '<%= request.getAttribute("errorMessage") %>';
                const action = '<%= request.getParameter("action") != null ? request.getParameter("action") : "" %>';
                
                if (action === 'login') {
                    document.getElementById('loginError').textContent = errorMessage;
                    document.getElementById('loginError').style.display = 'block';
                    showLoginForm();
                } else if (action === 'register') {
                    document.getElementById('signupError').textContent = errorMessage;
                    document.getElementById('signupError').style.display = 'block';
                    showSignupForm();
                }
            <% } %>
        });

        // Toggle between login and signup forms
        function showSignupForm() {
            document.getElementById('loginContainer').style.display = 'none';
            document.getElementById('signupContainer').style.display = 'block';
            document.getElementById('signupError').style.display = 'none';
            // Clear any login error when switching
            document.getElementById('loginError').style.display = 'none';
        }
        
        function showLoginForm() {
            document.getElementById('signupContainer').style.display = 'none';
            document.getElementById('loginContainer').style.display = 'block';
            document.getElementById('loginError').style.display = 'none';
            // Clear any signup error when switching
            document.getElementById('signupError').style.display = 'none';
        }
        
        document.getElementById('showSignup').addEventListener('click', function(e) {
            e.preventDefault();
            showSignupForm();
            // Scroll to top of form
            document.querySelector('.auth-form-section').scrollIntoView({ behavior: 'smooth' });
        });
        
        document.getElementById('showLogin').addEventListener('click', function(e) {
            e.preventDefault();
            showLoginForm();
            // Scroll to top of form
            document.querySelector('.auth-form-section').scrollIntoView({ behavior: 'smooth' });
        });
        
        // Password visibility toggle
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = document.querySelector(`[onclick="togglePassword('${inputId}')"] i`);
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
        
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('loginEmail').value;
            const password = document.getElementById('loginPassword').value;
            const errorElement = document.getElementById('loginError');
            
            // Reset error state
            errorElement.style.display = 'none';
            
            if (!email || !password) {
                e.preventDefault();
                errorElement.textContent = 'Please fill in all fields';
                errorElement.style.display = 'block';
                return;
            }
            
            if (!validateEmail(email)) {
                e.preventDefault();
                errorElement.textContent = 'Please enter a valid email address';
                errorElement.style.display = 'block';
                return;
            }
        });
        
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const username = document.getElementById('signupUsername').value;
            const email = document.getElementById('signupEmail').value;
            const password = document.getElementById('signupPassword').value;
            const confirmPassword = document.getElementById('signupConfirmPassword').value;
            const errorElement = document.getElementById('signupError');
            
            // Reset error state
            errorElement.style.display = 'none';
            
            if (!username || !email || !password || !confirmPassword) {
                e.preventDefault();
                errorElement.textContent = 'Please fill in all fields';
                errorElement.style.display = 'block';
                return;
            }
            
            if (!validateEmail(email)) {
                e.preventDefault();
                errorElement.textContent = 'Please enter a valid email address';
                errorElement.style.display = 'block';
                return;
            }
            
            if (password.length < 8) {
                e.preventDefault();
                errorElement.textContent = 'Password must be at least 8 characters long';
                errorElement.style.display = 'block';
                return;
            }
            
            if (password !== confirmPassword) {
                e.preventDefault();
                errorElement.textContent = 'Passwords do not match!';
                errorElement.style.display = 'block';
                return;
            }
        });
        
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }
    </script>
</body>
</html>