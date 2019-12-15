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
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Tambah Barang</h5>
        </div>
        <div class="card-body">
            <form action="P_barangServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>Kode Barang</label>
                            <%
                                if (kode != null) {
                                    out.println("<input type='hidden' name='kd_brg' value='" + brg.getKd_brg() + "'/>");
                                    out.println("<input type='text' name='kd_brg' class='form-control' disabled='' placeholder='Kode Supplier' value='" + brg.getKd_brg() + "'/>");
                                } else {
                                    try {
                                        ResultSet kd_brg = null;
                                        Statement perintah = koneksi.createStatement();
                                        kd_brg = perintah.executeQuery("Select max(right(kd_brg,4)) as no FROM barang");
                                        while (kd_brg.next()) {
                                            if (kd_brg.first() == false) {
                                                out.println("<input type='text' name='kd_brg' class='form-control' disabled='' placeholder='Kode Barang' value='BRG0001'>");
                                            } else {
                                                kd_brg.last();
                                                int autokd_brg = kd_brg.getInt(1) + 1;
                                                String nomor_kdbrg = String.valueOf(autokd_brg);
                                                int noLong = nomor_kdbrg.length();

                                                for (int a = 1; a < 5 - noLong; a++) {
                                                    nomor_kdbrg = "0" + nomor_kdbrg;
                                                }
                                                String nomer_kdbrg = "BRG" + nomor_kdbrg;
                                                out.println("<input type='hidden' name='kd_brg' value='" + nomer_kdbrg + "'/>");
                                                out.println("<input type='text' name='kd_brg' class='form-control' disabled='' placeholder='Kode Supplier' value='" + nomer_kdbrg + "'/>");
                                            }
                                        }
                                    } catch (Exception e) {
                                        out.println(e);
                                    }
                                }
                            %>
                        </div>
                    </div>
                    <div class="col-md-6 px-1">
                        <div class="form-group">
                            <label>Nama Barang</label>
                            <%if (kode != null) {%>
                            <input type="text" name="nm_brg" class="form-control" placeholder="Nama Barang" value="<%=brg.getNm_brg()%>">
                            <% } else {%>
                            <input type="text" name="nm_brg" class="form-control" placeholder="Nama Barang" value="">
                            <%}%>
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Stok</label>
                            <%if (kode != null) {%>
                            <input type="number" name="stok" value="<%=brg.getStok()%>" class="form-control" placeholder="Stok">
                            <% } else {%>
                            <input type="number" id="ename" name="stok" class="form-control" placeholder="Stok">
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_purchasing.jsp?hal=barang" class="btn btn-danger btn-round">Batal</a>
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
                    <th>
                        Action
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
                                                + "<td><a href=P_barangServlet?aksi=Hapus&kd_brg=" + rs2.getString("kd_brg") + "><i class='nc-icon nc-simple-remove'></i></a></td>"
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
    document.getElementById("ename").value = 0;
</script>