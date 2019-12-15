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
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Admin;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "D_adminServlet", urlPatterns = {"/D_adminServlet"})
public class D_adminServlet extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        Admin adm = new Admin();
        Admin validation = new Admin();
        String URL = "jdbc:mysql://localhost:3306/ta_syahrur";
        String USERNAME = "root";
        String PASSWORD = "";
        Statement stmt = null;
        Connection koneksi = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            stmt = koneksi.createStatement();
            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                adm.setId_admin(request.getParameter("id_admin"));
                adm.setPassword(request.getParameter("pass"));
                adm.setNama(request.getParameter("nm"));
                adm.setAlamat(request.getParameter("a_admin"));
                adm.setNo_telp(request.getParameter("no_telp"));
                adm.setHak_akses(request.getParameter("h_ak"));
                switch (aksi) {
                    case "Simpan":

                        rs = stmt.executeQuery("SELECT * FROM admin WHERE id_admin = '" + adm.getId_admin()+ "'");
                        if (rs.next()) {
                            pstmt = koneksi.prepareStatement("UPDATE admin SET "
                                    + "password=?, "
                                    + "nama=?, "
                                    + "alamat=?, "
                                    + "no_telp=?, "
                                    + "hak_akses=? "
                                    + "WHERE id_admin=?");
                            pstmt.setString(1, adm.getPassword());
                            pstmt.setString(2, adm.getNama());
                            pstmt.setString(3, adm.getAlamat());
                            pstmt.setString(4, adm.getNo_telp());
                            pstmt.setString(5, adm.getHak_akses());
                            pstmt.setString(6, adm.getId_admin());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data berhasil diperbaharui');"
                                        + "document.location='H_direktur.jsp?hal=admin';"
                                        + " </script>");
                            }
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO admin VALUES (?, ?, ?, ?, ?, ?)");
                            pstmt.setString(1, adm.getId_admin());
                            pstmt.setString(2, adm.getPassword());
                            pstmt.setString(3, adm.getNama());
                            pstmt.setString(4, adm.getAlamat());
                            pstmt.setString(5, adm.getNo_telp());
                            pstmt.setString(6, adm.getHak_akses());
                            
                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='H_direktur.jsp?hal=admin';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Hapus":
                        pstmt = koneksi.prepareStatement("DELETE FROM admin WHERE id_admin = ?");
                        pstmt.setString(1, adm.getId_admin());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data Berhasil Dihapus');"
                                    + "document.location='H_direktur.jsp?hal=admin';"
                                    + " </script>");
                        }
                        break;
                    default:
                        break;
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(D_adminServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(D_adminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(D_adminServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(D_adminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
