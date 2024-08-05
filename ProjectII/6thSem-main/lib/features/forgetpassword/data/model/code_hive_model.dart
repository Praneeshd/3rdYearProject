import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/hive_table_constant.dart';
import 'package:foodrush/features/forgetpassword/domain/entity/code_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'code_hive_model.g.dart';

final resetCodeHiveModelProvider = Provider(
  (ref) => CodeHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class CodeHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(3)
  final int resetCode;

  // Constructor
  CodeHiveModel({
    String? userId,
    required this.resetCode,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  CodeHiveModel.empty()
      : this(
          userId: '',
          resetCode: 0,
        );

  // Convert Hive Object to Entity
  CodeEntity toEntity() => CodeEntity(
        id: userId,
        resetCode: resetCode,
      );

  // Convert Entity to Hive Object
  CodeHiveModel toHiveModel(CodeEntity entity) => CodeHiveModel(
        userId: const Uuid().v4(),
        resetCode: entity.resetCode,
  
      );

  // Convert Entity List to Hive List
  List<CodeHiveModel> toHiveModelList(List<CodeEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId,resetCode: $resetCode';
  }
}
