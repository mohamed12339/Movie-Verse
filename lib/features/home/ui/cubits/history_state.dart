part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

<<<<<<< Updated upstream
final class HistoryInitial extends HistoryState {}
=======
class HistoryStateInitial extends HistoryState {}

class GetHistoryState extends HistoryState {
  final bool isLoading;
  final String errorMessage;
  final List<Movie> movies;

  GetHistoryState({
    required this.isLoading,
    required this.errorMessage,
    required this.movies,
  });

}

class AddToHistoryState extends HistoryState {
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;

  AddToHistoryState({
    required this.isLoading,
    required this.errorMessage,
    required this.isSuccess,
  });

}
>>>>>>> Stashed changes
