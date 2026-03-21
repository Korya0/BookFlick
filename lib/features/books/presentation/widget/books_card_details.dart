import 'package:bookna_app/core/presentation/widget/circle_dot.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/utils/functions/format_date.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BooksCardDetails extends StatelessWidget {
  const BooksCardDetails({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // If all required fields are null, return an empty SizedBox
    if (book.publishedDate == null &&
        book.categories == null &&
        book.pageCount == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Row(children: _buildDetailsRow(textTheme))],
    );
  }

  /// Builds the list of widgets for the Row dynamically based on available data.
  List<Widget> _buildDetailsRow(TextTheme textTheme) {
    final List<Widget> children = [];

    // Add published date if available
    if (book.publishedDate != null) {
      children.add(
        Text(
          formatDate(book.publishedDate!, outputFormat:AppStrings.yyyy),
          style: textTheme.bodyLarge,
        ),
      );
      // Add a dot if more items follow
      if (book.categories != null || book.pageCount != null) {
        children.add(const CircleDot());
      }
    }

    // Add first category if available
    if (book.categories != null && book.categories!.isNotEmpty) {
      children.add(
        Text(
          book.categories!.first.length > 16
              ? '${book.categories!.first.substring(0, 10)}...'
              : book.categories!.first,
          style: textTheme.bodyLarge,
        ),
      );
      // Add a dot if page count follows
      if (book.pageCount != null) {
        children.add(const CircleDot());
      }
    }

    // Add page count if available
    if (book.pageCount != null) {
      children.add(Text('${book.pageCount} ${AppStrings.page}', style: textTheme.bodyLarge));
    }

    return children;
  }
}
