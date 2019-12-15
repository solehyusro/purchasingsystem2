<%@page import="java.sql.*" %> 
<%@page import="model.Pemesanan"%>
<%
    Pemesanan pesan = new Pemesanan();
    ResultSet rs = null;
    String emp_id = request.getParameter("emp_id").toString();
    Connection koneksi = null;
    String data = null;
    Statement st;
    Statement stmt = null;
    koneksi = DriverManager
            .getConnection("jdbc:mysql://localhost/ta_syahrur",
                    "root", "");
    stmt = koneksi.createStatement();
    rs = stmt.executeQuery("SELECT *from pemesanan where  no_pesan='" + emp_id + "' ");
    while (rs.next()) {
        data = ":" + rs.getString(3) + ":" + emp_id;
    }
    out.println(data);
%>