<%@page import="java.sql.*, model.Pemesanan, model.Admin, model.Barang, model.Supplier"%>
<%
    Pemesanan pesan = new Pemesanan();
    Admin adm = new Admin();
    Barang brg = new Barang();
    Supplier supp = new Supplier();
    Connection koneksi = null;
    Statement stmt = null;
    Statement stmt2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/ta_syahrur",
                    "root", "");
    stmt = koneksi.createStatement();

    String kode = request.getParameter("kd_po");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM pemesanan"
                + " WHERE kd_po = '" + kode + "'");
        if (rs.next()) {
            pesan.setNo_po(rs.getString("no_po"));
            pesan.setKd_admin(rs.getString("kd_admin"));
            pesan.setKd_supp(rs.getString("no_po"));
            pesan.setKd_brg(rs.getString("kd_brg"));
            pesan.setTgl_po(rs.getString("tgl_po"));
            pesan.setByk_brg(Integer.parseInt(rs.getString("banyak_brg")));
            pesan.setHarga_satuan(Integer.parseInt(rs.getString("harga_satuan")));
            pesan.setStatus(rs.getString("status"));
        }
    }
%>

<div class="col-md-12">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title">Daftar Pemesanan</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        Kode Pemesanan
                    </th>
                    <th>
                        ID Admin
                    </th>
                    <th>
                        Kode Supplier
                    </th>
                    <th>
                        Kode Barang
                    </th>
                    <th>
                        Tanggal Pemesanan
                    </th>
                    <th>
                        Banyak Barang
                    </th>
                    <th>
                        Harga Satuan
                    </th>
                    <th>
                        Total
                    </th>
                    <th>
                        Status
                    </th>
                    <th>
                        Terima
                    </th>
                    <th>
                        Action
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM Pemesanan ORDER BY no_po");
                                if (!rs2.next()) {
                                    out.println("<tr>"
                                            + "<td colspan=9 align=center> "
                                            + "- Data Akun Kosong -"
                                            + "</td>"
                                            + "</tr>");
                                } else {
                                    rs2.beforeFirst();
                                    while (rs2.next()) {
                                        out.println("<tr>"
                                                + "<td>" + rs2.getString("no_po") + "</td>"
                                                + "<td>" + rs2.getString("kd_admin") + "</td>"
                                                + "<td>" + rs2.getString("kd_supp") + "</td>"
                                                + "<td>" + rs2.getString("kd_brg") + "</td>"
                                                + "<td>" + rs2.getString("tgl_po") + "</td>"
                                                + "<td>" + rs2.getString("banyak_brg") + "</td>"
                                                + "<td>" + rs2.getString("harga_satuan") + "</td>"
                                                + "<td>" + rs2.getString("total") + "</td>"
                                                + "<td>" + rs2.getString("status") + "</td>"
                                                + "<td>" + rs2.getString("terima") + "</td>"
                                                + "<td><a href='P_pembelianServlet?aksi=Terima&no_po="+ rs2.getString("no_po") +"'>Terima</a> | "
                                                + "<a href='P_pembelianServlet?aksi=Print&no_po="+ rs2.getString("no_po") +"'>Print</a></td>"
                                                + "</tr>");
                                    }
                                }
                            %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>