import 'package:carrot_market/common/layouts/default_layout.dart';
import 'package:carrot_market/product/screens/upload_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../common/const/app_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    Jiffy.locale('ko');
  }

  @override
  Widget build(BuildContext context) {
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
          child: const Icon(
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: AppColors.GREEN,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['title'],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['place'] +
                                            '  ',
                                        style: const TextStyle(
                                          color: AppColors.GRAY,
                                        ),
                                      ),
                                      Text(
                                        Jiffy((snapshot.data!.docs[index]
                                                    ['createdTime'])
                                                .toDate())
                                            .fromNow(),
                                        style: const TextStyle(
                                          color: AppColors.GRAY,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${snapshot.data!.docs[index]['price']}원',
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.chat_bubble_outline,
                                      ),
                                      const Text('4' + ' '),
                                      const Icon(Icons.favorite_border),
                                      Text(
                                        '${snapshot.data!.docs[index]['favorite']}',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
