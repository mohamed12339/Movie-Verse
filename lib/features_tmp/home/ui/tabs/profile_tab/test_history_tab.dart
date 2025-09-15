import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/features_tmp/home/ui/cubits/history_cubit.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/error_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/loading_view.dart';
import 'package:project_movie_app/features_tmp/home/ui/widgets/movies_grid_view.dart';


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
            state.getVisitedMoviesHistoryApiState.myData.isNotEmpty) {
          return MoviesGridView(
            movies:
                state.getVisitedMoviesHistoryApiState.myData.reversed.toList(),
          );
        } else if (state.getVisitedMoviesHistoryApiState.hasError) {
          return ErrorView(
            message: state.getVisitedMoviesHistoryApiState.myError.message,
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
