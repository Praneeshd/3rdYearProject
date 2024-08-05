import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/local_network/hive_service.dart';
import 'package:foodrush/features/forgetpassword/data/model/email_hive_model.dart';

final emailLocalDataSourceProvider = Provider(
  (ref) => EmailLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(emailHiveModelProvider),
  ),
);

class EmailLocalDataSource {
  final HiveService _hiveService;
  // ignore: unused_field
  final EmailHiveModel _emailHiveModel;

  EmailLocalDataSource(this._hiveService, this._emailHiveModel);

  Future<Either<Failure, bool>> AutoDisposeStateNotifierProviderFamily(
    String email,
  ) async {
    try {
      EmailHiveModel? users = await _hiveService.sendemail(email);
     if (users == null) {
        return Left(Failure(error: 'Email is invalid'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
