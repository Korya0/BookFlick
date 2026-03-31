import 'package:bookna_app/core/presentation/widget/global_bloc_providers.dart';
import 'package:bookna_app/core/resources/constants/app_strings.dart';
import 'package:bookna_app/core/resources/router/app_router.dart';
import 'package:bookna_app/core/resources/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BookFlick extends StatelessWidget {
  const BookFlick({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBlocProviders(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: getApplicationTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
