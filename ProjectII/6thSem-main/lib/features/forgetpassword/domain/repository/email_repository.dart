import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/forgetpassword/data/repository/email_remote_repository.dart';

final emailRepositoryProvider = Provider<IEmailRepository>((ref) {
  return ref.read(emailRemoteRepositoryProvider);
});

abstract class IEmailRepository {
  Future<Either<Failure, bool>> sendemailUser(String email);
}