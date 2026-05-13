import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar7View extends StatefulWidget {
  @override
  State<GrlCalendar7View> createState() => _GrlCalendar7ViewState();
}

class _GrlCalendar7ViewState extends State<GrlCalendar7View> {
  DateTime selectedDate = DateTime.now();
  String selectedPeriod = 'week';
  
  List<Map<String, dynamic>> habits = [
    {
      "id": 1,
      "name": "Drink 8 glasses of water",
      "icon": Icons.water_drop,
      "color": Colors.blue,
      "streak": 12,
      "target": 8,
      "current": 6,
      "unit": "glasses",
      "category": "health",
    },
    {
      "id": 2,
      "name": "Read for 30 minutes",
      "icon": Icons.book,
      "color": Colors.green,
      "streak": 8,
      "target": 30,
      "current": 20,
      "unit": "minutes",
      "category": "learning",
    },
    {
      "id": 3,
      "name": "Meditate",
      "icon": Icons.self_improvement,
      "color": Colors.purple,
      "streak": 15,
      "target": 1,
      "current": 1,
      "unit": "session",
      "category": "wellness",
    },
    {
      "id": 4,
      "name": "Exercise",
      "icon": Icons.fitness_center,
      "color": Colors.orange,
      "streak": 5,
      "target": 1,
      "current": 0,
      "unit": "workout",
      "category": "fitness",
    },
    {
      "id": 5,
      "name": "Journal writing",
      "icon": Icons.edit_note,
      "color": Colors.indigo,
      "streak": 3,
      "target": 1,
      "current": 1,
      "unit": "entry",
      "category": "personal",
    },
  ];

  Map<String, List<bool>> weeklyProgress = {
    "1": [true, true, false, true, true, true, false], // Habit 1 - 7 days
    "2": [true, false, true, true, false, true, true],  // Habit 2 - 7 days
    "3": [true, true, true, true, true, true, true],     // Habit 3 - 7 days
    "4": [false, true, false, true, true, false, false], // Habit 4 - 7 days
    "5": [true, true, false, true, false, true, true],   // Habit 5 - 7 days
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddHabitView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${habits.where((h) => (h["current"] as int) >= (h["target"] as int)).length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Completed Today",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white30,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(habits.map((h) => h["streak"] as int).reduce((a, b) => a + b) / habits.length).round()}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Avg. Streak",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white30,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(habits.where((h) => (h["current"] as int) >= (h["target"] as int)).length / habits.length * 100).round()}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Success Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Period Selector
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedPeriod = 'today';
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedPeriod == 'today' ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Today",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedPeriod == 'today' ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedPeriod = 'week';
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedPeriod == 'week' ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "This Week",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedPeriod == 'week' ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedPeriod = 'stats';
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedPeriod == 'stats' ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Statistics",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selectedPeriod == 'stats' ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content based on selected period
            if (selectedPeriod == 'today') _buildTodayView(),
            if (selectedPeriod == 'week') _buildWeekView(),
            if (selectedPeriod == 'stats') _buildStatsView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddHabitView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTodayView() {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Habits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...habits.map((habit) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: habit["color"] as Color,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (habit["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        habit["icon"] as IconData,
                        color: habit["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${habit["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${habit["category"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: habit["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (habit["current"] as int) >= (habit["target"] as int)
                            ? successColor.withAlpha(20)
                            : warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${habit["streak"]} day streak",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: (habit["current"] as int) >= (habit["target"] as int)
                              ? successColor
                              : warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Progress
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${habit["current"]}/${habit["target"]} ${habit["unit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: (habit["current"] as int) / (habit["target"] as int),
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              habit["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    if ((habit["current"] as int) < (habit["target"] as int))
                      Expanded(
                        child: QButton(
                          label: "Mark Done",
                          size: bs.sm,
                          onPressed: () {
                            if ((habit["current"] as int) < (habit["target"] as int)) {
                              habit["current"] = habit["target"];
                              setState(() {});
                              ss("Habit completed!");
                            }
                          },
                        ),
                      ),
                    if ((habit["current"] as int) >= (habit["target"] as int))
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if ((habit["current"] as int) > 0 && (habit["current"] as int) < (habit["target"] as int))
                      SizedBox(width: spSm),
                    if ((habit["current"] as int) > 0 && (habit["current"] as int) < (habit["target"] as int))
                      Expanded(
                        child: QButton(
                          label: "Add Progress",
                          size: bs.sm,
                          onPressed: () {
                            if ((habit["current"] as int) < (habit["target"] as int)) {
                              habit["current"] = (habit["current"] as int) + 1;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Week Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Habits",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                ...weekDays.map((day) => Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                )).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Habits Progress Grid
          ...habits.map((habit) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  child: Row(
                    children: [
                      Icon(
                        habit["icon"] as IconData,
                        color: habit["color"] as Color,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${habit["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(7, (dayIndex) {
                  bool isCompleted = weeklyProgress["${habit["id"]}"]![dayIndex];
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? (habit["color"] as Color)
                            : disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Icon(
                          isCompleted ? Icons.check : Icons.close,
                          color: isCompleted ? Colors.white : disabledBoldColor,
                          size: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildStatsView() {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Habit Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Best Streak
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Best Streak",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${habits.map((h) => h["streak"] as int).reduce((a, b) => a > b ? a : b)} days",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${habits.firstWhere((h) => h["streak"] == habits.map((h) => h["streak"] as int).reduce((a, b) => a > b ? a : b))["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Category Stats
          Text(
            "By Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Group habits by category and show stats
          ...Map.fromEntries(
            habits.map((h) => h["category"] as String).toSet().map((category) {
              List<Map<String, dynamic>> categoryHabits = habits.where((h) => h["category"] == category).toList();
              int completedToday = categoryHabits.where((h) => (h["current"] as int) >= (h["target"] as int)).length;
              double avgStreak = categoryHabits.map((h) => h["streak"] as int).reduce((a, b) => a + b) / categoryHabits.length;
              
              return MapEntry(category, {
                'habits': categoryHabits,
                'completed': completedToday,
                'total': categoryHabits.length,
                'avgStreak': avgStreak,
              });
            })
          ).entries.map((entry) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${entry.key}".toUpperCase(),
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${entry.value['completed']}/${entry.value['total']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Completion Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((entry.value['completed'] as int) / (entry.value['total'] as int) * 100).round()}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg. Streak",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(entry.value['avgStreak'] as double).round()} days",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (entry.value['completed'] as int) / (entry.value['total'] as int),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
