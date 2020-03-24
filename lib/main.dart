import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_playground/core/managers/core_manager.dart';
import 'package:flutter_playground/locator.dart';
import 'package:flutter_playground/screens/homepage.dart';
import 'package:provider/provider.dart';

import 'core/data_sources/task_local_data_source.dart';
import 'core/providers/dark_theme_provider.dart';
import 'core/providers/task_provider.dart';
import 'utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final taskLocalDataSource = locator<TaskLocalDataSource>();
  await Future.wait([taskLocalDataSource.init()]);
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: CoreManager(child: PlatformApp(
        title: 'Playground',
        debugShowCheckedModeBanner: false,
        android: (context) => MaterialAppData(
          theme: Styles.themeData(Provider.of<DarkThemeProvider>(context).darkTheme, context)
        ),
        home: HomePage(),
      )),
    );
  }
}
