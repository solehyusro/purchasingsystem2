<%@page import="java.sql.*, model.Pemesanan, model.Admin, model.Barang, model.Supplier"%>
<%@taglib prefix="c"uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql"uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:setDataSource var="dataSource"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/ta_syahrur"
                   user="root"password=""/>
<%
    Pemesanan pesan = new Pemesanan();
    Admin adm = new Admin();
    Barang brg = new Barang();
    Supplier supp = new Supplier();
    Connection koneksi = null;
    Statement stmt = null;
    Statement stmt2 = null;
    ResultSet rs3 = null;
    ResultSet rs2 = null;
    Class.forName("com.mysql.jdbc.Driver");
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/ta_syahrur",
                    "root", "");
    stmt = koneksi.createStatement();

    String kode = request.getParameter("kd_po");
    if (kode != null) {
        rs3 = stmt.executeQuery("SELECT * FROM pemesanan"
                + " WHERE kd_po = '" + kode + "'");
        if (rs3.next()) {
            pesan.setNo_po(rs3.getString("no_po"));
            pesan.setKd_admin(rs3.getString("kd_admin"));
            pesan.setKd_supp(rs3.getString("no_po"));
            pesan.setKd_brg(rs3.getString("kd_brg"));
            pesan.setTgl_po(rs3.getString("tgl_po"));
            pesan.setByk_brg(Integer.parseInt(rs3.getString("banyak_brg")));
            pesan.setHarga_satuan(Integer.parseInt(rs3.getString("harga_satuan")));
            pesan.setStatus(rs3.getString("status"));
        }
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% java.util.Date waktu = new java.util.Date();
    int tanggal = waktu.getDate();
    int tahun = waktu.getYear() + 1900;
    int bulan = waktu.getMonth() + 1;
    String tgl = tahun + "-" + bulan + "-" + tanggal;
%>
<%
    ResultSet rs = null;
    ResultSet qrybarang = null;
    ResultSet qrypemesanan = null;
%>
<sql:query var="ttl" dataSource="${dataSource}">
        SELECT SUM(quantity) AS ttl_D,
        SUM(subtotal) AS ttl_K FROM sementara
    </sql:query>
    <h1>Transaksi Pemesanan Barang</h1></br>
    <form action="P_pembelianServlet" method="post">
        <pre>
No Pesan       <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    ResultSet nopesan = null;
                    nopesan = stmt.executeQuery("select max(right(no_pesan,4)) as no FROM pemesanan");
                    while (nopesan.next()) {
                        if (nopesan.first() == false) {
                            out.println("<input type='text' class='form-control' id='inputpesan' readonly value='PS000001' name='no_pesan'>");
                        } else {
                            nopesan.last();
                            int autopesan = nopesan.getInt(1) + 1;
                            String nomorpesan = String.valueOf(autopesan);
                            int noLong = nomorpesan.length();

                            for (int a = 1; a < 6 - noLong; a++) {
                                nomorpesan = "0" + nomorpesan;
                            }
                            String nomerpesan = "PS" + nomorpesan;
                            out.println("<input type='text' class='form-control' id='inputpesan' readonly value='" + nomerpesan + "' name='no_pesan'>");
                            out.println("<input type='hidden' name='no_pesan' value='" + nomerpesan + "'/>");
                        }
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            %>
ID Admin       <input type="text" name="id_admin" id="id" class="form-control" readonly="" placeholder="ID Admin"/>
Tanggal Pesan  <input type="text" name="tanggal" readonly="" value =<%= tgl%> ></br>
Supplier       <select name="supplier">
                <option value="-1">Pilih Supplier</option>
                <%
                    rs = stmt.executeQuery("SELECT * from supplier ");
                    while (rs.next()) {
                        supp.setKd_supp(rs.getString("kd_supp"));
                        supp.setNm_supp(rs.getString("nm_supp"));
                %>
                            <option value="<%=supp.getKd_supp()%>"><%=supp.getKd_supp()%> || <%=supp.getNm_supp()%></option>
                <%  } %>
                </select><br>
Barang         <select name="semp_id" onchange="showEmp(this.value);">
                            <option value="-1">Pilih Barang</option> 
                <%
                    rs = stmt.executeQuery("SELECT * from barang ");
                    while (rs.next()) {
                        brg.setKd_brg(rs.getString("kd_brg"));
                        brg.setNm_brg(rs.getString("nm_brg"));
                %>
                            <option value="<%=brg.getKd_brg()%>"><%=brg.getKd_brg()%> || <%=brg.getNm_brg()%></option>
                <%  } %>
                        </select>
<input  type="hidden" name="emp_id" id="emp_id" value="">
Harga Barang   <input  type="text" name="emp_name" id="ename" value="" onkeyup="sum();"></br>
Jumlah Pesan   <input type="text" name="jml" id="jml" onkeyup="sum();"></br>
Subtotal       <input type="text" name="sub" id="subtotal" readonly="readonly"></br>
<script>
                function sum() {
                    var txtFirstNumberValue = document.getElementById('ename').value;
                    var txtSecondNumberValue = document.getElementById('jml').value;
                    var result = parseFloat(txtFirstNumberValue) * parseFloat(txtSecondNumberValue);
                    if (!isNaN(result)) {
                        document.getElementById('subtotal').value = result;
                    }
                }                                                                                                                                                                                    </script>
<input type="submit" value="Tambah" name="aksi"></br>
<table width="500" height="150" border="0" align="center">
    <tr align="center">
        <td colspan="3"><h3>Data Barang Untuk Dipesan</h3></td>
    </tr>
    <tr>
      <th>Nomor</th>
      <th>Kode Barang</th>
      <th>Quantity</th>
      <th>Subtotal</th>
      <th>AKSI</th>
    </tr>
                <%
                    int no = 1;
                    rs = stmt.executeQuery("SELECT * from sementara");
                    while (rs.next()) {
                        out.println("<tr class=isi>"
                                + "<td>" + no + "</td>"
                                + "<td>" + rs.getString(2) + "</td>"
                                + "<td>" + rs.getString(3) + "</td>"
                                + "<td>" + rs.getString(4) + "</td>"
                                + "<td><a href=P_pembelianServlet?aksi=Delete&kode=" + rs.getString(2) + ">Hapus</a></td>"
                                + "</tr>");
                        no++;
                    }
                %> 
    </table>
<c:forEach var='ttlDK'items='${ttl.rowsByIndex}'>

Total Jumlah Barang Dipesan <input type="text" readonly="readonly" name="totjum" size="1" value="${ttlDK[0]}">
Total Bayar                 <input type="text" readonly="readonly" name="tobay" value="${ttlDK[1]}"><br>
        </c:forEach>
            <input type="submit" value="simpan" name="aksi"> <input type="reset" value="cancel">
        </pre>
    </form>
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
                        Nomor Pemesanan
                    </th>
                    <th>
                        Tanggal Pemesanan
                    </th>
                    <th>
                        Total
                    </th>
                    <th>
                        Kode Supplier
                    </th>
                    <th>
                        Action
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM pemesanan");
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
                                                + "<td>" + rs2.getString(1) + "</td>"
                                                + "<td>" + rs2.getString(2) + "</td>"
                                                + "<td>" + rs2.getString(3) + "</td>"
                                                + "<td>" + rs2.getString(4) + "</td>"
                                                + "<td><a href='cetakpo.jsp?no_po=" + rs2.getString(1) + "'>Cetak PO</a></td>"
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
</script>