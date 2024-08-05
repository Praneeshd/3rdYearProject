import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/forgetpassword/data/data_source/email_remote_data_source.dart';
import 'package:foodrush/features/forgetpassword/domain/repository/email_repository.dart';

final emailRemoteRepositoryProvider = Provider<IEmailRepository>((ref) {
  return EmailRemoteRepository(
    ref.read(emailRemoteDataSourceProvider),
  );
});

class EmailRemoteRepository implements IEmailRepository {
  final EmailRemoteDataSource _emailRemoteDataSource;
  EmailRemoteRepository(this._emailRemoteDataSource);

  @override
  Future<Either<Failure, bool>> sendemailUser(String email,) {
    return _emailRemoteDataSource.sendemailUser(email);
  }
  
}
