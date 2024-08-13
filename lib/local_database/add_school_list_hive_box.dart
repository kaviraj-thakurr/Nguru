import 'package:hive/hive.dart';

part 'add_school_list_hive_box.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String schoolUrl;

  @HiveField(1)
  final String subDomain;

  @HiveField(2)
  final String schoolNickName;

  UserModel({required this.schoolUrl, required this.subDomain, required this.schoolNickName});
}
