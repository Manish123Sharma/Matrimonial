import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchRequested extends SearchEvent {
  final int searchResultType;
  final String searchValue;

  SearchRequested({required this.searchResultType, required this.searchValue});

  @override
  List<Object?> get props => [searchResultType, searchValue];
}

class ClearSearchResults extends SearchEvent {}
