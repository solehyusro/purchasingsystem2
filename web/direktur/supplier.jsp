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