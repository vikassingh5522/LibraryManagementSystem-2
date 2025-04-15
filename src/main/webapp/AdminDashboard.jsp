<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Book Management System</title>
    
    <!-- CSS Resources -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
    
    <style>
        :root {
            --primary: #4e73df;
            --secondary: #858796;
            --success: #1cc88a;
            --info: #36b9cc;
            --warning: #f6c23e;
            --danger: #e74a3b;
            --dark: #5a5c69;
            --light: #f8f9fc;
        }
        
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--primary) 10%, #224abe 100%);
            min-height: 100vh;
            color: white;
            transition: all 0.3s;
        }
        
        .sidebar-brand {
            height: 4.375rem;
            text-decoration: none;
            font-size: 1.2rem;
            font-weight: 800;
            padding: 1.5rem 1rem;
            text-align: center;
            letter-spacing: 0.05rem;
            z-index: 1;
        }
        
        .sidebar-divider {
            border-top: 1px solid rgba(255, 255, 255, 0.15);
            margin: 0 1rem 1rem;
        }
        
        .nav-item {
            position: relative;
        }
        
        .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 0.75rem 1rem;
            font-weight: 600;
        }
        
        .nav-link:hover {
            color: white;
        }
        
        .nav-link i {
            margin-right: 0.5rem;
        }
        
        .active {
            color: white;
        }
        
        .topbar {
            height: 4.375rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            background-color: white;
        }
        
        .topbar .navbar-search {
            width: 25rem;
        }
        
        .topbar .navbar-search input {
            font-size: 0.85rem;
            height: auto;
        }
        
        .topbar .dropdown-list {
            padding: 0;
            border: none;
            overflow: hidden;
            width: 20rem !important;
        }
        
        .content-wrapper {
            margin-left: 14rem;
            transition: all 0.3s;
        }
        
        .card {
            border: none;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
            padding: 1rem 1.35rem;
            font-weight: 600;
        }
        
        /* Dashboard Cards */
        .card-icon {
            font-size: 2rem;
            opacity: 0.3;
        }
        
        .card-primary {
            border-left: 0.25rem solid var(--primary);
        }
        
        .card-success {
            border-left: 0.25rem solid var(--success);
        }
        
        .card-info {
            border-left: 0.25rem solid var(--info);
        }
        
        .card-warning {
            border-left: 0.25rem solid var(--warning);
        }
        
        /* Book Management Table */
        .book-table {
            margin-bottom: 0;
            width: 100%;
        }
        
        .book-table th {
            background-color: #f8f9fa;
            color: var(--dark);
            font-weight: 600;
            padding: 1rem;
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
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .content-wrapper {
                margin-left: 0;
            }
            
            .sidebar {
                margin-left: -14rem;
            }
            
            .topbar .navbar-search {
                width: 100%;
            }
        }
    </style>
