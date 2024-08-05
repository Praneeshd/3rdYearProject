import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/hive_table_constant.dart';
import 'package:foodrush/features/auth/data/model/auth_hive_model.dart';
import 'package:foodrush/features/forgetpassword/data/model/code_hive_model.dart';
import 'package:foodrush/features/forgetpassword/data/model/email_hive_model.dart';
import 'package:foodrush/features/profile/data/model/profile_hive_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
 
//create object using provider
final hiveServiceProvider = Provider<HiveService>(
    (ref) => HiveService(),
);
 
 
class HiveService {

  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
 
    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }
 
  // ======================== User Queries ========================
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }
 
  Future<List<AuthHiveModel>> getAllusers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }
 
  //Login
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.email == email && element.password == password);
    box.close();
    return user;
  }
 
 //send email
   Future<EmailHiveModel?>sendemail(String email) async {
    var box = await Hive.openBox<EmailHiveModel>(HiveTableConstant.userBox);
    var send = box.values.firstWhere((element) =>
        element.email == email);
    box.close();
    return send;
  }
 
  //send code
   Future<CodeHiveModel?>sendresetCode(int resetCode) async {
    var box = await Hive.openBox<CodeHiveModel>(HiveTableConstant.userBox);
    var send = box.values.firstWhere((element) =>
        element.resetCode == resetCode);
    box.close();
    return send;
  }
 

   Future<void> updateProfile(ProfileHiveModel profile) async {
    var box =
        await Hive.openBox<ProfileHiveModel>(HiveTableConstant.profileBox);
    await box.put(profile.profileId, profile);
  }
  // ======================== Auth Queries ========================
 
  Future<void> addAuth(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }
 
  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var auths = box.values.toList();
    return auths;
  }
 
  Future<void> deleteAuth(String userId) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(userId);
  }
 
  // Delete hive
  Future<void> deleteHive() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }
}