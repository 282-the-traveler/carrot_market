import 'dart:io';

import 'package:carrot_market/common/layouts/default_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? title;
  int? price;
  String? description;
  PickedFile? _image;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
      .instance;

  Future getImageFromCamera() async {
    var image = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = image!;
    });
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'files/$fileName';
    print (fileName);
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination);
      await ref.putFile(File(_image!.path));
    } catch (e) {
      print('error occured');
    }
  }
  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return DefaultLayout(
      isBack: true,
      title: '중고거래 글쓰기',
      actions: TextButton(
        onPressed: () {
          setState(() {
            title = titleController.text;
            price = int.parse(priceController.text);
            description = descriptionController.text;
            firestore.collection('product').add({
              'title': title,
              'price': price,
              'description': description,
              'place': '발산동',
              'favorite': '8',
              'createdTime' : Timestamp.now()
            });
            uploadFile();
            titleController.clear();
            priceController.clear();
            descriptionController.clear();
            Navigator.
            pop
            (
            context
            );
          });
        },
        child: const Text('완료'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only num
              decoration: const InputDecoration(
                labelText: '가격',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 7,
              decoration: const InputDecoration(
                labelText: '내용',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    getImageFromCamera();
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    getImageFromGallery();
                  },
                  icon: const Icon(
                    Icons.photo_camera_back,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: _image == null
                      ? Text(
                    'No image selected.',
                  )
                      : Image.file(
                    File(
                      _image!.path,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
