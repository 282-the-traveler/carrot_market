import 'package:carrot_market/common/layouts/default_layout.dart';
import 'package:carrot_market/product/screens/upload_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/const/app_colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> products = [];

    return SafeArea(
      child: DefaultLayout(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadProduct(),
              ),
            );
          },
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('product')
              .orderBy(
                'createdTime',
                descending: true,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            20.0,
                          ),
                          child: Container(
                            color: AppColors.GREEN,
                            width: 120,
                            height: 120,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.docs[index]['title'],
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['place'],
                                  style: TextStyle(
                                    color: AppColors.GRAY,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['createdTime'],
                                  style: TextStyle(
                                    color: AppColors.GRAY,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${snapshot.data!.docs[index]['price']}원',
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                ),
                                Text('4'),
                                Icon(Icons.favorite_border),
                                Text(
                                  '${snapshot.data!.docs[index]['favorite']}',
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length);
          },
        ),
      ),
    );
  }
}
