import 'package:flutter/material.dart';
import '../bloc/anggaran_bloc.dart'; // Pastikan bloc ini sudah diimplementasikan
import '../model/anggaran.dart';

class AnggaranForm extends StatefulWidget {
  final Anggaran? anggaran;

  const AnggaranForm({Key? key, this.anggaran}) : super(key: key);

  @override
  _AnggaranFormState createState() => _AnggaranFormState();
}

class _AnggaranFormState extends State<AnggaranForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _budgetItemController = TextEditingController();
  final _allocatedController = TextEditingController();
  final _spentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.anggaran != null) {
      _budgetItemController.text = widget.anggaran!.budgetItem!;
      _allocatedController.text = widget.anggaran!.allocated.toString();
      _spentController.text = widget.anggaran!.spent.toString();
    }
  }

  @override
  void dispose() {
    _budgetItemController.dispose();
    _allocatedController.dispose();
    _spentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anggaran != null ? 'Edit Anggaran' : 'Tambah Anggaran'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _budgetItemController,
                  decoration: const InputDecoration(labelText: "Budget Item"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Budget Item harus diisi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _allocatedController,
                  decoration: const InputDecoration(labelText: "Allocated"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Allocated harus diisi";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _spentController,
                  decoration: const InputDecoration(labelText: "Spent"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Spent harus diisi";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(widget.anggaran != null ? 'Update' : 'Add'),
                ),
                if (_isLoading) const CircularProgressIndicator(), // Menampilkan loading
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final anggaran = Anggaran(
        id: widget.anggaran?.id, // Simpan id jika melakukan update
        budgetItem: _budgetItemController.text,
        allocated: int.parse(_allocatedController.text),
        spent: int.parse(_spentController.text),
      );

      // Menangani penambahan dan pembaruan anggaran
      if (widget.anggaran != null) {
        AnggaranBloc.updateAnggaran(anggaran: anggaran).then((_) {
          Navigator.pop(context); // Kembali ke halaman sebelumnya
        });
      } else {
        AnggaranBloc.addAnggaran(anggaran: anggaran).then((_) {
          Navigator.pop(context); // Kembali ke halaman sebelumnya
        });
      }
    }
  }
}
