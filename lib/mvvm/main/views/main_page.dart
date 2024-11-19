import 'package:flutter/material.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

import '../../../util/screen_adapter_helper.dart';
import 'bottom_tab_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        ScreenHelper.init(context);
        if (snapshot.connectionState == ConnectionState.done) {
          // if (LoginDao.getToken() == null) {
          //   return LoginPage();
          // } else {}
          return BottomTabView();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
