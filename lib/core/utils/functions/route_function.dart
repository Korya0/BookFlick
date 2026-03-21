import 'package:another_flushbar/flushbar.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<Object?> navigateToDetailsView(BuildContext context, Book book) {
  return book.bookId != null
      ? context.pushNamed(
        AppRoutes.bookDetails,
        pathParameters: {'bookId': book.bookId as String},
        extra: book,
      )
      : showTopFlushbar(context, 'No detail for this book');
}

Future<void> showTopFlushbar(BuildContext context, String message) async {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 1),
    backgroundColor: AppColors.secondaryBackground,
    margin: const EdgeInsets.all(AppMargin.m8),
    borderRadius: BorderRadius.circular(AppRadius.r10),
    icon: const Icon(Icons.info, color: AppColors.defaultIcon),
  ).show(context);
}
