import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/core/styles/app_styles.dart';
import 'package:movies/features/home/ui/cubits/history_cubit.dart';
import 'package:movies/features/home/ui/widgets/error_view.dart';
import 'package:movies/features/home/ui/widgets/loading_view.dart';
import 'package:movies/features/home/ui/widgets/movies_grid_view.dart';

class TestHistoryTap extends StatefulWidget {
  const TestHistoryTap({super.key});

  @override
  State<TestHistoryTap> createState() => _TestHistoryTapState();
}

class _TestHistoryTapState extends State<TestHistoryTap> {
  @override
  void initState() {
    BlocProvider.of<HistoryCubit>(context).getVisitedMoviesHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state.getVisitedMoviesHistoryApiState is LoadingApiResult) {
          return LoadingView();
        } else if (state.getVisitedMoviesHistoryApiState.hasData &&
            state.getVisitedMoviesHistoryApiState.getData.isNotEmpty) {
          return MoviesGridView(
            movies:
                state.getVisitedMoviesHistoryApiState.getData.reversed.toList(),
          );
        } else if (state.getVisitedMoviesHistoryApiState.hasError) {
          return ErrorView(
            message: state.getVisitedMoviesHistoryApiState.getError.message,
          );
        } else {
          return Center(
            child: Text(
              "No visited movies yet",
              style: AppStyles.white20regular,
            ),
          );
        }
      },
    );
  }
}
