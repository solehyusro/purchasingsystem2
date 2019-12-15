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
import model.Pemesanan;
import model.pesen;
import model.Pembayaran;

/**
 *
 * @author USER PC
 */
@WebServlet(name = "P_pembelianServlet", urlPatterns = {"/P_pembelianServlet"})
public class P_pembelianServlet extends HttpServlet {

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
        Pemesanan pesan = new Pemesanan();
        pesen psn = new pesen();
        Pembayaran bayar = new Pembayaran();
        Pemesanan validatin = new Pemesanan();
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
            Class.forName("com.mysql.jdbc.Driver");
            koneksi = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            stmt = koneksi.createStatement();
            String aksi = request.getParameter("aksi");
            if (aksi != null) {
                pesan.setNo_po(request.getParameter("no_po"));
                pesan.setKd_admin(request.getParameter("id_admin"));
                pesan.setKd_supp(request.getParameter("kd_supp"));
                pesan.setKd_brg(request.getParameter("kd_brg"));
                pesan.setTgl_po(request.getParameter("tgl_po"));
                pesan.setStatus(request.getParameter("status"));
                bayar.setNo_byr(request.getParameter("no_byr"));
                bayar.setNo_po(request.getParameter("no_po"));
                bayar.setId_admin(request.getParameter("id_admin"));
                bayar.setTgl_byr(request.getParameter("tgl_byr"));
                switch (aksi) {
                    case "Simpan":

                        pesan.setByk_brg(Integer.parseInt(request.getParameter("byk_brg")));
                        pesan.setHarga_satuan(Integer.parseInt(request.getParameter("h_satuan")));
                        pesan.setTotal(Integer.parseInt(request.getParameter("total")));
                        if (pesan.getTgl_po().equals("") || pesan.getByk_brg() == 0 || pesan.getTotal() == 0 || pesan.getHarga_satuan() == 0) {
                            out.println("<script>"
                                    + "alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!');"
                                    + "document.location='H_purchasing.jsp?hal=pemesanan';"
                                    + "</script>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO pemesanan VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, 'x', 'x')");
                            pstmt.setString(1, pesan.getNo_po());
                            pstmt.setString(2, pesan.getKd_admin());
                            pstmt.setString(3, pesan.getKd_supp());
                            pstmt.setString(4, pesan.getKd_brg());
                            pstmt.setString(5, pesan.getTgl_po());
                            pstmt.setInt(6, pesan.getByk_brg());
                            pstmt.setInt(7, pesan.getHarga_satuan());
                            pstmt.setInt(8, pesan.getTotal());
                            pstmt.setString(9, pesan.getStatus());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='H_purchasing.jsp?hal=pemesanan';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Bayar":
                        bayar.setTotal(Double.parseDouble(request.getParameter("total")));
                        if (bayar.getTgl_byr().equals("") || bayar.getTotal() == 0) {
                            out.println("<script>"
                                    + "alert('Gagal... masih ada data yang belum terisi, Silahkan Ulangi!!!');"
                                    + "document.location='H_purchasing.jsp?hal=pembayaran';"
                                    + "</script>");
                        } else {
                            pstmt = koneksi.prepareStatement("INSERT INTO pembayaran VALUES(?, ?, ?, ?, ?)");
                            pstmt.setString(1, bayar.getNo_byr());
                            pstmt.setString(2, bayar.getNo_po());
                            pstmt.setString(3, bayar.getId_admin());
                            pstmt.setString(4, bayar.getTgl_byr());
                            pstmt.setDouble(5, bayar.getTotal());

                            result = pstmt.executeUpdate();
                            if (result > 0) {
                                out.println("<script> "
                                        + "alert('Data telah ditambahkan');"
                                        + "document.location='H_accounting.jsp?hal=bayar';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Terima":
                        rs = stmt.executeQuery("SELECT * FROM pemesanan WHERE no_po = '" + pesan.getNo_po() + "'");
                        if (rs.next()) {
                            validatin.setByk_brg(rs.getInt("banyak_brg"));
                            validatin.setKd_brg(rs.getString("kd_brg"));
                            validatin.setStatus(rs.getString("terima"));
                        }
                        if (validatin.getStatus().equals("v")) {
                            out.println("<script> "
                                    + "alert('Maaf... Barang ini sudah diterima');"
                                    + "document.location='H_purchasing.jsp?hal=terima';"
                                    + " </script>");
                        } else {
                            pstmt = koneksi.prepareStatement("UPDATE pemesanan SET terima = 'v' WHERE no_po= ? ");
                            pstmt.setString(1, pesan.getNo_po());
                            result = pstmt.executeUpdate();

                            pstmt2 = koneksi.prepareStatement("UPDATE barang SET stok= stok + ? WHERE kd_brg= ? ");
                            pstmt2.setInt(1, validatin.getByk_brg());
                            pstmt2.setString(2, validatin.getKd_brg());
                            result2 = pstmt2.executeUpdate();
                            if (result2 > 0) {
                                out.println("<script> "
                                        + "alert('Data Telah Diperbaharui');"
                                        + "document.location='H_purchasing.jsp?hal=terima';"
                                        + " </script>");
                            }
                        }
                        break;
                    case "Print":
                        rs = stmt.executeQuery("SELECT * FROM pemesanan WHERE no_po = '" + pesan.getNo_po() + "'");
                        if (rs.next()) {
                            validatin.setStatus(rs.getString("terima"));
                        }
                        if (validatin.getStatus().equals("x")) {
                            out.println("<script> "
                                    + "alert('Maaf... Barang ini belum diterima');"
                                    + "document.location='H_purchasing.jsp?hal=terima';"
                                    + " </script>");
                        } else {
                            out.println("<script> "
                                    + "document.location='cetakterima.jsp?no_po=" + pesan.getNo_po() + "';"
                                    + " </script>");
                        }
                    case "Delete":
                        psn.setKdbarang(request.getParameter("kode"));
                        pstmt = koneksi.prepareStatement("DELETE FROM sementara WHERE kode= ?");
                        pstmt.setString(1, psn.getKdbarang());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah dihapus');"
                                    + "document.location='H_purchasing.jsp?hal=pemesanan';"
                                    + " </script>");
                        }
                        break;
                    case "Tambah":
                        psn.setNopesan(request.getParameter("no_pesan"));
                        psn.setKdbarang(request.getParameter("semp_id"));
                        psn.setQty(Integer.parseInt(request.getParameter("jml")));
                        psn.setSubtotal(Double.parseDouble(request.getParameter("sub")));
                        pstmt = koneksi.prepareStatement("INSERT INTO sementara values(?, ?, ?, ?)");
                        pstmt.setString(1, psn.getNopesan());
                        pstmt.setString(2, psn.getKdbarang());
                        pstmt.setInt(3, psn.getQty());
                        pstmt.setDouble(4, psn.getSubtotal());
                        result = pstmt.executeUpdate();
                        if (result > 0) {
                            out.println("<script> "
                                    + "alert('Data telah ditambahkan');"
                                    + "document.location='H_purchasing.jsp?hal=pemesanan';"
                                    + " </script> ");
                        }
                        break;
                    case "simpan":
                        psn.setNopesan(request.getParameter("no_pesan"));
                        psn.setTglpesan(request.getParameter("tanggal"));
                        psn.setKdsupplier(request.getParameter("supplier"));
                        psn.setTotal(Integer.parseInt(request.getParameter("tobay")));
                        pstmt = koneksi.prepareStatement("INSERT detail_pesan SELECT ?, kode, quantity, subtotal FROM sementara");
                        pstmt.setString(1, psn.getNopesan());
                        result = pstmt.executeUpdate();
                        pstmt1 = koneksi.prepareStatement("INSERT INTO pemesanan values(?, ?, ?, ?, ?)");
                        pstmt1.setString(1, psn.getNopesan());
                        pstmt1.setString(2, psn.getTglpesan());
                        pstmt1.setInt(3, psn.getTotal());
                        pstmt1.setString(4, psn.getKdsupplier());
                        pstmt1.setString(5, bayar.getId_admin());
                        result1 = pstmt1.executeUpdate();
                        pstmt2 = koneksi.prepareStatement("TRUNCATE TABLE sementara");
                        result2 = pstmt2.executeUpdate();
                        if (result + result1 + result2 > 0) {
                            out.println("<script> "
                                    + "alert('Data telah disimpan');"
                                    + "document.location='H_purchasing.jsp?hal=pemesanan';"
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
            Logger.getLogger(P_pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(P_pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(P_pembelianServlet.class.getName()).log(Level.SEVERE, null, ex);
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
