import 'package:flutter/material.dart';

import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/complaints_list_widget.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/navigation_tabs.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/news.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/profile_header_widget.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/widget/search_dialog_widget.dart';

import 'package:hubaix/features/bottom_navigation/pages/home_page/service/home_service.dart';
import 'package:hubaix/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsService newsService = NewsService();

  String? searchText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ProfileHeaderWidget(
            onPressed: () {
              Utils.showDialogBox(context, SearchDialogWidget(
                onSearch: (text) {
                  setState(() {
                    searchText = text;
                  });
                },
              ));
            },
          ),
          const NavigationTabs(),
          const SizedBox(
              height: 100,
              width: double.infinity,
              child: ComplaintsListWidget()),
          NewsList(
            searchText: searchText,
          ),
        ],
      ),
    );
  }
}
