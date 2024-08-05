import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/forgetpassword/data/data_source/code_remote_data_source.dart';
import 'package:foodrush/features/forgetpassword/domain/repository/code_repository.dart';

final resetCodeRemoteRepositoryProvider = Provider<ICodeRepository>((ref) {
  return CodeRemoteRepository(
    ref.read(resetCodeRemoteDataSourceProvider),
  );
});

class CodeRemoteRepository implements ICodeRepository {
  final CodeRemoteDataSource _resetCodeRemoteDataSource;
  CodeRemoteRepository(this._resetCodeRemoteDataSource);

  @override
  Future<Either<Failure, bool>> sendresetCodeUser(int resetCode) {
    return _resetCodeRemoteDataSource.sendresetCodeUser(resetCode);
  }
}
