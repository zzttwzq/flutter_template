import 'package:app/config/config.dart';
import 'package:app/views/grid_page/grid_page_binding.dart';
import 'package:app/views/list_page/list_page_binding.dart';
import 'package:app/views/scroll_page/scroll_page_binding.dart';
import 'package:flutterbase/flutterbase.dart';
import '../localization/app_localization.dart';
import 'package:app/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    ListPageBinding().dependencies();
    GridPageBinding().dependencies();
    ScrollPageBinding().dependencies();
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Config.designSize,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              // systemOverlayStyle: SystemUiOverlayStyle(
              //     systemNavigationBarColor: Color(0xFF000000),
              //     systemNavigationBarIconBrightness: Brightness.light,
              //     statusBarColor: Colors.transparent,
              //     statusBarIconBrightness: Brightness.dark,
              //     statusBarBrightness: Brightness.light), // 状态栏内容黑色
              scrolledUnderElevation: 0, // 界面里ListView等可滚动视图滚动时，AppBar不要改变颜色
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          builder: (context, child) {
            TransitionBuilder hudBuilder = HudUtil.init();
            child = hudBuilder(context, child);

            return MediaQuery(
              // 设置文字大小不随系统设置改变
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child,
            );
          },
          onGenerateRoute: (settings) {
            // if (settings.name == '/page1') {
            //   return MaterialPageRoute(
            //     builder: (context) => const DrawPage(),
            //     settings: settings,
            //   );
            // }
            return null;
          },
          initialRoute: AppRoute.initialRoute,
          getPages: AppRoute.pages,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            debugPrint('>>>locale_callback ${locale?.languageCode}');

            if (AppLocalization.getCurrentSystemLanguage() != locale) {
              debugPrint('>>> 需要更新');
              AppLocalization.switchLanguage(Locale('zh', 'CN'));
            }
          },
          supportedLocales: AppLocalization.languages,
          translations: AppLocalization(),
          fallbackLocale: AppLocalization.getDefaultLanguage(),
          locale: AppLocalization.getCurrentSystemLanguage(),
        );
      },
    );
  }
}
