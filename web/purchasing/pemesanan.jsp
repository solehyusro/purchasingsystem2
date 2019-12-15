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
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Tambah Pemesanan</h5>
        </div>
        <div class="card-body">
            <form action="P_pembelianServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>Kode Pemesanan</label>
                            <%
                                try {
                                    ResultSet no_po = null;
                                    Statement perintah = koneksi.createStatement();
                                    no_po = perintah.executeQuery("Select max(right(no_po,4)) as no FROM pemesanan");
                                    while (no_po.next()) {
                                        if (no_po.first() == false) {
                                            out.println("<input type='text' name='no_po' class='form-control' disabled='' placeholder='No Pemesanan' value='PSN0001'>");
                                        } else {
                                            no_po.last();
                                            int autono_po = no_po.getInt(1) + 1;
                                            String nomor_nopo = String.valueOf(autono_po);
                                            int noLong = nomor_nopo.length();

                                            for (int a = 1; a < 5 - noLong; a++) {
                                                nomor_nopo = "0" + nomor_nopo;
                                            }
                                            String nomer_nopo = "PSN" + nomor_nopo;
                                            out.println("<input type='hidden' name='no_po' value='" + nomer_nopo + "'/>");
                                            out.println("<input type='text' name='no_po' class='form-control' disabled='' placeholder='No Pemesanan' value='" + nomer_nopo + "'/>");
                                        }
                                    }
                                } catch (Exception e) {
                                    out.println(e);
                                }
                            %>
                        </div>
                    </div>
                    <div class="col-md-3 px-1">
                        <div class="form-group">
                            <label>ID Admin</label>
                            <input type="text" name="id_admin" id="id" class="form-control" readonly="" placeholder="ID Admin"/>
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Kode Supplier</label>
                            <select name="kd_supp" class="form-control select">
                                <%
                                    ResultSet kd_supp = null;
                                    kd_supp = stmt.executeQuery("SELECT * FROM supplier");
                                    while (kd_supp.next()) {
                                        supp.setKd_supp(kd_supp.getString("kd_supp"));
                                        supp.setNm_supp(kd_supp.getString("nm_supp"));
                                %>
                                <option value="<%=supp.getKd_supp()%>"><%=supp.getKd_supp()%> <%=supp.getNm_supp()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Kode Barang</label>
                            <select name="kd_brg" class="form-control select">
                                <%
                                    ResultSet kd_brg = null;
                                    kd_brg = stmt.executeQuery("SELECT * FROM barang");
                                    while (kd_brg.next()) {
                                        brg.setKd_brg(kd_brg.getString("kd_brg"));
                                        brg.setNm_brg(kd_brg.getString("nm_brg"));
                                %>
                                <option value="<%=brg.getKd_brg()%>"><%=brg.getKd_brg()%> <%=brg.getNm_brg()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Tanggal Pemesanan</label>
                            <input type="date" name="tgl_po" class="form-control">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Banyak Barang</label>
                            <input type="number" name="byk_brg" class="form-control"  id="byk" onchange="jumlah()">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Harga Satuan</label>
                            <input type="number" name="h_satuan" class="form-control" id="harga" onchange="jumlah()">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Total</label>
                            <input type="number" name="total" class="form-control" id="total">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Status</label>
                            <select name="status" class="form-control select">
                                <option value="Belum Lunas">Belum Lunas</option>
                                <option value="Lunas">Lunas</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_purchasing.jsp?hal=pemesanan" class="btn btn-danger btn-round">Batal</a>
                    </div>
                    <div class="update ml-auto mr-auto">
                        <input type="submit" name="aksi" value="Simpan" class="btn btn-primary btn-round">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
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
                                                + "<td><a href='cetakpo.jsp?no_po=" + rs2.getString("no_po") + "'>Print</a></td>"
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
<script type="text/javascript">
    document.getElementById("id").value = localStorage.getItem("kode");
    document.getElementById("byk").value = 0;
    document.getElementById("harga").value = 0;
    document.getElementById("total").value = 0;
</script>
<script type="text/javascript">
    function jumlah() {
        var harga = document.getElementById("harga").value;
        var byk = document.getElementById("byk").value;
        var total = harga * byk;
        document.getElementById("total").value = total;
    }
</script>
