// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_movie_app/features_tmp/home/ui/cubits/history_cubit.dart';
// import 'package:project_movie_app/features_tmp/home/ui/widgets/movies_grid_view.dart';
//
//
// class TestProfileScreen extends StatefulWidget {
//   const TestProfileScreen({super.key});
//
//   @override
//   State<TestProfileScreen> createState() => _TestProfileScreenState();
// }
//
// class _TestProfileScreenState extends State<TestProfileScreen> {
//
//   @override
//   void initState() {
//     BlocProvider.of<HistoryCubit>(context).getVisitedMoviesHistory();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HistoryCubit, HistoryState>(builder: (context, state) {
//       if(state is GetHistoryState && state.isLoading) {
//         return Center(child: CircularProgressIndicator());
//       } else if(state is GetHistoryState && state.movies.isNotEmpty) {
//         return MoviesGridView(movies: state.movies);
//       } else {
//         return Center(child: Text((state as GetHistoryState).errorMessage));
//       }
//     });
//   }
// }
