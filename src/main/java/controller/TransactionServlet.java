package controller;


import dao.BookDAO;
import dao.TransactionDAO;
import model.Transaction;
import model.User;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/transactions")
public class TransactionServlet extends HttpServlet {
    private TransactionDAO transactionDao;
    private BookDAO bookDao;
    
    @Override
    public void init() throws ServletException {
        transactionDao = new TransactionDAO();
        bookDao = new BookDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (action == null) {
            if (user.getRole().equals("librarian")) {
                List<Transaction> transactions = transactionDao.getAllTransactions();
                request.setAttribute("transactions", transactions);
                request.getRequestDispatcher("transactionList.jsp").forward(request, response);
            } else {
                List<Transaction> userTransactions = transactionDao.getTransactionsByUserId(user.getUserId());
                request.setAttribute("transactions", userTransactions);
                request.getRequestDispatcher("userTransactions.jsp").forward(request, response);
            }
        } else {
            try {
                switch (action) {
                    case "borrow":
                        borrowBook(request, response);
                        break;
                    case "return":
                        returnBook(request, response);
                        break;
                    case "approve":
                        approveTransaction(request, response);
                        break;
                    default:
                        response.sendRedirect("dashboard.jsp");
                        break;
                }
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }
    }
    
    private void borrowBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        Transaction transaction = new Transaction();
        transaction.setUserId(user.getUserId());
        transaction.setBookId(bookId);
        transaction.setBorrowDate(Date.valueOf(LocalDate.now()));
        transaction.setDueDate(Date.valueOf(LocalDate.now().plusDays(14))); // 2 weeks
        transaction.setStatus("pending");
        
        if (transactionDao.addTransaction(transaction)) {
            request.setAttribute("message", "Borrow request submitted");
        } else {
            request.setAttribute("error", "Failed to submit borrow request");
        }
        
        response.sendRedirect("books");
    }
    
    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int transactionId = Integer.parseInt(request.getParameter("transactionId"));
        
        if (transactionDao.updateTransactionStatus(transactionId, "returned")) {
            request.setAttribute("message", "Book returned successfully");
        } else {
            request.setAttribute("error", "Failed to return book");
        }
        
        response.sendRedirect("transactions");
    }
    
    private void approveTransaction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int transactionId = Integer.parseInt(request.getParameter("transactionId"));
        
        if (transactionDao.updateTransactionStatus(transactionId, "approved")) {
            request.setAttribute("message", "Transaction approved");
        } else {
            request.setAttribute("error", "Failed to approve transaction");
        }
        
        response.sendRedirect("transactions");
    }
}