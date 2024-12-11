import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/models/item.dart';
import 'package:inventory_management/screens/item_detail_screen.dart';

class CardItem extends StatelessWidget {
  final Barang barang;

  const CardItem({super.key, required this.barang});
  String _formatHarga(double harga) {
    if (harga == harga.toInt()) {
      return NumberFormat("#,###", "id_ID").format(harga.toInt());
    } else {
      return NumberFormat("#,###.##", "id_ID").format(harga);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(barang: barang),
            ),
          );
        },
        child: 
        SizedBox(
          height: 220, // Ukuran total kartu
          child: Card(
            color: const Color.fromARGB(255, 24, 24, 23),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Tata letak kiri
              children: [
                // Bagian Gambar
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: barang.foto.isNotEmpty
                      ? Image.file(
                          File(barang.foto),
                          fit: BoxFit.cover,
                          height: 140, // Tinggi gambar
                          width: double.infinity, // Lebar penuh
                        )
                      : Container(
                          height: 140,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
                // Bagian Teks
                Padding(
                  padding: const EdgeInsets.all(12.0), // Jarak dari tepi
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Kolom kiri: Nama Barang dan Kategori
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barang.namaBarang,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 238, 185, 11)
                            ),
                            overflow: TextOverflow.ellipsis, // Jika teks terlalu panjang
                          ),
                          const SizedBox(height: 4), // Jarak antar teks
                          Text(
                            'Kategori: ${barang.kategori}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 255, 254, 246),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      // Kolom kanan: Harga dan Stok
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp. ${_formatHarga(barang.harga)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 238, 185, 11)
                            ),
                          ),
                          const SizedBox(height: 4), // Jarak antar teks
                          Text(
                            'Stok: ${barang.stok}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 255, 254, 246),
                            ),
                          ),
                        ],
                      ),                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
