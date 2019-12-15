<%@page import="java.sql.*"%>
<%@page import="model.Barang"%>
<%@page import="model.beli"%>
<%@page import="model.pesen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    beli pembelian = new beli();
    pesen pemesanan = new pesen();
    Barang barang = new Barang();
    ResultSet rs = null;
    ResultSet qrybarang = null;
    ResultSet qrypesan = null;
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
%>
<% java.util.Date waktu = new java.util.Date();
    int tanggal = waktu.getDate();
    int tahun = waktu.getYear() + 1900;
    int bulan = waktu.getMonth() + 1;
    String tgl = tahun + "-" + bulan + "-" + tanggal;
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
<h1>Transaksi Pembelian Barang</h1></br>
<form action="P_beliServlet" method="post">
    <pre>
No Beli       <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                ResultSet nobeli = null;
                nobeli = stmt.executeQuery("select max(right(no_beli,4)) as no FROM pembelian");
                while (nobeli.next()) {
                    if (nobeli.first() == false) {
                        out.println("<input type='text' class='form-control' id='inputbeli' readonly value='PB000001' name='no_beli'>");
                    } else {
                        nobeli.last();
                        int autobeli = nobeli.getInt(1) + 1;
                        String nomorbeli = String.valueOf(autobeli);
                        int noLong = nomorbeli.length();

                        for (int a = 1; a < 5 - noLong; a++) {
                            nomorbeli = "0" + nomorbeli;
                        }
                        String nomerbeli = "PB" + nomorbeli;
                        out.println("<input type='text' class='form-control' id='inputbeli' readonly value='" + nomerbeli + "' name='no_beli'>");
                        out.println("<input type='hidden' name='no_beli' value='" + nomerbeli + "'/>");
                    }

                }
            } catch (Exception e) {
                out.println(e);
            }
        %>
ID Admin       <input type="text" name="id_admin" id="id" class="form-control" readonly="" placeholder="ID Admin"/>
No Invoice    <input type="text" name="no_faktur" placeholder="No Invoice"/></br>
Tanggal beli  <input type="text" name="tanggal" readonly="" value =<%= tgl%> ></br>
Nomor Pesan   <select name="nomor" onchange="showEmp(this.value);">
            <option value="-1">Pilih Nomor Pesan</option>
            <%
                qrypesan = stmt.executeQuery("SELECT no_pesan FROM pemesanan where not exists"
                        + "(select * from pembelian where pemesanan.no_pesan=pembelian.no_pesan)");
                while (qrypesan.next()) {
                    pemesanan.setNopesan(qrypesan.getString("no_pesan"));
            %>
                    <option value="<%=pemesanan.getNopesan()%>"><%=pemesanan.getNopesan()%></option>
            <%  }%>
                           </select>
<input  type="hidden" name="emp_id" id="emp_id" value="">
Total         <input type="text" name="totbeli" value ="" id="ename" ></br>
            <input type="submit" value="Simpan" name="aksi"> <input type="reset" value="cancel">

                </select>
    </pre>
</form>
<script type="text/javascript">
    document.getElementById("id").value = localStorage.getItem("kode");
</script>