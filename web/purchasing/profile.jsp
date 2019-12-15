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
        }
    }
%>
<div class="col-md-12">
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Profile</h5>
        </div>
        <div class="card-body">
            <form action="profileServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>ID Admin</label>
                            <input type="text" name="id_admin" id="id" class="form-control" readonly="" placeholder="ID Admin"/>
                        </div>
                    </div>
                    <div class="col-md-6 px-1">
                        <div class="form-group">
                            <label>Nama</label>
                            <input type="text" name="nm" id="nm" class="form-control" placeholder="Nama">
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Nomor Telpon</label>
                            <input type="text" name="no_telp" id="telp" class="form-control" placeholder="Nomor Telpon">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Password</label>
                            <input type="password" name="pass" id="pass" class="form-control" placeholder="Password">
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label>Alamat</label>
                            <textarea name="a_admin" id="alamat" class="form-control textarea" placeholder="Alamat Anda..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_purchasing.jsp?hal=profile" class="btn btn-danger btn-round">Batal</a>
                    </div>
                    <div class="update ml-auto mr-auto">
                        <input type="submit" name="aksi" value="Update" class="btn btn-primary btn-round">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    document.getElementById("id").value = localStorage.getItem("kode");
    document.getElementById("nm").value = localStorage.getItem("nama");
    document.getElementById("telp").value = localStorage.getItem("telp");
    document.getElementById("pass").value = localStorage.getItem("pass");
    document.getElementById("alamat").value = localStorage.getItem("alamat");
</script>