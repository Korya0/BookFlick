import 'package:bookna_app/core/di/global_bloc_providers.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/router/app_router.dart';
import 'package:bookna_app/core/theme/app_theme.dart';
import 'package:bookna_app/core/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class BookFlick extends StatelessWidget {
  const BookFlick({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unFocus(),
      child: GlobalBlocProviders(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: getApplicationTheme(),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
