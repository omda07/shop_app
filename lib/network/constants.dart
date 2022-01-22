// method (url) : v2/top-headlines
// queries :country=eg&categories=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//country=eg&categories=business&apiKey=21ec5da562414c9e9fb0525d87dbb2e6

//https://newsapi.org/v2/everything?q=tesla&apiKey=21ec5da562414c9e9fb0525d87dbb2e6

import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: token.toString()).then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;
