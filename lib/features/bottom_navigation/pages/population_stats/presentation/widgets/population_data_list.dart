// import 'package:flutter/material.dart';
// import 'package:hubaix/features/bottom_navigation/pages/population_stats/repository/data/population_dummy_list.dart';
// import 'package:hubaix/utils/colors.dart';
//
// class PopulationDataList extends StatelessWidget {
//   const PopulationDataList({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Modern color scheme
//
//     return Container(
//       color: AppColor.bgColor,
//       child: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: populationList.length,
//         separatorBuilder: (context, index) => const SizedBox(height: 16),
//         itemBuilder: (context, index) {
//           final data = populationList[index];
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 12,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header with gradient accent
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColor.primaryColor,
//                           AppColor.secondaryColor
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.people_alt_outlined,
//                             color: Colors.white, size: 20),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             data.name,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Stats cards
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: AppColor.bgColor,
//                     ),
//                     child: Column(
//                       children: [
//                         // Gender distribution
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildStatCard(
//                                 context,
//                                 icon: Icons.male,
//                                 iconColor: AppColor.maleColor,
//                                 label: 'Male',
//                                 value: data.malePopulation,
//                                 bgColor: AppColor.maleColor.withOpacity(0.1),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: _buildStatCard(
//                                 context,
//                                 icon: Icons.female,
//                                 iconColor: AppColor.femaleColor,
//                                 label: 'Female',
//                                 value: data.femalePopulation,
//                                 bgColor: AppColor.femaleColor.withOpacity(0.1),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//
//                         // Total population with progress indicator
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.white,
//                             border: Border.all(color: Colors.grey.shade200),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Total Population',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                   Text(
//                                     data.totalPopulation.toString(),
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColor.secondaryColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               LinearProgressIndicator(
//                                 value: (data.totalPopulation / 100000)
//                                     .clamp(0.0, 1.0),
//                                 backgroundColor: Colors.grey.shade200,
//                                 color: AppColor.accentColor,
//                                 minHeight: 6,
//                                 borderRadius: BorderRadius.circular(3),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildStatCard(
//     BuildContext context, {
//     required IconData icon,
//     required Color iconColor,
//     required String label,
//     required int value,
//     required Color bgColor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: bgColor,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: iconColor.withOpacity(0.2),
//                 ),
//                 child: Icon(icon, size: 18, color: iconColor),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value.toString(),
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: iconColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:hubaix/utils/colors.dart';
// import '../../repository/data/population_api_service.dart';
// import '../../repository/model/population_model.dart';
//
// class PopulationDataList extends StatefulWidget {
//   const PopulationDataList({super.key});
//
//   @override
//   State<PopulationDataList> createState() => _PopulationDataListState();
// }
//
// class _PopulationDataListState extends State<PopulationDataList> {
//   late Future<List<Population>> futurePopulationList;
//
//   @override
//   void initState() {
//     super.initState();
//     futurePopulationList = PopulationApiService().fetchPopulationData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColor.bgColor,
//       child: FutureBuilder<List<Population>>(
//         future: futurePopulationList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No population data found.'));
//           }
//
//           final populationList = snapshot.data!;
//
//           return ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: populationList.length,
//             separatorBuilder: (context, index) => const SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final data = populationList[index];
//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 12,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header with gradient accent
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 16),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColor.primaryColor,
//                               AppColor.secondaryColor
//                             ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.people_alt_outlined,
//                                 color: Colors.white, size: 20),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Text(
//                                 data.name,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Stats cards
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: AppColor.bgColor,
//                         ),
//                         child: Column(
//                           children: [
//                             // Gender distribution
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: _buildStatCard(
//                                     context,
//                                     icon: Icons.male,
//                                     iconColor: AppColor.maleColor,
//                                     label: 'Male',
//                                     value: data.malePopulation,
//                                     bgColor: AppColor.maleColor.withOpacity(0.1),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: _buildStatCard(
//                                     context,
//                                     icon: Icons.female,
//                                     iconColor: AppColor.femaleColor,
//                                     label: 'Female',
//                                     value: data.femalePopulation,
//                                     bgColor:
//                                     AppColor.femaleColor.withOpacity(0.1),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//
//                             // Total population with progress indicator
//                             Container(
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.white,
//                                 border: Border.all(color: Colors.grey.shade200),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Total Population',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.grey.shade700,
//                                         ),
//                                       ),
//                                       Text(
//                                         data.totalPopulation.toString(),
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: AppColor.secondaryColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   LinearProgressIndicator(
//                                     value: (data.totalPopulation / 100000)
//                                         .clamp(0.0, 1.0),
//                                     backgroundColor: Colors.grey.shade200,
//                                     color: AppColor.accentColor,
//                                     minHeight: 6,
//                                     borderRadius: BorderRadius.circular(3),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildStatCard(
//       BuildContext context, {
//         required IconData icon,
//         required Color iconColor,
//         required String label,
//         required int value,
//         required Color bgColor,
//       }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: bgColor,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: iconColor.withOpacity(0.2),
//                 ),
//                 child: Icon(icon, size: 18, color: iconColor),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value.toString(),
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: iconColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hubaix/utils/colors.dart';
import '../../repository/data/population_api_service.dart';
import '../../repository/model/population_model.dart';
import '../../repository/data/population_api_service.dart';
import '../../repository/data/population_api_service.dart';

class PopulationDataList extends StatefulWidget {
  const PopulationDataList({super.key});

  @override
  State<PopulationDataList> createState() => _PopulationDataListState();
}

class _PopulationDataListState extends State<PopulationDataList> {
  late Future<List<Population>> futurePopulationList;

  @override
  void initState() {
    super.initState();
    futurePopulationList = PopulationApiService().fetchPopulationData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: FutureBuilder<List<Population>>(
        future: futurePopulationList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No population data found.'));
          }

          final populationList = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: populationList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final data = populationList[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with gradient accent
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              AppColor.secondaryColor,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.people_alt_outlined,
                                color: Colors.white, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                data.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Stats cards
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.bgColor,
                        ),
                        child: Column(
                          children: [
                            // Gender distribution
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    icon: Icons.male,
                                    iconColor: AppColor.maleColor,
                                    label: 'Male',
                                    value: data.malePopulation,
                                    bgColor: AppColor.maleColor.withOpacity(0.1),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    icon: Icons.female,
                                    iconColor: AppColor.femaleColor,
                                    label: 'Female',
                                    value: data.femalePopulation,
                                    bgColor: AppColor.femaleColor.withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Total population with progress indicator
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Population',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      Text(
                                        data.totalPopulation.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: LinearProgressIndicator(
                                      value: (data.totalPopulation / 100000)
                                          .clamp(0.0, 1.0),
                                      backgroundColor: Colors.grey.shade200,
                                      color: AppColor.accentColor,
                                      minHeight: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required int value,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.2),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
