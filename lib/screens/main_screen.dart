import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_management/screens/add_item_screen.dart';
import 'package:inventory_management/screens/home_screen.dart';
import 'package:inventory_management/widgets/dialogs/custom_video_dialog.dart';

class MainScreeen extends StatefulWidget {
  const MainScreeen({super.key});

  @override
  State<MainScreeen> createState() => _MainScreeenState();
}

class _MainScreeenState extends State<MainScreeen> {
  int _selectedNavbarIndex = 0;

  void _onTabChange(int index) {
    if (index == 2 || index == 3) {
      showCustomLottieDialog(context);
    }
    setState(() {
      _selectedNavbarIndex = index;
    });
  }

  Widget _getSelectedView() {
    switch (_selectedNavbarIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AddItemScreen();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedView(),
      bottomNavigationBar: GNav(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        backgroundColor: const Color.fromARGB(255, 24, 24, 23),
        activeColor: const Color.fromARGB(255, 24, 24, 23),
        tabBackgroundColor: const Color.fromARGB(255, 238, 185, 11),
        tabBorderRadius: 15,
        tabMargin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        gap: 5,
        selectedIndex: _selectedNavbarIndex,
        onTabChange: _onTabChange,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            iconColor: Color.fromARGB(255, 255, 254, 246),
          ),
          GButton(
            icon: Icons.add,
            text: 'Add Item',
            iconColor: Color.fromARGB(255, 255, 254, 246),
          ),
          GButton(
            icon: Icons.history,
            text: 'History',
            iconColor: Color.fromARGB(255, 255, 254, 246),
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            iconColor: Color.fromARGB(255, 255, 254, 246),
          ),
        ],
      ),
    );
  }
}
