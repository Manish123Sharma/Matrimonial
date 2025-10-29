import 'package:bloc/bloc.dart';
import '../../services/api_service.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiService;
  final List<dynamic> _accumulatedResults = [];

  SearchBloc({required this.apiService}) : super(SearchInitial()) {
    on<SearchRequested>((event, emit) async {
      emit(SearchLoading());

      try {
        final response = await apiService.search(
          searchResultType: event.searchResultType,
          searchValue: event.searchValue,
        );

        if (response.statusCode == 200) {
          final data = response.data;
          if (data != null && data['Results'] != null) {
            final newResults = List<dynamic>.from(data['Results']);
            _accumulatedResults.addAll(newResults);
            emit(SearchLoaded(List<dynamic>.from(_accumulatedResults)));
          } else {
            emit(SearchFailure('No results found.'));
          }
        } else {
          emit(SearchFailure('Server error: ${response.statusCode}'));
        }
      } catch (e) {
        emit(SearchFailure('Error fetching results: $e'));
      }
    });

    on<ClearSearchResults>((event, emit) {
      _accumulatedResults.clear();
      emit(SearchInitial());
    });
  }
}
