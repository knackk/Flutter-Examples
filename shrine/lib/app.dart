// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'colors.dart';
import 'backdrop.dart';
import 'model/product.dart';
import 'category_menu.dart';

final ThemeData _theme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData baseTheme = ThemeData.light();

  return baseTheme.copyWith(
      accentColor: kShrineBrown900,
      primaryColor: kShrinePink400,
      buttonColor: kShrinePink400,
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
      textTheme: _buildShrineTextTheme(baseTheme.textTheme),
      primaryTextTheme: _buildShrineTextTheme(baseTheme.primaryTextTheme),
      accentTextTheme: _buildShrineTextTheme(baseTheme.accentTextTheme),
      primaryIconTheme: baseTheme.iconTheme.copyWith(color: kShrineBrown900),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ));
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

class ShrineApp extends StatefulWidget {
  @override
  _ShrineAppState createState() {
    return new _ShrineAppState();
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      debugShowCheckedModeBanner: false,
      home: Backdrop(
          currentCategory: Category.all,
          frontLayer: HomePage(
            category: _currentCategory,
          ),
          backLayer: CategoryMenu(
              onCategoryTap: _onCategoryTap, currentCategory: _currentCategory),
          backTitle: Text('Menu'),
          frontTitle: Text('Shrine')),
      initialRoute: '/login',
      onGenerateRoute: widget._getRoute,
      theme: _theme,
    );
  }
}
