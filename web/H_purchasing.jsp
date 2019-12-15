<%-- 
    Document   : H_purchasing
    Created on : May 22, 2019, 8:34:03 PM
    Author     : USER PC
--%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>
            Purchasing Page
        </title>
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <!-- CSS Files -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/demo/demo.css" rel="stylesheet" />
    </head>

    <body class="">
        <div class="wrapper ">
            <div class="sidebar" data-color="white" data-active-color="danger">
                <!--
                  Tip 1: You can change the color of the sidebar using: data-color="blue | green | orange | red | yellow"
                -->
                <div class="logo">
                    <a href="#" class="simple-text logo-mini">
                        <div class="logo-image-small">
                            <img src="assets/img/logo-small.png">
                        </div>
                    </a>
                    <a href="#" class="simple-text logo-normal">
                        <script type="text/javascript">
                            document.write(localStorage.getItem("nama"));
                        </script>
                        <!-- <div class="logo-image-big">
                          <img src="assets/img/logo-big.png">
                        </div> -->
                    </a>
                </div>
                <div class="sidebar-wrapper">
                    <ul class="nav">
                        <li <%  String aktif = request.getParameter("hal");
                            if (aktif == null) {
                                out.println("class='active'");
                            }%>>
                            <a href="H_purchasing.jsp">
                                <i class="nc-icon nc-bank"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li
                            <c:choose> 
                                <c:when test="${param.hal=='supplier'}"> 
                                    class="active"
                                </c:when>
                            </c:choose>
                            >
                            <a href="H_purchasing.jsp?hal=supplier">
                                <i class="nc-icon nc-single-copy-04"></i>
                                <p>Data Supplier</p>
                            </a>
                        </li>
                        <li
                            <c:choose>
                                <c:when test="${param.hal=='barang'}"> 
                                    class="active"
                                </c:when>
                            </c:choose>
                            >
                            <a href="H_purchasing.jsp?hal=barang">
                                <i class="nc-icon nc-single-copy-04"></i>
                                <p>Data Barang</p>
                            </a>
                        </li>
                        <li
                            <c:choose>
                                <c:when test="${param.hal=='pemesanan'}"> 
                                    class="active"
                                </c:when>
                            </c:choose>
                            >
                            <a href="H_purchasing.jsp?hal=pemesanan">
                                <i class="nc-icon nc-email-85"></i>
                                <p>Pemesanan Barang</p>
                            </a>
                        </li>
                        <li
                            <c:choose>
                                <c:when test="${param.hal=='beli'}"> 
                                    class="active"
                                </c:when>
                            </c:choose>
                            >
                            <a href="H_purchasing.jsp?hal=beli">
                                <i class="nc-icon nc-credit-card"></i>
                                <p>Pembelian Barang</p>
                            </a>
                        </li>
                        <li
                            <c:choose>
                                <c:when test="${param.hal=='laporan_beli'}"> 
                                    class="active"
                                </c:when>
                            </c:choose>
                                    >
                            <a href="H_purchasing.jsp?hal=laporan_beli">
                                <i class="nc-icon nc-paper"></i>
                                <p>Laporan Pembelian</p>
                            </a>
                        </li>
                        <li
                            <c:choose>
                                <c:when test="${param.hal=='profile'}"> 
                                    class="active"
                                </c:when>
                            </c:choose>
                            >
                            <a href="H_purchasing.jsp?hal=profile">
                                <i class="nc-icon nc-single-02"></i>
                                <p>User Profile</p>
                            </a>
                        </li>
                        <li class="active-pro">
                            <a href="index.html">
                                <i class="nc-icon nc-user-run"></i>
                                <p>Log Out</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="main-panel">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
                    <div class="container-fluid">
                        <div class="navbar-wrapper">
                            <div class="navbar-toggle">
                                <button type="button" class="navbar-toggler">
                                    <span class="navbar-toggler-bar bar1"></span>
                                    <span class="navbar-toggler-bar bar2"></span>
                                    <span class="navbar-toggler-bar bar3"></span>
                                </button>
                            </div>
                            <a class="navbar-brand" href="#">Purchasing</a>
                        </div>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar navbar-kebab"></span>
                            <span class="navbar-toggler-bar navbar-kebab"></span>
                            <span class="navbar-toggler-bar navbar-kebab"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <form>
                                <div class="input-group no-border">
                                    <input type="text" value="" class="form-control" placeholder="Search...">
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <i class="nc-icon nc-zoom-split"></i>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </nav>
                <!-- End Navbar -->
                <!-- <div class="panel-header panel-header-lg">
            
            <canvas id="bigDashboardChart"></canvas>
            
            
          </div> -->
                <div class="content">
                    <c:choose> 
                        <c:when test="${param.hal=='supplier'}"> 
                            <%@include file="purchasing/supplier.jsp" %>
                        </c:when>
                        <c:when test="${param.hal=='barang'}"> 
                            <%@include file="purchasing/barang.jsp" %>
                        </c:when>
                        <c:when test="${param.hal=='pemesanan'}"> 
                            <%@include file="purchasing/pesan.jsp" %>
                        </c:when>
                        <c:when test="${param.hal=='beli'}"> 
                            <%@include file="purchasing/beli.jsp" %>
                        </c:when>
                        <c:when test="${param.hal=='terima'}"> 
                            <%@include file="purchasing/terima.jsp" %>
                        </c:when>
                        <c:when test="${param.hal=='laporan_beli'}"> 
                            <%@include file="purchasing/laporan_beli.jsp" %>
                        </c:when>
                        <c:when test="${param.hal=='profile'}"> 
                            <%@include file="purchasing/profile.jsp" %>
                        </c:when>
                        <c:otherwise>
                            <%@include file="purchasing/home.jsp" %>
                        </c:otherwise>
                    </c:choose>
                </div>
                <footer class="footer footer-black  footer-white ">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="credits ml-auto">
                                <span class="copyright">
                                    ©
                                    <script>
                                        document.write(new Date().getFullYear())
                                    </script>, made with <i class="fa fa-heart heart"></i> by Syahrur Rhamadan
                                </span>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <!--   Core JS Files   -->
        <script src="assets/js/core/jquery.min.js"></script>
        <script src="assets/js/core/popper.min.js"></script>
        <script src="assets/js/core/bootstrap.min.js"></script>
        <script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
        <!--  Google Maps Plugin    -->
        <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
        <!-- Chart JS -->
        <script src="assets/js/plugins/chartjs.min.js"></script>
        <!--  Notifications Plugin    -->
        <script src="assets/js/plugins/bootstrap-notify.js"></script>
        <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
        <script src="assets/js/paper-dashboard.min.js?v=2.0.0" type="text/javascript"></script>
        <!-- Paper Dashboard DEMO methods, don't include it in your project! -->
        <script src="assets/demo/demo.js"></script>
        <script>
                                        $(document).ready(function () {
                                            // Javascript method's body can be found in assets/assets-for-demo/js/demo.js
                                            demo.initChartsPages();
                                        });
        </script>
    </body>

</html>
