import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/search_bloc/search_event.dart';
import '../blocs/search_bloc/search_state.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_event.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc _searchBloc;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _searchBloc = context.read<SearchBloc>();
    _authBloc = context.read<AuthBloc>();


    _searchBloc.add(SearchRequested(searchResultType: 2, searchValue: "1"));
    _searchBloc.add(SearchRequested(searchResultType: 2, searchValue: "4"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(c).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(c).pop(true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                await _authBloc.apiService.clearCookies(persist: false);
                _authBloc.add(LogoutRequested());
                Future.delayed(const Duration(milliseconds: 100), () {
                  context.go('/');
                });
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchFailure) {
            return Center(child: Text(state.message));
          } else if (state is SearchLoaded) {
            final results = state.results;
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
                      backgroundImage: NetworkImage(
                        item['DefaultPhoto'] ??
                            'https://cdn.rdgroup.in/t/img/user/Female.gif',
                      ),
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
                        Text(
                          'ID: ${item['ProfileId']}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['LastActive'] ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Start searching.'));
          }
        },
      ),
    );
  }
}
