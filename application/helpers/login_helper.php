<?php
//function cek akses blum login
function is_logged_in()
{
    $ci = get_instance();
    if (!$ci->session->userdata('logged_in')) {
        redirect('login');
    }
}

function cekAdmin()
{
    $ci = get_instance();
    if (!$ci->session->userdata('logged_in') && $ci->session->userdata('logged_in') != '1') {
        redirect('login');
    }
}

function rupiah($angka)
{

    $hasil_rupiah = "Rp " . number_format($angka, 0, ',', '.');
    return $hasil_rupiah;
}

function GetMACAdd()
{
    ob_start();
    system('getmac');
    $Content = ob_get_contents();
    ob_clean();
    return (substr($Content, strpos($Content, '\\') - 20, 17)) == '8C-8C-AA-B5-48-9F' ? true : false;
}

function cekHost()
{
    return (gethostname()) == 'DESKTOP-AEGLGP4' ? true : false;
}
