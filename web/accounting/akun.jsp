<%@page import="java.sql.*, model.akun"%>
<%
    akun akun = new akun();
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

    String kode = request.getParameter("kd_akun");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM akun"
                + " WHERE kd_akun = '" + kode + "'");
        if (rs.next()) {
            akun.setKd_akun(rs.getString("kd_akun"));
            akun.setNm_akun(rs.getString("nm_akun"));
            akun.setJ_akun(rs.getString("jenis_akun"));
            akun.setSaldo_normal(Double.parseDouble(rs.getString("saldo_normal")));
        }
    }
%>

<div class="col-md-12">
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Tambah Akun</h5>
        </div>
        <div class="card-body">
            <form action="A_akunServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>Kode Akun</label>
                            <%if (kode != null) {%>
                            <input type="text" name="kd_akun" class="form-control" readonly="" placeholder="Kode Akun" value="<%=akun.getKd_akun()%>"/>
                            <% } else {%>
                            <input type="text" name="kd_akun" class="form-control" placeholder="Kode Akun" value=""/>
                            <%}%>
                        </div>
                    </div>
                    <div class="col-md-3 px-1">
                        <div class="form-group">
                            <label>Nama Akun</label>
                            <%if (kode != null) {%>
                            <input type="text" name="nm_akun" class="form-control" placeholder="Nama Akun" value="<%=akun.getNm_akun()%>">
                            <% } else {%>
                            <input type="text" name="nm_akun" class="form-control" placeholder="Nama Akun" value="">
                            <%}%>
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Jenis Akun</label>
                            <select name="j_akun" class="form-control select">
                                <%if (kode != null) {%>
                                <option  value="<%=akun.getJ_akun()%>" selected=""><%=akun.getJ_akun()%></option>
                                <% } %>
                                <option  value="Harta">Harta</option>
                                <option  value="Hutang">Hutang</option>
                                <option  value="Modal">Modal</option>
                                <option  value="Penjualan">Penjualan</option>
                                <option  value="Pembelian">Pembelian</option>
                                <option  value="Biaya">Biaya</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Saldo Normal</label>
                            <%if (kode != null) {%>
                            <input type="number" name="sn" class="form-control" placeholder="Saldo Normal" value="<%=akun.getSaldo_normal()%>">
                            <% } else {%>
                            <input type="number" name="sn" class="form-control" placeholder="Saldo Normal" id="saldo">
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_accounting.jsp?hal=akun" class="btn btn-danger btn-round">Batal</a>
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
            <h4 class="card-title">Daftar Akun</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        Kode Akun
                    </th>
                    <th>
                        Nama Akun
                    </th>
                    <th>
                        Jenis Akun
                    </th>
                    <th>
                        Saldo Normal
                    </th>
                    <th>
                        Action
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM akun ORDER BY kd_akun");
                                if (!rs2.next()) {
                                    out.println("<tr>"
                                            + "<td colspan=5 align=center> "
                                            + "- Data Akun Kosong -"
                                            + "</td>"
                                            + "</tr>");
                                } else {
                                    rs2.beforeFirst();
                                    while (rs2.next()) {
                                        out.println("<tr>"
                                                + "<td>" + rs2.getString("kd_akun") + "</td>"
                                                + "<td>" + rs2.getString("nm_akun") + "</td>"
                                                + "<td>" + rs2.getString("jenis_akun") + "</td>"
                                                + "<td>" + rs2.getString("saldo_normal") + "</td>"
                                                + "<td><a href=A_akunServlet?aksi=Hapus&kd_akun=" + rs2.getString("kd_akun") + "><i class='nc-icon nc-simple-remove'></i></a> |"
                                                + "<a href=H_accounting.jsp?hal=akun&kd_akun=" + rs2.getString("kd_akun") + "><i class='nc-icon nc-share-66'></i></a></td>"
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
    document.getElementById("saldo").value = 0;
</script>