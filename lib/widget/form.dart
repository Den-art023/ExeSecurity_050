import 'package:flutter/material.dart';
import 'package:ucp_kedua/controller/kuliner_controller.dart';
import 'package:ucp_kedua/model/kuliner.dart';
import 'package:ucp_kedua/screen/home_view.dart';
import 'package:ucp_kedua/screen/map_screen.dart';

class FormKuliner extends StatefulWidget {
  const FormKuliner({super.key});

  @override
  State<FormKuliner> createState() => _FormKulinerState();
}

class _FormKulinerState extends State<FormKuliner> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();

  String? _lokasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masukkan Data"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nama Tempat",
                      hintText: "Masukkan Nama Tempat"),
                  controller: _namaController,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  readOnly: true, // Prevent manual text input
                  onTap: () {
                    // Show date picker on tap
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), // Set initial date to today
                      firstDate:
                          DateTime(2000, 1, 1), // Optional: Set minimum date
                      lastDate:
                          DateTime(2100, 12, 31), // Optional: Set maximum date
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        // Format date manually (without intl package)
                        String formattedDate =
                            '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                        _namaController.text = formattedDate;
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Tanggal",
                    hintText:
                        "Pilih Tanggal", // Use "Pilih Tanggal" for better clarity
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text("Alamat"),
                    _lokasi == null
                        ? const SizedBox(
                            width: double.infinity,
                            child: Text("Alamat Kosong"))
                        : Text('$_lokasi'),
                    _lokasi == null
                        ? TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapsScreen(
                                      onLocationSelected: (selectedAddress) {
                                    setState(() {
                                      _lokasi = selectedAddress;
                                    });
                                  }),
                                ),
                              );
                            },
                            child: const Text("Pilih Alamat"),
                          )
                        : TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapsScreen(
                                      onLocationSelected: (selectedAddress) {
                                    setState(() {
                                      _lokasi = selectedAddress;
                                    });
                                  }),
                                ),
                              );
                              setState(() {
                                {}
                              });
                            },
                            child: const Text("Ubah Alamat"),
                          ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Nama Lokasi: ${_namaController.text}");
                    print("Tanggal Berkunjung: ${_tanggalController.text}");
                    print("Alamat: $_lokasi");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()),
                        (route) => false);
                  }
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
