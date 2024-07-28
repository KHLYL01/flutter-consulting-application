import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;
  final IconData icon;
  const ProfileWidget(
      {Key? key,
      required this.image,
      required this.onClicked,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  buildImage(BuildContext context) {
    final String imagePath = this.image.path;
    final image = imagePath.contains('/data/user/0/')
        ? FileImage(File(imagePath))
        : AssetImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          height: 128,
          width: 128,
          child: InkWell(
            onTap: () async {
              final source = await showImageSource(context);
              if (source == null) return;

              onClicked(source);
            },
          ),
        ),
      ),
    );
  }

  buildEditIcon(Color color) {
    return buildCircle(
      all: 3,
      color: Colors.white,
      child: buildCircle(
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          color: color,
          all: 6),
    );
  }

  Widget buildCircle({
    required Widget child,
    required Color color,
    required double all,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }

  showImageSource(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20),
      //   ),
      // ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Pick Camera'),
            onTap: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            leading: const Icon(Icons.camera_alt),
          ),
          ListTile(
            title: const Text('Pick Gallery'),
            onTap: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
            leading: const Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
