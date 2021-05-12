import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Upload Your Image'),
        actions: [
          MaterialButton(
            child: Text(
              'Camera',
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          MaterialButton(
            child: Text('Gallery'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    final pickedImageFile = await ImagePicker.pickImage(source: imageSource, imageQuality: 50, maxWidth: 150);
    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add Image')),
      ],
    );
  }
}
