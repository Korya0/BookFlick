  import 'package:bookna_app/features/favorite/presentation/controller/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void fetchMoreBooks(BuildContext context) {
    if (context.read<FavoriteCubit>().state.isNotEmpty) {
      context.read<FavoriteCubit>();
    }
  }
  