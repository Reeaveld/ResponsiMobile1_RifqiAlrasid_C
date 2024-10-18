import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/anggaran_bloc.dart';
import '../model/anggaran.dart';
import 'anggaran_detail.dart';
import 'anggaran_form.dart';
import 'login_page.dart';

class AnggaranPage extends StatefulWidget {
  const AnggaranPage({Key? key}) : super(key: key);

  @override
  _AnggaranPageState createState() => _AnggaranPageState();
}

class _AnggaranPageState extends State<AnggaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Anggaran'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AnggaranForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Anggaran>>(
        future: AnggaranBloc.getAnggarans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListAnggaran(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListAnggaran extends StatelessWidget {
  final List<Anggaran>? list;

  const ListAnggaran({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemAnggaran(
          anggaran: list![i],
        );
      },
    );
  }
}

class ItemAnggaran extends StatelessWidget {
  final Anggaran anggaran;

  const ItemAnggaran({Key? key, required this.anggaran}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnggaranDetail(
              anggaran: anggaran,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(anggaran.budgetItem!),
          subtitle: Text("Allocated: ${anggaran.allocated}\nSpent: ${anggaran.spent}"),
          trailing: Text(anggaran.id.toString()),
        ),
      ),
    );
  }
}
