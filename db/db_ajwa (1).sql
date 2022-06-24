-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Jun 2022 pada 11.11
-- Versi server: 10.4.21-MariaDB
-- Versi PHP: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ajwa`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `id_dtl_pembelian` int(11) NOT NULL,
  `no_faktur` varchar(255) NOT NULL,
  `kd_obat` varchar(10) NOT NULL,
  `no_batch` varchar(100) DEFAULT NULL,
  `harga_beli` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL,
  `tgl_expired` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `detail_pembelian`
--

INSERT INTO `detail_pembelian` (`id_dtl_pembelian`, `no_faktur`, `kd_obat`, `no_batch`, `harga_beli`, `qty`, `sub_total`, `tgl_expired`) VALUES
(1, '65767697876878768', '1701O0121', '323232', 4000, 40, 160000, '2022-07-30'),
(2, '65767697876878768', '1901O0202', '232323', 20000, 5, 100000, '2022-06-30');

--
-- Trigger `detail_pembelian`
--
DELIMITER $$
CREATE TRIGGER `insert_tbl_exp` AFTER INSERT ON `detail_pembelian` FOR EACH ROW BEGIN
INSERT INTO tbl_exp_date(id_dtl_pembelian)
VALUES
    (NEW.id_dtl_pembelian );
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tambah_stok` AFTER INSERT ON `detail_pembelian` FOR EACH ROW BEGIN
        UPDATE master_obat SET stok = stok + NEW.qty WHERE kd_obat = NEW.kd_obat;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_trx_penjualan`
--

CREATE TABLE `detail_trx_penjualan` (
  `id_dtl_trx_jual` int(11) NOT NULL,
  `kd_transaksi` varchar(20) NOT NULL,
  `no_faktur` varchar(255) NOT NULL,
  `kd_obat` varchar(10) NOT NULL,
  `qty` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `detail_trx_penjualan`
--

INSERT INTO `detail_trx_penjualan` (`id_dtl_trx_jual`, `kd_transaksi`, `no_faktur`, `kd_obat`, `qty`, `sub_total`) VALUES
(2, '221121001', '', '1411O0047', 1, 23000),
(3, '241121001', '', '2411O0050', 1, 23000),
(4, '241121002', '', '0811O0017', 1, 43000),
(5, '241221001', '', '0811O0030', 1, 42000),
(6, '241221001', '', '0811O0031', 1, 12000),
(7, '241221001', '', '0811O0032', 1, 7000),
(8, '241221001', '', '2411O0048', 1, 22000),
(9, '311221001', '', '0911O0041', 1, 25000),
(10, '010122001', '', '0811O0026', 1, 5000),
(11, '010122001', '', '0811O0027', 1, 5000),
(12, '010122001', '', '0811O0037', 2, 10000),
(13, '080122001', '', '2312O0060', 1, 39000),
(14, '080122002', '', '0811O0025', 1, 5000),
(15, '080122002', '', '0811O0026', 1, 5000),
(16, '180122001', '', '0811O0031', 2, 24000),
(17, '180122001', '', '1701O0124', 1, 13000),
(18, '180122002', '', '1701O0114', 1, 15000),
(19, '200122001', '', '0811O0035', 1, 15000),
(20, '200122002', '', '1901O0173', 1, 17000),
(21, '220122001', '', '0811O0027', 1, 5000),
(22, '220122002', '', '3112O0078', 1, 2500),
(23, '220122002', '', '0101O0093', 1, 1500),
(24, '220122003', '', '1901O0209', 1, 13000),
(25, '220122004', '', '0811O0011', 1, 4000),
(26, '230122001', '', '1901O0151', 1, 4000),
(27, '230122001', '', '1901O0154', 1, 3000),
(28, '200322001', '', '1701O0119', 1, 2500),
(29, '200322002', '', '1701O0119', 1, 2500),
(30, '200322003', '', '2003O0351', 2, 12000),
(31, '210322001', '', '1701O0119', 1, 2500),
(32, '220322001', '', '0811O0033', 2, 200000),
(33, '220322002', '', '1701O0119', 1, 2500),
(34, '220322003', '', '1701O0121', 1, 5000),
(35, '220322004', '', '1701O0122', 1, 5000),
(36, '220322005', '', '1701O0121', 1, 5000),
(37, '220322006', '', '1701O0128', 1, 22000),
(38, '070622001', '', '1701O0119', 1, 2500),
(39, '210622001', '', '1701O0119', 1, 2500),
(40, '210622002', '', '1701O0119', 1, 2500),
(41, '210622003', '', '1901O0202', 1, 1500),
(42, '210622003', '', '1701O0121', 1, 5000),
(43, '210622004', '', '1901O0203', 1, 1500),
(44, '210622004', '', '1901O0154', 1, 3000),
(45, '210622005', '', '1901O0203', 1, 1500),
(46, '210622005', '', '1901O0202', 1, 1500),
(47, '210622006', '', '1901O0203', 1, 1500),
(48, '210622006', '', '1901O0202', 1, 1500),
(49, '210622007', '', '1901O0203', 1, 1500),
(50, '210622007', '', '1901O0202', 1, 1500),
(51, '210622008', '', '1901O0202', 1, 1500),
(52, '210622008', '', '1901O0204', 1, 1500),
(53, '210622009', '', '1901O0203', 1, 1500),
(54, '210622009', '', '1901O0202', 1, 1500),
(55, '220622001', '', '1701O0119', 1, 2500),
(56, '220622002', '', '1701O0119', 1, 2500),
(57, '220622003', '', '1701O0119', 1, 2500),
(58, '220622004', '', '1701O0119', 1, 2500),
(59, '220622005', '', '1701O0119', 1, 2500),
(60, '220622006', '', '1701O0119', 5, 12500),
(61, '220622006', '', '1901O0203', 1, 1500),
(62, '220622006', '', '1901O0202', 2, 3000),
(63, '220622007', '', '1701O0119', 1, 2500),
(64, '220622007', '', '1901O0203', 5, 7500),
(65, '230622001', '', '1701O0119', 7, 17500),
(66, '230622001', '', '1901O0203', 1, 1500),
(67, '230622002', '', '0101O0095', 1, 2000),
(68, '230622002', '', '0811O0011', 1, 4000);

--
-- Trigger `detail_trx_penjualan`
--
DELIMITER $$
CREATE TRIGGER `hapus_trx_restorestok` AFTER DELETE ON `detail_trx_penjualan` FOR EACH ROW BEGIN
        UPDATE master_obat SET stok = stok + OLD.qty WHERE kd_obat = OLD.kd_obat;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pengurangan_stok` AFTER INSERT ON `detail_trx_penjualan` FOR EACH ROW BEGIN
        UPDATE master_obat SET stok = stok - NEW.qty WHERE kd_obat = NEW.kd_obat;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `faktur_pembelian`
--

