import 'package:equatable/equatable.dart';

class CodeEntity extends Equatable {
  final String? id;
  final int resetCode;

  const CodeEntity({
    this.id,
    required this.resetCode,
  });

  @override
  List<Object?> get props => [id, resetCode];
}