class Activity {
  final int id;
  final String title;
  final String time;
  final String category;
  final bool done;

  Activity({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    required this.done,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'],
        title: json['title'],
        time: json['time'],
        category: json['category'],
        done: json['done'],
      );
}