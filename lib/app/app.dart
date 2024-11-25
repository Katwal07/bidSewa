import 'package:flutter/material.dart';

import '../common/res/size_configs.dart';
import '../core/config/routes/routes.dart';
import '../core/config/routes/routes_name.dart';
import '../core/config/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfigs().init(constraints, orientation);
            return MaterialApp(
              title: 'NEPA_BID',
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: AppRoutesName.splashScreen,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        );
      },
    );
  }
}
