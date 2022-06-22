<?php
/* Call this file 'hello-world.php' */
require FCPATH . '/vendor/autoload.php';

use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
use Mike42\Escpos\CapabilityProfile;
use Mike42\Escpos\Printer;

function struk($data, $user)
{
    $profile = CapabilityProfile::load("simple");
    $connector = new WindowsPrintConnector("RP58Printer");
    $printer = new Printer($connector, $profile);

    $orderId = $data['order_id'];
    $total = $data['tagihan_simpan'];
    $tunai = $data['bayar_simpan'];
    $kembalian = $data['kembalian_simpan'];
    // $printer->initialize();
    // $printer->selectPrintMode(Printer::MODE_FONT_A);
    // $printer->text(buatBaris1Kolom("Apotek Kiya Medika"));
    // $printer->text(buatBaris1Kolom(""));
    // $printer->text(buatBaris1Kolom("Alamat : Jl. Jend. Ahmad Yani, Pondambea"));
    // $printer->text(buatBaris1Kolom("Hp :  0853-4269-7757"));


    // Membuat judul
    $printer->initialize();
    $printer->selectPrintMode(Printer::MODE_DOUBLE_HEIGHT); // Setting teks menjadi lebih besar
    $printer->setJustification(Printer::JUSTIFY_CENTER); // Setting teks menjadi rata tengah
    $printer->text("Apotek Kiya Medika\n");
    $printer->text("\n");
    $printer->initialize();
    $printer->text("Alamat : Jl. Jend. Ahmad Yani,  Pondambea\n");
    $printer->text("Hp :  0853-4269-7757\n");

    // Membuat tabel
    $printer->initialize(); // Reset bentuk/jenis teks
    $printer->text("--------------------------------\n");
    $printer->text("Order Id : " . $orderId . "\n");
    $printer->text("Operator : " . $user . "\n");
    $printer->text("Time : " . date("d-m-Y h:i:s") . "\n");
    $printer->text("--------------------------------\n");

    for ($i = 0; $i < count($data['arrnama']); $i++) {
        $printer->text(buatBaris1Kolom($data['arrnama'][$i]));
        $printer->text(buatBaris3Kolom($data['arr_qty'][$i] . ' x', formatRp($data['arr_harga'][$i]), formatRp($data['arr_subtotal'][$i])));
    }

    // $printer->text(buatBaris3Kolom("2pcs", "15.000", "30.000"));
    // $printer->text(buatBaris3Kolom("2pcs", "5.000", "10.000"));
    // $printer->text(buatBaris3Kolom("1pcs", "8.200", "16.400"));
    $printer->text("--------------------------------\n");
    $printer->text(buatBaris3Kolom('', "Total", formatRp($total)));
    $printer->text(buatBaris3Kolom('', "Tunai", formatRp($tunai)));
    $printer->text(buatBaris3Kolom('', "Kembalian", formatRp($kembalian)));
    $printer->text("\n");

    // Pesan penutup
    $printer->initialize();
    $printer->setJustification(Printer::JUSTIFY_CENTER);
    $printer->text("Terima kasih\n");

    $printer->cut();
    $printer->close();
}

function buatBaris1Kolom($kolom1)
{
    // Mengatur lebar setiap kolom (dalam satuan karakter)
    $lebar_kolom_1 = 32;

    // Melakukan wordwrap(), jadi jika karakter teks melebihi lebar kolom, ditambahkan \n 
    $kolom1 = wordwrap($kolom1, $lebar_kolom_1, "\n", true);

    // Merubah hasil wordwrap menjadi array, kolom yang memiliki 2 index array berarti memiliki 2 baris (kena wordwrap)
    $kolom1Array = explode("\n", $kolom1);

    // Mengambil jumlah baris terbanyak dari kolom-kolom untuk dijadikan titik akhir perulangan
    $jmlBarisTerbanyak = count($kolom1Array);

    // Mendeklarasikan variabel untuk menampung kolom yang sudah di edit
    $hasilBaris = array();

    // Melakukan perulangan setiap baris (yang dibentuk wordwrap), untuk menggabungkan setiap kolom menjadi 1 baris 
    for ($i = 0; $i < $jmlBarisTerbanyak; $i++) {

        // memberikan spasi di setiap cell berdasarkan lebar kolom yang ditentukan, 
        $hasilKolom1 = str_pad((isset($kolom1Array[$i]) ? $kolom1Array[$i] : ""), $lebar_kolom_1, " ");

        // Menggabungkan kolom tersebut menjadi 1 baris dan ditampung ke variabel hasil (ada 1 spasi disetiap kolom)
        $hasilBaris[] = $hasilKolom1;
    }

    // Hasil yang berupa array, disatukan kembali menjadi string dan tambahkan \n disetiap barisnya.
    return join("\n", $hasilBaris) . "\n";
}

function buatBaris3Kolom($kolom1, $kolom2, $kolom3)
{
    // Mengatur lebar setiap kolom (dalam satuan karakter)
    $lebar_kolom_1 = 4;
    $lebar_kolom_2 = 10;
    $lebar_kolom_3 = 14;

    // Melakukan wordwrap(), jadi jika karakter teks melebihi lebar kolom, ditambahkan \n 
    $kolom1 = wordwrap($kolom1, $lebar_kolom_1, "\n", true);
    $kolom2 = wordwrap($kolom2, $lebar_kolom_2, "\n", true);
    $kolom3 = wordwrap($kolom3, $lebar_kolom_3, "\n", true);

    // Merubah hasil wordwrap menjadi array, kolom yang memiliki 2 index array berarti memiliki 2 baris (kena wordwrap)
    $kolom1Array = explode("\n", $kolom1);
    $kolom2Array = explode("\n", $kolom2);
    $kolom3Array = explode("\n", $kolom3);

    // Mengambil jumlah baris terbanyak dari kolom-kolom untuk dijadikan titik akhir perulangan
    $jmlBarisTerbanyak = max(count($kolom1Array), count($kolom2Array), count($kolom3Array));

    // Mendeklarasikan variabel untuk menampung kolom yang sudah di edit
    $hasilBaris = array();

    // Melakukan perulangan setiap baris (yang dibentuk wordwrap), untuk menggabungkan setiap kolom menjadi 1 baris 
    for ($i = 0; $i < $jmlBarisTerbanyak; $i++) {

        // memberikan spasi di setiap cell berdasarkan lebar kolom yang ditentukan, 
        $hasilKolom1 = str_pad((isset($kolom1Array[$i]) ? $kolom1Array[$i] : ""), $lebar_kolom_1, " ");
        // memberikan rata kanan pada kolom 3 dan 4 karena akan kita gunakan untuk harga dan total harga
        $hasilKolom2 = str_pad((isset($kolom2Array[$i]) ? $kolom2Array[$i] : ""), $lebar_kolom_2, " ", STR_PAD_LEFT);

        $hasilKolom3 = str_pad((isset($kolom3Array[$i]) ? $kolom3Array[$i] : ""), $lebar_kolom_3, " ", STR_PAD_LEFT);

        // Menggabungkan kolom tersebut menjadi 1 baris dan ditampung ke variabel hasil (ada 1 spasi disetiap kolom)
        $hasilBaris[] = $hasilKolom1 . " " . $hasilKolom2 . " " . $hasilKolom3;
    }

    // Hasil yang berupa array, disatukan kembali menjadi string dan tambahkan \n disetiap barisnya.
    // return implode($hasilBaris, "\n");
    return join("\n", $hasilBaris) . "\n";
}

function formatRp($angka)
{
    $hasil_rupiah =  number_format($angka, 0, ',', '.');
    return $hasil_rupiah;
}
