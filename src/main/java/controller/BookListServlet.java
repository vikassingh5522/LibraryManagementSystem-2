package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.BookDAO;
import model.Book;

@WebServlet("/booksList")
public class BookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDao;

    @Override
    public void init() throws ServletException {
        super.init();
        bookDao = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get all books from database
            List<Book> books = bookDao.getAllBooks();
            
            // Set books in request attribute
            request.setAttribute("books", books);
            
            // Forward to JSP page
            request.getRequestDispatcher("/bookList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving books: " + e.getMessage());
            request.getRequestDispatcher("/bookList.jsp").forward(request, response);
        }
    }
}