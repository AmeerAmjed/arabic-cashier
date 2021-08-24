import 'package:cashier/database/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cashier/database/database.dart';
import 'package:cashier/screens/home/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.initiateDatabase();
DB.getEventTableData().then((value) => print(value));
print(DB.getEventTableData());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: Consumer<Data>(
        builder: (context, data, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [Locale("ar")],
            locale: Locale("ar"),
            theme: ThemeData(
              fontFamily: 'Tajawal_Regular',
              primarySwatch: Colors.indigo,
            ),
            home: Home(
              datas: data.getListItem,
            ),
          );
        },
      ),
    );
  }
}
