import 'dart:developer';

import 'package:champ/api/supabase.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/pages/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Func {
  Future<List<CategoryModel>> getCategories() async {
    try {
      var sup = SupabaseInit().supabase;

      var list = await sup!.from('categories').select();

      List<CategoryModel> newList =
          (list as List).map((item) => CategoryModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  Future<List<SneakerModel>> getSneakers() async {
    try {
      var sup = SupabaseInit().supabase;

      var list = await sup!.from('sneakers').select();

      List<SneakerModel> newList =
          (list as List).map((item) => SneakerModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  void tryToRegUser(String email, String password, BuildContext context) async {
    var sup = SupabaseInit().supabase;

    final AuthResponse res = await sup!.auth.signUp(
      email: email,
      password: password,
    );
  }

  void tryToSignIn(String email, String password, BuildContext context) async {
    if ((email.isEmpty && password.isEmpty) ||
        (email.isEmpty || password.isEmpty)) {
      log('empty fields');
      return;
    }

    try {
      var sup = SupabaseInit().supabase;

      final AuthResponse res = await sup!.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const MainPage()));
      } else {
        log('no user');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
