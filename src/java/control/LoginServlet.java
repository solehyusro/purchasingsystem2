/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Admin;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");

        Admin admin = new Admin();
        Admin validation = new Admin();

        String URL = "jdbc:mysql://localhost:3306/ta_syahrur";
        String USERNAME = "root";
        String PASSWORD = "";

        Connection koneksi = null;
        PreparedStatement pstmt = null;
        Statement stmt = null;
        ResultSet rs = null;
        int result = 0;

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            admin.setId_admin(request.getParameter("id_admin"));
            admin.setPassword(request.getParameter("password"));
            stmt = koneksi.createStatement();
            if (admin.getId_admin().equals("") && admin.getPassword().equals("")) {
                out.println("<script> "
                        + "alert('ID Admin dan Password belum diisi');"
                        + "document.location='index.html';"
                        + " </script>");
            } else if (admin.getId_admin().equals("")) {
                out.println("<script> "
                        + "alert('ID Admin belum diisi');"
                        + "document.location='index.html';"
                        + " </script>");
            } else if (admin.getPassword().equals("")) {
                out.println("<script> "
                        + "alert('Password belum diisi');"
                        + "document.location='index.html';"
                        + " </script>");
            } else {
                rs = stmt.executeQuery("SELECT * FROM admin WHERE id_admin = '" + admin.getId_admin() + "' AND password = '" + admin.getPassword() + "'");

                if (rs.next()) {
                    validation.setNama(rs.getString("nama"));
                    validation.setNo_telp(rs.getString("no_telp"));
                    validation.setPassword(rs.getString("password"));
                    validation.setAlamat(rs.getString("alamat"));
                    validation.setHak_akses(rs.getString("hak_akses"));
                } else {
                    validation.setHak_akses("tidak ada");
                }

                if (validation.getHak_akses().equals("Accounting")) {
                    out.println("<script> "
                            + "localStorage.setItem('kode', '" + admin.getId_admin() + "');"
                            + "localStorage.setItem('nama', '" + validation.getNama() + "');"
                            + "localStorage.setItem('telp', '" + validation.getNo_telp()+ "');"
                            + "localStorage.setItem('pass', '" + validation.getPassword()+ "');"
                            + "localStorage.setItem('alamat', '" + validation.getAlamat()+ "');"
                            + "alert('Selamat Datang " + validation.getNama() + "');"
                            + "document.location='H_accounting.jsp';"
                            + " </script>");
                } else if (validation.getHak_akses().equals("Purchasing")) {
                    out.println("<script> "
                            + "localStorage.setItem('kode', '" + admin.getId_admin() + "');"
                            + "localStorage.setItem('nama', '" + validation.getNama() + "');"
                            + "localStorage.setItem('telp', '" + validation.getNo_telp()+ "');"
                            + "localStorage.setItem('pass', '" + validation.getPassword()+ "');"
                            + "localStorage.setItem('alamat', '" + validation.getAlamat()+ "');"
                            + "alert('Selamat Datang " + validation.getNama() + "');"
                            + "document.location='H_purchasing.jsp';"
                            + " </script>");
                } else if (validation.getHak_akses().equals("Direktur")) {
                    out.println("<script> "
                            + "localStorage.setItem('kode', '" + admin.getId_admin() + "');"
                            + "localStorage.setItem('nama', '" + validation.getNama() + "');"
                            + "localStorage.setItem('telp', '" + validation.getNo_telp()+ "');"
                            + "localStorage.setItem('pass', '" + validation.getPassword()+ "');"
                            + "localStorage.setItem('alamat', '" + validation.getAlamat()+ "');"
                            + "alert('Selamat Datang " + validation.getNama() + "');"
                            + "document.location='H_direktur.jsp';"
                            + " </script>");
                } else {
                    out.println("<script> "
                            + "alert('ID Admin dan Password salah');"
                            + "document.location='index.html';"
                            + " </script>");
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
