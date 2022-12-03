import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  Color? backgroundColor;
  final Widget child;
  final bool isBack;
  final String? title;
  final TextButton? actions;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;

  DefaultLayout({
    Key? key,
    this.backgroundColor,
    required this.child,
    this.actions,
    this.isBack = false,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
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
        leading: isBack ? BackButton() : SizedBox.shrink(),
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [actions!],
        foregroundColor: Colors.black,
      );
    }
  }
}
