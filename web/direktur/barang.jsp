<%@page import="java.sql.*, model.Barang"%>
<%
    Barang brg = new Barang();
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

    String kode = request.getParameter("kd_brg");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM barang"
                + " WHERE kd_brg = '" + kode + "'");
        if (rs.next()) {
            brg.setKd_brg(rs.getString("kd_brg"));
            brg.setNm_brg(rs.getString("nm_brg"));
            brg.setStok(Integer.parseInt(rs.getString("stok")));
        }
    }
%>
<div class="col-md-12">
    <div class="card">
        <div class="row">
            <div class="update ml-auto mr-auto">
                <a href="cetakbarang.jsp" class="btn btn-primary btn-round">Print</a>
            </div>
        </div>
        <div class="card-header">
            <h4 class="card-title">Daftar Barang</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        Kode Barang
                    </th>
                    <th>
                        Nama
                    </th>
                    <th>
                        Stok
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM barang ORDER BY kd_brg");
                                if (!rs2.next()) {
                                    out.println("<tr>"
                                            + "<td colspan=4 align=center> "
                                            + "- Data Akun Kosong -"
                                            + "</td>"
                                            + "</tr>");
                                } else {
                                    rs2.beforeFirst();
                                    while (rs2.next()) {
                                        out.println("<tr>"
                                                + "<td>" + rs2.getString("kd_brg") + "</td>"
                                                + "<td>" + rs2.getString("nm_brg") + "</td>"
                                                + "<td>" + rs2.getString("stok") + "</td>"
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