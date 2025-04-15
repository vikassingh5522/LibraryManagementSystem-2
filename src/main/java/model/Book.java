package model;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private String isbn;
    private int publicationYear;
    private int quantity;
    
    // Constructors
    public Book() {}
    
    public Book(String title, String author, String isbn, int publicationYear, int quantity) {
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.publicationYear = publicationYear;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }
    
    public int getPublicationYear() { return publicationYear; }
    public void setPublicationYear(int publicationYear) { 
        this.publicationYear = publicationYear; 
    }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { 
        this.quantity = quantity; 
    }
    
    @Override
    public String toString() {
        return "Book [id=" + bookId + ", title=" + title + ", author=" + author + 
               ", isbn=" + isbn + ", year=" + publicationYear + ", quantity=" + quantity + "]";
    }
}