CREATE TABLE `faktur_pembelian` (
  `no_faktur` varchar(255) NOT NULL,
  `id_suplier` int(11) NOT NULL,
  `tgl_beli` date NOT NULL,
  `jt_tempo` date NOT NULL,
  `jml_harga` int(20) NOT NULL,
  `ppn_persen` int(11) NOT NULL,
  `ppn` int(20) NOT NULL,
  `total_trx` int(20) NOT NULL,
  `user_input` int(11) NOT NULL,
  `waktu_input` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `faktur_pembelian`
--

INSERT INTO `faktur_pembelian` (`no_faktur`, `id_suplier`, `tgl_beli`, `jt_tempo`, `jml_harga`, `ppn_persen`, `ppn`, `total_trx`, `user_input`, `waktu_input`) VALUES
('65767697876878768', 12, '2022-06-22', '2022-07-09', 260000, 0, 0, 260000, 7, '2022-06-24 09:07:08');

--
-- Trigger `faktur_pembelian`
--
DELIMITER $$
CREATE TRIGGER `hapus_dtl_pembelian` BEFORE DELETE ON `faktur_pembelian` FOR EACH ROW BEGIN
        DELETE FROM detail_pembelian WHERE no_faktur= OLD.no_faktur; 
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `laporan1`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `laporan1` (
`kd_obat` varchar(10)
,`nama_obat` varchar(50)
,`harga_beli` int(11)
,`penambahan` decimal(32,0)
,`pengurangan` int(1)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_data_master`
--

CREATE TABLE `log_data_master` (
  `id` int(11) NOT NULL,
  `no_log` varchar(100) NOT NULL,
  `aktifitas` varchar(10) NOT NULL,
  `nama_data` varchar(100) NOT NULL,
  `nama_kolom` int(100) NOT NULL,
  `nilai_awal` int(250) NOT NULL,
  `nilai_baru` int(250) NOT NULL,
  `user` varchar(10) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_obat`
--

CREATE TABLE `master_obat` (
  `kd_obat` varchar(10) NOT NULL,
  `nama_obat` varchar(50) NOT NULL,
  `satuan` varchar(100) DEFAULT NULL,
  `kemasan` varchar(255) NOT NULL,
  `prinsipal` varchar(100) DEFAULT NULL,
  `harga_jual` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `user_input` int(11) NOT NULL,
  `user_update` int(11) NOT NULL,
  `waktu_input` timestamp NULL DEFAULT current_timestamp(),
  `time_stamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `master_obat`
--

INSERT INTO `master_obat` (`kd_obat`, `nama_obat`, `satuan`, `kemasan`, `prinsipal`, `harga_jual`, `stok`, `user_input`, `user_update`, `waktu_input`, `time_stamp`) VALUES
('0101O0092', 'Im Boost Force', 'Strip', 'Dus 3 Strip', 'Soho', 80000, 20, 0, 7, '2022-01-21 13:01:24', '2022-06-24 09:10:12'),
('0101O0093', 'Vicee Grape Tab', 'strip', 'Dus 100 Tab', 'Darya Varia', 1000, 199, 0, 0, '2022-01-22 13:42:11', '2022-03-24 03:03:30'),
('0101O0094', 'Tablet Tambah Darah Neo', 'Strip', 'Dus 10 Strip', 'Kf', 6000, 10, 0, 0, '2022-01-04 13:17:33', '2022-03-24 03:03:30'),
('0101O0095', 'Baymed Surgical Face Mask Hijab', 'Pcs', 'Dus 50 Pc', 'Baymed', 2000, 503, 0, 0, '2022-01-19 06:24:19', '2022-06-23 07:29:41'),
('0101O0096', 'Cendo LFX MD', 'Mini Dose', 'Strip', 'Cendo', 18000, 25, 0, 0, '2022-01-04 13:17:33', '2022-03-24 03:03:30'),
('0401O0097', 'Minyak Kutus-Kutus 100 ml', 'Botol', 'Botol 100 ml', 'Sumber Waras', 190000, 8, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('0401O0098', 'Wouds Cough Expectorant', 'Botol', 'Botol 60 ml', 'Kalbe', 20000, 3, 0, 0, '2022-01-04 13:25:16', '2022-03-24 03:03:30'),
('0401O0099', 'Stop Cold Dragee', 'Strip', 'Dus 15 Strip', 'Darya Varia', 3000, 77, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('0401O0101', 'Glauseta Tab', 'Strip', 'Dus 10 Strip', 'Sanbe', 60000, 10, 0, 0, '2022-01-18 10:50:10', '2022-03-24 03:03:30'),
('0701O0102', 'Siloxan 5 ml', 'Botol', 'Botol 5 ml', 'Cendo', 80000, 10, 0, 0, '2022-01-07 13:57:34', '2022-03-24 03:03:30'),
('0701O0103', 'Cendo Xitrol EO Salep', 'Tube', 'Tube 3,5 g', 'Cendo', 50000, 3, 0, 0, '2022-01-07 13:57:34', '2022-03-24 03:03:30'),
('0701O0104', 'Polynel 0,6 ml MD', 'Mini Dose', 'Strip 5 MD', 'Cendo', 5000, 10, 0, 0, '2022-01-07 13:57:34', '2022-03-24 03:03:30'),
('0811O0007', 'Oxoferin Solution 30 ml', 'Botol 30 ml', 'Botol', 'Pharos', 96000, 2, 0, 0, '2021-11-08 08:55:26', '2022-03-24 03:03:30'),
('0811O0008', 'Sensipad Underpad Alas Popok', 'Bungkus 10 Pc', 'Bungkus 10 Pc', 'Sensi', 45000, 3, 0, 0, '2021-11-08 08:55:26', '2022-03-24 03:03:30'),
('0811O0009', 'Amlodipin 5 mg Tab', 'Strip', 'Dus 3 Strip', 'Novell', 5000, 5, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('0811O0010', 'Amlodipin 10 mg', 'Strip', 'Dus 3 Strip', 'Novell', 8000, 5, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('0811O0011', 'Sensi Mask Duckbill 50 \'s', 'Pc', 'Dus 50 Pc', 'Sensi', 4000, 198, 0, 0, '2022-01-22 13:53:17', '2022-06-23 07:29:41'),
('0811O0012', 'Desoximetasone salep 0,25 %', 'Tube', 'Tube', 'Novell', 26000, 3, 0, 0, '2021-11-08 08:55:26', '2022-03-24 03:03:30'),
('0811O0013', 'Egoji Chewy Gummy Jeruk', 'Bks', 'Dus 5 Bks', 'Novell', 10000, 30, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('0811O0014', 'Egoji Chewy Gummy Strawberry', 'Bks', 'Dus 5 Bks', 'Novell', 10000, 30, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('0811O0015', 'Plossa Hanger Eucalyptus', 'Pc', 'Pc', 'Plossa', 13000, 17, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('0811O0016', 'Super Magic Man Premium Gold', 'Dus', 'Dus 3 Sach', 'Delta', 13000, 2, 0, 0, '2021-12-25 09:00:24', '2022-03-24 03:03:30'),
('0811O0017', 'Cooling 5 Plus Orange', 'Botol 15 ml', 'Botol', 'Pharos', 41000, 5, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('0811O0018', 'Plossa Mini Eucalyptus', 'Pcs', 'Pcs', 'Plossa', 7000, 6, 0, 0, '2021-11-08 08:55:26', '2022-03-24 03:03:30'),
('0811O0019', 'Sensi Convex Mask 4 ply', 'Pcs', 'Dus 20 Pcs', 'Sensi', 10000, 20, 0, 0, '2021-11-08 08:55:26', '2022-03-24 03:03:30'),
('0811O0020', 'Sensi Glove Latex Non Powder', 'Dus', 'Dus 50 Pair', 'Sensi', 220000, 3, 0, 0, '2021-11-08 08:55:26', '2022-03-24 03:03:30'),
('0811O0021', 'Polident Cleanser', 'Strip', 'Dus 12 Strip', 'Glaxo', 13000, 38, 0, 0, '2022-01-01 08:59:31', '2022-03-24 03:03:30'),
('0811O0022', 'Im Boost Tab', 'Strip', 'Dus 5 Strip', 'Soho', 41000, 16, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('0811O0024', 'Nymiko Suspensi', 'Botol 12 ml', 'Botol', 'Sanbe', 44000, 3, 0, 0, '2021-11-08 09:11:34', '2022-03-24 03:03:30'),
('0811O0025', 'Amoxicillin 500 mg (HJ)', 'Strip', 'Dus 20 Strip', 'Hexafarm', 5000, 69, 0, 0, '2022-01-24 13:26:45', '2022-03-24 03:03:30'),
('0811O0026', 'As. Mefenamat 500 mg (Nova)', 'Strip', 'Dus 10 Strip', 'Nova', 5000, 58, 0, 0, '2022-01-24 13:26:45', '2022-03-24 03:03:30'),
('0811O0027', 'Ampicilln 500 mg (Nova)', 'Strip', 'Dus 10 Strip', 'Nova', 5000, 51, 0, 0, '2022-01-22 13:41:20', '2022-03-24 03:03:30'),
('0811O0028', 'Forti D 1000', 'Dus', 'Dus 28 Kapsul', 'Darya Varia', 82000, 2, 0, 0, '2021-12-26 12:46:29', '2022-03-24 03:03:30'),
('0811O0029', 'Minyak Kayu Putih 210 ml', 'Botol 210 ml', 'Botol', 'Cap Lang', 72000, 10, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('0811O0030', 'Minyak Kayu Putih 120 ml', 'Botol 120 ml', 'Botol 120 ml', 'Cap Lang', 43000, 11, 0, 0, '2022-01-26 04:03:33', '2022-03-24 03:03:30'),
('0811O0031', 'Minyak Kayu Putih 30 ml', 'Botol 30 ml', 'Botol', 'Cap Lang', 12000, 34, 0, 0, '2022-01-26 04:03:33', '2022-03-24 03:03:30'),
('0811O0032', 'Minyak Kayu Putih 15 ml', 'Botol 15 ml', 'Botol', 'Cap Lang', 7000, 23, 0, 0, '2022-01-24 13:44:22', '2022-03-24 03:03:30'),
('0811O0033', 'Eucalyptus Desinfektan Spray 200 ml', 'Botol 500 ml', 'Botol', 'Cap Lang', 100000, 0, 0, 0, '2022-03-22 03:11:13', '2022-03-24 03:03:30'),
('0811O0034', 'Balsem Aktiv 20 g', 'Pot 20 g', 'Pot', 'Cap Lang', 9000, 10, 0, 0, '2022-01-24 13:55:00', '2022-03-24 03:03:30'),
('0811O0035', 'Balsem Aktiv 40 g', 'Pot 40 g', 'Pot', 'Cap Lang', 16000, 2, 0, 0, '2022-01-20 13:42:24', '2022-03-24 03:03:30'),
('0811O0036', 'Sensi Mask Duckbill 3\'s', 'Bks', 'Bks', 'Sensi', 12000, 21, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('0811O0037', 'Bodrex Tab', 'Strip', 'Dus 2 Strip', 'Bode', 5000, 126, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('0811O0038', 'Bodrexin Flu & Batuk PE Syr', 'Botol 56 ml', 'Botol', 'Bode', 12000, 11, 0, 0, '2021-12-30 21:28:25', '2022-03-24 03:03:30'),
('0911O0039', 'My Baby Minyak Telon Plus 150 ml', 'Botol 150 ml', 'Botol', 'Tempo', 38000, 3, 0, 0, '2021-11-09 09:29:30', '2022-03-24 03:03:30'),
('0911O0040', 'My Baby Minyak Telon Plus 60 ml', 'Botol 60 ml', 'Botol', 'Tempo', 19000, 3, 0, 0, '2021-11-09 09:29:30', '2022-03-24 03:03:30'),
('0911O0041', 'My Baby Minyak Telon Plus 90 ml', 'Botol 90 ml', 'Botol', 'Tempo', 25000, 2, 0, 0, '2021-12-31 11:25:27', '2022-03-24 03:03:30'),
('1111O0042', 'Donepezil Tab', 'Strip', 'Dus 3 Strip', 'Nulab', 80000, 0, 0, 0, '2022-01-23 05:27:47', '2022-03-24 03:03:30'),
('1411O0043', 'Pehacain Injeksi', 'Ampul', 'Dus 20 Ampul', 'Phapros', 4000, 20, 0, 0, '2021-11-14 04:36:16', '2022-03-24 03:03:30'),
('1411O0044', 'Ciprofloxacin Tab (Nova)', 'Strip', 'Dus 10 Strip', 'Nova', 6000, 30, 0, 0, '2021-11-14 04:36:16', '2022-03-24 03:03:30'),
('1411O0045', 'Antimo Anak Jeruk', 'Sachet', 'Dus 10 Sachet', 'Phapros', 2000, 10, 0, 0, '2021-11-14 04:36:16', '2022-03-24 03:03:30'),
('1411O0046', 'Decolgen Tab', 'Strip', 'Dus 25 Strip', 'Darya Varia', 2500, 75, 0, 0, '2022-01-18 10:47:22', '2022-03-24 03:03:30'),
('1411O0047', 'Hufagrip Flu & Batuk', 'Botol 60 ml', 'Botol 60 ml', 'Hufa', 23000, 12, 0, 0, '2022-01-24 14:01:33', '2022-03-24 03:03:30'),
('1701O0106', 'Becom C Kaplet', 'Strip', 'Dus 10 Strip', 'Sanbe', 21000, 30, 0, 0, '2022-01-24 08:28:01', '2022-03-24 03:03:30'),
('1701O0107', 'Tremenza Tablet', 'Strip', 'Dus 10 Strip', 'Sanbe', 20000, 10, 0, 0, '2022-01-17 13:12:14', '2022-03-24 03:03:30'),
('1701O0108', 'Levocin Eye Drop 5 ml', 'Botol 5 ml', 'Botol', 'Sanbe', 103000, 5, 0, 0, '2022-01-17 13:28:53', '2022-03-24 03:03:30'),
('1701O0109', 'Sanmol Syr', 'Botol 60 ml', 'Botol', 'Sanbe', 16000, 41, 0, 0, '2022-01-24 13:46:20', '2022-03-24 03:03:30'),
('1701O0110', 'Sanmol Tab', 'Strip', 'Dus 25 Str', 'Sanbe', 2000, 86, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1701O0111', 'Poldan Mig Kaplet', 'Strip', 'Dus 25 Strip', 'Sanbe', 3000, 25, 0, 0, '2022-01-17 13:27:01', '2022-03-24 03:03:30'),
('1701O0112', 'Elkana Syrup', 'Botol 60 ml', 'Botol', 'Sanbe', 31000, 5, 0, 0, '2022-01-19 04:18:11', '2022-03-24 03:03:30'),
('1701O0113', 'Neurosanbe Injeksi', 'Ampul', 'Dus 10 Ampul', 'Sanbe', 7500, 10, 0, 0, '2022-01-17 13:21:03', '2022-03-24 03:03:30'),
('1701O0114', 'Neurosanbe Plus Kaplet', 'Strip', 'Dus 10 Strip', 'Sanbe', 15000, 9, 0, 0, '2022-01-18 10:35:58', '2022-03-24 03:03:30'),
('1701O0115', 'Neurosanbe Tablet', 'Strip', 'Dus 10 Strip', 'Sanbe', 16000, 11, 0, 0, '2022-01-19 04:18:11', '2022-03-24 03:03:30'),
('1701O0116', 'Sanaflu Kaplet', 'Strip', 'Dus 25 Strip', 'Sanbe', 2500, 25, 0, 0, '2022-01-17 13:24:39', '2022-03-24 03:03:30'),
('1701O0117', 'Fungiderm 5 gr', 'Tube 5 gr', 'Tube', 'Konimex', 16000, 6, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1701O0118', 'Fungiderm 10 gr', 'Tube 10 gr', 'Tube', 'Konimex', 28000, 3, 0, 0, '2022-01-17 13:57:05', '2022-03-24 03:03:30'),
('1701O0119', 'Paramex Sakit Kepala', 'Strip', 'Dus 50 Strip', 'Konimex', 2500, 127, 0, 0, '2022-03-22 03:39:11', '2022-06-23 05:19:02'),
('1701O0120', 'Pil Kita', 'Strip 4 Tab', 'Dus 50 Strip', 'Marguna', 5000, 50, 0, 0, '2022-01-17 14:08:36', '2022-03-24 03:03:30'),
('1701O0121', 'Paracetamol Syr Apel', 'Botol 60 ml', 'Botol', 'AFI', 5000, 62, 0, 0, '2022-03-22 07:28:00', '2022-06-24 09:07:08'),
('1701O0122', 'Paraceamol Syr Mint', 'Botol 60 ml', 'Botol', 'AFI', 5000, 4, 0, 0, '2022-03-22 03:41:50', '2022-03-24 03:03:30'),
('1701O0123', 'Adem Sari Vit C', 'Sachet', 'Dus 5 Sachet', 'enesis', 3000, 15, 0, 0, '2022-01-17 14:08:36', '2022-03-24 03:03:30'),
('1701O0124', 'Pi Kang Shuang Krim', 'Tube 5 gr', 'Tube', 'Pi Kang', 13000, 29, 0, 0, '2022-01-24 13:37:06', '2022-03-24 03:03:30'),
('1701O0125', 'Mylanta Liquid 50 ml', 'Botol 50 ml', 'Botol', 'Jhonson-Jhonson', 16000, 5, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1701O0126', 'Mylanta Tablet', 'Strip', 'Dus 10 Strip', 'Jhonson-Jhonson', 8000, 10, 0, 0, '2022-01-17 14:08:36', '2022-03-24 03:03:30'),
('1701O0127', 'Kalpanax K Cream 5 g', 'Tube 5 gr', 'Tube', 'Kalbe', 14000, 3, 0, 0, '2022-01-17 14:08:36', '2022-03-24 03:03:30'),
('1701O0128', 'Kondom Sutra 12 S', 'Dus 12 Sach', 'Dus', 'Sutra', 22000, 4, 0, 0, '2022-03-22 07:29:32', '2022-03-24 03:03:30'),
('1701O0129', 'Laserin 60 ml', 'Botol 60 ml', 'Botol', 'Mecosin', 13000, 7, 0, 0, '2022-01-24 13:37:06', '2022-03-24 03:03:30'),
('1701O0130', 'Laserin 110 ml', 'Botol 110 ml', 'Botol', 'Mucosin', 23000, 3, 0, 0, '2022-01-17 14:08:36', '2022-03-24 03:03:30'),
('1801O0131', 'Sanmol Drops', 'Botol 10 ml', 'Botol', 'Sanbe', 20000, 9, 0, 0, '2022-01-24 08:28:01', '2022-03-24 03:03:30'),
('1801O0132', 'Safe Care Aromatherapy Minyak Angin', 'Botol', 'Botol', 'Safe Care', 17000, 48, 0, 0, '2022-01-24 13:46:20', '2022-03-24 03:03:30'),
('1801O0133', 'Nebacetin Powder 5 g', 'Botol', 'Botol', 'Pharos', 26000, 6, 0, 0, '2022-01-18 11:05:55', '2022-03-24 03:03:30'),
('1801O0134', 'Proris Forte Suspensi 50 ml', 'Botol 50 ml', 'Botol', 'Pharos', 35000, 6, 0, 0, '2022-01-18 11:05:55', '2022-03-24 03:03:30'),
('1801O0135', 'Proris Suspensi 60 ml', 'Botol 60 ml', 'Botol', 'Pharos', 29000, 6, 0, 0, '2022-01-18 11:05:55', '2022-03-24 03:03:30'),
('1801O0136', 'Iremax Tablet', 'Strip', 'Dus 10 Strip', 'Guardian', 14000, 60, 0, 0, '2022-01-26 03:57:11', '2022-03-24 03:03:30'),
('1801O0137', 'Ibuprofen 400 mg Tab', 'Strip', 'Dus 10 Strip', 'Rama', 4000, 60, 0, 0, '2022-01-26 03:57:11', '2022-03-24 03:03:30'),
('1901O0138', 'Fatigon 60 Tab', 'Strip', 'Dus 15 Strip', 'Fatigon', 5000, 91, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0139', 'Fitkom Orange', 'Tab', 'Botol 21 Tab', 'Ftkom', 16000, 24, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0140', 'Hemaviton Action', 'Tab', 'Box 10 strip', 'Hemaviton', 7000, 21, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0141', 'Nufagesic syrup 60 ml', 'Botol', 'Botol 60 mL', 'Nufagesic', 7000, 2, 0, 0, '2022-01-19 16:56:50', '2022-03-24 03:03:30'),
('1901O0143', 'Inzana Tab', 'Strip', 'Box 25 strip', 'inzana', 1500, 51, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0144', 'Askamex Tab', 'strip', 'Box 50 strip', 'Askamex', 2500, 101, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0145', 'Betadine Solution 15 mL', 'Botol', 'Botol 15 ml', 'Betadine', 16000, 6, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('1901O0146', 'Betadine Solution 5 mL', 'Botol', 'Botol 5 ml', 'Betadine', 6000, 3, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0147', 'Biolysin Tab', 'strip', 'Box 10 strip', 'Biolysin', 6000, 21, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0148', 'Combantrin (OTC) 125 mg', 'Strip', 'Box 25 Strip', 'Combantrin', 17500, 50, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0149', 'Combantrin Susp Orange', 'Botol', 'Botol 10 ml', 'Combantrin', 20000, 8, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('1901O0150', 'Maximus 500', 'Blister', 'Box 30 Tab', 'Maximus', 18000, 7, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0151', 'methylprednisolon 4 mg Tab', 'Strip', 'Box 10 strip', 'Methylprednisolon', 4000, 21, 0, 0, '2022-01-23 02:04:06', '2022-03-24 03:03:30'),
('1901O0152', 'Mixagrip Flu', 'Strip', 'Box 25 @4 strip', 'Mixagrip', 2500, 51, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0153', 'Natur E sc', 'Strip', 'Box 4', 'Natur E', 5000, 9, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0154', 'Paracetamol 500 mg Tab', 'Strip', 'Box 30 strip', 'Nova', 3000, 151, 0, 0, '2022-01-26 03:57:11', '2022-06-21 05:11:46'),
('1901O0155', 'Pharmaton Formula', 'Strip', 'Box 10 Strip @5', 'Pharmaton', 28000, 21, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0156', 'Antangin JRG', 'Sachet', 'Dus 12', 'antangin', 3000, 49, 0, 0, '2022-01-24 13:11:10', '2022-03-24 03:03:30'),
('1901O0157', 'Antimo Dewasa Tab', 'strip', 'Box 72 cacth cover', 'antimo', 5000, 91, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0158', 'Antimo Anak Strawberry', 'Sachet', 'box 10', 'antimo', 2000, 21, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0159', 'Bodrexin Tab', 'Strip', 'pack 25 @4', 'Bodrexin', 2500, 51, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0160', 'Cooling 5 Mint', 'Botol', 'Botol', 'cooling', 43000, 3, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0161', 'Pharmaton Vit FCT', 'Strip', 'Box 10 Strip @5', 'pharmaton', 28000, 21, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0162', 'Polysilane Tab', 'Tab', 'Box 5 @8', 'Polysilane', 10000, 11, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0163', 'Procold Flu Kap', 'Strip', 'Box 24 blister', 'procold', 4000, 49, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0164', 'Tolak Angin Cair Anak', 'Sachet', 'Dus 12 Sachet', 'Tolak angin', 2500, 25, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0165', 'Natrium Diklofenak 25 mg', 'Strip', 'Box 50 Strip', 'Nadic', 4000, 11, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('1901O0166', 'Asam Mefenamat', 'Strip', 'Box 10 strip', 'Nova', 5000, 93, 0, 0, '2022-01-24 13:51:56', '2022-03-24 03:03:30'),
('1901O0167', 'Konidin Tab', 'strip', 'Box 50 Strip @4', 'konidin', 2500, 51, 0, 0, '2022-01-20 03:52:57', '2022-03-24 03:03:30'),
('1901O0168', 'Vicks Formula 44 anak Strawberry', 'botol', 'botol 27 mL', 'Vicks', 10000, 7, 0, 0, '2022-01-20 03:52:57', '2022-03-24 03:03:30'),
('1901O0169', 'Herocyn Kecil 85 gr', 'Botol', 'Botol 85 gr', 'herocyn', 13000, 6, 0, 0, '2022-01-24 13:13:49', '2022-03-24 03:03:30'),
('1901O0170', 'Herocyn Besar 150 gr', 'Botol', 'Botol 150 gr', 'herocyn', 23000, 3, 0, 0, '2022-01-19 06:10:04', '2022-03-24 03:03:30'),
('1901O0171', 'Formuno Kaplet', 'Strip', 'Box 10 strip', 'formuno', 90000, 1, 0, 0, '2022-01-19 04:02:11', '2022-03-24 03:03:30'),
('1901O0172', 'Histapan 50 mg Tab', 'Strip', 'Box 10 strip', 'histapan', 8500, 1, 0, 0, '2022-01-19 04:18:11', '2022-03-24 03:03:30'),
('1901O0173', 'Mefinal 500 mg', 'Strip', 'Box 10 strip', 'mefinal', 17000, 6, 0, 0, '2022-01-20 13:43:14', '2022-03-24 03:03:30'),
('1901O0174', 'Neo Kaolana syr 120 mL', 'Botol', 'Botol 120 mL', 'Neo Kaolana', 16000, 5, 0, 0, '2022-01-24 08:28:01', '2022-03-24 03:03:30'),
('1901O0175', 'Sanmag Suspensi syr', 'Botol', 'Botol 120 mL', 'sanmag', 32000, 7, 0, 0, '2022-01-24 08:28:01', '2022-03-24 03:03:30'),
('1901O0176', 'Ambroxol 30 mg Tab', 'Strip', 'Dus 10 Strip', 'ambroxol', 2500, 2, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0177', 'Antasida Doen Tab', 'Strip', 'Dus 10 Strip', 'antasida', 2500, 2, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0178', 'Cotrimoxazole Adult Tab', 'Strip', 'Dus 10 Strip', 'Cotri', 3500, 1, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0179', 'Cotrimoxazole Suspensi', 'Botol', 'Botol 60 ml', 'cotri', 8000, 5, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0180', 'Salbutamol 2 mg Tab', 'Strip', 'Dus 10 Strip', 'salbutamol', 2000, 1, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0181', 'Salicyl Fresh 60 g', 'Botol', 'Botol 60 gr', 'Kf', 16000, 5, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0182', 'Amoxicillin syr 250 mg', 'Botol', 'Botol 60 ml', 'Amoxicillin', 16000, 5, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0183', 'Fresh Air Surgical Mask Ear Loop', 'pcs', 'Dus 50 Pcs', 'Masker', 2500, 10, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0184', 'Atorvastatin 10 mg Tab', 'Strip', 'Dus 3 Strip', 'atorvastatin', 22000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0185', 'Bioplacenton Jelly', 'tube', 'Tube 15 g', 'bioplacenton', 25000, 2, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0186', 'Cefixime Kapsul 100 mg', 'Strip', 'Dus 5 Strip', 'Cefixime', 10000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0187', 'Cefixime Syr 100 mg', 'Botol', 'Botol 30 ml', 'cefixime', 23000, 3, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0188', 'Loratadine 10 mg', 'Strip', 'Dus 5 Strip', 'loratadine', 3000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0189', 'Meloxicam 15 mg', 'Strip', 'Dus 5 strip', 'Meloxicam', 8000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0190', 'Meloxicam 7,5 mg', 'Strip', 'Dus 5 Strip', 'Meloxicam', 5000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0191', 'Simvastatin Tab 10 mg', 'Strip', 'Dus 10 Strip', 'simvastatin', 3000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0192', 'Vicee Jeruk Tab', 'Strip', 'Dus 100 Tab', 'Vicee', 750, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0193', 'Voltaren Gel 10 g', 'Tube', 'Tube 10 g', 'voltaren', 53000, 1, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('1901O0194', 'Ambroxol syr', 'Botol', 'Botol 60 ml', 'ambroxol', 6000, 5, 0, 0, '2022-01-19 04:58:05', '2022-03-24 03:03:30'),
('1901O0195', 'Duckbill anak (cewek)', 'pcs', 'pcs', 'duckbill', 4000, 10, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0196', 'Duckbill anak (cowok)', 'pcs', 'pcs', 'duckbill', 4000, 10, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0197', 'KN95 Cewek', 'pcs', 'pcs', 'KN95', 8000, 10, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0198', 'KN95 Cowok', 'pcs', 'pcs', 'KN95', 8000, 10, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0199', 'Face Shield  Kacamata Anak-anak cewek', 'pcs', 'pcs', 'face shield', 10000, 5, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0200', 'Face shield akrilik pelindung', 'pcs', 'pcs', 'face shield', 50000, 1, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0201', 'Face shield kacamata Anak-anak cowok', 'pcs', 'pcs', 'face shield', 10000, 5, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0202', 'Premiere beaute Dispo Face Mask Hijab ( Blue)', 'pcs', 'pcs', 'premiere', 1500, 47, 0, 0, '2022-01-19 06:20:40', '2022-06-24 09:07:08'),
('1901O0203', 'Premiere beaute Dispo Face Mask Earloop (blue)', 'pcs', 'pcs', 'primiere', 1500, 38, 0, 0, '2022-01-19 06:20:40', '2022-06-23 05:19:02'),
('1901O0204', 'Premiere  Dispo Face Mask Earloop (Blue)', 'pcs', 'pcs', 'Premiere  Dispo Face Mask Earloop (Blue)', 1500, 49, 0, 0, '2022-01-19 06:20:40', '2022-06-21 07:12:13'),
('1901O0205', 'Premiere  Dispo Face Mask hijab (Blue)', 'pcs', 'pcs', 'Premiere  Dispo Face Mask hijab (Blue)', 1500, 50, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0206', 'EVO White', 'pcs', 'pcs', 'EV whitw', 10000, 10, 0, 0, '2022-01-19 06:20:40', '2022-03-24 03:03:30'),
('1901O0207', 'Minyak Tawon FF', 'Botol', 'Botol 90 ml', 'Minyak Tawon FF', 67000, 14, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0208', 'Minyak Tawon EE', 'Botol', 'Botol 60 ml', 'Minyak Tawon EE', 47000, 14, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0209', 'Herocyn Baby (L)', 'Botol', 'Botol 200 g', 'Herocyn Baby (L)', 13500, 1, 0, 0, '2022-01-22 13:43:11', '2022-03-24 03:03:30'),
('1901O0210', 'Herocyn Baby (S)', 'Botol', 'Botol 100g', 'Herocyn Baby (S)', 9000, 2, 0, 0, '2022-01-19 06:10:04', '2022-03-24 03:03:30'),
('1901O0211', 'Herocyn Mini 50g', 'Botol', 'Botol 50g', 'Herocyn Mini 50g', 9000, 5, 0, 0, '2022-01-24 13:13:49', '2022-03-24 03:03:30'),
('1901O0212', 'Neozep Forte tab', 'cathc', 'Dus 25 Cathc', 'Neozep Forte tab', 2500, 1, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0213', 'OBHC Batuk Flu anak Strawberry', 'Botol', 'Botol 60 ml', 'OBHC Batuk Flu anak Strawberry', 14000, 3, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0214', 'Panadol Cold & Flu', 'strip', 'Box 10 strip', 'Panadol Cold & Flu', 14000, 1, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0215', 'Paratusin Syr', 'Botol', 'Botol 60 ml', 'Paratusin Syr', 33000, 3, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0216', 'Paratusin Tab', 'Strip', 'Box 20 strip', 'Paratusin Tab', 14000, 1, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0217', 'Pimtrakol Cherry Syr', 'Botol', 'Botol 60 ml', 'Pimtrakol Cherry Syr', 14000, 5, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0218', 'Pimtrakol Plus Syr Lemon', 'Botol', 'Botol 60 ml', 'Pimtrakol Plus Syr Lemon', 14000, 5, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0219', 'Alpara Kaplet', 'Strip', 'Box 15 strip', 'Alpara Kaplet', 9000, 3, 0, 0, '2022-01-19 14:43:35', '2022-03-24 03:03:30'),
('1901O0220', 'Woods Cough Syr ATT 60 mL', 'Botol', 'Botol 60 ml', 'Woods Cough Syr ATT 60 mL', 20000, 5, 0, 0, '2022-01-19 14:49:00', '2022-03-24 03:03:30'),
('1901O0221', 'Vicks Formula 44 anak 54 mL', 'Botol', 'Botol 54 ml', 'Vicks Formula 44 anak 54 mL', 17000, 3, 0, 0, '2022-01-19 14:49:00', '2022-03-24 03:03:30'),
('1901O0222', 'Vicks Formula 44 dewasa 27 mL', 'Botol', 'Botol 27 ml', 'Vicks Formula 44 dewasa 27 mL', 9000, 5, 0, 0, '2022-01-19 14:49:00', '2022-03-24 03:03:30'),
('1901O0223', 'Dexamethasone 0,5 mg', 'Strip', 'Dus 20 Strip', 'Dexamethasone 0,5 mg', 3000, 60, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0224', 'Fitkom Grape 21', 'Tab', 'Botol 60 Tab', 'Fitkom Grape 21', 14000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0225', 'Fitkom jeruk 21', 'Tab', 'Botol 60 Tab', 'Fitkom jeruk 21', 14000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0226', 'Fitkom Strawberry', 'Tab', 'Botol 60 Tab', 'Fitkom Strawberry', 14000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0227', 'Fresh Care Cytrus 10 mL', 'Botol', 'Botol 10 ml', 'Fresh Care Cytrus 10 mL', 14000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0228', 'Fresh Care Green Tea 10 mL', 'Botol', 'Botol 10 ml', 'Fresh Care Green Tea 10 mL', 14000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0229', 'Fresh Care Lavender 10 mL', 'Botol', 'Botol 10 ml', 'Fresh Care Lavender 10 mL', 14000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0230', 'Fresh Care Minyak Angin Kayu Putih', 'Botol ', 'Botol 10 ml', 'Fresh Care Minyak Angin Kayu Putih', 14000, 6, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0231', 'Fresh Care MMA', 'Botol', 'Botol 10 ml', 'Fresh Care MMA', 14000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0232', 'Gandapura 30 mL', 'Botol', 'Botol 30 ml', 'Gandapura', 8000, 3, 0, 0, '2022-01-24 13:44:22', '2022-03-24 03:03:30'),
('1901O0233', 'Grafazol 500', 'Strip', 'Box 10 strip', 'Gandapura', 5000, 10, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0234', 'Hansaplast Pol 1,25 x 1 m', 'Rol', 'Box 20 Rol', 'Hansaplast Pol 1,25 x 1 m', 4000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0235', 'Hansaplast Strip', 'Strip', 'Box 100 Strip', 'Hansaplast Strip', 500, 100, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0236', 'Insto Eye Drops', 'Botol', 'Botol 7,5 mL', 'Insto Eye Drops', 14000, 7, 0, 0, '2022-01-26 03:49:56', '2022-03-24 03:03:30'),
('1901O0237', 'Laxing Caps', 'Blister', 'Box 25 Blister', 'Laxing Caps', 4000, 50, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0238', 'Lelap Kaplet', 'Tab', 'Box 25 Strip', 'Lelap Kaplet', 13000, 25, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0239', 'Magic Power Merah', 'dus', 'Pack 10 Dus', 'Magic Power Merah', 15000, 30, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0240', 'Magic Power Hitam', 'dus', 'Pack 10 dus', 'Magic Power Hitam', 15000, 30, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0241', 'Neo Rheumacyl Tab', 'tab', 'Strip ', 'Neo Rheumacyl Tab', 9000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0242', 'Neo Ultrasiline Cream', 'Tube', 'Box 12 Tube', 'Neo Ultrasiline Cream', 10000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0243', 'Neuralgin Rx Tab', 'Strip', 'Box 10 Blister', 'Neuralgin Rx Tab', 9000, 10, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0244', 'Ponstan 500 mg', 'strip', 'Box 10 Blister', 'Ponstan 500 mg', 32000, 10, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0245', 'Rohto Cool 7 mL', 'Botol', 'Botol 7 mL', 'Rohto Cool 7 mL', 17000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0246', 'Rohto Obat Mata', 'Botol', 'Botol 7 ml', 'Rohto Obat Mata', 13000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0247', 'Peditox Liquid', 'Botol', 'Botol 50 ml', 'Peditox Liquid', 9000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0248', 'Plossa Eucalyptus (Hijau)', 'pcs', 'pcs', 'Plossa Eucalyptus (Hijau)', 13000, 0, 0, 0, '2022-01-19 14:02:03', '2022-03-24 03:03:30'),
('1901O0249', 'Plossa Red Hot (Merah)', 'pcs', 'pcs', 'Plossa Red Hot (Merah)', 13000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0250', 'Polident Adhesive 60 gr', 'tube', 'Tube 60 gr', 'Polident Adhesive 60 gr', 79000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0251', 'Polysilane Suspensi', 'Botol', 'Botol 100 ml', 'Polysilane Suspensi', 25000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0252', 'Promag Tab 30 Strip', 'Strip', 'Pack 4 box @3', 'Promag Tab 30 Strip', 8000, 12, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0253', 'Puyer 1g', 'Sachet', 'Box 10 x 10', 'Puyer 1g', 7000, 100, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0254', 'Redoxon effervescent zinc', 'tube', 'Tube', 'Redoxon effervescent zinc', 43000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0255', 'Sakatonik ABC Grape', 'Tab', 'Botol 30 tab', 'Sakatonik ABC Grape', 16000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0256', 'Sakatonik ABC Orange', 'Tab', 'Botol 30 tab', 'Sakatonik ABC Orange', 16000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0257', 'Sakatonik ABC Strawberry', 'Tab', 'Botol 30 tab', 'Sakatonik ABC Strawberry', 16000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0258', 'Salonpas koyo', 'pcs', 'box 10', 'Salonpas koyo', 8000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0259', 'Salonpas Hot koyo', 'pcs', 'Box 10 ', 'Shimizu', 8000, 20, 0, 0, '2022-01-22 13:59:19', '2022-03-24 03:03:30'),
('1901O0260', 'Sensitive', 'pcs', 'Strip', 'Sensitive', 23000, 25, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0261', 'Siladex M & E', 'Botol', 'Botol 60 ml', 'Siladex M & E', 14000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0262', 'Super Tetra Soft Caps', 'Botol', 'Box 20 strip @6', 'Super Tetra Soft Caps', 9000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0263', 'Tempra syr', 'Botol', 'Botol 60 ml', 'Tempra syr', 47000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0264', 'Termorex 30 ml', 'Botol', 'Botol 30 ml', 'Termorex 30 ml', 10000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('1901O0265', 'Minyak Tawon GG 350 mL', 'Botol', 'Botol 350 ml', 'Minyak Tawon GG ', 230000, 5, 0, 0, '2022-01-24 13:37:06', '2022-03-24 03:03:30'),
('2001O0266', 'Domperidon Tab', 'Strip', 'Dus 10 Strip', 'Btr', 4000, 10, 0, 0, '2022-01-24 13:17:10', '2022-03-24 03:03:30'),
('2001O0267', 'Hansaplast Strip Jumbo', 'Strip', 'box 50 Lembar', 'Hansaplast', 750, 50, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0268', 'Im Boost Force Kid Syr', 'Botol', 'Botol 60 ml', 'Kf', 73000, 5, 0, 0, '2022-01-24 13:37:06', '2022-03-24 03:03:30'),
('2001O0269', 'Im Boost Kid Syr', 'Botol', 'Botol 60 ml', 'Kf', 40000, 4, 0, 0, '2022-01-24 13:37:06', '2022-03-24 03:03:30'),
('2001O0270', 'Kanna Krim Lembut', 'tube', 'tube 30 g', 'Kanna', 19000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0271', 'Kanna White 15gr', 'tube', 'tube 30gr', 'Kanna', 11000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0272', 'Kondom Fiesta Banana', 'dus', 'dus @3', 'Kondom fiesta', 12000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0273', 'Kondom Fiesta buble gum', 'dus', 'dus @3', 'Kondom', 12000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0274', 'Kondom Fiesta Delay', 'dus', 'dus @3', 'Kondom', 13000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0275', 'Kondom Fiesta Grape', 'dus', 'Dus @3', 'Kondom Fiesta', 12000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0276', 'Kondom Fiesta Strawberry', 'dus', 'Dus @3', 'Kondom Fiesta', 12000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0277', 'Krim 88 Anti Jamur', 'tube', 'tube 5gr', 'Krim 88', 21000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0278', 'Listerin Cool Mint 100 mL', 'Botol', 'Botol 100 ml', 'Listerin Cool Mint', 9000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0279', 'Listerin Cool Mint 250 mL', 'Botol', 'Botol 250 ml', 'Listerin Cool Mint', 23000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0280', 'Minyak Angin Kapak 28 mL', 'Botol', 'Botol 28 ml', 'Minyak Angin Kapak', 39000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0281', 'Minyak Angin Kapak 3 ml', 'Botol', 'Botol 3ml', 'Minyak Angin Kapak', 7000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0282', 'Minyak Angin Kapak 5ml', 'Botol', 'Botol 5 ml', 'Minyak Angin Kapak', 11000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0283', 'Microlax Tube', 'tube', 'Tube ', 'microlax', 24000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0284', 'Neo Entrostop', 'Strip', 'pack 6 dus', 'Neo Entrostop', 8000, 6, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0285', 'Omepros', 'Botol', 'Botol isi 30', 'Omepros', 146000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0286', 'One Med Test Kehamilan', 'pcs', 'Box 50 pcs', 'One Med', 3000, 50, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0287', 'Panadol Kaplet', 'Strip', 'Box 10 strip', 'Panadol', 11000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0288', 'Panadol Extra', 'Strip', 'Box 10 strip', 'Panadol Extra', 12000, 10, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0289', 'Proris Forte Syr', 'Botol', 'botol 50 ml', 'Proris', 35000, 3, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0290', 'Termorex Plus 30 ml', 'Botol', 'botol 30 ml', 'Termorex', 10000, 0, 0, 0, '2022-01-20 04:23:39', '2022-03-24 03:03:30'),
('2001O0291', 'Adem Sari 12x5 Sach', 'Sachet', 'box 5 Sachet', 'Adem Sari', 15000, 2, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0292', 'Ambeven New', 'Strip', 'Box 10 strip', 'Ambeven New', 17000, 30, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0293', 'AnaKonidin 60 ml', 'Botol', 'Botol 60 ml', 'AnaKonidin 60ml', 13000, 7, 0, 0, '2022-01-24 13:32:57', '2022-03-24 03:03:30'),
('2001O0294', 'Andalan O.C', 'dus', 'box 15 dus', 'Andalan O.C', 15000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2001O0295', 'Fresh Care Press & Relax', 'Botol', 'Botol 10 ml', 'Fresh Care Press & Relax', 14000, 12, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0296', 'Fresh Care Spalsh Fruity', 'Botol', 'Botol 10 ml', 'Fresh Care', 14000, 12, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0297', 'Fe Traches', 'Strip', 'Box 12 Strip', 'Fe Traches', 15000, 12, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0298', 'Feminax', 'Strip', 'Box 25 Strip @4', 'Feminax', 3000, 25, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0299', 'Entrostop Herbal Anak', 'box', 'Dus 6 box', 'Entrostop ', 13000, 3, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0300', 'Durex Strawberry', 'dus', 'Box 3 pcs', 'Durex', 21000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0301', 'Durex Extra safe', 'dus', 'Box 3 pcs', 'Durex', 21000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0302', 'Durex Comfort', 'dus', 'Box 3 pcs', 'Durex', 18000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0303', 'Diapet Syr Anak', 'Botol', 'Botol 60 ml', 'Diapet Syr Anak', 12000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0304', 'Diapet Tab', 'Strip', 'box 12 strip', 'Diapet', 5000, 12, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0305', 'Daktarin Cream 5g', 'tube', 'tube 5gr', 'Daktarin Cream 5g', 27000, 3, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0306', 'Cerebrofort Gold Orange', 'Botol', 'Botol 100 ml', 'Cerebrofort Gold Orange', 20000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0307', 'Cerebrofort Gold Strawberry', 'Botol', 'Botol 100 ml', 'Cerebrofort Gold', 20000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0308', 'Callusol 10 ml', 'Botol', 'Botol 10 ml', 'Callusol 10 ml', 33000, 2, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0309', 'Caladin Lotion', 'Botol', 'Botol 60 ml', 'Caladin Lotion', 17000, 3, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0310', 'Bye - Bye Fever For Children', 'pcs', 'box 5 pcs', 'Bye - Bye Fever', 11000, 10, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0311', 'Bye - Bye Fever For Babies', 'pcs', 'box 10 pcs', 'Bye - Bye Fever', 8000, 20, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0312', ' Bronksis Syr', 'Botol', 'Botol 60 ml', 'Bronksis', 9000, 5, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0313', 'Bodrex Migra Tab', 'Strip', 'Box 25 Strip', 'Bodrex', 2500, 50, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0314', 'Biolysin Syr', 'Botol', 'Botol 60 ml', 'Biolysin Syr', 14000, 5, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0315', 'Betadine Solution 30 mL', 'Botol', 'botol 30 ml', 'Betadine Solution 30 mL', 26000, 3, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0316', 'Betadine Plester Elastic Fabric', 'amplop', 'amplop', 'Betadine Plester Elastic Fabric', 5000, 3, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0317', 'Batugin Elixir 300 ml', 'Botol', 'botol 300 ml', 'Batugin Elixir 300 ml', 51000, 3, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0318', 'Baby Cough Syr', 'Botol', 'Botol 60 ml', 'Baby Cough Syr', 6000, 10, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('2001O0319', 'Lodia Tab 2mg', 'Strip', 'Box 10 strip', 'Lodia Tab 2mg', 8000, 30, 0, 0, '2022-01-24 08:28:01', '2022-03-24 03:03:30'),
('2003O0351', 'tes', 'tablet', 'box', 'c3', 6000, 18, 0, 0, '2022-03-20 12:12:57', '2022-03-24 03:03:30'),
('2101O0320', 'Prednison Tab', 'Strip', 'Box 10 strip', 'holi', 2000, 10, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2101O0322', 'Curcuma FCT', 'Strip', 'Box 10 strip', 'Curcuma FCT', 14000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2301O0323', 'Infus Set Dewasa (Aximed)', 'Pcs', 'Pcs', 'Aximed', 12000, 7, 0, 0, '2022-01-23 13:54:51', '2022-03-24 03:03:30'),
('2301O0324', 'Ringer Laktat Infus 500 ml (MJB)', 'Botol', 'Botol 500 ml', 'MJB', 14000, 0, 0, 0, '2022-01-23 13:48:28', '2022-03-24 03:03:30'),
('2301O0325', 'NaCl 0,9 % Infus (KF)', 'Botol', 'Botol 500 ml', 'Kimia Farma', 14000, 0, 0, 0, '2022-01-23 13:49:06', '2022-03-24 03:03:30'),
('2301O0326', 'Suntikan KB Andalan 1 Bulan', 'Vial', 'Dus 20 Vial', 'Andalan', 10000, 0, 0, 0, '2022-01-23 13:50:50', '2022-03-24 03:03:30'),
('2312O0053', 'Inza Kaplet', 'Strip', 'Dus 25 Strip', 'Konimex', 3000, 25, 0, 0, '2021-12-23 11:22:14', '2022-03-24 03:03:30'),
('2312O0054', 'Termorex Plus 60 ml', 'Botol 60 ml', 'Botol', 'Konimex', 17, 3, 0, 0, '2021-12-23 11:22:14', '2022-03-24 03:03:30'),
('2312O0055', 'Protecal Defense Effervescent', 'Tube', 'Tube', 'Konimex', 38000, 1, 0, 0, '2021-12-23 12:06:37', '2022-03-24 03:03:30'),
('2312O0056', 'Protecal Solid Effervescent ', 'Tube', 'Tube', 'Konimex', 37000, 1, 0, 0, '2021-12-23 12:06:46', '2022-03-24 03:03:30'),
('2312O0057', 'Protecal Osteo Effervescent', 'Tube', 'Tube', 'Konimex', 40000, 1, 0, 0, '2021-12-23 12:06:54', '2022-03-24 03:03:30'),
('2312O0058', 'Renovit Botol', 'Botol', 'Botol', 'Konimex', 86, 3, 0, 0, '2022-01-26 04:19:47', '2022-03-24 03:03:30'),
('2312O0059', 'Renovit Strip (New)', 'Strip', 'Dus 25 Strip', 'Konimex', 12000, 75, 0, 0, '2022-01-26 04:19:47', '2022-03-24 03:03:30'),
('2312O0060', 'Cooling 5 Spray', 'Botol 15 ml', 'Botol', 'Pharos', 39000, 2, 0, 0, '2022-01-08 13:35:00', '2022-03-24 03:03:30'),
('2312O0061', 'Medi-Klin Gel', 'Tube 15 gram', 'Tube', 'SDM', 30000, 1, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0062', 'Omeprazole Kaps (Novell)', 'Strip', 'Dus 3 Strip', 'Novell', 5000, 4, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('2312O0063', 'Medi-Klin TR gel', 'Tube', 'Dus', 'SDM', 53000, 1, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0064', 'Cetirizine 10 mg (NV)', 'Strip', 'Dus 5 Strip', 'Novell', 5000, 6, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('2312O0065', 'Albothyl Concentrate 5 ml', 'Botol 5 ml', 'Botol', 'Pharos', 31000, 1, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0066', 'PD Spoit 1 ml', 'Pcs', 'Pcs', 'PD', 2000, 1, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0067', 'PD Spoit 3 ml', 'Pcs', 'Pcs', 'PD', 2000, 1, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0068', 'Amlodipin Tablet 5 mg (NV)', 'Strip', 'Dus 3 Strip', 'Novell', 5000, 3, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0069', 'Ketokonazole Krim 2 %', 'Tube', 'Dus', 'Novell', 13000, 1, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0070', 'Forhead Thermometer MC 720', 'Pc', 'Dus', 'Omron', 700000, 10, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2312O0071', 'Antis Hand Rub Plus 500 ml', 'Botol 500 ml', 'Botol', 'Antis', 52000, 80, 0, 0, '2021-12-23 13:02:23', '2022-03-24 03:03:30'),
('2401O0327', 'Betametason 0,1% Cream', 'tube', 'tube', 'Betametason 0,1% Cream', 3000, 25, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0328', 'Calcium lactate 500 mg tab', 'Strip', 'Dus 10 Strip', 'mersi', 2000, 10, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0329', 'Gentamicin 0,1%', 'tube', 'Tube', 'Gentamicin 0,1%', 3500, 10, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0330', 'Glibenclamid', 'Strip', 'Dus 10 Strip', 'Pharos', 2000, 20, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0331', 'hydrocortison 2,5% Cream', 'tube', 'Tube', 'hydrocortison ', 5000, 24, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0332', 'Ketoconazole 200 mg Tab', 'Strip', 'dus 5 strip', 'Ketoconazole', 8000, 10, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0333', 'metronidazole 500 mg Tab', 'Strip', 'Dus 10 Strip', 'metronidazole', 4000, 20, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0334', 'Medika Alkohol 70% 100ml', 'Botol', 'Botol 100 ml', 'Medika Alkohol', 7000, 3, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0335', 'Medika Rivanol 100ml', 'Botol', 'Botol 100 ml', 'Medika Rivanol', 5000, 3, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0336', 'Oxytetracyclin 3% SK', 'tube', 'Tube', '0xytetracyclin 3%', 3000, 3, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0337', 'Piroxicam 10mg', 'Strip', 'Dus 10 Strip', 'Piroxicam 10mg', 3000, 10, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0338', 'Zink Dispersibel', 'Strip', 'Dus 10 Strip', 'Zink Dispersibel', 6000, 10, 0, 0, '2022-01-24 09:02:01', '2022-03-24 03:03:30'),
('2401O0339', 'Vicee Orange Tab', 'Strip', 'Box 100 Strip', 'Vicee Orange Tab', 1000, 100, 0, 0, '2022-01-24 13:11:10', '2022-03-24 03:03:30'),
('2401O0340', 'Tolak Angin Cair', 'Sachet', 'Box 12 Sachet', 'Tolak Angin Cair', 4000, 24, 0, 0, '2022-01-24 13:11:10', '2022-03-24 03:03:30'),
('2401O0341', 'Domperidone Suspensi 60ml', 'Botol', 'Botol 60 ml', 'Domperidone Suspensi 60ml', 6000, 3, 0, 0, '2022-01-24 13:17:10', '2022-03-24 03:03:30'),
('2401O0342', 'Hufagrip Pilek syr', 'Botol', 'Botol 60 ml', 'Hufagrip Pilek syr', 17000, 4, 0, 0, '2022-01-24 13:22:53', '2022-03-24 03:03:30'),
('2401O0343', 'Neo Napacin ', 'Strip', 'Box 50 Strip ', 'Neo Napacin ', 3000, 50, 0, 0, '2022-01-24 13:29:47', '2022-03-24 03:03:30'),
('2401O0344', 'Paramex Flu dan Batuk New', 'Strip', 'Box 25 Strip', 'Paramex Flu dan Batuk New', 3000, 25, 0, 0, '2022-01-24 13:29:47', '2022-03-24 03:03:30'),
('2401O0345', 'Vicee Strawberry Tab', 'Strip', 'Box 50 Strip', 'Vicee Strawberry Tab', 1000, 100, 0, 0, '2022-01-24 13:51:56', '2022-03-24 03:03:30'),
('2401O0346', 'Inhaler Lang', 'pcs', 'pcs', 'Inhaler Lang', 8000, 20, 0, 0, '2022-01-24 13:55:00', '2022-03-24 03:03:30'),
('2401O0347', 'OBHC Batuk Flu Jahe', 'Botol', 'Botol 60 ml', 'OBHC Batuk Flu Jahe', 13000, 3, 0, 0, '2022-01-24 14:01:33', '2022-03-24 03:03:30'),
('2401O0348', 'OBHC Batuk Flu Menthol', 'Botol', 'Botol 60 ml', 'OBHC Batuk Flu Menthol', 13000, 3, 0, 0, '2022-01-24 14:01:33', '2022-03-24 03:03:30'),
('2401O0349', 'OBHC Batuk Flu Madu', 'Botol', 'Botol 100 ml', 'OBHC Batuk Flu Madu', 18000, 2, 0, 0, '2022-01-24 14:01:33', '2022-03-24 03:03:30'),
('2403O0352', 'obat tes', 'cet', 'box', 'c3', 233333, 0, 0, 0, '2022-03-24 02:02:32', '2022-03-24 03:03:30'),
('2403O0353', 'tes 2', 'tablet', 'box', 'c3', 23232, 0, 0, 0, '2022-03-24 02:06:23', '2022-03-24 03:03:30'),
('2403O0354', 'tes 3', 'tablet', 'box', 'c3', 2323, 0, 0, 0, '2022-03-24 02:08:26', '2022-03-24 03:03:30'),
('2403O0355', 'te7', 'tablet', 'box', 'c3', 23232, 2, 0, 0, '2022-03-24 02:52:11', '2022-03-24 03:03:30'),
('2403O0356', 'tes bro', 'dsds', 'dsds', 'dsd', 4000, 2, 0, 0, '2022-03-24 02:37:06', '2022-03-24 03:03:30'),
('2403O0357', 'coba', 'tablet', 'box', 'c3', 5000, 0, 0, 0, NULL, '2022-03-24 03:06:38'),
('2403O0358', 'tes lagi', 'tablet', 'box', 'c3', 33333, 0, 0, 0, NULL, '2022-03-24 03:10:31'),
('2403O0359', 'dsds', 'tablet', 'box', 'c3', 2222, 0, 0, 0, NULL, '2022-03-24 03:15:05'),
('2403O0360', 'DADASD', 'tablet', 'box', 'c3', 40000, 2, 0, 0, '2022-03-24 03:35:21', '2022-03-24 03:36:36'),
('2411O0048', 'Minyak Kayu Putih 60 ml', 'Botol 60 ml', 'Botol', 'Cap Lang', 22000, 26, 0, 0, '2022-01-26 04:03:33', '2022-03-24 03:03:30'),
('2411O0049', 'Minyak Tawon DD', 'Botol 30 mL', 'Botol', 'Tawon Jaya', 30000, 32, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2411O0050', 'Minyak Tawon CC', 'Botol 20 ml', 'Botol', 'Tawon Jaya', 23000, 8, 0, 0, '2022-01-19 06:10:04', '2022-03-24 03:03:30'),
('2411O0051', 'Balsem Otot Geliga 20 g', 'Pot 20 g', 'Pot', 'Eagle Indofarma', 10000, 5, 0, 0, '2022-01-01 09:48:01', '2022-03-24 03:03:30'),
('2411O0052', 'Balsem Lang', 'Pot 20 g', 'Pot', 'Eagle Indofarma', 10000, 2, 0, 0, '2021-11-24 11:54:19', '2022-03-24 03:03:30'),
('2512O0072', 'Vicks Vaporub 25 gr', 'Pot 25 gr', 'Pot 25 gr', 'Vicks', 20000, 5, 0, 0, '2022-01-19 05:33:39', '2022-03-24 03:03:30'),
('2512O0073', 'Vicks Vaporub 10 gr', 'Pot 10 gr', 'Pot', 'Vicks', 9000, 12, 0, 0, '2022-01-26 03:49:56', '2022-03-24 03:03:30'),
('2512O0074', 'Enervon C Tab', 'Strip', 'Dus 25 Strip', 'Darya Varia', 6000, 27, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('2601O0350', 'Insto Moist 7,5 ml', 'Botol', 'Botol 7,5 ml', 'Insto Moist 7,5 ml', 14000, 3, 0, 0, '2022-01-26 03:49:56', '2022-03-24 03:03:30'),
('2612O0075', 'Salep 88', 'Pot', 'Pot', 'Meccaya', 12000, 12, 0, 0, '2021-12-26 12:31:45', '2022-03-24 03:03:30'),
('3112O0077', 'Bodrex Flu dan Batuk PE', 'Strip', 'Dus 25 Strip', 'Tempo', 2500, 102, 0, 0, '2022-01-20 03:48:24', '2022-03-24 03:03:30'),
('3112O0078', 'Bodrex Extra', 'Strip', 'Dus 25 Strip', 'Tempo', 2500, 125, 0, 0, '2022-01-22 13:42:11', '2022-03-24 03:03:30'),
('3112O0079', 'IPI Vitamin C', 'Botol', 'Botol 45 Tab', 'Tempo', 6000, 2, 0, 0, '2021-12-30 21:20:19', '2022-03-24 03:03:30'),
('3112O0080', 'Eyefresh 0,6 ml MD', 'Mini Dose', 'Mini Dose', 'Cendo', 6000, 10, 0, 0, '2021-12-31 11:16:06', '2022-03-24 03:03:30'),
('3112O0081', 'Cendo Xitrol 0,6 ml MD', 'Mini Dose', 'Mini Dose', 'Cendo', 7000, 10, 0, 0, '2021-12-31 11:16:06', '2022-03-24 03:03:30'),
('3112O0082', 'Cendo Posop 0,6 ml', 'Mini Dose', 'Mini Dose', 'Cendo', 14000, 60, 0, 0, '2022-01-07 13:57:34', '2022-03-24 03:03:30'),
('3112O0083', 'Mometasone Furoate Krim 5 g', 'Tube', 'Tube', 'Nulab', 17000, 3, 0, 0, '2021-12-31 11:16:06', '2022-03-24 03:03:30'),
('3112O0084', 'Acetylcystein 200 mg', 'Strip', 'Dus 10 Strip', 'Nulab', 13000, 10, 0, 0, '2021-12-31 11:16:06', '2022-03-24 03:03:30'),
('3112O0085', 'Komix Jahe G Formula', 'Sachet', 'Sachet', 'Kalbe', 2000, 61, 0, 0, '2022-01-20 03:52:57', '2022-03-24 03:03:30'),
('3112O0086', 'Komix Jeruk Nipis', 'Sachet', 'Sachet', 'Kalbe', 2000, 61, 0, 0, '2022-01-20 03:52:57', '2022-03-24 03:03:30'),
('3112O0087', 'Grantusif Tablet', 'Strip', 'Dus 10 Strip', 'Graha Farma', 5000, 10, 0, 0, '2022-01-01 08:46:34', '2022-03-24 03:03:30'),
('3112O0088', 'Pi Kang Suang Krim 5 g', 'Tube', 'Tube', 'Pi Kang', 13000, 20, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('3112O0089', 'CDR Effervecent', 'Tube', 'Tube', 'Bayer', 47000, 12, 0, 0, '2022-01-21 13:26:44', '2022-03-24 03:03:30'),
('3112O0090', 'Kalpanax K Cream 5 g', 'Tube', 'Tube', 'Kalbe', 15000, 5, 0, 0, '2022-01-21 13:01:24', '2022-03-24 03:03:30'),
('3112O0091', 'Sangobion Tab 250', 'Strip', 'Dus 25 Strip', 'Merck', 17000, 25, 0, 0, '2022-01-01 08:52:36', '2022-03-24 03:03:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id_suplier` int(11) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `hp` varchar(100) NOT NULL,
  `alamat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_suplier`, `nama_supplier`, `hp`, `alamat`) VALUES
(12, 'PT. Antarmitra Sembada', '085', 'Jl. Tumanurung No. 3B RT 02/RW 05 Makassar'),
(13, 'PT. Matakar Kendari', '0401-3129976', 'Jl. Supu Yusuf'),
(14, 'PT. Tempo', '08001509999', 'Jl. Pattimura No. 88 Kendari'),
(15, 'PT. Penta Valent', '081343857603', 'Jl. MTQ Kendari\r\n'),
(16, 'PT. Butora', '082195307467', 'Jl. Pintu Selatan II No. 99 Kolaka\r\n'),
(17, 'PT. Niaga Mitra Maju', '085342173000', 'Lalomba'),
(18, 'PT. Marga Nusantara Jaya', '4603146', 'Jl. Pahlawan No. 1'),
(19, 'PT. Anugrah Pharmindo Lestari', '085', 'Makassar'),
(20, 'PT. Distributor Farmasi Kendari', '081340013103', 'Jl. Banawula Sinapoy No. 168 Kendari'),
(21, 'PT. Kimia Farma TD', '0401-3193918', 'Jl. Belimbing  No. Kel Anduonohu'),
(22, 'PT. Bina San Prima', '0411-4730510', 'Komp. Pergudangan dan Industri Parangloe Indah Blok L1 No. 2, 3 & 6 Makassar'),
(23, 'PT. Millenium Pharmacon Internasional (MPI)', '085', 'Makassar'),
(24, 'PT. Tri Sapta Jaya', '085', 'jalan'),
(25, 'tes', '2323', '12323213'),
(26, 'tes 2', '3232', '3123'),
(27, 'tes 4', '2323', '23232'),
(28, 'tes dsd', '3232', '3232');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_aktifitas`
--

CREATE TABLE `tbl_aktifitas` (
  `id` int(11) NOT NULL,
  `kd_aktifitas` varchar(100) NOT NULL,
  `aktifitas` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_aktifitas`
--

INSERT INTO `tbl_aktifitas` (`id`, `kd_aktifitas`, `aktifitas`) VALUES
(1, '2', 'UPDATE'),
(2, '3', 'DELETE');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_exp_date`
--

CREATE TABLE `tbl_exp_date` (
  `id` int(11) NOT NULL,
  `id_dtl_pembelian` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_exp_date`
--

INSERT INTO `tbl_exp_date` (`id`, `id_dtl_pembelian`) VALUES
(2, 536),
(3, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transkasi_penjualan`
--

CREATE TABLE `transkasi_penjualan` (
  `kd_transaksi` varchar(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_pembeli` varchar(50) NOT NULL,
  `alamat_pembeli` varchar(100) NOT NULL,
  `note` varchar(100) NOT NULL,
  `total_trx` int(11) NOT NULL,
  `total_bayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL,
  `waktu_trx` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transkasi_penjualan`
--

INSERT INTO `transkasi_penjualan` (`kd_transaksi`, `id_user`, `nama_pembeli`, `alamat_pembeli`, `note`, `total_trx`, `total_bayar`, `kembalian`, `waktu_trx`) VALUES
('010122001', 1, '', '', '', 20000, 20000, 0, '2022-01-01 11:11:47'),
('070622001', 1, '', '', '', 2500, 50000, 47500, '2022-06-07 07:06:34'),
('080122001', 1, '', '', '', 39000, 50000, 11000, '2022-01-08 13:35:00'),
('080122002', 1, '', '', '', 10000, 10000, 0, '2022-01-08 13:35:28'),
('180122001', 1, 'mama ipa', 'jl. dg. pasau', '', 37000, 100000, 63000, '2022-01-18 08:45:02'),
('180122002', 1, '', '', '', 15000, 15000, 0, '2022-01-18 10:35:58'),
('200122001', 1, '', '', '', 15000, 15000, 0, '2022-01-20 13:42:24'),
('200122002', 1, '', '', '', 17000, 20000, 3000, '2022-01-20 13:43:14'),
('200322001', 1, '', '', '', 2500, 10000, 7500, '2022-03-20 11:54:01'),
('200322002', 1, '', '', '', 2500, 10000, 7500, '2022-03-20 12:04:13'),
('200322003', 1, 'aad', 'lepo', '-', 12000, 15000, 3000, '2022-03-20 12:12:57'),
('210322001', 1, 'saya', '', '', 2500, 50000, 47500, '2022-03-21 03:51:56'),
('210622001', 7, '', '', '', 2500, 5000, 2500, '2022-06-21 02:56:06'),
('210622002', 7, '', '', '', 2500, 5000, 2500, '2022-06-21 05:05:28'),
('210622003', 7, '', '', '', 6500, 10000, 3500, '2022-06-21 05:08:31'),
('210622004', 7, '', '', '', 4500, 5000, 500, '2022-06-21 05:11:46'),
('210622005', 7, '', '', '', 3000, 5000, 2000, '2022-06-21 05:49:01'),
('210622006', 7, '', '', '', 3000, 5000, 2000, '2022-06-21 05:59:38'),
('210622007', 7, '', '', '', 3000, 5000, 2000, '2022-06-21 06:29:56'),
('210622008', 7, '', '', '', 3000, 5000, 2000, '2022-06-21 07:12:13'),
('210622009', 7, '', '', '', 3000, 5000, 2000, '2022-06-21 07:23:50'),
('220122001', 1, '', '', '', 5000, 5000, 0, '2022-01-22 13:41:20'),
('220122002', 1, '', '', '', 4000, 4000, 0, '2022-01-22 13:42:11'),
('220122003', 1, '', '', '', 13000, 13000, 0, '2022-01-22 13:43:11'),
('220122004', 1, '', '', '', 4000, 4000, 0, '2022-01-22 13:53:17'),
('220322001', 1, '', '', '', 200000, 200000, 0, '2022-03-22 03:11:13'),
('220322002', 1, '', '', '', 2500, 5000, 2500, '2022-03-22 03:39:11'),
('220322003', 1, '', '', '', 5000, 10000, 5000, '2022-03-22 03:41:21'),
('220322004', 1, '', '', '', 5000, 10000, 5000, '2022-03-22 03:41:50'),
('220322005', 1, 'Putu', 'Jl adakah\r\n', '', 5000, 10000, 5000, '2022-03-22 07:28:00'),
('220322006', 1, '', '', '', 22000, 50000, 28000, '2022-03-22 07:29:32'),
('220622001', 7, '', '', '', 2500, 5000, 2500, '2022-06-22 14:54:11'),
('220622002', 7, '', '', '', 2500, 10000, 7500, '2022-06-22 14:58:12'),
('220622003', 7, '', '', '', 2500, 50000, 47500, '2022-06-22 15:13:09'),
('220622004', 7, '', '', '', 2500, 20000, 17500, '2022-06-22 15:14:27'),
('220622005', 7, '', '', '', 2500, 10000, 7500, '2022-06-22 15:27:02'),
('220622006', 7, '', '', '', 17000, 50000, 33000, '2022-06-22 15:31:52'),
('220622007', 7, '', '', '', 10000, 10000, 0, '2022-06-22 15:36:39'),
('221121001', 1, '', '', '', 23000, 30000, 7000, '2021-11-22 09:13:18'),
('230122001', 1, '', '', '', 7000, 7000, 0, '2022-01-23 02:04:06'),
('230622001', 7, '', '', '', 19000, 100000, 81000, '2022-06-23 05:19:02'),
('230622002', 7, '', '', '', 6000, 10000, 4000, '2022-06-23 07:29:41'),
('241121001', 1, '', '', '', 23000, 30000, 7000, '2021-11-24 12:17:14'),
('241121002', 1, '', '', '', 43000, 50000, 7000, '2021-11-24 12:17:35'),
('241221001', 1, 'kidang', 'jl. nuri no. 2', '', 83000, 83000, 0, '2021-12-24 08:08:40'),
('311221001', 1, '', '', '', 25000, 25000, 0, '2021-12-31 11:25:27');

--
-- Trigger `transkasi_penjualan`
--
DELIMITER $$
CREATE TRIGGER `hapus_trx_penjualan` BEFORE DELETE ON `transkasi_penjualan` FOR EACH ROW BEGIN
        DELETE FROM detail_trx_penjualan WHERE kd_transaksi = OLD.kd_transaksi; 
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(128) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(156) NOT NULL,
  `role_id` int(11) NOT NULL,
  `waktu_buat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `password`, `role_id`, `waktu_buat`) VALUES
(7, 'admin', 'admin', '$2y$10$vi6EUm52wb7XTTU/W4amGuKwptUE82w.13p9qHn9KLCn1s.6CGu1q', 1, '2022-03-20 11:24:28'),
(8, 'erzena', 'erzena', '$2y$10$nMtPjyDzQytBlAe7qPToeOAZ/54lT2Uxn7SPdUCespNFA3a6lvOiy', 1, '2022-01-17 13:01:09'),
(9, 'aad', 'aad', '$2y$10$VHFpxK6Z8FYgi97Vvpltauyr8SopHAvBRe7kTeoX3C5UlSdnu2exW', 2, '2022-03-20 12:16:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_role`
--

INSERT INTO `user_role` (`id`, `role`) VALUES
(1, 'Admin'),
(2, 'Karyawan');

-- --------------------------------------------------------

--
-- Struktur untuk view `laporan1`
--
DROP TABLE IF EXISTS `laporan1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporan1`  AS SELECT `a`.`kd_obat` AS `kd_obat`, `c`.`nama_obat` AS `nama_obat`, `a`.`harga_beli` AS `harga_beli`, sum(`a`.`qty`) AS `penambahan`, 0 AS `pengurangan` FROM ((`detail_pembelian` `a` left join `faktur_pembelian` `b` on(`a`.`no_faktur` = `b`.`no_faktur`)) left join `master_obat` `c` on(`c`.`kd_obat` = `a`.`kd_obat`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD PRIMARY KEY (`id_dtl_pembelian`),
  ADD KEY `no_faktur` (`no_faktur`);

--
-- Indeks untuk tabel `detail_trx_penjualan`
--
ALTER TABLE `detail_trx_penjualan`
  ADD PRIMARY KEY (`id_dtl_trx_jual`),
  ADD KEY `kd_transaksi` (`kd_transaksi`);

--
-- Indeks untuk tabel `faktur_pembelian`
--
ALTER TABLE `faktur_pembelian`
  ADD PRIMARY KEY (`no_faktur`),
  ADD KEY `id_suplier` (`id_suplier`);

--
-- Indeks untuk tabel `log_data_master`
--
ALTER TABLE `log_data_master`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `master_obat`
--
ALTER TABLE `master_obat`
  ADD PRIMARY KEY (`kd_obat`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_suplier`);

--
-- Indeks untuk tabel `tbl_aktifitas`
--
ALTER TABLE `tbl_aktifitas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_exp_date`
--
ALTER TABLE `tbl_exp_date`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transkasi_penjualan`
--
ALTER TABLE `transkasi_penjualan`
  ADD PRIMARY KEY (`kd_transaksi`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  MODIFY `id_dtl_pembelian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `detail_trx_penjualan`
--
ALTER TABLE `detail_trx_penjualan`
  MODIFY `id_dtl_trx_jual` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT untuk tabel `log_data_master`
--
ALTER TABLE `log_data_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_suplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `tbl_aktifitas`
--
ALTER TABLE `tbl_aktifitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_exp_date`
--
ALTER TABLE `tbl_exp_date`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD CONSTRAINT `detail_pembelian_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `faktur_pembelian` (`no_faktur`);

--
-- Ketidakleluasaan untuk tabel `detail_trx_penjualan`
--
ALTER TABLE `detail_trx_penjualan`
  ADD CONSTRAINT `detail_trx_penjualan_ibfk_1` FOREIGN KEY (`kd_transaksi`) REFERENCES `transkasi_penjualan` (`kd_transaksi`);

--
-- Ketidakleluasaan untuk tabel `faktur_pembelian`
--
ALTER TABLE `faktur_pembelian`
  ADD CONSTRAINT `faktur_pembelian_ibfk_1` FOREIGN KEY (`id_suplier`) REFERENCES `supplier` (`id_suplier`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
