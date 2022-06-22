 <!-- Select2 -->
 <script src="<?= base_url(); ?>assets/plugins/select2/js/select2.full.min.js"></script>
 <script></script>
 <script>
     document.addEventListener('keydown', function(e) {

         if (e.which === 113 || e.keyCode === 113) {
             // alert("1234");
             $('.select2').siblings('select').select2('open');
             e.preventDefault();
         }
         if (e.which === 9 || e.keyCode === 9) {
             $('#totalBayar').focus();
             e.preventDefault();
         }
     });
     //  navigasi
     $('#bologna-list a').on('click', function(e) {
         e.preventDefault()
         $(this).tab('show')
     });
     //  delete list
     $("#keranjangList").on('click', '.delRow', function() {
         $(this).closest('tr').remove();
         updateTotalTagihan();

     });
     $('#totalBayar').on('keyup change', function() {
         $(this).removeClass('is-invalid')
         let totalTagihan = remove_str($('#totalTagihan').text());
         let bayar = remove_str($(this).val());
         $(this).val(formatRupiah(bayar, 'Rp. '));
         kembalianVal(bayar - totalTagihan);
         if (totalTagihan == bayar) {
             $('#tampilan_kembalian').removeClass('is-invalid')
         }
     });

     //  kembalian
     function kembalianVal(params) {
         if (params) {
             $('#kembalian').val(params);
             if (params < 0) {
                 $('#kembalian').val(params);
                 let gkml2 = $('#kembalian').val();
                 let generate2 = params.toString().replace(/-/g, "");
                 $('#tampilan_kembalian').val('-' + formatRupiah(generate2, 'Rp. ')).css("color", "red");
                 $('#tampilan_kembalian').addClass('is-invalid')

             } else {
                 $('#tampilan_kembalian').val(formatRupiah($('#kembalian').val(), 'Rp. ')).css("color", "black");
                 $('#tampilan_kembalian').removeClass('is-invalid')
             }
         } else {
             $('#tampilan_kembalian').val(0);
             $('#kembalian').val(0);
         }

     }
 </script>
 <script>
     var no = 1,
         dataPrint;
     $(document).ready(function() {


         $('#id_select_obat').select2({
             theme: "bootstrap4",
             width: '100%',
             ajax: {
                 url: "<?= base_url('Kasir/getObat'); ?>",
                 dataType: 'json',
                 type: "post",
                 delay: 250,
                 data: function(params) {
                     return {
                         search: params.term,
                     }
                 },
                 processResults: function(data) {
                     return {
                         results: data
                     };
                 },
                 cache: true,
                 // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
             },
             placeholder: 'Ketik Nama Obat Atau kd Obat',
             minimumInputLength: 3,
         });
     }).on('select2:select', function(evt) {
         var nm = $("#id_select_obat option:selected").val();
         //   console.log(nm);
         $.ajax({
             type: 'POST',
             url: '<?= base_url('Kasir/getObatById'); ?>',
             data: {
                 data: nm
             },
             dataType: 'JSON',
             success: function(res) {
                 $("#id_select_obat").val('').trigger('change');
                 if (cekIdInLsit(res.id)) {
                     Swal.fire(
                         'Warning!',
                         'Obat atau Kode Obat sudah ada dilist',
                         'warning'
                     )
                     return false
                 }
                 if (res.stok <= 0) {
                     Swal.fire(
                         'Stok Kosong!',
                         `Obat : ${res.nama_obat}`,
                         'warning'
                     )
                     return false
                 }
                 $('#addList').append(`
                 <tr id="${res.id}">
                        <td scope="row">${no++}</td>
                        <td class="namafornota">${res.nama_obat}</td>
                        <td class="satuanfornota">${res.satuan}</td>
                        <td><input type="number" id="hb${res.id}" data-kd_obat="${res.id}"  class="form-control form-control-sm  cek_harga" name="harga[]" value="${res.harga}" readonly ></td>
                        <td>
                            <div class="form-group col-auto">
                                <div class="">
                                    <input type="hidden" class="form-control form-control-sm" name="kd_obat[]" value="${res.id}" readonly>
                                    <input type="hidden" class="form-control form-control-sm" name="stok[]" value="${res.stok}" readonly>
                                    <input type="number" id="qty${res.id}"  class="form-control form-control-sm getData-FromInput" data-nama_obat="${res.nama_obat}" data-kd_obat="${res.id}" data-stok="${res.stok}" data-harga="${res.harga}"  min="1" value='1' name="qty[]"  required>
                                    <div class="invalid-tooltip">
                                        Qty Lebih Dari Jumlah Stok
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td><input type="text" class="form-control form-control-sm ${res.id} " name="subTotal[]" value="${res.harga}" readonly></td>
                        <td>
                            <button type="button" class="btn btn-danger delRow"> <i class="fas fa-trash"></i></button>
                        </td>
                    </tr>
                 `)

                 handleSubTotal();
                 updateTotalTagihan();
                 $(".getData-FromInput:last").focus();
                 //  $('input[name ="harga[]"]').focus();
             },
             error: function(xhr, ajaxOptions, thrownError) {
                 // console.log(xhr.);
                 console.log(xhr.responseText);
                 Swal.fire(
                     'Error!',
                     xhr.responseText,
                     'error'
                 )
                 window.location.reload();
             }
         })
     });
 </script>
 <script>
     function handleSubTotal() {
         $('.getData-FromInput').on('keyup change click', function() {
             let kd_obat = $(this).data('kd_obat');
             //  let harga = $(this).data('harga');
             let harga = $(`#hb${kd_obat}`).val();
             let stok = parseInt($(this).data('stok'));
             let qty = parseInt($(this).val());

             //  ini subtotal
             $(`.${kd_obat}`).val(formatRupiah(harga * qty, ''));

             qty > stok ? $(this).addClass('is-invalid') : $(this).removeClass('is-invalid')
             // update total tagihan
             updateTotalTagihan();
             //   klik tab for fokus
             document.addEventListener('keydown', function(e) {
                 if (e.which === 9 || e.keyCode === 9) {
                     $('#totalBayar').focus();
                     e.preventDefault();
                 }
             });
         });
         $('.cek_harga').on('keyup change', function() {
             let kd_obat2 = $(this).data('kd_obat');
             let qty2 = parseInt($(`#qty${kd_obat2}`).val());
             let harga2 = parseInt($(this).val());
             //  ini subtotal
             $(`.${kd_obat2}`).val(formatRupiah(harga2 * qty2, ''));
             // update total tagihan
             updateTotalTagihan();

         });
     }

     function cekIdInLsit(resId) {
         let cek = $('#keranjangList tr').map(function() {
             return this.id
         }).get();
         return cek.includes(resId);
     }

     function updateTotalTagihan() {
         let arrSubTotal = $("input[name='subTotal[]']")
             .map(function() {
                 return remove_str($(this).val());
             }).get().reduce(function(total, num) {
                 return total + num;
             });
         // update total tagihan
         $('#totalTagihan').html(formatRupiah(arrSubTotal, ''));

     }
     $("form").on("submit", function(event) {
         event.preventDefault();
         $('.rowNota').remove();
         let tagihan_simpan = remove_str($('#totalTagihan').text());
         let bayar_simpan = remove_str($('#totalBayar').val());
         let kembalian_simpan = remove_str($('#kembalian').val());
         let arr_kd_obat = cetakArrSubmit('kd_obat');
         let arr_stok = cetakArrSubmit('stok');
         let arr_qty = cetakArrSubmit('qty');

         // catatn untuk nota sampe di sini mi
         let arrnama = [],
             satuanforNota = [];
         $('.namafornota ').each(function() {
             arrnama.push($(this).text());
         });
         $('.satuanfornota').each(function() {
             satuanforNota.push($(this).text());
         });
         let arr_harga = cetakArrSubmit('harga');
         let arr_subtotal = cetakArrSubmit('subTotal').map(m => remove_str(m));

         var totalRowCount = $("#keranjangList tr").length - 1;
         if (totalRowCount == 0 || !bayar_simpan || tagihan_simpan > bayar_simpan || arr_qty.includes("") || isNaN(tagihan_simpan)) {
             if (!bayar_simpan) {
                 $('#bayar').addClass('is-invalid')
             }
             Swal.fire({
                 title: 'Lengkapi Data',
                 icon: 'warning',
                 html: ` <ul class="list-group">
                                    <li class="list-group-item">Jumlah Belanja    : ${totalRowCount?'<b>'+totalRowCount+'</b>':'<span style="color: red;"><b>Belum Ada Transaksi</b></span>'}</li>
                                    <li class="list-group-item">Jumlah Bayar    : ${bayar_simpan?bayar_simpan:'<span style="color: red;"><b>Bayar Harus Diisi</b></span>'}</li>
                                    <li class="list-group-item">${tagihan_simpan > bayar_simpan?'<span style="color: red;"><b>Jumlah Bayar harus sama dengan atau <br> lebih besar Total yang harus dibayar</b></span>':''}</li>
                                    <li class="list-group-item">${arr_qty.includes("") || isNaN(tagihan_simpan)?'<span style="color: red;"><b>Qty Harus Diisi <br> Total yang harus di bayar 0</b></span>':''}</li>
                                </ul>`,
                 showCancelButton: false,
                 // confirmButtonColor: '#3085d6',
                 cancelButtonColor: '#d33',
                 confirmButtonText: 'Okay!'
             })
             return false;
         } else {
             Swal.fire({
                 title: 'Yakin Simpan?',
                 text: "Transaksi Akan Tersimpan Didatabase!",
                 icon: 'warning',
                 html: `<form>
                        <div class="form-group">
                            <label for="nama_pembeli" class="col-form-label">Nama Pembeli:</label>
                            <input type="text" class="form-control" name="nama_pembeli" id="nama_pembeli">
                        </div>
                        <div class="form-group">
                            <label for="alamat" class="col-form-label">Alamat</label>
                            <textarea  class="form-control" name="alamat" id="alamat"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="note" class="col-form-label">Note</label>
                            <textarea  class="form-control" name="note" id="note"></textarea>
                        </div>
                        </form>`,
                 showCancelButton: true,
                 confirmButtonColor: '#3085d6',
                 cancelButtonColor: '#d33',
                 confirmButtonText: 'Ya, Simpan!'
             }).then((result) => {
                 if (result.value) {
                     let data = {
                         'tagihan_simpan': tagihan_simpan,
                         'bayar_simpan': bayar_simpan,
                         'kembalian_simpan': kembalian_simpan,
                         'arr_kd_obat': arr_kd_obat,
                         'arr_stok': arr_stok,
                         'arr_qty': arr_qty,
                         'arr_subtotal': arr_subtotal,
                         'catatanPembeli': $("form").serializeArray()
                     };


                     $.ajax({
                         type: "POST",
                         url: "<?= base_url('kasir/submitTrx'); ?>",
                         data: data,
                         dataType: "JSON",
                         success: function(res) {
                             if (res.status == true) {
                                 let allDataSimpan = '';
                                 for (let index = 0; index < arr_kd_obat.length; index++) {
                                     allDataSimpan += listNote(satuanforNota[index], arr_kd_obat[index], arrnama[index], arr_harga[index], arr_qty[index], arr_subtotal[index]);
                                 }
                                 $("#detaillist_nota tbody").html(allDataSimpan);

                                 $("#invoice_nama").text(data.catatanPembeli[3].value);
                                 $("#invoice_alamat").text(data.catatanPembeli[4].value);
                                 $("#invoice_note").text(data.catatanPembeli[5].value);
                                 $("#invoice_bayar").text('Rp. ' + $('#totalBayar').val());
                                 $("#invoice_kembali").text('Rp. ' + $('#tampilan_kembalian').val());
                                 $("#invoice_Total").text('Rp. ' + $('#totalTagihan').text());

                                 $('#invoice_no_nota ').text(res.id_nota);

                                 $('#success_tic').modal('show');
                                 $('#addList tr').remove();
                                 $('form').each(function() {
                                     this.reset();
                                 });
                                 $('#totalTagihan').text('0');

                                 dataPrint = {
                                     'order_id': res.id_nota,
                                     'tagihan_simpan': tagihan_simpan,
                                     'bayar_simpan': bayar_simpan,
                                     'kembalian_simpan': kembalian_simpan,
                                     'arrnama': arrnama,
                                     'arr_qty': arr_qty,
                                     'arr_harga': arr_harga,
                                     'arr_subtotal': arr_subtotal,
                                 };
                             }
                         },
                         error: function(xhr, status, error) {
                             console.log(xhr.responseText);
                             Swal.fire(
                                 'Error!',
                                 xhr.responseText,
                                 'error'
                             )
                             window.location.reload();
                         }
                     });
                 }

             })
         }


     });

     function cetakArrSubmit(params) {
         let arrCetak = [];
         $(`input[name='${params}[]']`).each(function() {
             arrCetak.push(this.value);
         });
         return arrCetak;
     }

     function listNote(satuanforNota, kdObat, arrnama, arr_harga, arr_qty, arr_subtotal) {
         // <tr>

         //             <td class="description">${arrnama}</td>
         //             <td class="quantity">${arr_qty}</td>
         //             <td class="price">${formatRupiah(arr_harga)}</td>
         //             <td>${formatRupiah(arr_subtotal)}</td>
         //         </tr>
         return `
                <tr>
                    <td colspan="3">${arrnama}</td>
                </tr>
                <tr>
                    <td>@ ${formatRupiah(arr_harga)}</td>
                    <td width="7%">${arr_qty}x</td>
                    <td>${formatRupiah(arr_subtotal)}</td>
                </tr>
                `;

     }

     function klikbtnPrint() {
         //  window.print();
         $('#success_tic').modal('hide');

         $.ajax({
             type: "POST",
             url: "<?= base_url('Cetak/cetak'); ?>",
             data: dataPrint,
             dataType: "JSON",
             success: function(res) {
                 if (res.code != "00") {
                     Swal.fire(
                         'Error!',
                         "gagal cetak Nota",
                         'error'
                     )
                 }
             },
             error: function(xhr, status, error) {
                 console.log(xhr.responseText);
                 Swal.fire(
                     'Error!',
                     xhr.responseText,
                     'error'
                 )
                 //  window.location.reload();
             }
         });
     }
 </script>