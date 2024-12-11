import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/database/databasehelper.dart';
import 'package:inventory_management/models/history.dart';
import 'package:inventory_management/models/item.dart';
import 'package:inventory_management/screens/add_history_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  final Barang barang;

  const ItemDetailScreen({super.key, required this.barang});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  List<Riwayat> _riwayatList = [];
  int totalStok = 0;

  @override
  void initState() {
    super.initState();
    _fetchRiwayat();
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    try {
      final dbHelper = DatabaseHelper();
      final data = await dbHelper.getBarangById(widget.barang.idBarang!);
      setState(() {
        totalStok = data!['stok'];
      });
    } catch (e) {
      debugPrint('Error fetching detail: $e');
    }
  }

  String _formatHarga(double harga) {
    if (harga == harga.toInt()) {
      return NumberFormat("#,###", "id_ID").format(harga.toInt());
    } else {
      return NumberFormat("#,###.##", "id_ID").format(harga);
    }
  }

  Future<void> _fetchRiwayat() async {
    try {
      final dbHelper = DatabaseHelper();
      final data = await dbHelper.getRiwayatByBarangId(widget.barang.idBarang!);
      setState(() {
        _riwayatList = data.map((e) => Riwayat.fromMap(e)).toList();
      });
    } catch (e) {
      debugPrint('Error fetching riwayat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchRiwayat();
    _fetchDetail();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 23),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 31),
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color.fromARGB(255, 255, 254, 246),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 254, 246)),
      ),
      body: 
      // Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.barang.namaBarang,
                          style: const TextStyle(
                              fontSize: 15, 
                              fontWeight: FontWeight.bold, 
                              color: Color.fromARGB(255, 238, 185, 11))
                      ),
                      Text(widget.barang.kategori
                          , style: const TextStyle(
                              fontSize: 12, 
                              color: Colors.white)
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Rp. ${_formatHarga(widget.barang.harga)}'
                          , style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold, 
                              color: Color.fromARGB(255, 238, 185, 11))
                      ),
                      Text('Stok: $totalStok'
                          , style: const TextStyle(
                              fontSize: 12, 
                              color: Colors.white)
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            widget.barang.foto.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(widget.barang.foto),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                )
                : const Icon(Icons.image_not_supported, size: 200),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Deskripsi: ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 238, 185, 11)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 100, // Atur tinggi sesuai kebutuhan
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Opsional: Tambahkan border
                  borderRadius: BorderRadius.circular(8), // Opsional: Radius sudut
                ),
                child: SingleChildScrollView(
                  child: Text(
                    textAlign: TextAlign.justify,
                    widget.barang.deskripsi,
                    style: const TextStyle(fontSize: 12, color: Colors.white), // Sesuaikan gaya teks
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color.fromARGB(255, 255, 254, 246), // Background hitam untuk container
                ),
              height: 40,
              child: Stack(
                clipBehavior: Clip.none, // Untuk memastikan tombol berada di luar container
                children: [
                  Positioned(
                    top: -30, // Posisi tombol di atas tepi container
                    left: (MediaQuery.of(context).size.width / 2) - 30, // Tengah layar
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 238, 185, 11), // Background biru untuk tombol
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddHistoryScreen(barang: widget.barang),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, size: 45, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                color: const Color.fromARGB(255, 255, 254, 246), // Background hitam untuk ListView
                child: ListView.builder(
                  itemCount: _riwayatList.length,
                  itemBuilder: (context, index) {
                    final riwayat = _riwayatList.reversed.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: riwayat.jenisTransaksi == 'Masuk'
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: riwayat.jenisTransaksi == 'Masuk'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0),
                          title: Text(
                            'Date: ${riwayat.tanggal}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Jumlah: ${riwayat.stok}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          trailing: Text(
                            riwayat.jenisTransaksi,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: riwayat.jenisTransaksi == 'Masuk'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    // );
  }
}
