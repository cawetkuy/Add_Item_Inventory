import 'package:flutter/material.dart';
import 'package:inventory_management/database/databasehelper.dart';
import 'package:inventory_management/models/item.dart';
import 'package:inventory_management/widgets/cards/card_item.dart';
import 'package:inventory_management/widgets/placeholder/placeholder_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Barang>> _barangFuture;

  Future<List<Barang>> _fetchBarang() async {
    final dbHelper = DatabaseHelper();
    final data = await dbHelper.getAllBarang();
    return data.map((e) => Barang.fromMap(e)).toList();
  }

  void _refreshData() {
    setState(() {
      _barangFuture = _fetchBarang();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 55, 20, 0),
      color: const Color.fromARGB(255, 255, 254, 246),
      child: RefreshIndicator(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi !,',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 24, 23)
                  ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Jessica Carmelita',
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: Color.fromARGB(255, 238, 185, 11)
                  ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tracking barang anda melalui Inventory Management',
                style: TextStyle(
                  fontSize: 14, 
                  color:  Color.fromARGB(255, 24, 24, 23)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Barang>>(
                  future: _fetchBarang(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const PlaceholderNoItem();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final barang = snapshot.data!.toList()[index];
                        return CardItem(barang: barang);
                      },
                    );
                  },
                ),
              )
            ],
          ),
          onRefresh: () async {
            _refreshData();
          }),
    );
  }
}
