import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/searchController.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchUserController());


    controller.fetchSearchResults(searchResultType: 2, searchValue: "1");
    controller.fetchSearchResults(searchResultType: 2, searchValue: "4");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final results = controller.results;

        if (results.isEmpty) {
          return const Center(child: Text('No profiles found.'));
        }

        return ListView.builder(
          itemCount: results.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final item = results[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item['DefaultPhoto'] ??
                      'https://cdn.rdgroup.in/t/img/user/Female.gif'),
                  radius: 28,
                ),
                title: Text(
                  item['Name'] ?? 'Unknown',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Age: ${item['Age'] ?? '-'}'),
                    Text('Gotra: ${item['Gotra'] ?? '-'}'),
                    Text('Education: ${item['Education'] ?? '-'}'),
                    Text('Income: ${item['IncomeCategory'] ?? '-'}'),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ID: ${item['ProfileId']}',
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(item['LastActive'] ?? '',
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
