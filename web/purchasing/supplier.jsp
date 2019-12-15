<%@page import="java.sql.*, model.Supplier"%>
<%
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

    String kode = request.getParameter("kd_supp");
    if (kode != null) {
        rs = stmt.executeQuery("SELECT * FROM supplier"
                + " WHERE kd_supp = '" + kode + "'");
        if (rs.next()) {
            supp.setKd_supp(rs.getString("kd_supp"));
            supp.setNm_supp(rs.getString("nm_supp"));
            supp.setA_supp(rs.getString("alamat"));
            supp.setNp_supp(rs.getString("no_telp"));
        }
    }
%>

<div class="col-md-12">
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Tambah Supplier</h5>
        </div>
        <div class="card-body">
            <form action="P_supplierServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>Kode Supplier</label>
                            <%
                                if (kode != null) {
                                    out.println("<input type='hidden' name='kd_supp' value='" + supp.getKd_supp() + "'/>");
                                    out.println("<input type='text' name='kd_supp' class='form-control' disabled='' placeholder='Kode Supplier' value='" + supp.getKd_supp() + "'/>");
                                } else {
                                    try {
                                        ResultSet kd_supp = null;
                                        Statement perintah = koneksi.createStatement();
                                        kd_supp = perintah.executeQuery("Select max(right(kd_supp,4)) as no FROM supplier");
                                        while (kd_supp.next()) {
                                            if (kd_supp.first() == false) {
                                                out.println("<input type='text' name='kd_supp' class='form-control' disabled='' placeholder='Kode Supplier' value='SUP0001'>");
                                            } else {
                                                kd_supp.last();
                                                int autokd_supp = kd_supp.getInt(1) + 1;
                                                String nomor_kdsupp = String.valueOf(autokd_supp);
                                                int noLong = nomor_kdsupp.length();

                                                for (int a = 1; a < 5 - noLong; a++) {
                                                    nomor_kdsupp = "0" + nomor_kdsupp;
                                                }
                                                String nomer_kdsupp = "SUP" + nomor_kdsupp;
                                                out.println("<input type='hidden' name='kd_supp' value='" + nomer_kdsupp + "'/>");
                                                out.println("<input type='text' name='kd_supp' class='form-control' disabled='' placeholder='Kode Supplier' value='" + nomer_kdsupp + "'/>");
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
                            <label>Nama Supplier</label>
                            <%if (kode != null) {%>
                            <input type="text" name="nm_supp" class="form-control" placeholder="Nama Supplier" value="<%=supp.getNm_supp()%>">
                            <% } else {%>
                            <input type="text" name="nm_supp" class="form-control" placeholder="Nama Supplier" value="">
                            <%}%>
                        </div>
                    </div>
                    <div class="col-md-3 pl-1">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Nomor Telpon</label>
                            <%if (kode != null) {%>
                            <input type="text" name="nt_supp" value="<%=supp.getNp_supp()%>" class="form-control" placeholder="Nomor Telpon">
                            <% } else {%>
                            <input type="text" name="nt_supp" class="form-control" placeholder="Nomor Telpon">
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Alamat</label>
                            <%if (kode != null) {%>
                            <textarea name="a_supp" class="form-control textarea" placeholder="Alamat Anda..."><%=supp.getA_supp()%></textarea>
                            <% } else {%>
                            <textarea name="a_supp" class="form-control textarea" placeholder="Alamat Anda..."></textarea>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_purchasing.jsp?hal=supplier" class="btn btn-danger btn-round">Batal</a>
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
                <a href="cetaksupp.jsp" class="btn btn-primary btn-round">Print</a>
            </div>
        </div>
        <div class="card-header">
            <h4 class="card-title">Daftar Supplier</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        Kode Supplier
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
                        Action
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM supplier ORDER BY kd_supp");
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
                                                + "<td>" + rs2.getString("kd_supp") + "</td>"
                                                + "<td>" + rs2.getString("nm_supp") + "</td>"
                                                + "<td>" + rs2.getString("alamat") + "</td>"
                                                + "<td>" + rs2.getString("no_telp") + "</td>"
                                                + "<td><a href=P_supplierServlet?aksi=Hapus&kd_supp=" + rs2.getString("kd_supp") + "><i class='nc-icon nc-simple-remove'></i></a> |"
                                                + "<a href=H_purchasing.jsp?hal=supplier&kd_supp=" + rs2.getString("kd_supp") + "><i class='nc-icon nc-share-66'></i></a></td>"
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