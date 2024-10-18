import 'package:flutter/material.dart';
import '../bloc/produk_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/produk.dart';
import 'pemasukan_page.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH KEUANGAN";
  String tombolSubmit = "SIMPAN";
  final _kodeProdukTextboxController = TextEditingController();
  final _amountTextboxController = TextEditingController();
  final _frequencyTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH KEUANGAN";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.source!;
        _amountTextboxController.text = widget.produk!.amount.toString();
        _frequencyTextboxController.text =
            widget.produk!.frequency.toString();
      });
    } else {
      judul = "TAMBAH KEUANGAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _sourceTextField(),
                _amountTextField(),
                _frequencyTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Source
  Widget _sourceTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Source"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Source harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Amount
  Widget _amountTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Amount"),
      keyboardType: TextInputType.text,
      controller: _amountTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Amount harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox frequency
  Widget _frequencyTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "frequency"),
      keyboardType: TextInputType.number,
      controller: _frequencyTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "frequency harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                //kondisi update produk
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.source = _kodeProdukTextboxController.text;
    createProduk.amount = int.parse(_amountTextboxController.text);
    createProduk.frequency = int.parse(_frequencyTextboxController.text);
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
