import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/activity.dart';
import '../services/session_service.dart';
import 'login_screen.dart';
import 'package:intl/intl.dart';

const List<String> activityCategories = [
  'Kuliah',
  'Kerja',
  'Kesehatan',
  'Hobi',
  'Belanja',
  'Keluarga',
  'Lainnya',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Activity> activities = [];

  Future<void> fetchActivities() async {
    final data = await SupabaseService.getActivities();
    setState(() {
      activities = data.map((e) => Activity.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> showAddActivityDialog() async {
    final titleController = TextEditingController();
    String? selectedCategory;
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    String getDateTimeText() {
      if (selectedDate == null || selectedTime == null)
        return 'Select Date and Time';
      final dt = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      return DateFormat('yyyy-MM-dd HH:mm').format(dt);
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Activity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Activities'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: activityCategories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) {
                selectedCategory = val;
              },
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      selectedDate = date;
                      selectedTime = time;
                    });
                  }
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date and Time',
                  border: OutlineInputBorder(),
                ),
                child: Text(getDateTimeText()),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Tambah'),
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  selectedCategory == null ||
                  selectedDate == null ||
                  selectedTime == null) {
                return;
              }
              final dt = DateTime(
                selectedDate!.year,
                selectedDate!.month,
                selectedDate!.day,
                selectedTime!.hour,
                selectedTime!.minute,
              );
              await SupabaseService.addActivity(
                titleController.text,
                DateFormat('yyyy-MM-dd HH:mm').format(dt),
                selectedCategory!,
              );
              Navigator.pop(context);
              fetchActivities();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SupabaseService.signOut();
              await SessionService.setLoggedIn(false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: activities
                  .map(
                    (a) => ListTile(
                      title: Text(
                        a.title,
                        style: TextStyle(
                          decoration: a.done
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text('${a.time} - ${a.category}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: a.done,
                            onChanged: (val) async {
                              await SupabaseService.markDone(
                                a.id,
                                val ?? false,
                              );
                              fetchActivities();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await SupabaseService.deleteActivity(a.id);
                              fetchActivities();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddActivityDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
