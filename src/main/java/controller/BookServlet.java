package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Book;
import dao.BookDAO;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDao;
    
    
// // Database connection parameters - adjust these for your environment
//    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/library_db";
//    private static final String JDBC_USER = "root";
//    private static final String JDBC_PASSWORD = "Vikas@9156";

    @Override
    public void init() throws ServletException {
        super.init();
        bookDao = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "list") {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "list":
                default:
                    listBooks(request, response);
                    break;
            }
        } catch (SQLException ex) {
            handleDatabaseError(request, response, ex);
        } catch (NumberFormatException ex) {
            handleUserInputError(request, response, "Invalid book ID format");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addBook(request, response);
                    break;
                case "update":
                    updateBook(request, response);
                    break;
                default:
                    response.sendRedirect("books");
                    break;
            }
        } catch (SQLException ex) {
            handleDatabaseError(request, response, ex);
        } catch (NumberFormatException ex) {
            handleUserInputError(request, response, "Invalid numeric input");
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Book> books = bookDao.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("bookList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("bookForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book existingBook = bookDao.getBookById(id);
        
        if (existingBook != null) {
            request.setAttribute("book", existingBook);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("bookForm.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Book not found with ID: " + id);
            response.sendRedirect("books");
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Book newBook = extractBookFromRequest(request);
        bookDao.addBook(newBook);
        request.getSession().setAttribute("success", "Book added successfully");
        response.sendRedirect("books");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = extractBookFromRequest(request);
        book.setBookId(id);
        bookDao.updateBook(book);
        request.getSession().setAttribute("success", "Book updated successfully");
        response.sendRedirect("books");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookDao.deleteBook(id);
        request.getSession().setAttribute("success", "Book deleted successfully");
        response.sendRedirect("books");
    }

    private Book extractBookFromRequest(HttpServletRequest request) {
        Book book = new Book();
        book.setTitle(request.getParameter("title"));
        book.setAuthor(request.getParameter("author"));
        book.setIsbn(request.getParameter("isbn"));
        
        try {
            book.setPublicationYear(Integer.parseInt(request.getParameter("publicationYear")));
            book.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        } catch (NumberFormatException e) {
            // Set default values or handle differently if needed
            book.setPublicationYear(0);
            book.setQuantity(0);
        }
        
        return book;
    }

    private void handleDatabaseError(HttpServletRequest request, HttpServletResponse response, 
            SQLException ex) throws ServletException, IOException {
        ex.printStackTrace();
        request.setAttribute("error", "Database error: " + ex.getMessage());
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }

    private void handleUserInputError(HttpServletRequest request, HttpServletResponse response,
            String message) throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}