import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaTrainingSessionsView extends StatefulWidget {
  const FwaTrainingSessionsView({super.key});

  @override
  State<FwaTrainingSessionsView> createState() => _FwaTrainingSessionsViewState();
}

class _FwaTrainingSessionsViewState extends State<FwaTrainingSessionsView> {
  List<Map<String, dynamic>> sessions = [
    {
      "id": "session_1",
      "date": "2024-03-20",
      "time": "07:00",
      "duration": 60,
      "trainer": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=60&keyword=trainer",
        "speciality": "Strength Training",
      },
      "type": "Strength Training",
      "location": "Downtown Gym",
      "status": "upcoming",
      "notes": "Focus on upper body strength building",
      "exercises": [
        {"name": "Bench Press", "sets": 4, "reps": "8-10", "weight": "70kg"},
        {"name": "Pull-ups", "sets": 3, "reps": "6-8", "weight": "Bodyweight"},
        {"name": "Shoulder Press", "sets": 3, "reps": "10-12", "weight": "25kg"},
      ],
    },
    {
      "id": "session_2",
      "date": "2024-03-18",
      "time": "18:30",
      "duration": 60,
      "trainer": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=60&keyword=trainer",
        "speciality": "Cardio",
      },
      "type": "HIIT Cardio",
      "location": "Downtown Gym",
      "status": "completed",
      "notes": "High intensity interval training session",
      "exercises": [
        {"name": "Burpees", "sets": 4, "reps": "30 sec", "weight": "Bodyweight"},
        {"name": "Mountain Climbers", "sets": 4, "reps": "30 sec", "weight": "Bodyweight"},
        {"name": "Jump Squats", "sets": 4, "reps": "30 sec", "weight": "Bodyweight"},
      ],
      "feedback": {
        "rating": 5,
        "comment": "Excellent session! Sarah pushed me to my limits.",
        "energyLevel": 4,
        "difficulty": 5,
      },
    },
    {
      "id": "session_3",
      "date": "2024-03-16",
      "time": "07:00",
      "duration": 60,
      "trainer": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=60&keyword=trainer",
        "speciality": "Functional Training",
      },
      "type": "Functional Training",
      "location": "Downtown Gym",
      "status": "completed",
      "notes": "Core stability and functional movements",
      "exercises": [
        {"name": "Deadlifts", "sets": 4, "reps": "6-8", "weight": "80kg"},
        {"name": "Planks", "sets": 3, "reps": "60 sec", "weight": "Bodyweight"},
        {"name": "Turkish Get-ups", "sets": 3, "reps": "5 each side", "weight": "16kg"},
      ],
      "feedback": {
        "rating": 5,
        "comment": "Great focus on form and technique.",
        "energyLevel": 4,
        "difficulty": 4,
      },
    },
    {
      "id": "session_4",
      "date": "2024-03-14",
      "time": "18:30",
      "duration": 60,
      "trainer": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=60&keyword=trainer",
        "speciality": "Flexibility",
      },
      "type": "Flexibility & Recovery",
      "location": "Downtown Gym",
      "status": "completed",
      "notes": "Active recovery and mobility work",
      "exercises": [
        {"name": "Dynamic Stretching", "sets": 1, "reps": "10 min", "weight": "Bodyweight"},
        {"name": "Foam Rolling", "sets": 1, "reps": "15 min", "weight": "Bodyweight"},
        {"name": "Yoga Flow", "sets": 1, "reps": "20 min", "weight": "Bodyweight"},
      ],
      "feedback": {
        "rating": 4,
        "comment": "Very relaxing and helpful for recovery.",
        "energyLevel": 3,
        "difficulty": 2,
      },
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Upcoming", "Completed", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSessions = _getFilteredSessions();

    return Scaffold(
      appBar: AppBar(
        title: Text("Training Sessions"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showCalendarView();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showAnalytics();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSessionsOverview(),
            SizedBox(height: spMd),
            _buildFilterSection(),
            SizedBox(height: spMd),
            _buildSessionsList(filteredSessions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bookNewSession();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSessionsOverview() {
    int totalSessions = sessions.length;
    int completedSessions = sessions.where((s) => s["status"] == "completed").length;
    int upcomingSessions = sessions.where((s) => s["status"] == "upcoming").length;
    
    double averageRating = sessions
        .where((s) => s["feedback"] != null)
        .map((s) => s["feedback"]["rating"] as int)
        .fold(0.0, (sum, rating) => sum + rating) / 
        sessions.where((s) => s["feedback"] != null).length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Training Progress",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Keep up the great work!",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildOverviewStat("Total Sessions", "$totalSessions", Icons.fitness_center),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat("Completed", "$completedSessions", Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat("Upcoming", "$upcomingSessions", Icons.schedule),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat("Avg Rating", "${averageRating.toStringAsFixed(1)}", Icons.star),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Sessions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: filterOptions.map((filter) {
              bool isSelected = selectedFilter == filter;
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsList(List<Map<String, dynamic>> filteredSessions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sessions (${filteredSessions.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: filteredSessions.map((session) {
            return _buildSessionCard(session);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    Color statusColor = _getStatusColor(session["status"]);
    bool isUpcoming = session["status"] == "upcoming";

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isUpcoming ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [shadowSm],
                ),
                child: ClipOval(
                  child: Image.network(
                    "${session["trainer"]["avatar"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${session["type"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${session["status"].toString().toUpperCase()}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "with ${session["trainer"]["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${DateTime.parse(session["date"]).dMMMy} at ${session["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${session["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (session["notes"] != null && (session["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${session["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (session["exercises"] != null) ...[
            SizedBox(height: spMd),
            Text(
              "Workout Plan",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              children: (session["exercises"] as List).take(3).map((exercise) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(15),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${exercise["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${exercise["sets"]}x${exercise["reps"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          if (session["feedback"] != null) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: warningColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Session Feedback",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (session["feedback"]["rating"] as int)
                                ? Icons.star
                                : Icons.star_border,
                            color: warningColor,
                            size: 14,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${session["feedback"]["comment"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              if (isUpcoming) ...[
                Expanded(
                  child: QButton(
                    label: "Reschedule",
                    size: bs.sm,
                    onPressed: () {
                      _rescheduleSession(session);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () {
                      _cancelSession(session);
                    },
                  ),
                ),
              ] else if (session["status"] == "completed" && session["feedback"] == null) ...[
                Expanded(
                  child: QButton(
                    label: "Rate Session",
                    size: bs.sm,
                    onPressed: () {
                      _rateSession(session);
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _viewSessionDetails(session);
                    },
                  ),
                ),
              ],
              SizedBox(width: spSm),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  _messageTrainer(session);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "upcoming":
        return primaryColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredSessions() {
    if (selectedFilter == "All") {
      return sessions;
    }
    return sessions.where((session) => session["status"] == selectedFilter.toLowerCase()).toList();
  }

  void _bookNewSession() {
    // Navigate to booking page
  }

  void _showCalendarView() {
    // Show calendar view
  }

  void _showAnalytics() {
    // Show analytics view
  }

  void _rescheduleSession(Map<String, dynamic> session) {
    // Reschedule session logic
  }

  void _cancelSession(Map<String, dynamic> session) {
    // Cancel session logic
  }

  void _rateSession(Map<String, dynamic> session) {
    // Rate session logic
  }

  void _viewSessionDetails(Map<String, dynamic> session) {
    // View session details
  }

  void _messageTrainer(Map<String, dynamic> session) {
    // Message trainer
  }
}
