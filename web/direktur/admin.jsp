<%@page import="java.sql.*, model.Admin"%>
<%
    Admin adm = new Admin();
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

    String kode = request.getParameter("id_admin");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM admin"
                + " WHERE id_admin = '" + kode + "'");
        if (rs.next()) {
            adm.setId_admin(rs.getString("id_admin"));
            adm.setPassword(rs.getString("password"));
            adm.setNama(rs.getString("nama"));
            adm.setAlamat(rs.getString("alamat"));
            adm.setNo_telp(rs.getString("no_telp"));
            adm.setHak_akses(rs.getString("hak_akses"));
        }
    }
%>

<div class="col-md-12">
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Tambah Admin</h5>
        </div>
        <div class="card-body">
            <form action="D_adminServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>ID Admin</label>
                            <%
                                if (kode != null) {
                                    out.println("<input type='hidden' name='id_admin' value='" + adm.getId_admin()+ "'/>");
                                    out.println("<input type='text' name='id_admin' class='form-control' disabled='' placeholder='Kode Supplier' value='" + adm.getId_admin()+ "'/>");
                                } else {
                                    try {
                                        ResultSet id_admin = null;
                                        Statement perintah = koneksi.createStatement();
                                        id_admin = perintah.executeQuery("Select max(right(id_admin,4)) as no FROM admin");
                                        while (id_admin.next()) {
                                            if (id_admin.first() == false) {
                                                out.println("<input type='text' name='id_admin' class='form-control' disabled='' placeholder='ID Admin' value='HEK0001'>");
                                            } else {
                                                id_admin.last();
                                                int autoid_admin = id_admin.getInt(1) + 1;
                                                String nomor_idadmin = String.valueOf(autoid_admin);
                                                int noLong = nomor_idadmin.length();

                                                for (int a = 1; a < 5 - noLong; a++) {
                                                    nomor_idadmin = "0" + nomor_idadmin;
                                                }
                                                String nomer_idadmin = "Hek" + nomor_idadmin;
                                                out.println("<input type='hidden' name='id_admin' value='" + nomer_idadmin + "'/>");
                                                out.println("<input type='text' name='id_admin' class='form-control' disabled='' placeholder='Kode Supplier' value='" + nomer_idadmin + "'/>");
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
                            <label>Nama</label>
                            <%if (kode != null) {%>
                            <input type="text" name="nm" class="form-control" placeholder="Nama" value="<%=adm.getNama()%>">
                            <% } else {%>
                            <input type="text" name="nm" class="form-control" placeholder="Nama" value="">
                            <%}%>
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Nomor Telpon</label>
                            <%if (kode != null) {%>
                            <input type="text" name="no_telp" value="<%=adm.getNo_telp()%>" class="form-control" placeholder="Nomor Telpon">
                            <% } else {%>
                            <input type="text" name="no_telp" class="form-control" placeholder="Nomor Telpon">
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Password</label>
                            <%if (kode != null) {%>
                            <input type="password" name="pass" value="<%=adm.getPassword()%>" class="form-control" placeholder="Password">
                            <% } else {%>
                            <input type="password" name="pass" class="form-control" placeholder="Password">
                            <%}%>
                        </div>
                    </div>
                        <div class="col-md-3">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Hak Akses</label>
                            <select name="h_ak" class="form-control select">
                                <%if (kode != null) {%>
                                <option  value="<%=adm.getHak_akses()%>" selected=""><%=adm.getHak_akses()%></option>
                                <% } %>
                                <option  value="Accounting">Accounting</option>
                                <option  value="Purchasing">Purchasing</option>
                                <option  value="Direktur">Direktur</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Alamat</label>
                            <%if (kode != null) {%>
                            <textarea name="a_admin" class="form-control textarea" placeholder="Alamat Anda..."><%=adm.getAlamat()%></textarea>
                            <% } else {%>
                            <textarea name="a_admin" class="form-control textarea" placeholder="Alamat Anda..."></textarea>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_direktur.jsp?hal=admin" class="btn btn-danger btn-round">Batal</a>
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
            <h4 class="card-title">Daftar Admin</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        ID Admin
                    </th>
                    <th>
                        Nama
                    </th>
                    <th>
                        Alamat
                    </th>
                    <th>
                        No. telpon
                    </th>
                    <th>
                        Hak Akses
                    </th>
                    <th>
                        Action
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM admin ORDER BY id_admin");
                                if (!rs2.next()) {
                                    out.println("<tr>"
                                            + "<td colspan=6 align=center> "
                                            + "- Data Akun Kosong -"
                                            + "</td>"
                                            + "</tr>");
                                } else {
                                    rs2.beforeFirst();
                                    while (rs2.next()) {
                                        out.println("<tr>"
                                                + "<td>" + rs2.getString("id_admin") + "</td>"
                                                + "<td>" + rs2.getString("nama") + "</td>"
                                                + "<td>" + rs2.getString("alamat") + "</td>"
                                                + "<td>" + rs2.getString("no_telp") + "</td>"
                                                + "<td>" + rs2.getString("hak_akses") + "</td>"
                                                + "<td><a href=D_adminServlet?aksi=Hapus&id_admin=" + rs2.getString("id_admin") + "><i class='nc-icon nc-simple-remove'></i></a> |"
                                                + "<a href=H_direktur.jsp?hal=admin&id_admin=" + rs2.getString("id_admin") + "><i class='nc-icon nc-share-66'></i></a></td>"
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