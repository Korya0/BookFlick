import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/utils/debouncer.dart';
import 'package:bookna_app/features/catalog/presentation/controller/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _textController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _textController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return TextFormField(
      controller: _textController,
      cursorColor: AppColors.textFieldCursor,
      style: theme.bodyLarge,
      onChanged:
          (title) => _debouncer.run(
            () => context.read<SearchCubit>().getBooksByTitle(title),
          ),
      decoration: _buildInputDecoration(theme),
    );
  }

  InputDecoration _buildInputDecoration(TextTheme theme) => InputDecoration(
    focusedBorder: _buildBorder(),
    enabledBorder: _buildBorder(),
    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.disabledIcon),
    suffixIcon: IconButton(
      icon: const Icon(Icons.clear_rounded, color: AppColors.disabledIcon),
      onPressed: () {
        _textController.clear();
        context.read<SearchCubit>().getBooksByTitle('');
      },
    ),
    hintText: AppStrings.searchHint,
    hintStyle: theme.bodyLarge,
  );

  OutlineInputBorder _buildBorder() => OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.textFieldBorder),
    borderRadius: BorderRadius.circular(AppRadius.r8),
  );
}
