import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/local_network/hive_service.dart';
import 'package:foodrush/features/forgetpassword/data/model/code_hive_model.dart';
final resetCodeLocalDataSourceProvider = Provider(
  (ref) => CodeLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(resetCodeHiveModelProvider),
  ),
);

class CodeLocalDataSource {
  final HiveService _hiveService;
  // ignore: unused_field
  final CodeHiveModel _resetCodeHiveModel;

  CodeLocalDataSource(this._hiveService, this._resetCodeHiveModel);

  // ignore: non_constant_identifier_names
  Future<Either<Failure, bool>> AutoDisposeStateNotifierProviderFamily(
    int resetCode,
  ) async {
    try {
      CodeHiveModel? users = await _hiveService.sendresetCode(resetCode);
     if (users == null) {
        return Left(Failure(error: 'Code is invalid'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
