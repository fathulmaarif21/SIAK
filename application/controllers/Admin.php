<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Admin extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        cekAdmin();
        $this->load->model('ObatModel');
        $this->load->model('TrxPenjualanModel');
        $this->load->model('SupplierModel');
        $this->load->model('FakturPembelianModel');
        $this->load->model('UserModel');
        date_default_timezone_set('Asia/Ujung_Pandang');
    }

    public function index()
    {
        // dd($this->ObatModel->findAll());
        $this->load->view('admin/dashboard/index');
    }
    public function tes()
    {
        $var = '20/04/2012';
        echo date('Y-m-d', strtotime(str_replace('/', '-', $var)));
        // var_dump(date('Y-m-d', strtotime('17/02/2021')));
    }

    // Master Obat
    public function viewMasterObat()
    {
        $data['title'] = 'Data Master Obat';
        $this->load->view('admin/masterObat/index', $data);
    }

    function getObatById($kdObat)
    {
        $data =  $this->ObatModel->obatById($kdObat);
        echo json_encode($data);
    }
    function get_no_faktur($kdObat)
    {
        $data =  $this->ObatModel->getNofaktur($kdObat)->result();
        echo json_encode($data);
    }

    public function updateObat()
    {
        $kd_obat = $this->input->post('kd_obat');
        $nama_obat = $this->input->post('nama_obat');
        $satuan = $this->input->post('satuan');
        $kemasan = $this->input->post('kemasan');
        $prinsipal = $this->input->post('prinsipal');
        $harga_jual = $this->input->post('harga_jual');
        $stok = $this->input->post('stok');
        // $autokode = $this->ObatModel->autoKdObat();
        // echo 'O' . date('dm') . $autokode;
        $update = [
            "nama_obat" => $nama_obat,
            "satuan" => $satuan,
            "kemasan" => $kemasan,
            "prinsipal" => $prinsipal,
            "harga_jual" => $harga_jual,
            "stok" => $stok
        ];
        $this->ObatModel->updateObat($kd_obat, $update);
        echo json_encode(array("status" => TRUE));
    }
    public function deleteObatById($id)
    {
        $this->ObatModel->delete_by_id($id);
        echo json_encode(array("status" => TRUE));
    }
    public function saveObat()
    {
        $autoKdObat = $this->ObatModel->autoKdObat();
        $ObatModel = [
            'kd_obat' => date('dm') . 'O' . $autoKdObat,
            'nama_obat' => $this->input->post('addNamaObat'),
            'satuan' => $this->input->post('addsatuan'),
            'kemasan' => $this->input->post('addkemasan'),
            'prinsipal' => $this->input->post('addprinsipal'),
            'harga_jual' => $this->input->post('addHargaJual'),
            'stok' => 0
        ];

        $this->ObatModel->addObat($ObatModel);
        $data = ['status' => true];
        echo json_encode($data);
    }
    // master obat
    public function getDatatableObat()
    {

        $lists =  $this->ObatModel->get_datatables();
        $data = [];
        $no = $this->input->post("start");
        foreach ($lists as $list) {
            $no++;
            $row = [];
            $row[] = $list->kd_obat;
            $row[] = $list->nama_obat;
            $row[] = $list->satuan;
            $row[] = $list->kemasan;
            $row[] = $list->prinsipal;
            $row[] = rupiah($list->harga_jual);
            $row[] = $list->stok == 0 ? '<b style="color: red;">' . $list->stok . '</b>' : $list->stok;
            $row[] = $list->waktu_input;
            //add html for action
            $row[] =
                '<a class="btn btn-sm btn-info" data-toggle="modal" data-target="#noFakturModal" href="javascript:void(0)" title="No_Faktur" onclick="getFaktur(' . "'" . $list->kd_obat . "'" . ')"><i class="far fa-eye"></i> Detail</a>
            <a class="btn btn-sm btn-warning" href="javascript:void(0)" title="Edit" onclick="edit_obat(' . "'" . $list->kd_obat . "'" . ')"><i class="far fa-edit"></i> Edit</a>
            <a class="btn btn-sm btn-danger" href="javascript:void(0)" title="Hapus" onclick="deleteObat(' . "'" . $list->kd_obat . "'" . ')"><i class="far fa-trash-alt"></i> Delete</a>';

            $data[] = $row;
        }
        $output = [
            "draw" => $this->input->post('draw'),
            "recordsTotal" =>  $this->ObatModel->count_all(),
            "recordsFiltered" =>  $this->ObatModel->count_filtered(),
            "data" => $data
        ];
        echo json_encode($output);
    }
    public function sinkronObatBykdObats($kd_obat)
    {
        // $kd_obat = '0708O0006';
        $obatfaktur = $this->FakturPembelianModel->qtyObatFaktur($kd_obat);
        $obatJual  = $this->TrxPenjualanModel->qtyDetailJual($kd_obat);
        if ($obatfaktur && $obatJual) {
            $qtyFaktur = ($obatfaktur->qty == null) ? 0 :  $obatfaktur->qty;
            $qtyJual = ($obatJual->qty == null) ? 0 : $obatJual->qty;
            $stok = intval($qtyFaktur) - intval($qtyJual);
            $update = [
                "stok" => $stok
            ];
            // $StokMaster = $this->ObatModel->obatById($kd_obat);
            // var_dump($StokMaster);
            $this->ObatModel->updateStokByObat($kd_obat, $update);
            $status = true;
            $pesan = 'Stok Telah disingkronkan';
        } else {
            $status = false;
            $pesan = 'Gagal Select Data';
        }
        $response = [
            'status' => $status,
            'pesan' => $pesan
        ];
        echo json_encode($response);
    }

    // end of master obat
    //--------------------------------------------------------------------
    // master trx penjualan
    public function viewMasterTrxPenjualan()
    {
        $data['title'] = 'Master Trx Penjualan';
        $this->load->view('admin/masterTrxPenjualan/index', $data);
    }
    public function masterTrxPenjualanModel()
    {
        $lists =  $this->TrxPenjualanModel->get_datatables();
        $data = [];
        $no = $this->input->post("start");

        if (isset($_POST['searchByFromdate']) && isset($_POST['searchByTodate']) && $lists) {
            $sumtotal = $this->TrxPenjualanModel->sum_total_trx_byDate($_POST['searchByFromdate'], $_POST['searchByTodate'])->row();
            $total = [];
            $total[] = '';
            $total[] = '';
            $total[] = '';
            $total[] = '<b>Total : </b>';
            $total[] = $sumtotal->total_pertgl == null ? '<b>Rp. 0 </b>' : '<b>' . rupiah($sumtotal->total_pertgl) . '</b>';
            $total[] = '';
            $total[] = '';
            $total[] = '';
            $total[] = '';
            $data[] = $total;
        };

        foreach ($lists as $list) {
            $no++;
            $row = [];
            $row[] = $list->kd_transaksi;
            $row[] = $list->nama_pembeli;
            $row[] = $list->alamat_pembeli;
            $row[] = $list->note;
            $row[] = rupiah($list->total_trx);
            $row[] = rupiah($list->total_bayar);
            $row[] = rupiah($list->kembalian);
            $row[] = $list->waktu_trx;
            //add html for action
            // onclick="detail_trx(' . "'" . $value->kd_transaksi . "'" . ')"
            // $row[] = '
            // <a class="btn btn-sm btn-info" href="javascript:void(0)" onclick="detail_trx(' . "'" . $list->kd_transaksi . "'" . ')" title="detail" ><i class="fas fa-info"></i> Detail</a>
            // <a class="btn btn-sm btn-success" href="javascript:void(0)" onclick="CetakNota(' . "'" . $list->kd_transaksi . "'" . ')" title="detail" ><i class="fas fa-print"></i> Nota</a>
            // <a class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="deleteTrx(' . "'" . $list->kd_transaksi . "'" . ')" title="Delete" ><i class="fas fa-trash"></i> Delete</a>
            // ';
            $row[] = '
            <a class="btn btn-sm btn-info" href="javascript:void(0)" onclick="detail_trx(' . "'$list->kd_transaksi'" . ')" title="detail" ><i class="fas fa-info"></i> Detail</a>
            <a class="btn btn-sm btn-success" href="javascript:void(0)"  onclick="CetakNota(this)" 
            data-id="' . $list->kd_transaksi . '"
            data-nama="' . $list->nama_pembeli . '"
            data-alamat="' . $list->alamat_pembeli . '"
            data-note="' . $list->note . '"
            data-tot_trx="' . rupiah($list->total_trx) . '"
            data-tot_bayar="' . rupiah($list->total_bayar) . '"
            data-kembali="' . rupiah($list->kembalian) . '"
            data-tgl_nota="' . date('d/m/Y', strtotime($list->waktu_trx)) . '"
            title="detail" ><i class="fas fa-print"></i> Nota</a>
            <a class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="deleteTrx(' . $list->kd_transaksi . ')" title="Delete" ><i class="fas fa-trash"></i> Delete</a>
            ';
            $data[] = $row;
        }
        //   onclick="CetakNota(' . $list->kd_transaksi . ',' . $list->nama_pembeli . ',' . $list->alamat_pembeli . ',' . $list->note . ',' . rupiah($list->total_trx) . ',' . rupiah($list->total_bayar) . ',' . rupiah($list->kembalian) . ')" 
        $output = [
            "draw" => $this->input->post('draw'),
            "recordsTotal" =>  $this->TrxPenjualanModel->count_all(),
            "recordsFiltered" =>  $this->TrxPenjualanModel->count_filtered(),
            "data" => $data
        ];
        echo json_encode($output);
        // getTrxPenjualanModelByTime
    }
    public function deleteTrxPenjualanModel($kd_transaksi)
    {
        $this->TrxPenjualanModel->delete_by_id($kd_transaksi);
        echo json_encode(array("status" => TRUE));
    }

    // faktur pembelian
    public function viewFaktuPembelian()
    {
        $data['title'] = 'Transaksi Faktur Pembelian';
        $this->load->view('admin/fakturPembelian/index', $data);
    }
    public function masterFaktuPembelian()
    {
        $data['title'] = 'Master Faktur Pembelian';
        $this->load->view('admin/masterFakturPembelian/index', $data);
    }
    public function detailFakturPembelian()
    {
        $kdFaktur = $this->input->post('id');
        $data = $this->FakturPembelianModel->getDetailFaktur($kdFaktur)->result();
        echo json_encode($data);
    }
    public function deleteFakturPembelian()
    {
        $id = $this->input->post('id');
        $this->FakturPembelianModel->delete_by_id($id);
        echo json_encode(array("status" => TRUE));
    }
    public function deleteDetailFaktur()
    {
        $id = $this->input->post('id');
        $this->FakturPembelianModel->deleteDtlFakturPembelian($id);
        echo json_encode(array("status" => TRUE));
    }
    // dattable faktur
    public function dtFaktuPembelian()
    {
        $lists =  $this->FakturPembelianModel->get_datatables();
        $data = [];
        $no = $this->input->post("start");
        foreach ($lists as $list) {
            $no++;
            $row = [];
            $row[] = $list->no_faktur;
            $row[] = $list->nama_supplier;
            $row[] = rupiah($list->jml_harga);
            $row[] = $list->ppn_persen . ' %';
            $row[] = rupiah($list->ppn);
            $row[] = rupiah($list->total_trx);
            $row[] = $list->tgl_beli;
            $row[] = $list->jt_tempo;
            $row[] = $list->waktu_input;
            //add html for action
            // onclick="detail_trx(' . "'" . $value->no_faktur . "'" . ')"
            $row[] = '
            <a class="btn btn-sm btn-info" href="javascript:void(0)" onclick="detail_trx(' . "'" . $list->no_faktur . "'" . ')" title="detail" ><i class="fas fa-info"></i> Detail</a>
            <a class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="deleteTrx(' . "'" . $list->no_faktur . "'" . ')" title="Delete" ><i class="fas fa-trash"></i> Delete</a>
            ';
            $data[] = $row;
        }
        $output = [
            "draw" => $this->input->post('draw'),
            "recordsTotal" =>  $this->FakturPembelianModel->count_all(),
            "recordsFiltered" =>  $this->FakturPembelianModel->count_filtered(),
            "data" => $data
        ];
        echo json_encode($output);
        // getTrxPenjualanModelByTime
    }

    public function getfakturbyDate()
    {
        $tgl_start = $this->input->post('tgl_start');
        $tgl_end = $this->input->post('tgl_end');
        $data = [];
        if (empty($tgl_start) || empty($tgl_end)) {
            $status = false;
        } else {
            $status = true;
            $lists = $this->FakturPembelianModel->getFakturBetDate($tgl_start, $tgl_end)->result();
            foreach ($lists as $list) {
                $row = [];
                $row[] = $list->no_faktur;
                $row[] = $list->nama_supplier;
                $row[] = rupiah($list->jml_harga);
                $row[] = $list->ppn_persen . ' %';
                $row[] = rupiah($list->ppn);
                $row[] = rupiah($list->total_trx);
                $row[] = $list->tgl_beli;
                $row[] = $list->jt_tempo;
                $row[] = $list->waktu_input;
                //add html for action
                // onclick="detail_trx(' . "'" . $value->no_faktur . "'" . ')"
                $row[] = '
            <a class="btn btn-sm btn-info" href="javascript:void(0)" onclick="detail_trx(' . "'" . $list->no_faktur . "'" . ')" title="detail" ><i class="fas fa-info"></i> Detail</a>
            <a class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="deleteTrx(' . "'" . $list->no_faktur . "'" . ')" title="Delete" ><i class="fas fa-trash"></i> Delete</a>
            ';
                $data[] = $row;
            }
        }
        $output = [
            'status' => $status,
            'data' => $data
        ];
        echo json_encode($output);
    }
    public function saveFakturPembelian()
    {
        $noFaktur = $this->input->post('NomorFaktur');
        $suplier = $this->input->post('suplier');
        $tglFaktur = $this->input->post('tglFaktur');
        $jt_tempo = $this->input->post('jt_tempo');
        $arr_kd_obat = $this->input->post('kd_obat');
        $arr_qty = $this->input->post('qty');
        $arr_tglExp = $this->input->post('tglExp');
        $arr_no_batch = $this->input->post('no_batch');
        $ppn_persen = $this->input->post('PPn');
        $arr_harga_beli = str_replace(".", "", $this->input->post('harga_beli'));
        $arr_sub_total = str_replace(".", "", $this->input->post('subTotal'));
        $totaltrx = str_replace(".", "", $this->input->post('totaltrx'));
        $jml_harga = str_replace(".", "", $this->input->post('jml_harga'));
        $ppn = str_replace(".", "", $this->input->post('resultPPn'));
        $cekFaktur  = $this->FakturPembelianModel->getDetailFaktur($noFaktur);
        if ($cekFaktur->num_rows() > 0) {
            $response = [
                'success' => false,
                'data' => $noFaktur,
                'msg' => "Nomor Faktur Sudah Ada !"
            ];
        } else {
            $dataFaktur = [
                "no_faktur" => $noFaktur,
                "id_suplier " => $suplier,
                "total_trx" => $totaltrx,
                "tgl_beli" => $tglFaktur,
                "jt_tempo" => $jt_tempo,
                "jml_harga" => $jml_harga,
                "ppn_persen" => $ppn_persen,
                "ppn" => $ppn,
            ];
            $detailTrx = [];
            for ($i = 0; $i < count($arr_kd_obat); $i++) {
                $detail = [
                    "no_faktur" => $noFaktur,
                    "kd_obat" => $arr_kd_obat[$i],
                    "no_batch" => $arr_no_batch[$i],
                    "qty" => $arr_qty[$i],
                    "harga_beli" => $arr_harga_beli[$i],
                    "sub_total" => $arr_qty[$i] * $arr_harga_beli[$i],
                    "tgl_expired" => $arr_tglExp[$i]
                ];
                array_push($detailTrx, $detail);
            }
            $this->FakturPembelianModel->addFakturPembelian($dataFaktur, $detailTrx);
            $response = [
                'success' => true,
                'data' => $noFaktur,
                'msg' => "Berhasil Tersimpan"
            ];
        }
        echo json_encode($response);
    }

    public function addDetailFaktur()
    {
        $no_faktur = $this->input->post('addno_faktur');
        $kd_obat = $this->input->post('addkd_obat');
        $no_batch = $this->input->post('addno_batch');
        $qty = $this->input->post('addqty');
        $harga_beli = $this->input->post('addharga_beli');
        $tgl_expired = $this->input->post('addtgl_expired');
        $detail = [
            "no_faktur" => $no_faktur,
            "kd_obat" => $kd_obat,
            "no_batch" => $no_batch,
            "qty" => $qty,
            "harga_beli" => $harga_beli,
            "sub_total" => $qty * $harga_beli,
            "tgl_expired" => $tgl_expired
        ];
        $this->FakturPembelianModel->addFakturPembelian2($detail);
        $response = [
            'success' => true,
            'data' => $no_faktur,
            'msg' => "Berhasil Tersimpan"
        ];
        echo json_encode($response);
    }

    // supplier
    public function getSupplier()
    {
        echo json_encode($this->SupplierModel->getAllsupp()->result());
    }
    public function saveSupplier()
    {
        $this->SupplierModel->addSupplier([
            'nama_supplier' => $this->input->post('nama_supplier'),
            'hp' => $this->input->post('no_hp'),
            'alamat' => $this->input->post('alamat'),
        ]);
        $data = ['status' => true];
        echo json_encode($data);
    }
    public function deleteSupplierById($id)
    {
        $this->SupplierModel->delete_by_id($id);
        echo json_encode(array("status" => TRUE));
    }

    // Master Supplier
    public function viewMasterSupplier()
    {
        $data['title'] = 'Data Master Supplier';
        $this->load->view('admin/masterSupplier/index', $data);
    }

    public function getSupplierById($kdSupplier)
    {
        $data =  $this->SupplierModel->geySupplierbyid($kdSupplier)->row();
        echo json_encode($data);
    }

    public function updateSupplier()
    {
        $id_suplier = $this->input->post('id_suplier');
        $nama_supplier = $this->input->post('nama_supplier');
        $hp = $this->input->post('hp');
        $alamat = $this->input->post('alamat');
        // $autokode = $this->SupplierModel->autoKdSupplier();
        // echo 'O' . date('dm') . $autokode;
        $update = [
            "nama_supplier" => $nama_supplier,
            "hp" => $hp,
            "alamat" => $alamat
        ];
        $this->SupplierModel->updateSupplier($id_suplier, $update);
        echo json_encode(array("status" => TRUE));
    }

    // Master Supplier
    public function getDatatableSupplier()
    {

        $lists =  $this->SupplierModel->get_datatables();
        $data = [];
        $no = $this->input->post("start");
        foreach ($lists as $list) {
            $no++;
            $row = [];
            $row[] = $list->nama_supplier;
            $row[] = $list->hp;
            $row[] = $list->alamat;
            //add html for action
            $row[] = '<a class="btn btn-sm btn-warning" href="javascript:void(0)" title="Edit" onclick="edit(' . "'" . $list->id_suplier . "'" . ')"><i class="far fa-edit"></i> Edit</a>
                <a class="btn btn-sm btn-danger" href="javascript:void(0)" title="Hapus" onclick="deleteSupplier(' . "'" . $list->id_suplier . "'" . ')"><i class="far fa-trash-alt"></i> Delete</a>';

            $data[] = $row;
        }
        $output = [
            "draw" => $this->input->post('draw'),
            "recordsTotal" =>  $this->SupplierModel->count_all(),
            "recordsFiltered" =>  $this->SupplierModel->count_filtered(),
            "data" => $data
        ];
        echo json_encode($output);
    }
    // end of Master Supplier

    // UserManagement
    public function viewUserManagement()
    {
        $data['users'] = $this->UserModel->getAllUser()->result();
        // dd($data);
        $data['title'] = 'User Management';
        $this->load->view('admin/userManagement/index', $data);
    }
    public function getUserByid($id)
    {

        echo json_encode($this->UserModel->obatById($id));
    }

    public function saveNewUser()
    {
        $userName = $this->input->post('username');

        $cekUsername = $this->UserModel->cekUserAdd($userName);
        if ($cekUsername) {
            if ($cekUsername->num_rows() > 0) {
                $response = [
                    'success' => false,
                    'data' => $userName,
                    'msg' => "username Sudah Ada !"
                ];
            } else {
                $data = [
                    'nama' => $this->input->post('nama'),
                    'username'  => $userName,
                    'password'  =>  password_hash($this->input->post('password'), PASSWORD_DEFAULT),
                    'role_id'  => $this->input->post('role')
                ];

                $save = $this->UserModel->addUser($data);
                $response = [
                    'success' => true,
                    'data' => $save,
                    'msg' => "berhasil tambah user"
                ];
            }
        } else {
            $response = [
                'success' => false,
                'data' => $userName,
                'msg' => "Gagal Update"
            ];
        }



        echo json_encode($response);
    }

    public function ubahUser()
    {
        $id_user = $this->input->post('id_user');
        $usernameUpdate = $this->input->post('usernameUpdate');

        $cekUsername = $this->UserModel->cekUserUpdate($id_user, $usernameUpdate);
        if ($cekUsername) {
            if ($cekUsername->num_rows() > 0) {
                $response = [
                    'success' => false,
                    'data' => $usernameUpdate,
                    'msg' => "username Sudah Ada !"
                ];
            } else {
                $data = [
                    'nama' => $this->input->post('namaUpdate'),
                    'username'  => $usernameUpdate,
                    'role_id'  => $this->input->post('roleUpdate')
                ];


                $save = $this->UserModel->updateUser($id_user, $data);;
                $response = [
                    'success' => true,
                    'data' => '',
                    'msg' => "berhasil Ubah"
                ];
            }
        } else {
            $response = [
                'success' => false,
                'data' => $usernameUpdate,
                'msg' => "Gagal Update"
            ];
        }

        echo json_encode($response);
    }
    public function deleteUserById($id)
    {
        // $img = $this->UserModel->where('id', $id)->find();
        // unlink("img/" . $img);
        $this->UserModel->delete_by_id($id);
        echo json_encode(array("status" => TRUE));
    }


    // Report

}
