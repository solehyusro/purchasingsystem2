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

%>
<div class="col-md-12">
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Cetak</h5>
        </div>
        <div class="card-body">
            <form action="cetakbeli.jsp" method="post">
                <div class="row">
                    <div class="col-md-4 px-1">
                        <div class="form-group">
                            <label>Masukkan Bulan :</label>
                            <select name="bulan" class="form-control">
                                <option value="1">Januari</option>
                                <option value="2">Februari</option>
                                <option value="3">Maret</option>
                                <option value="4">April</option>
                                <option value="5">Mei</option>
                                <option value="6">Juni</option>
                                <option value="7">Juli</option>
                                <option value="8">Agustus</option>
                                <option value="9">September</option>
                                <option value="10">Oktober</option>
                                <option value="11">November</option>
                                <option value="12">Desember</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 pl-1">
                        <div class="form-group">
                            <label>Masukkan Tahun :</label>
                            <input type="text" name="tahun" class="form-control" placeholder="Tahun"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <input type="submit"class="btn btn-primary btn-round" value="Print">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title">Laporan Pembelian</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        Nomor Pemesanan
                    </th>
                    <th>
                        ID Admin
                    </th>
                    <th>
                        Nomor Pembelian
                    </th>
                    <th>
                        Nomor Faktur
                    </th>
                    <th>
                        Tanggal Pembelian
                    </th>
                    <th>
                        Kode Barang
                    </th>
                    <th>
                        Nama Barang
                    </th>
                    <th>
                        Banyak
                    </th>
                    
                    <th>
                        Total
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT "
                                        + "detail_pembelian.`kd_brg` AS no6, "
                                        + "detail_pembelian.`qty_beli` AS no8, "
                                        + "detail_pembelian.`sub_beli` AS no10, "
                                        + "(detail_pembelian.`sub_beli`/detail_pembelian.`qty_beli`) AS no9, "
                                        + "pembelian.`no_beli` AS no3, "
                                        + "pembelian.`tgl_beli` AS no5, "
                                        + "pembelian.`no_faktur` AS no4, "
                                        + "pembelian.`no_pesan` AS no1, "
                                        + "pembelian.`id_admin` AS no2, "
                                        + "barang.`nm_brg` AS no7 "
                                        + "FROM "
                                        + "`pembelian` pembelian INNER JOIN `detail_pembelian` detail_pembelian ON pembelian.`no_beli` = detail_pembelian.`no_beli` "
                                        + "INNER JOIN `admin` admin ON pembelian.`id_admin` = admin.`id_admin` "
                                        + "INNER JOIN `barang` barang ON detail_pembelian.`kd_brg` = barang.`kd_brg`");
                                if (!rs2.next()) {
                                    out.println("<tr>"
                                            + "<td colspan=10 align=center> "
                                            + "- Data Akun Kosong -"
                                            + "</td>"
                                            + "</tr>");
                                } else {
                                    rs2.beforeFirst();
                                    while (rs2.next()) {
                                        out.println("<tr>"
                                                + "<td>" + rs2.getString("no1") + "</td>"
                                                + "<td>" + rs2.getString("no2") + "</td>"
                                                + "<td>" + rs2.getString("no3") + "</td>"
                                                + "<td>" + rs2.getString("no4") + "</td>"
                                                + "<td>" + rs2.getString("no5") + "</td>"
                                                + "<td>" + rs2.getString("no6") + "</td>"
                                                + "<td>" + rs2.getString("no7") + "</td>"
                                                + "<td>" + rs2.getString("no8") + "</td>"
                                                
                                                + "<td>" + rs2.getString("no10") + "</td>"
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