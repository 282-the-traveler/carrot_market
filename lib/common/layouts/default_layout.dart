import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  Color? backgroundColor;
  final Widget child;
  final bool isBack;
  final String? title;
  final String? action;
  final Widget? bottomNavigationBar;

  DefaultLayout({
    Key? key,
    this.backgroundColor,
    required this.child,
    this.isBack = false,
    this.title,
    this.action,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: isBack ?  BackButton() :  SizedBox.shrink(),
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Text(
            action!,
          )
        ],
        foregroundColor: Colors.black,
      );
    }
  }
}
