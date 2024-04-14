import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Use fixed instead of shifting
          iconSize: 32,
          showSelectedLabels:
              false, // Do not show labels when an item is selected
          showUnselectedLabels: false, // Do not show labels at other times
          elevation: 0,
          currentIndex: controller.selectedMenu.value,
          onTap: (index) => controller.selectedMenu.value = index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_chart_outlined),
              activeIcon: Icon(Icons.add_chart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: '',
            ),
          ],
          selectedItemColor:
              Colors.white, // Customize the color of the selected item
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedMenu = 0.obs;
  final screens = [
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.black),
    Container(color: Colors.red),
    Container(color: Colors.yellow),
  ];
}