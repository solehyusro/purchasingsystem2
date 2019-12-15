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
import model.akun;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "A_akunServlet", urlPatterns = {"/A_akunServlet"})
public class A_akunServlet extends HttpServlet {

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
        akun akun = new akun();
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
                akun.setKd_akun(request.getParameter("kd_akun"));
                akun.setNm_akun(request.getParameter("nm_akun"));
                akun.setJ_akun(request.getParameter("j_akun"));

                switch (aksi) {
                    case "Simpan":
                        if (akun.getKd_akun().equals("") || akun.getNm_akun().equals("")) {
                            out.println("<script>"
                                    + "alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!');"
                                    + "document.location='H_accounting.jsp?hal=akun';"
                                    + "</script>");
                        } else {
                            akun.setSaldo_normal(Double.parseDouble(request.getParameter("sn")));
                            rs = stmt.executeQuery("SELECT * FROM akun WHERE kd_akun = '" + akun.getKd_akun() + "'");
                            if (rs.next()) {
                                pstmt = koneksi.prepareStatement("UPDATE akun SET "
                                        + "nm_akun=?, "
                                        + "jenis_akun=?, "
                                        + "saldo_normal=? "
                                        + "WHERE kd_akun=?");
                                pstmt.setString(1, akun.getNm_akun());
                                pstmt.setString(2, akun.getJ_akun());
                                pstmt.setDouble(3, akun.getSaldo_normal());
                                pstmt.setString(4, akun.getKd_akun());

                                result = pstmt.executeUpdate();
                                if (result > 0) {
                                    out.println("<script> "
                                            + "alert('Data berhasil diperbaharui');"
                                            + "document.location='H_accounting.jsp?hal=akun';"
                                            + " </script>");
                                }
                            } else {
                                pstmt = koneksi.prepareStatement("INSERT INTO akun VALUES (?, ?, ?, ?)");
                                pstmt.setString(1, akun.getKd_akun());
                                pstmt.setString(2, akun.getNm_akun());
                                pstmt.setString(3, akun.getJ_akun());
                                pstmt.setDouble(4, akun.getSaldo_normal());

                                result = pstmt.executeUpdate();
                                if (result > 0) {
                                    out.println("<script> "
                                            + "alert('Data telah ditambahkan');"
                                            + "document.location='H_accounting.jsp?hal=akun';"
                                            + " </script>");
                                }
                            }
                        }
                        break;
                    case "Hapus":
                        pstmt = koneksi.prepareStatement("DELETE FROM akun WHERE kd_akun = ?");
                        pstmt.setString(1, akun.getKd_akun());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data Berhasil Dihapus');"
                                    + "document.location='H_accounting.jsp?hal=akun';"
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
            Logger.getLogger(A_akunServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(A_akunServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(A_akunServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(A_akunServlet.class.getName()).log(Level.SEVERE, null, ex);
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
