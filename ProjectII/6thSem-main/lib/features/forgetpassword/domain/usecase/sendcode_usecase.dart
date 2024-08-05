import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/forgetpassword/domain/repository/code_repository.dart';

final codeUseCaseProvider = Provider.autoDispose<CodeUseCase>(
  (ref) => CodeUseCase(ref.watch(resetCodeRepositoryProvider)),
);

class CodeUseCase {
  final ICodeRepository _codeRepository;

  CodeUseCase(this._codeRepository);

  Future<Either<Failure, bool>> sendresetCodeUser(
    int resetCode, String email,
  ) async {
    return await _codeRepository.sendresetCodeUser(resetCode);
  }
}