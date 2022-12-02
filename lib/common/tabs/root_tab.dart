import 'package:carrot_market/common/const/app_colors.dart';
import 'package:carrot_market/common/layouts/default_layout.dart';
import 'package:flutter/material.dart';

import '../../product/screens/product_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 바텀 네비게이션바
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.RED,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: index == 0
                ? Icon(Icons.home)
                : Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: index == 1
            ? Icon(Icons.home)
        : Icon(Icons.home),
            label: '동네',
          ),
          BottomNavigationBarItem(
            icon: index == 2
                ? Icon(Icons.home)
                : Icon(Icons.home),
            label: '저장',
          ),
          BottomNavigationBarItem(
            icon: index == 3
                ? Icon(Icons.home)
                : Icon(Icons.home),
            label: '설정',
          )
        ],
      ),
      // 탭바뷰
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          ProductScreen(),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}