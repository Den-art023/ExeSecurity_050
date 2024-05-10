import 'package:flutter/material.dart';
import 'package:ucp_kedua/controller/kuliner_controller.dart';
import 'package:ucp_kedua/model/kuliner.dart';
import 'package:ucp_kedua/widget/form.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KulinerController _controller = KulinerController();

  @override
  void initState() {
    super.initState();
    _controller.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Tempat Kuliner"),
      ),
      body: FutureBuilder<List<Kuliner>>(
        future: _controller.getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kuliner place = snapshot.data![index];
                return ListTile(
                  title: Text(place.nama),
                  subtitle: Text(place.tanggal),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormKuliner()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
