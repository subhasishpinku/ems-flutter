import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  final String image;
  final Function(String?) onImageSelected;

  const ProfileImage({
    super.key,
    required this.image,
    required this.onImageSelected,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker picker = ImagePicker();

  String? imagePath;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });

      // Send selected image to parent
      widget.onImageSelected(image.path);
    }
  }

  void resetImage() {
    setState(() {
      imagePath = null;
    });

    widget.onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (imagePath != null) {
      imageProvider = FileImage(File(imagePath!));
    } else if (widget.image.isNotEmpty) {
      imageProvider = NetworkImage(
        "https://ems.ueplnet.com${widget.image}",
      );
    } else {
      imageProvider = const AssetImage("assets/profile.jpg");
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: imageProvider,
        ),

        const SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.upload),
              label: const Text("Upload"),
            ),

            const SizedBox(width: 10),

            ElevatedButton.icon(
              onPressed: resetImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text("Reset"),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          "Allowed JPG, JPEG, PNG",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}