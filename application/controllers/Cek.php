<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Cek extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        if (GetMACAdd()) {
            redirect('login');
        } else {
            echo "error : anda tidak memiliki akses ke aplikasi";
        }
    }
}
