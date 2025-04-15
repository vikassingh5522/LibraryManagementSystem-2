package dao;

import model.Transaction;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.util.descriptor.web.ContextTransaction;

public class TransactionDAO {
    // Create
    public boolean addTransaction(Transaction transaction) {
        String sql = "INSERT INTO transactions (user_id, book_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, transaction.getUserId());
            stmt.setInt(2, transaction.getBookId());
            stmt.setDate(3, transaction.getBorrowDate());
            stmt.setDate(4, transaction.getDueDate());
            stmt.setString(5, transaction.getStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
        	
            e.printStackTrace();
            return false;
        }
    }
    
    // Update transaction status
    public boolean updateTransactionStatus(int transactionId, String status) {
        String sql = "UPDATE transactions SET status=? WHERE transaction_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, transactionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all transactions
    public List<Transaction> getAllTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM transactions";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getInt("transaction_id"));
                transaction.setUserId(rs.getInt("user_id"));
                transaction.setBookId(rs.getInt("book_id"));
                transaction.setBorrowDate(rs.getDate("borrow_date"));
                transaction.setDueDate(rs.getDate("due_date"));
                transaction.setReturnDate(rs.getDate("return_date"));
                transaction.setStatus(rs.getString("status"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
    // Get transactions by user ID
    public List<Transaction> getTransactionsByUserId(int userId) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE user_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(rs.getInt("transaction_id"));
                    transaction.setUserId(rs.getInt("user_id"));
                    transaction.setBookId(rs.getInt("book_id"));
                    transaction.setBorrowDate(rs.getDate("borrow_date"));
                    transaction.setDueDate(rs.getDate("due_date"));
                    transaction.setReturnDate(rs.getDate("return_date"));
                    transaction.setStatus(rs.getString("status"));
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
}