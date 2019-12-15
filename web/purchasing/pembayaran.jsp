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
            pesan.setNo_po(rs.getString("no_byr"));
            pesan.setKd_admin(rs.getString("kd_admin"));
            pesan.setKd_supp(rs.getString("no_byr"));
            pesan.setKd_brg(rs.getString("kd_brg"));
            pesan.setTgl_po(rs.getString("tgl_po"));
            pesan.setByk_brg(Integer.parseInt(rs.getString("banyak_brg")));
            pesan.setHarga_satuan(Integer.parseInt(rs.getString("harga_satuan")));
            pesan.setStatus(rs.getString("status"));
        }
    }
%>
<script type="text/javascript">
    function showEmp(emp_value)
    {
        if (document.getElementById("emp_id").value != "-1")
        {
            xmlHttp = GetXmlHttpObject()
            if (xmlHttp == null)
            {
                alert("Browser does not support HTTP Request")
                return
            }
            var url = "purchasing/getotal.jsp"
            url = url + "?emp_id=" + emp_value

            xmlHttp.onreadystatechange = stateChanged
            xmlHttp.open("GET", url, true)
            xmlHttp.send(null)
        } else
        {
            alert("-");
        }
    }

    function stateChanged()
    {
        document.getElementById("ename").value = "";
        document.getElementById("emp_id").value = "";
        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete")
        {

            var showdata = xmlHttp.responseText;
            var strar = showdata.split(":");

            if (strar.length == 1)
            {
                document.getElementById("emp_id").focus();
                alert("-");
                document.getElementById("ename").value = " ";
                document.getElementById("emp_id").value = " ";
            } else if (strar.length > 1)
            {
                document.getElementById("ename").value = strar[1];
            }

        }
    }

    function GetXmlHttpObject()
    {
        var xmlHttp = null;
        try
        {
            xmlHttp = new XMLHttpRequest();
        } catch (e)
        {
            try
            {
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e)
            {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }
</script>
<div class="col-md-12">
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Tambah Pembayaran</h5>
        </div>
        <div class="card-body">
            <form action="P_pembelianServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>Kode Pembayaran</label>
                            <%
                                try {
                                    ResultSet no_byr = null;
                                    Statement perintah = koneksi.createStatement();
                                    no_byr = perintah.executeQuery("Select max(right(no_bayar,4)) as no FROM pembayaran");
                                    while (no_byr.next()) {
                                        if (no_byr.first() == false) {
                                            out.println("<input type='text' name='no_byr' class='form-control' disabled='' placeholder='No Pemesanan' value='PSN0001'>");
                                        } else {
                                            no_byr.last();
                                            int autono_byr = no_byr.getInt(1) + 1;
                                            String nomor_nobyr = String.valueOf(autono_byr);
                                            int noLong = nomor_nobyr.length();

                                            for (int a = 1; a < 5 - noLong; a++) {
                                                nomor_nobyr = "0" + nomor_nobyr;
                                            }
                                            String nomer_nobyr = "BRY" + nomor_nobyr;
                                            out.println("<input type='hidden' name='no_byr' value='" + nomer_nobyr + "'/>");
                                            out.println("<input type='text' name='no_byr' class='form-control' disabled='' placeholder='No Pemesanan' value='" + nomer_nobyr + "'/>");
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
                            <label for="exampleInputEmail1">Kode Pemesanan</label>
                            <select name="no_po" class="form-control select" onchange="showEmp(this.value);" >
                                <option value="">Pilih Kode Pemesanan</option>
                                <%
                                    ResultSet no_po = null;
                                    no_po = stmt.executeQuery("SELECT no_pesan FROM pemesanan where not exists"
                        + "(select * from pembayaran where pemesanan.no_pesan=pembayaran.no_pesan)");
                                    while (no_po.next()) {
                                        pesan.setNo_po(no_po.getString("no_pesan"));
                                %>
                                <option value="<%=pesan.getNo_po()%>"><%=pesan.getNo_po()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 pl-1">
                        <div class="form-group">
                            <label>ID Admin</label>
                            <input type="text" name="id_admin" id="id" class="form-control" readonly="" placeholder="ID Admin"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Tanggal Bayar</label>
                            <input type="date" name="tgl_byr" class="form-control">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Total</label>
                            <input  type="hidden" name="emp_id" id="emp_id" value="">
                            <input type="number" name="total" class="form-control" id="ename">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="update ml-auto mr-auto">
                        <a href="H_purchasing.jsp?hal=pembayaran" class="btn btn-danger btn-round">Batal</a>
                    </div>
                    <div class="update ml-auto mr-auto">
                        <input type="submit" name="aksi" value="Bayar" class="btn btn-primary btn-round">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    document.getElementById("id").value = localStorage.getItem("kode");
    document.getElementById("ename").value = 0;
</script>