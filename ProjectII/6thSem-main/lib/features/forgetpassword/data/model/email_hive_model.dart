import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/hive_table_constant.dart';
import 'package:foodrush/features/forgetpassword/domain/entity/email_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'email_hive_model.g.dart';

final emailHiveModelProvider = Provider(
  (ref) => EmailHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class EmailHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(3)
  final String email;

  // Constructor
  EmailHiveModel({
    String? userId,
    required this.email,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  EmailHiveModel.empty()
      : this(
          userId: '',
          email: '',
        );

  // Convert Hive Object to Entity
  EmailEntity toEntity() => EmailEntity(
        id: userId,
        email: email,
      );

  // Convert Entity to Hive Object
  EmailHiveModel toHiveModel(EmailEntity entity) => EmailHiveModel(
        userId: const Uuid().v4(),
        email: entity.email,
  
      );

  // Convert Entity List to Hive List
  List<EmailHiveModel> toHiveModelList(List<EmailEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId,email: $email';
  }
}
