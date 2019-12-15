<%@page import="java.sql.*, model.jurnal, model.Admin, model.akun, model.Pemesanan"%>
<%
    jurnal jurnal = new jurnal();
    Pemesanan pesan = new Pemesanan();
    Admin adm = new Admin();
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
            <h5 class="card-title">Tambah Jurnal</h5>
        </div>
        <div class="card-body">
            <form action="A_jurnalServlet" method="post">
                <div class="row">
                    <div class="col-md-3 pr-1">
                        <div class="form-group">
                            <label>No. Jurnal</label>
                            <%                                try {
                                    ResultSet no_j = null;
                                    Statement perintah = koneksi.createStatement();
                                    no_j = perintah.executeQuery("Select max(right(no_jurnal,5)) as no FROM jurnal");
                                    while (no_j.next()) {
                                        if (no_j.first() == false) {
                                            out.println("<input type='text' name='no_j' class='form-control' disabled='' placeholder='Kode Barang' value='NJ00001'>");
                                        } else {
                                            no_j.last();
                                            int autono_j = no_j.getInt(1) + 1;
                                            String nomor_noj = String.valueOf(autono_j);
                                            int noLong = nomor_noj.length();

                                            for (int a = 1; a < 6 - noLong; a++) {
                                                nomor_noj = "0" + nomor_noj;
                                            }
                                            String nomer_noj = "NJ" + nomor_noj;
                                            out.println("<input type='hidden' name='no_j' value='" + nomer_noj + "'/>");
                                            out.println("<input type='text' name='no_j' class='form-control' disabled='' placeholder='No Jurnal' value='" + nomer_noj + "'/>");
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
                            <label for="exampleInputEmail1">Kode Pemesanan</label>
                            <select name="no_po" class="form-control select" onchange="showEmp(this.value);">
                                <option value="">Pilih Kode Pemesanan</option>
                                <%
                                    ResultSet no_po = null;
                                    no_po = stmt.executeQuery("SELECT no_pesan FROM pemesanan where not exists"
                                            + "(select * from jurnal where pemesanan.no_pesan=jurnal.no_pesan)");
                                    while (no_po.next()) {
                                        pesan.setNo_po(no_po.getString("no_pesan"));
                                %>
                                <option value="<%=pesan.getNo_po()%>"><%=pesan.getNo_po()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Tanggal</label>
                            <input type="date" name="tgl" class="form-control">
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Kode Akun Debet</label>
                            <select name="akun_d" class="form-control select">
                                <%
                                    ResultSet kd_akun = null;
                                    kd_akun = stmt.executeQuery("SELECT * FROM akun");
                                    while (kd_akun.next()) {
                                        akun.setKd_akun(kd_akun.getString("kd_akun"));
                                        akun.setNm_akun(kd_akun.getString("nm_akun"));
                                %>
                                <option value="<%=akun.getKd_akun()%>"><%=akun.getKd_akun()%> <%=akun.getNm_akun()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Kode Akun Kredit</label>
                            <select name="akun_k" class="form-control select">
                                <%
                                    kd_akun = stmt.executeQuery("SELECT * FROM akun");
                                    while (kd_akun.next()) {
                                        akun.setKd_akun(kd_akun.getString("kd_akun"));
                                        akun.setNm_akun(kd_akun.getString("nm_akun"));
                                %>
                                <option value="<%=akun.getKd_akun()%>"><%=akun.getKd_akun()%> <%=akun.getNm_akun()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Nominal</label>
                            <input  type="hidden" name="emp_id" id="emp_id" value="">
                            <input type="text" name="nominal" class="form-control" id="ename">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Keterangan</label>
                            <textarea name="ket" class="form-control textarea" placeholder="Keterangan"></textarea>
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
    <div class="card card-user">
        <div class="card-header">
            <h5 class="card-title">Cetak</h5>
        </div>
        <div class="card-body">
            <form action="cetakjurnal.jsp" method="post">
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
            <h4 class="card-title">Daftar Jurnal</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead class=" text-primary">
                    <th>
                        No. Jurnal
                    </th>
                    <th>
                        Tanggal
                    </th>
                    <th>
                        Keterangan
                    </th>
                    <th>
                        Akun
                    </th>
                    <th>
                        Debet
                    </th>
                    <th>
                        Kredit
                    </th>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                rs2 = stmt.executeQuery("SELECT * FROM jurnal a INNER JOIN jurnal_detail b ON a.no_jurnal=b.no_jurnal ORDER BY a.no_jurnal");
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
                                                + "<td>" + rs2.getString("a.no_jurnal") + "</td>"
                                                + "<td>" + rs2.getString("a.tgl") + "</td>"
                                                + "<td>" + rs2.getString("a.ket") + "</td>"
                                                + "<td>" + rs2.getString("b.kd_akun") + "</td>"
                                                + "<td>" + rs2.getString("b.debet") + "</td>"
                                                + "<td>" + rs2.getString("b.kredit") + "</td>"
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
    document.getElementById("ename").value = 0;
</script>