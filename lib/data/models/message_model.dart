import 'package:hive_flutter/adapters.dart';
part 'message_model.g.dart';

@HiveType(typeId: 0)
class MessageModel {
  @HiveField(0)
  late bool? isMine;

  @HiveField(1)
  late String? message;

  @HiveField(2)
  late String? base64;

  MessageModel({this.isMine = true, this.message, this.base64});
}