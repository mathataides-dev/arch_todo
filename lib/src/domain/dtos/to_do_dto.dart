class ToDoDTO {
  String title;
  String description;
  bool isDone;

  ToDoDTO({this.title = '', this.description = '', this.isDone = false});

  void setTitle(String title) => this.title = title;
  void setDescription(String description) => this.description = description;
  void toggleIsDone(bool isDone) => this.isDone = isDone;
}
