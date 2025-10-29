import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<dynamic> results;
  SearchLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);

  @override
  List<Object?> get props => [message];
}
