import 'package:database_project/entity/attributeNames.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../colors.dart';
import '../components/snackBar.dart';
import '../employee/employe_project_view.dart';
import '../entity/user.dart';
import '../manager/manager_home.dart';
import 'authetication.dart';

class UserController {
  final _collection = AttributeNames.walletCollection;
  final supabase = Supabase.instance.client;
  /*final supabase = Supabase.instance.client;
  Map<String, dynamic> params = {'usrId': '123n2n3e2mk3s23'};
  dynamic response = await supabase.rpc('aaa', params: params);
  print('RPC Response: ${response}');*/
/*

  Future<bool> createUser(User user) async {
    try {
      String id = await supabase.registerData(
        data: user,
        collection: _collection,
      );

      await supabase.updateData(
        data: user.copyWith(id: id),
        id: id,
        collection: _collection,
      );

      return true;
    } catch (e, stackTrace) {
      return Future.error(
          "Error while signing up user ${e.toString()}{", stackTrace);
    }
  }
*/

/*  Future<void> updateUser(User user) async {
    try {
      await supabase.updateData(
        collection: _collection,
        id: user.id,
        data: user,
      );
    } catch (e, stackTrace) {
      return Future.error(
          "Error while updating user ${e.toString()}{", stackTrace);
    }
  }*/

  Future<AppUser> searchUser(
      String name, String password, BuildContext context) async {
    try {
      dynamic response = await supabase.rpc('get_user_details', params: {
        'email_param': name,
        'password_param': password,
      });
      final user = AppUser.fromJson(response);
      Authentication auth = Authentication();
      bool isAdvisor = await auth.isAdvisor(user.id);
      print(isAdvisor);
      isAdvisor
          ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ManagerHome()),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmployeeProjectView()),
            );
      return user;
    } catch (e, stackTrace) {
      {
        ShowSnackBar(context: context, doesItAppearAtTheBottom: true)
            .showErrorSnackBar(
          message: "The is no user with this email or password.",
          color: DSColors.accentsErrorRed,
        );
      }
      return Future.error(e.toString(), stackTrace);
    }
  }

/*  Future<List<User>> searchUserWithCondition(
      {required String cond, required String condName}) async {
    List<User> retorno = [];
    try {
      final dado = await supabase.searchDataWithCondition(
          collection: _collection, cond: cond, condName: condName);
      dado.forEach((element) {
        retorno.add(User.fromJson(element));
      });

      return retorno;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }*/
}
