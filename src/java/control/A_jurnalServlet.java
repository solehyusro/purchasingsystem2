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
import model.jurnal;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "A_jurnalServlet", urlPatterns = {"/A_jurnalServlet"})
public class A_jurnalServlet extends HttpServlet {

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

        jurnal jurnal = new jurnal();
        String URL = "jdbc:mysql://localhost:3306/ta_syahrur";
        String USERNAME = "root";
        String PASSWORD = "";
        Statement stmt = null;
        Connection koneksi = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        ResultSet rs = null;
        int result = 0;
        int result2 = 0;
        int result3 = 0;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            stmt = koneksi.createStatement();
            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                jurnal.setNo_jurnal(request.getParameter("no_j"));
                jurnal.setKd_admin(request.getParameter("id_admin"));
                jurnal.setNo_po(request.getParameter("no_po"));
                jurnal.setD_akun(request.getParameter("akun_d"));
                jurnal.setK_akun(request.getParameter("akun_k"));
                jurnal.setTgl(request.getParameter("tgl"));
                jurnal.setKet(request.getParameter("ket"));
                switch (aksi) {
                    case "Simpan":
                        jurnal.setDebet(Double.parseDouble(request.getParameter("nominal")));
                        jurnal.setKredit(Double.parseDouble(request.getParameter("nominal")));
                        if (jurnal.getTgl().equals("") || jurnal.getDebet()==0) {
                            out.println("<script>"
                                    + "alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!');"
                                    + "document.location='H_accounting.jsp?hal=jurnal';"
                                    + "</script>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO jurnal VALUES (?, ?, ?, ?, ?)");
                            pstmt.setString(1, jurnal.getNo_jurnal());
                            pstmt.setString(2, jurnal.getKd_admin());
                            pstmt.setString(3, jurnal.getKet());
                            pstmt.setString(4, jurnal.getTgl());
                            pstmt.setString(5, jurnal.getNo_po());
                            result = pstmt.executeUpdate();


                            pstmt2 = koneksi.prepareStatement("INSERT INTO jurnal_detail VALUES(?, ?, ?, 0)");
                            pstmt2.setString(1, jurnal.getNo_jurnal());
                            pstmt2.setString(2, jurnal.getD_akun());
                            pstmt2.setDouble(3, jurnal.getDebet());
                            result2 = pstmt2.executeUpdate();

                            pstmt3 = koneksi.prepareStatement("UPDATE akun SET saldo_normal= saldo_normal + ? WHERE kd_akun= ?");
                            pstmt3.setDouble(1, jurnal.getDebet());
                            pstmt3.setString(2, jurnal.getD_akun());
                            result3 = pstmt3.executeUpdate();

                            pstmt2 = koneksi.prepareStatement("INSERT INTO jurnal_detail VALUES(?, ?, 0, ?)");
                            pstmt2.setString(1, jurnal.getNo_jurnal());
                            pstmt2.setString(2, jurnal.getK_akun());
                            pstmt2.setDouble(3, jurnal.getKredit());
                            result2 = pstmt2.executeUpdate();

                            pstmt3 = koneksi.prepareStatement("UPDATE akun SET saldo_normal= saldo_normal + ? WHERE kd_akun= ?");
                            pstmt3.setDouble(1, jurnal.getKredit());
                            pstmt3.setString(2, jurnal.getK_akun());
                            result3 = pstmt3.executeUpdate();
                            if (result3 > 0) {
                                out.println("<script> "
                                        + "alert('Jurnal telah ditambahkan');"
                                        + "document.location='H_accounting.jsp?hal=jurnal';"
                                        + " </script>");
                            }
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
            Logger.getLogger(A_jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(A_jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(A_jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(A_jurnalServlet.class.getName()).log(Level.SEVERE, null, ex);
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
