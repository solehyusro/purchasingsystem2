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
import model.Supplier;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "P_supplierServlet", urlPatterns = {"/P_supplierServlet"})
public class P_supplierServlet extends HttpServlet {

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
        Supplier sup = new Supplier();
        Supplier validation = new Supplier();
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
                sup.setKd_supp(request.getParameter("kd_supp"));
                sup.setNm_supp(request.getParameter("nm_supp"));
                sup.setA_supp(request.getParameter("a_supp"));
                sup.setNp_supp(request.getParameter("nt_supp"));
                switch (aksi) {
                    case "Simpan":
                        if (sup.getNm_supp().equals("")||sup.getNp_supp().equals("")||sup.getA_supp().equals("")) {
                            out.println("<script>"
                                    + "alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!');"
                                    + "document.location='H_purchasing.jsp?hal=supplier';"
                                    + "</script>");
                        } else {
                            rs = stmt.executeQuery("SELECT * FROM supplier WHERE kd_supp = '" + sup.getKd_supp() + "'");
                            if (rs.next()) {
                                pstmt = koneksi.prepareStatement("UPDATE supplier SET "
                                        + "nm_supp=?, "
                                        + "alamat=?, "
                                        + "no_telp=? "
                                        + "WHERE kd_supp=?");
                                pstmt.setString(1, sup.getNm_supp());
                                pstmt.setString(2, sup.getA_supp());
                                pstmt.setString(3, sup.getNp_supp());
                                pstmt.setString(4, sup.getKd_supp());

                                result = pstmt.executeUpdate();
                                if (result > 0) {
                                    out.println("<script> "
                                            + "alert('Data berhasil diperbaharui');"
                                            + "document.location='H_purchasing.jsp?hal=supplier';"
                                            + " </script>");
                                }
                            } else {
                                pstmt = koneksi.prepareStatement("INSERT INTO supplier VALUES (?, ?, ?, ?)");
                                pstmt.setString(1, sup.getKd_supp());
                                pstmt.setString(2, sup.getNm_supp());
                                pstmt.setString(3, sup.getA_supp());
                                pstmt.setString(4, sup.getNp_supp());

                                result = pstmt.executeUpdate();
                                if (result > 0) {
                                    out.println("<script> "
                                            + "alert('Data telah ditambahkan');"
                                            + "document.location='H_purchasing.jsp?hal=supplier';"
                                            + " </script>");
                                }
                            }
                        }
                        break;
                    case "Hapus":
                        pstmt = koneksi.prepareStatement("DELETE FROM supplier WHERE kd_supp = ?");
                        pstmt.setString(1, sup.getKd_supp());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data Berhasil Dihapus');"
                                    + "document.location='H_purchasing.jsp?hal=supplier';"
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
            Logger.getLogger(P_supplierServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_supplierServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(P_supplierServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_supplierServlet.class.getName()).log(Level.SEVERE, null, ex);
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
