import 'package:flutter/material.dart';
import '../bloc/anggaran_bloc.dart';
import '../widget/warning_dialog.dart';
import '../model/anggaran.dart';
import 'anggaran_form.dart';
import 'anggaran_page.dart';

// ignore: must_be_immutable
class AnggaranDetail extends StatefulWidget {
  Anggaran? anggaran;

  AnggaranDetail({Key? key, this.anggaran}) : super(key: key);

  @override
  _AnggaranDetailState createState() => _AnggaranDetailState();
}

class _AnggaranDetailState extends State<AnggaranDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Anggaran'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Item: ${widget.anggaran!.budgetItem}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Dialokasikan: Rp. ${widget.anggaran!.allocated}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Dibelanjakan: Rp. ${widget.anggaran!.spent}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnggaranForm(
                  anggaran: widget.anggaran!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            AnggaranBloc.deleteAnggaran(id: widget.anggaran!.id!).then(
              (value) => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AnggaranPage(),
                  ),
                ),
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
