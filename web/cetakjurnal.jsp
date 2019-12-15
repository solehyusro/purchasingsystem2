<%-- 
    Document   : cetakjurnal
    Created on : Jun 17, 2019, 7:33:36 PM
    Author     : USER PC
--%>

<%@page import="java.io.*, java.util.*, java.sql.*"%> 
<%@page import="net.sf.jasperreports.engine.*"%> 
<%@page import="net.sf.jasperreports.view.JasperViewer.*" %> 
<%@page import="javax.servlet.ServletResponse" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Connection conn = null;
        
        String url="jdbc:mysql://localhost:3306/ta_syahrur"; 
        String username="root"; 
        String password=""; 
        
        int bulan=Integer.parseInt(request.getParameter("bulan")) ;
        int tahun=Integer.parseInt(request.getParameter("tahun")) ; 
        
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        
        File reportFile = new File(application
                .getRealPath("/Laporan/jurnal.jasper"));
        
        Map parameter = new HashMap();
        parameter.put("bln", bulan);
        parameter.put("thn", tahun); 

        byte[] bytes = JasperRunManager
                .runReportToPdf(reportFile.getPath(), parameter, conn); 

        response.setContentType("application/pdf");
        response.setContentLength(bytes.length); 

        ServletOutputStream outStream = response.getOutputStream();
        outStream.write(bytes, 0, bytes.length);
        outStream.flush();
        outStream.close();
        %>
    </body>
</html>
