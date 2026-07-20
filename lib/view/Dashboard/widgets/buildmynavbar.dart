import 'package:flutter/material.dart';

class BuildMyNavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onPageSelected;

  const BuildMyNavBar({
    super.key,
    required this.pageIndex,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF1565C0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// Home
          _navItem(
            index: 0,
            currentIndex: pageIndex,
            selectedIcon: Icons.home_rounded,
            unselectedIcon: Icons.home_outlined,
            label: "Home",
          ),

          /// Hub
          // _navItem(
          //   index: 1,
          //   currentIndex: pageIndex,
          //   selectedIcon: Icons.location_on,
          //   unselectedIcon: Icons.location_on_outlined,
          //   label: "Hub",
          // ),

          // /// LCO
          // _navItem(
          //   index: 2,
          //   currentIndex: pageIndex,
          //   selectedIcon: Icons.assignment,
          //   unselectedIcon: Icons.assignment_outlined,
          //   label: "LCO",
          // ),

          /// Profile
          _navItem(
            index: 1,
            currentIndex: pageIndex,
            selectedIcon: Icons.person,
            unselectedIcon: Icons.person_outline,
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required int index,
    required int currentIndex,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required String label,
  }) {
    final bool selected = currentIndex == index;

    return InkWell(
      onTap: () => onPageSelected(index),
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? selectedIcon : unselectedIcon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
