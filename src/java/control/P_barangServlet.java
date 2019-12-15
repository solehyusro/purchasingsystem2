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
import model.Barang;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "P_barangServlet", urlPatterns = {"/P_barangServlet"})
public class P_barangServlet extends HttpServlet {

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
        Barang brg = new Barang();
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
                brg.setKd_brg(request.getParameter("kd_brg"));
                brg.setNm_brg(request.getParameter("nm_brg"));

                switch (aksi) {
                    case "Simpan":
                        if (brg.getNm_brg().equals("")) {
                            out.println("<script>"
                                    + "alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!');"
                                    + "document.location='H_purchasing.jsp?hal=barang';"
                                    + "</script>");
                        }else {
                        brg.setStok(Integer.parseInt(request.getParameter("stok")));
                        pstmt = koneksi.prepareStatement("INSERT INTO barang VALUES (?, ?,  ?)");
                        pstmt.setString(1, brg.getKd_brg());
                        pstmt.setString(2, brg.getNm_brg());
                        pstmt.setInt(3, brg.getStok());

                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah ditambahkan');"
                                    + "document.location='H_purchasing.jsp?hal=barang';"
                                    + " </script>");
                        }
                        }
                        break;
                    case "Hapus":
                        pstmt = koneksi.prepareStatement("DELETE FROM barang WHERE kd_brg = ?");
                        pstmt.setString(1, brg.getKd_brg());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data Berhasil Dihapus');"
                                    + "document.location='H_purchasing.jsp?hal=barang';"
                                    + " </script>");
                        }
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
            Logger.getLogger(P_barangServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_barangServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(P_barangServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_barangServlet.class.getName()).log(Level.SEVERE, null, ex);
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