</head>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">
            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin">
                <div class="sidebar-brand-icon">
                    <i class="fas fa-book-open"></i>
                </div>
                <div class="sidebar-brand-text mx-3">BookSys Admin</div>
            </a>
            
            <!-- Divider -->
            <hr class="sidebar-divider my-0">
            
            <!-- Nav Items -->
            <li class="nav-item active">
                <a class="nav-link" href="admin">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <hr class="sidebar-divider">
            
            <div class="sidebar-heading">
                Management
            </div>
            
            <li class="nav-item">
                <a class="nav-link" href="admin?section=books">
                    <i class="fas fa-fw fa-book"></i>
                    <span>Books</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="admin?section=users">
                    <i class="fas fa-fw fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="admin?section=loans">
                    <i class="fas fa-fw fa-exchange-alt"></i>
                    <span>Book Loans</span>
                </a>
            </li>
            
            <hr class="sidebar-divider">
            
            <div class="sidebar-heading">
                Reports
            </div>
            
            <li class="nav-item">
                <a class="nav-link" href="admin?section=reports">
                    <i class="fas fa-fw fa-chart-bar"></i>
                    <span>Statistics</span>
                </a>
            </li>
            
            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">
            
            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle">
                    <i class="fas fa-angle-left"></i>
                </button>
            </div>
        </ul>
        <!-- End of Sidebar -->
        
        <!-- Content Wrapper -->
        <div class="content-wrapper" id="content-wrapper">
            <!-- Topbar -->
            <nav class="navbar navbar-expand topbar static-top">
                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                
                <!-- Topbar Search -->
                <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                    <div class="input-group">
                        <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search fa-sm"></i>
                            </button>
                        </div>
                    </div>
                </form>
                
                <!-- Topbar Navbar -->
                <ul class="navbar-nav ml-auto">
                    <!-- Nav Item - Alerts -->
                    <li class="nav-item dropdown no-arrow mx-1">
                        <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown">
                            <i class="fas fa-bell fa-fw"></i>
                            <!-- Counter - Alerts -->
                            <span class="badge badge-danger badge-counter">3+</span>
                        </a>
                    </li>
                    
                    <!-- Nav Item - Messages -->
                    <li class="nav-item dropdown no-arrow mx-1">
                        <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown">
                            <i class="fas fa-envelope fa-fw"></i>
                            <!-- Counter - Messages -->
                            <span class="badge badge-danger badge-counter">7</span>
                        </a>
                    </li>
                    
                    <div class="topbar-divider d-none d-sm-block"></div>
                    
                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">Admin User</span>
                            <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- End of Topbar -->
            
            <!-- Begin Page Content -->
            <div class="container-fluid" id="page-content">
                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                        <i class="fas fa-download fa-sm text-white-50"></i> Generate Report
                    </a>
                </div>
                
                <!-- Content Row -->
                <div class="row">
                    <!-- Total Books Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Books</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalBooks}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-book fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Available Books Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Available Books</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${availableBooks}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Total Users Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Registered Users</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalUsers}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pending Requests Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Pending Requests</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${pendingRequests}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Content Row -->
                <div class="row">
                    <!-- Books Chart -->
                    <div class="col-xl-8 col-lg-7">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">Books Overview</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-area">
                                    <canvas id="booksChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Categories Pie Chart -->
                    <div class="col-xl-4 col-lg-5">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">Books by Category</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-pie pt-4 pb-2">
                                    <canvas id="categoryChart"></canvas>
                                </div>
                                <div class="mt-4 text-center small">
                                    <c:forEach items="${bookCategories}" var="category">
                                        <span class="mr-2">
                                            <i class="fas fa-circle" style="color: ${category.color}"></i> ${category.name}
                                        </span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Content Row -->
                <div class="row">
                    <!-- Recent Books -->
                    <div class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Recently Added Books</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Author</th>
                                                <th>Date Added</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentBooks}" var="book" end="4">
                                                <tr>
                                                    <td>${book.title}</td>
                                                    <td>${book.author}</td>
                                                    <td>${book.dateAdded}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Activity -->
                    <div class="col-lg-6 mb-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Recent Activity</h6>
                            </div>
                            <div class="card-body">
                                <div class="activity-feed">
                                    <c:forEach items="${recentActivities}" var="activity">
                                        <div class="mb-3 activity-item">
                                            <div class="small text-gray-500">${activity.timestamp}</div>
                                            <span class="font-weight-bold">${activity.user}</span> ${activity.action}
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Books Management Section (shown when ?section=books) -->
                <c:if test="${param.section == 'books'}">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex justify-content-between align-items-center">
                            <h6 class="m-0 font-weight-bold text-primary">Book Management</h6>
                            <a href="books?action=new" class="btn btn-sm btn-primary">
                                <i class="fas fa-plus"></i> Add New Book
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="bookTable" width="100%" cellspacing="0">
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
                                        <c:forEach items="${books}" var="book">
                                            <tr>
                                                <td>${book.title}</td>
                                                <td>${book.author}</td>
                                                <td>${book.isbn}</td>
                                                <td>${book.publicationYear}</td>
                                                <td>${book.quantity}</td>
                                                <td>
                                                    <span class="badge ${book.quantity > 0 ? 'bg-success' : 'bg-danger'}">
                                                        ${book.quantity > 0 ? 'Available' : 'Out of Stock'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="books?action=edit&id=${book.bookId}" class="btn btn-sm btn-warning">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="books?action=delete&id=${book.bookId}" 
                                                       class="btn btn-sm btn-danger" 
                                                       onclick="return confirm('Are you sure you want to delete this book?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Users Management Section (shown when ?section=users) -->
                <c:if test="${param.section == 'users'}">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">User Management</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="userTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${users}" var="user">
                                            <tr>
                                                <td>${user.name}</td>
                                                <td>${user.email}</td>
                                                <td>${user.role}</td>
                                                <td>
                                                    <span class="badge ${user.active ? 'bg-success' : 'bg-secondary'}">
                                                        ${user.active ? 'Active' : 'Inactive'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="users?action=edit&id=${user.id}" class="btn btn-sm btn-warning">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="users?action=toggle-status&id=${user.id}" class="btn btn-sm ${user.active ? 'btn-secondary' : 'btn-success'}">
                                                        <i class="fas ${user.active ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Book Loans Section (shown when ?section=loans) -->
                <c:if test="${param.section == 'loans'}">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Book Loans Management</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="loansTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Book</th>
                                            <th>User</th>
                                            <th>Borrow Date</th>
                                            <th>Due Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${loans}" var="loan">
                                            <tr>
                                                <td>${loan.bookTitle}</td>
                                                <td>${loan.userName}</td>
                                                <td>${loan.borrowDate}</td>
                                                <td>${loan.dueDate}</td>
                                                <td>
                                                    <span class="badge ${loan.status == 'Returned' ? 'bg-success' : loan.overdue ? 'bg-danger' : 'bg-primary'}">
                                                        ${loan.status}${loan.overdue ? ' (Overdue)' : ''}
                                                    </span>
                                                </td>
                                                <td>
                                                    <c:if test="${loan.status != 'Returned'}">
                                                        <a href="loans?action=return&id=${loan.id}" class="btn btn-sm btn-success">
                                                            <i class="fas fa-check"></i> Mark Returned
                                                        </a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Reports Section (shown when ?section=reports) -->
                <c:if test="${param.section == 'reports'}">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">System Reports</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <h6 class="m-0 font-weight-bold text-primary">Most Popular Books</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-bar">
                                                <canvas id="popularBooksChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <h6 class="m-0 font-weight-bold text-primary">Loan Activity</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-line">
                                                <canvas id="loanActivityChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h6 class="m-0 font-weight-bold text-primary">Export Data</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex justify-content-around">
                                                <a href="reports?type=books&format=csv" class="btn btn-primary">
                                                    <i class="fas fa-file-csv"></i> Export Books (CSV)
                                                </a>
                                                <a href="reports?type=users&format=pdf" class="btn btn-danger">
                                                    <i class="fas fa-file-pdf"></i> Export Users (PDF)
                                                </a>
                                                <a href="reports?type=loans&format=excel" class="btn btn-success">
                                                    <i class="fas fa-file-excel"></i> Export Loans (Excel)
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
    
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
    <!-- JavaScript Resources -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    
    <script>
        // Sidebar Toggle
        $('#sidebarToggle, #sidebarToggleTop').on('click', function(e) {
            $('body').toggleClass('sidebar-toggled');
            $('.sidebar').toggleClass('toggled');
            if ($('.sidebar').hasClass('toggled')) {
                $('.sidebar .collapse').collapse('hide');
            }
        });
        
        // Close any open menu accordions when window is resized below 768px
        $(window).resize(function() {
            if ($(window).width() < 768) {
                $('.sidebar .collapse').collapse('hide');
            }
        });
        
        // Scroll to top button appear
        $(document).on('scroll', function() {
            const scrollDistance = $(this).scrollTop();
            if (scrollDistance > 100) {
                $('.scroll-to-top').fadeIn();
            } else {
                $('.scroll-to-top').fadeOut();
            }
        });
        
        // Smooth scrolling using jQuery easing
        $(document).on('click', 'a.scroll-to-top', function(e) {
            const $anchor = $(this);
            $('html, body').stop().animate({
                scrollTop: ($($anchor.attr('href')).offset().top
            }, 1000, 'easeInOutExpo');
            e.preventDefault();
        });
        
        // Charts
        document.addEventListener('DOMContentLoaded', function() {
            // Books Overview Chart
            const booksCtx = document.getElementById('booksChart').getContext('2d');
            const booksChart = new Chart(booksCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Books Added',
                        data: [12, 19, 15, 21, 14, 16, 25, 18, 22, 19, 26, 31],
                        backgroundColor: 'rgba(78, 115, 223, 0.05)',
                        borderColor: 'rgba(78, 115, 223, 1)',
                        borderWidth: 2,
                        pointBackgroundColor: 'rgba(78, 115, 223, 1)',
                        pointBorderColor: '#fff',
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: 'rgba(78, 115, 223, 1)',
                        pointHoverBorderColor: '#fff',
                        pointHitRadius: 10,
                        pointBorderWidth: 2,
                        tension: 0.3
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            // Categories Pie Chart
            const categoryCtx = document.getElementById('categoryChart').getContext('2d');
            const categoryChart = new Chart(categoryCtx, {
                type: 'doughnut',
                data: {
                    labels: [
                        <c:forEach items="${bookCategories}" var="category" varStatus="loop">
                            '${category.name}'<c:if test="${!loop.last}">, </c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                        data: [
                            <c:forEach items="${bookCategories}" var="category" varStatus="loop">
                                ${category.count}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        ],
                        backgroundColor: [
                            <c:forEach items="${bookCategories}" var="category" varStatus="loop">
                                '${category.color}'<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                        ],
                        hoverBorderColor: "rgba(234, 236, 244, 1)",
                    }]
                },
                options: {
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    cutout: '70%',
                }
            });
            
            // Popular Books Chart (for reports section)
            if (document.getElementById('popularBooksChart')) {
                const popularBooksCtx = document.getElementById('popularBooksChart').getContext('2d');
                const popularBooksChart = new Chart(popularBooksCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Book 1', 'Book 2', 'Book 3', 'Book 4', 'Book 5'],
                        datasets: [{
                            label: 'Number of Loans',
                            data: [42, 38, 35, 28, 25],
                            backgroundColor: 'rgba(78, 115, 223, 0.8)',
                            borderColor: 'rgba(78, 115, 223, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }
            
            // Loan Activity Chart (for reports section)
            if (document.getElementById('loanActivityChart')) {
                const loanActivityCtx = document.getElementById('loanActivityChart').getContext('2d');
                const loanActivityChart = new Chart(loanActivityCtx, {
                    type: 'line',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                        datasets: [{
                            label: 'Loans',
                            data: [120, 145, 132, 158, 167, 182],
                            backgroundColor: 'rgba(78, 115, 223, 0.05)',
                            borderColor: 'rgba(78, 115, 223, 1)',
                            borderWidth: 2,
                            tension: 0.3
                        }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>***