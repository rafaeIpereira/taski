import 'package:hive/hive.dart';

part 'todo.g.dart'; // Necessário para o Hive Generator

@HiveType(typeId: 0) // Define o tipo do adaptador
class  Todo extends HiveObject {
  @HiveField(0) // Campo 0
  String title;

  @HiveField(1) // Campo 1
  String description;

  @HiveField(2) // Campo 1
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
