import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/repository/model/news_model.dart';
import 'package:share_plus/share_plus.dart';

class Utils {
  static void showSnackBar(BuildContext context, String msg,
      {Color bgcolor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bgcolor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showDialogBox(
    BuildContext context,
    Widget widget, {
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => widget,
    );
  }

  static void showBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => widget,
    );
  }

  static void showBottomSheet2(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => widget,
    );
  }

  static void push(BuildContext context, Widget screen) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<void> shareArticle(NewsArticle article) async {
    await Share.share('Check out this news: ${article.title}\n${article.url}');
  }
}
