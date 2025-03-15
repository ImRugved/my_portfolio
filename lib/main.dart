import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rugved_portfolio_flutter/screens/portfolio_app.dart';
import 'package:rugved_portfolio_flutter/theme/theme_provider.dart';
import 'package:rugved_portfolio_flutter/theme/theme_constants.dart';
import 'package:rugved_portfolio_flutter/utils/url_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          navigatorKey: UrlUtils.navigatorKey,
          title: 'Portfolio - Beyond the Resume',
          debugShowCheckedModeBanner: false,
          theme: ThemeConstants.lightTheme,
          darkTheme: ThemeConstants.darkTheme,
          themeMode: themeProvider.themeMode,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
          home: const PortfolioApp(),
        ),
      ),
    );
  }
}
