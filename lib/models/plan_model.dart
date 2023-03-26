class Plan {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<Task> tasks;

  Plan(
      {required this.name,
      required this.startDate,
      required this.endDate,
      required this.tasks});
}

class Task {
  final String name;
  final DateTime date;
  final String description;

  Task({required this.name, required this.date, required this.description});
}
