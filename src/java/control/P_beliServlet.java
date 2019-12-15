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
import model.beli;
import model.Pembayaran;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "P_beliServlet", urlPatterns = {"/P_beliServlet"})
public class P_beliServlet extends HttpServlet {

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
        String URL = "jdbc:mysql://localhost:3306/ta_syahrur";
        String USERNAME = "root";
        String PASSWORD = "";
        Statement stmt = null;
        Connection koneksi = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        ResultSet rs = null;
        int result = 0;
        int result1 = 0;
        int result2 = 0;
        int result3 = 0;
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            beli pembelian = new beli();
            Pembayaran bayar = new Pembayaran();
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            stmt = koneksi.createStatement();
            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                switch (aksi) {
                    case "Simpan":
                        pembelian.setNobeli(request.getParameter("no_beli"));
                        pembelian.setTglbeli(request.getParameter("tanggal"));
                        pembelian.setNofaktur(request.getParameter("no_faktur"));
                        pembelian.setNopesan(request.getParameter("nomor"));
                        pembelian.setTotbeli(Integer.parseInt(request.getParameter("totbeli")));                      
                        bayar.setId_admin(request.getParameter("id_admin"));
                        pstmt=koneksi.prepareStatement("INSERT into detail_pembelian SELECT ?, kd_brg, qty_pesan, subtotal FROM detail_pesan where no_pesan= ?");
                        pstmt.setString(1, pembelian.getNobeli());
                        pstmt.setString(2, pembelian.getNopesan());
                        result=pstmt.executeUpdate();      
                        pstmt1 = koneksi.prepareStatement("INSERT INTO pembelian VALUES (?, ?, ?, ?, ?, ?)");
                        pstmt1.setString(1, pembelian.getNobeli());
                        pstmt1.setString(2, pembelian.getTglbeli());
                        pstmt1.setString(3, pembelian.getNofaktur());
                        pstmt1.setInt(4, pembelian.getTotbeli());
                        pstmt1.setString(5, pembelian.getNopesan());
                        pstmt1.setString(6, bayar.getId_admin());
                        result1 = pstmt1.executeUpdate();
                            if (result + result1 > 0) {
                                out.println("<script> "
                                        + "alert('Data telah disimpan');"
                                        + "document.location='H_purchasing.jsp?hal=beli';"
                                        + " </script>");
                            }                       
                        break;
                    default:
                }
            } else {
                out.println("<script> "
                        + "alert('Gagal Eksekusi');"
                        + "document.location='H_purchasing.jsp?hal=beli';"
                        + " </script>");
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
            Logger.getLogger(P_beliServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_beliServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(P_beliServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_beliServlet.class.getName()).log(Level.SEVERE, null, ex);
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
