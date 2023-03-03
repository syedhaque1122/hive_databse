

import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject
{
  @HiveField(0)
  String title;


  @HiveField(1)
  var date;

  @HiveField(2)
  var amount;

  NotesModel({required this.title,required this.date,required this.amount});




}