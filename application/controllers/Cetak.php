<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Cetak extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        // $this->load->library('session');
        // $this->load->model('UserModel');
        // $this->load->model('TriggerModel');
        // is_logged_in();
        $this->load->helper('print');
    }
    public function cetak()
    {
        $res = [
            "code" => "00",
            "msg" => "success"
        ];

        $data =  $this->input->post();
        if ($data) {
            if ($data == "" || $data == null) {
                $res = [
                    "code" => "99",
                    "msg" => "success"
                ];
                echo json_encode($res);
            } else {
                $user = ($this->session->userdata('nama')) ? $this->session->userdata('nama') : "Admin";
                struk($data, $user);
                echo json_encode($res);
            }
        }
    }
}
