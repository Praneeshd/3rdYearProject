import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/forgetpassword/data/repository/code_remote_repository.dart';


final resetCodeRepositoryProvider = Provider<ICodeRepository>((ref) {
  return ref.read(resetCodeRemoteRepositoryProvider);
});

abstract class ICodeRepository {
  Future<Either<Failure, bool>> sendresetCodeUser(int resetCode);
}