<div class="card card-success">
    <div class="card-header">
        <ul class="nav nav-tabs card-header-tabs" id="bologna-list" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" href="#trxFakturPembelian" role="tab" aria-controls="description" aria-selected="true"><i class="fas fa-exchange-alt"></i> Transaksi Pembelian</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#formaddObat" role="tab" aria-controls="history" aria-selected="false"><i class="fas fa-briefcase-medical"></i> Tambah Data Obat</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#formSupplier" role="tab" aria-controls="deals" aria-selected="false"><i class="fas fa-user-tie"></i> Tambah Supplier</a>
            </li>
            <li class="nav-item ml-5 float-right">
                <button type="button" class="btn btn-warning " data-toggle="modal" data-target="#Shortcut"><i class="fas fa-info-circle"></i> Shortcut</button>
            </li>
        </ul>

    </div>
    <div class="card-body">
        <div class="tab-content mt-3">
            <div class="tab-pane active" id="trxFakturPembelian" role="tabpanel">
                <?php $this->load->view('admin/fakturPembelian/formFaktur'); ?>
            </div>

            <div class="tab-pane" id="formaddObat" role="tabpanel" aria-labelledby="history-tab">
                <?php $this->load->view('admin/fakturPembelian/formObat'); ?>
            </div>

            <div class="tab-pane" id="formSupplier" role="tabpanel" aria-labelledby="deals-tab">
                <?php $this->load->view('admin/fakturPembelian/formSupplier'); ?>
            </div>
        </div>
    </div>
</div>