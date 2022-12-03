import 'package:carrot_market/common/layouts/default_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            });
            titleController.clear();
            priceController.clear();
            descriptionController.clear();
            Navigator.pop(context);
          });
        },
        child: Text('완료'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: '제목',
              ),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only num
              decoration: InputDecoration(
                labelText: '가격',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: '내용',
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
              ),
            )
          ],
        ),
      ),
    );
  }
}
