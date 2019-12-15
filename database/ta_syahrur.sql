-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Inang: 127.0.0.1
-- Waktu pembuatan: 21 Jul 2019 pada 15.20
-- Versi Server: 5.5.27
-- Versi PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Basis data: `ta_syahrur`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id_admin` varchar(7) NOT NULL,
  `password` varchar(20) NOT NULL,
  `nama` varchar(40) NOT NULL,
  `alamat` text NOT NULL,
  `no_telp` varchar(13) NOT NULL,
  `hak_akses` enum('Accounting','Purchasing','Direktur') NOT NULL,
  PRIMARY KEY (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id_admin`, `password`, `nama`, `alamat`, `no_telp`, `hak_akses`) VALUES
('Hek0001', '0001', 'Accounting', 'Jauh', '0001', 'Accounting'),
('Hek0002', '0002', 'Purchasing', 'Dekat', '0002', 'Purchasing'),
('Hek0003', '0003', 'Direktur', 'Jauh Bet', '0003', 'Direktur');

-- --------------------------------------------------------

--
-- Struktur dari tabel `akun`
--

CREATE TABLE IF NOT EXISTS `akun` (
  `kd_akun` varchar(5) NOT NULL,
  `nm_akun` varchar(40) NOT NULL,
  `jenis_akun` varchar(30) NOT NULL,
  `saldo_normal` double NOT NULL,
  PRIMARY KEY (`kd_akun`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `akun`
--

INSERT INTO `akun` (`kd_akun`, `nm_akun`, `jenis_akun`, `saldo_normal`) VALUES
('11000', 'Kas', 'Harta', 75661),
('12000', 'Piutang', 'Harta', 9),
('13000', 'Persediaan', 'Harta', 75659),
('21000', 'Hutang', 'Hutang', 12009),
('31000', 'modal', 'Modal', 0),
('51000', 'Pembelian', 'Pembelian', 12000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE IF NOT EXISTS `barang` (
  `kd_brg` varchar(7) NOT NULL,
  `nm_brg` varchar(40) NOT NULL,
  `stok` int(11) NOT NULL,
  PRIMARY KEY (`kd_brg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`kd_brg`, `nm_brg`, `stok`) VALUES
('BRG0001', 'Baja', 159),
('BRG0002', 'Kayu', 26),
('BRG0003', 'Kabel', 0),
('BRG0004', 'Baut', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pembelian`
--

CREATE TABLE IF NOT EXISTS `detail_pembelian` (
  `no_beli` char(8) NOT NULL,
  `kd_brg` char(7) NOT NULL,
  `qty_beli` int(11) NOT NULL,
  `sub_beli` int(11) NOT NULL,
  KEY `no_beli` (`no_beli`),
  KEY `kd_brg` (`kd_brg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_pembelian`
--

INSERT INTO `detail_pembelian` (`no_beli`, `kd_brg`, `qty_beli`, `sub_beli`) VALUES
('PB0001', 'BRG0001', 12, 12000),
('PB0001', 'BRG0002', 12, 14400),
('PB0002', 'BRG0003', 12, 6000),
('PB0003', 'BRG0001', 12, 6000000),
('PB0003', 'BRG0001', 2, 1000000),
('PB0004', 'BRG0001', 12, 12000),
('PB0005', 'BRG0001', 7, 693000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pesan`
--

CREATE TABLE IF NOT EXISTS `detail_pesan` (
  `no_pesan` char(8) NOT NULL,
  `kd_brg` char(7) NOT NULL,
  `qty_pesan` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  KEY `no_pesan` (`no_pesan`),
  KEY `kd_brg` (`kd_brg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_pesan`
--

INSERT INTO `detail_pesan` (`no_pesan`, `kd_brg`, `qty_pesan`, `subtotal`) VALUES
('PS00001', 'BRG0001', 12, 12000),
('PS00001', 'BRG0002', 12, 14400),
('PS00002', 'BRG0003', 12, 6000),
('PS00003', 'BRG0001', 12, 6000000),
('PS00003', 'BRG0001', 2, 1000000),
('PS00004', 'BRG0001', 12, 12000),
('PS00005', 'BRG0001', 7, 693000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurnal`
--

CREATE TABLE IF NOT EXISTS `jurnal` (
  `no_jurnal` varchar(7) NOT NULL,
  `kd_admin` varchar(7) NOT NULL,
  `ket` text NOT NULL,
  `tgl` date NOT NULL,
  `no_pesan` varchar(7) NOT NULL,
  PRIMARY KEY (`no_jurnal`),
  KEY `kd_admin` (`kd_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jurnal`
--

INSERT INTO `jurnal` (`no_jurnal`, `kd_admin`, `ket`, `tgl`, `no_pesan`) VALUES
('NJ00001', 'Hek0001', 'Tunai', '2019-06-26', 'PS00001'),
('NJ00002', 'Hek0001', 'beli', '2019-06-26', 'PS00002'),
('NJ00003', 'Hek0001', 'tunai', '2019-07-02', 'PS00004');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurnal_detail`
--

CREATE TABLE IF NOT EXISTS `jurnal_detail` (
  `no_jurnal` varchar(7) NOT NULL,
  `kd_akun` varchar(5) NOT NULL,
  `debet` double NOT NULL,
  `kredit` double NOT NULL,
  KEY `kd_jurnal` (`no_jurnal`),
  KEY `kd_akun` (`kd_akun`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jurnal_detail`
--

INSERT INTO `jurnal_detail` (`no_jurnal`, `kd_akun`, `debet`, `kredit`) VALUES
('NJ00001', '13000', 26400, 0),
('NJ00001', '11000', 0, 26400),
('NJ00002', '13000', 6000, 0),
('NJ00002', '11000', 0, 6000),
('NJ00003', '51000', 12000, 0),
('NJ00003', '11000', 0, 12000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE IF NOT EXISTS `pembayaran` (
  `no_bayar` varchar(7) NOT NULL,
  `no_pesan` varchar(7) NOT NULL,
  `id_admin` varchar(7) NOT NULL,
  `tgl_bayar` date NOT NULL,
  `jumlah` double NOT NULL,
  PRIMARY KEY (`no_bayar`),
  KEY `kd_admin` (`id_admin`),
  KEY `no_po` (`no_pesan`),
  KEY `kd_admin_2` (`id_admin`),
  KEY `id_admin` (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`no_bayar`, `no_pesan`, `id_admin`, `tgl_bayar`, `jumlah`) VALUES
('BRY0001', 'PS00001', 'Hek0001', '2019-06-26', 26400),
('BRY0002', 'PS00002', 'Hek0001', '2019-06-26', 6000),
('BRY0003', 'PS00004', 'Hek0001', '2019-07-02', 12000),
('BRY0004', 'PS00003', 'Hek0001', '2019-07-16', 7000000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembelian`
--

CREATE TABLE IF NOT EXISTS `pembelian` (
  `no_beli` char(8) NOT NULL,
  `tgl_beli` date NOT NULL,
  `no_faktur` char(10) NOT NULL,
  `total_beli` int(11) NOT NULL,
  `no_pesan` char(8) NOT NULL,
  `id_admin` varchar(7) NOT NULL,
  PRIMARY KEY (`no_beli`),
  KEY `id_admin` (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pembelian`
--

INSERT INTO `pembelian` (`no_beli`, `tgl_beli`, `no_faktur`, `total_beli`, `no_pesan`, `id_admin`) VALUES
('PB0001', '2019-06-26', 'FK0001', 26400, 'PS00001', 'Hek0002'),
('PB0002', '2019-06-26', 'FK0002', 6000, 'PS00002', 'Hek0002'),
('PB0003', '2019-06-28', 'FK0003', 7000000, 'PS00003', 'Hek0002'),
('PB0004', '2019-07-02', 'FK0004', 12000, 'PS00004', 'Hek0002'),
('PB0005', '2019-07-17', 'F0006', 693000, 'PS00005', 'Hek0002');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanan`
--

CREATE TABLE IF NOT EXISTS `pemesanan` (
  `no_pesan` char(8) NOT NULL,
  `tgl_pesan` date NOT NULL,
  `total` int(11) NOT NULL,
  `kd_supp` varchar(7) NOT NULL,
  `id_admin` varchar(7) NOT NULL,
  PRIMARY KEY (`no_pesan`),
  KEY `id_admin` (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pemesanan`
--

INSERT INTO `pemesanan` (`no_pesan`, `tgl_pesan`, `total`, `kd_supp`, `id_admin`) VALUES
('PS00001', '2019-06-26', 26400, 'SUP0001', 'Hek0002'),
('PS00002', '2019-06-26', 6000, 'SUP0003', 'Hek0002'),
('PS00003', '2019-06-28', 7000000, 'SUP0001', 'Hek0002'),
('PS00004', '2019-07-02', 12000, '-1', 'Hek0002'),
('PS00005', '2019-07-16', 693000, 'SUP0003', 'Hek0002');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sementara`
--

CREATE TABLE IF NOT EXISTS `sementara` (
  `nomer` char(8) NOT NULL,
  `kode` char(7) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `kd_supp` varchar(7) NOT NULL,
  `nm_supp` varchar(40) NOT NULL,
  `alamat` text NOT NULL,
  `no_telp` varchar(13) NOT NULL,
  PRIMARY KEY (`kd_supp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`kd_supp`, `nm_supp`, `alamat`, `no_telp`) VALUES
('SUP0001', 'PT Berharap Maju', 'Jauh', '123'),
('SUP0002', 'Bank', 'Dekat', '123123'),
('SUP0003', 'PT Makmur Bener', 'Cukup Jauh', '234'),
('SUP0004', 'PT Makmur Jaya', 'Ga Jauh', '08121111190');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
