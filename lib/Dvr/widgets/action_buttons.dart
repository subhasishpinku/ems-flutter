import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onAdd;

  const ActionButtons({
    super.key,
    required this.onSearch,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 46,
          height: 46,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff3F73F6),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: onSearch,
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 18),
        SizedBox(
          width: 46,
          height: 46,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1296F3),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: onAdd,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}