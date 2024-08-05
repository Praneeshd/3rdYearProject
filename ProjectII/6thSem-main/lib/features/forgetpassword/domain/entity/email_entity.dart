import 'package:equatable/equatable.dart';

class EmailEntity extends Equatable {
  final String? id;
  final String email;

  const EmailEntity({
    this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [id, email];
}
