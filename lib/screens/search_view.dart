// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:matrimonial/api_routes.dart';
// import 'package:matrimonial/controllers/authController.dart';
// import 'package:matrimonial/controllers/searchController.dart' as my;

// class SearchView extends StatelessWidget {
//   const SearchView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final my.SearchController searchC = Get.find();
//     final AuthController authC = Get.find();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Results'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               final persist = authC.saveCookie.value;
//               await authC.logout(persist: persist);
//               Get.offAllNamed(Routes.login);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () => searchC.fetchResults(
//                     searchResultType: 1,
//                     searchValue: '1',
//                   ),
//                   child: const Text('Refresh'),
//                 ),
//                 const SizedBox(width: 12),
//                 Obx(
//                   () => searchC.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : const SizedBox.shrink(),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (searchC.error.value.isNotEmpty) {
//                 return Center(
//                   child: Text(
//                     searchC.error.value,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 );
//               }
//               if (searchC.isLoading.value && searchC.results.isEmpty) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (searchC.results.isEmpty) {
//                 return const Center(child: Text('No results'));
//               }
//               return ListView.separated(
//                 padding: const EdgeInsets.all(12),
//                 itemCount: searchC.results.length,
//                 separatorBuilder: (_, __) => const Divider(),
//                 itemBuilder: (context, idx) {
//                   final item = searchC.results[idx];
//                   String title = '';
//                   if (item is Map) {
//                     title =
//                         item['FullName']?.toString() ??
//                         item['name']?.toString() ??
//                         item['ProfileId']?.toString() ??
//                         item.toString();
//                   } else {
//                     title = item.toString();
//                   }
//                   return ListTile(
//                     title: Text(title),
//                     subtitle: Text(
//                       item is Map ? item.toString() : item.toString(),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
