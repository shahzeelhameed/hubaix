import 'package:flutter/material.dart';
import 'package:hubaix/config/components/populaton_info_title.dart';
import 'package:hubaix/config/components/total_population_title.dart';
import 'package:hubaix/features/bottom_navigation/pages/population_stats/presentation/widgets/population_data_list.dart';
import 'package:hubaix/features/bottom_navigation/pages/population_stats/repository/data/population_dummy_list.dart';

// Model class for UC data

class PopulationDataPage extends StatelessWidget {
  const PopulationDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Population Statistics',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        elevation: 0,
      ),
      body: const PopulationDataList(),
    );
  }
}
