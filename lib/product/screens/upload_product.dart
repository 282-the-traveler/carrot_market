import 'package:carrot_market/common/layouts/default_layout.dart';
import 'package:flutter/material.dart';

class UploadProduct extends StatelessWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '중고거래 글쓰기',
      action: '완료',
      child: Column(
        children: [
          const Text(
            '제목',
          ),
          const Text(
            '가격',
          ),
          const Text(
            '내용',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt_outlined,
            ),
          )
        ],
      ),
    );
  }
}
