import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPillTrackerView extends StatefulWidget {
  const HcaPillTrackerView({super.key});

  @override
  State<HcaPillTrackerView> createState() => _HcaPillTrackerViewState();
}

class _HcaPillTrackerViewState extends State<HcaPillTrackerView> {
  String selectedPeriod = "Today";
  String searchQuery = "";
  DateTime selectedDate = DateTime.now();
  
  List<String> periodOptions = ["Today", "This Week", "This Month", "All Time"];
  
  List<Map<String, dynamic>> pillHistory = [
    {
      "id": 1,
      "medication": "Amoxicillin",
      "dosage": "500mg",
      "scheduledTime": "08:00",
      "takenTime": "08:15",
      "status": "taken_late",
      "date": "2024-01-15",
      "dayOfWeek": "Monday",
      "delay": 15,
      "notes": "Taken with breakfast",
      "color": warningColor,
      "pillCount": 1,
      "sideEffects": [],
      "mood": "good",
      "symptoms": []
    },
    {
      "id": 2,
      "medication": "Lisinopril",
      "dosage": "10mg",
      "scheduledTime": "09:00",
      "takenTime": "09:00",
      "status": "taken_on_time",
      "date": "2024-01-15",
      "dayOfWeek": "Monday",
      "delay": 0,
      "notes": "On empty stomach as prescribed",
      "color": successColor,
      "pillCount": 1,
      "sideEffects": [],
      "mood": "good",
      "symptoms": []
    },
    {
      "id": 3,
      "medication": "Metformin",
      "dosage": "850mg",
      "scheduledTime": "19:00",
      "takenTime": null,
      "status": "missed",
      "date": "2024-01-14",
      "dayOfWeek": "Sunday",
      "delay": null,
      "notes": "Forgot to take after dinner",
      "color": dangerColor,
      "pillCount": 1,
      "sideEffects": [],
      "mood": "neutral",
      "symptoms": ["Nausea"]
    },
    {
      "id": 4,
      "medication": "Vitamin D3",
      "dosage": "2000 IU",
      "scheduledTime": "10:00",
      "takenTime": "09:45",
      "status": "taken_early",
      "date": "2024-01-15",
      "dayOfWeek": "Monday",
      "delay": -15,
      "notes": "Taken with morning coffee",
      "color": infoColor,
      "pillCount": 1,
      "sideEffects": [],
      "mood": "excellent",
      "symptoms": []
    },
    {
      "id": 5,
      "medication": "Ibuprofen",
      "dosage": "400mg",
      "scheduledTime": "As needed",
      "takenTime": "14:30",
      "status": "taken_as_needed",
      "date": "2024-01-14",
      "dayOfWeek": "Sunday",
      "delay": 0,
      "notes": "For headache relief",
      "color": primaryColor,
      "pillCount": 1,
      "sideEffects": [],
      "mood": "fair",
      "symptoms": ["Headache"]
    },
    {
      "id": 6,
      "medication": "Amoxicillin",
      "dosage": "500mg",
      "scheduledTime": "14:00",
      "takenTime": "14:00",
      "status": "taken_on_time",
      "date": "2024-01-15",
      "dayOfWeek": "Monday",
      "delay": 0,
      "notes": "With lunch",
      "color": successColor,
      "pillCount": 1,
      "sideEffects": [],
      "mood": "good",
      "symptoms": []
    },
    {
      "id": 7,
      "medication": "Metformin",
      "dosage": "850mg",
      "scheduledTime": "07:00",
      "takenTime": "07:30",
      "status": "taken_late",
      "date": "2024-01-15",
      "dayOfWeek": "Monday",
      "delay": 30,
      "notes": "Overslept, took with breakfast",
      "color": warningColor,
      "pillCount": 1,
      "sideEffects": ["Mild stomach upset"],
      "mood": "good",
      "symptoms": []
    }
  ];

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = pillHistory;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((pill) =>
        pill["medication"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        pill["notes"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort by date and time
    filtered.sort((a, b) {
      DateTime dateA = DateTime.parse("${a['date']} ${a['scheduledTime'] == 'As needed' ? '00:00' : a['scheduledTime']}:00");
      DateTime dateB = DateTime.parse("${b['date']} ${b['scheduledTime'] == 'As needed' ? '00:00' : b['scheduledTime']}:00");
      return dateB.compareTo(dateA);
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pill Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () => _showAnalytics(),
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () => _showCalendarView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildComplianceStats(),
            _buildWeeklyOverview(),
            _buildPillHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search pills",
          value: searchQuery,
          hint: "Search by medication or notes",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QCategoryPicker(
          items: periodOptions.map((period) => {
            "label": period,
            "value": period,
          }).toList(),
          value: selectedPeriod,
          onChanged: (index, label, value, item) {
            selectedPeriod = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildComplianceStats() {
    int totalPills = pillHistory.length;
    int takenOnTime = pillHistory.where((p) => p["status"] == "taken_on_time").length;
    int takenLate = pillHistory.where((p) => p["status"] == "taken_late").length;
    int missed = pillHistory.where((p) => p["status"] == "missed").length;
    int asNeeded = pillHistory.where((p) => p["status"] == "taken_as_needed").length;
    
    double complianceRate = totalPills > 0 ? ((takenOnTime + takenLate + asNeeded) / totalPills * 100) : 0;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Compliance Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: complianceRate >= 90 ? successColor.withAlpha(20) : 
                     complianceRate >= 70 ? warningColor.withAlpha(20) : 
                     dangerColor.withAlpha(20),
            ),
            child: Center(
              child: Text(
                "${complianceRate.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: complianceRate >= 90 ? successColor : 
                         complianceRate >= 70 ? warningColor : 
                         dangerColor,
                ),
              ),
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildComplianceCard("On Time", "$takenOnTime", successColor),
              _buildComplianceCard("Late", "$takenLate", warningColor),
              _buildComplianceCard("Missed", "$missed", dangerColor),
              _buildComplianceCard("As Needed", "$asNeeded", infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverview() {
    Map<String, List<Map<String, dynamic>>> groupedByDay = {};
    
    for (var pill in pillHistory) {
      String day = pill["dayOfWeek"];
      if (!groupedByDay.containsKey(day)) {
        groupedByDay[day] = [];
      }
      groupedByDay[day]!.add(pill);
    }

    List<String> weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_view_week, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Weekly Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays.map((day) {
              List<Map<String, dynamic>> dayPills = groupedByDay[day] ?? [];
              int takenCount = dayPills.where((p) => p["status"] != "missed").length;
              int totalCount = dayPills.length;
              
              return _buildDayColumn(day.substring(0, 3), takenCount, totalCount);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayColumn(String day, int taken, int total) {
    Color color = total == 0 ? disabledColor : 
                  taken == total ? successColor :
                  taken > 0 ? warningColor : dangerColor;

    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: color),
          ),
          child: Center(
            child: Text(
              "$taken/$total",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPillHistory() {
    if (filteredHistory.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.medication,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No pill history found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Start tracking your medications",
              style: TextStyle(color: disabledColor),
            ),
          ],
        ),
      );
    }

    Map<String, List<Map<String, dynamic>>> groupedByDate = {};
    
    for (var pill in filteredHistory) {
      String date = pill["date"];
      if (!groupedByDate.containsKey(date)) {
        groupedByDate[date] = [];
      }
      groupedByDate[date]!.add(pill);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pill History (${filteredHistory.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...groupedByDate.entries.map((entry) => _buildDateGroup(entry.key, entry.value)),
      ],
    );
  }

  Widget _buildDateGroup(String date, List<Map<String, dynamic>> pills) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    String dayOfWeek = pills.first["dayOfWeek"];

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Text(
                  "$dayOfWeek, $formattedDate",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${pills.length} pills",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spXs),
          ...pills.map((pill) => _buildPillCard(pill)),
        ],
      ),
    );
  }

  Widget _buildPillCard(Map<String, dynamic> pill) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: pill["color"] as Color,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (pill["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getStatusIcon(pill["status"]),
                  color: pill["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${pill["medication"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (pill["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusText(pill["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: pill["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${pill["dosage"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Scheduled: ${pill["scheduledTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (pill["takenTime"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.check, size: 14, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Taken: ${pill["takenTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
          if (pill["delay"] != null && pill["delay"] != 0) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(
                  pill["delay"] > 0 ? Icons.access_time : Icons.schedule,
                  size: 14,
                  color: pill["delay"] > 0 ? warningColor : infoColor,
                ),
                SizedBox(width: spXs),
                Text(
                  pill["delay"] > 0 
                    ? "${pill["delay"]} minutes late"
                    : "${(pill["delay"] as int).abs()} minutes early",
                  style: TextStyle(
                    fontSize: 12,
                    color: pill["delay"] > 0 ? warningColor : infoColor,
                  ),
                ),
              ],
            ),
          ],
          if (pill["notes"].isNotEmpty) ...[
            SizedBox(height: spXs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.note, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${pill["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if ((pill["sideEffects"] as List).isNotEmpty) ...[
            SizedBox(height: spXs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning, size: 14, color: warningColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Side effects: ${(pill["sideEffects"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showPillDetails(pill),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editPillEntry(pill),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "taken_on_time":
        return Icons.check_circle;
      case "taken_late":
        return Icons.access_time;
      case "taken_early":
        return Icons.schedule;
      case "missed":
        return Icons.cancel;
      case "taken_as_needed":
        return Icons.help_outline;
      default:
        return Icons.medication;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "taken_on_time":
        return "ON TIME";
      case "taken_late":
        return "LATE";
      case "taken_early":
        return "EARLY";
      case "missed":
        return "MISSED";
      case "taken_as_needed":
        return "AS NEEDED";
      default:
        return "UNKNOWN";
    }
  }

  void _showAnalytics() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Pill Tracker Analytics",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              _buildAnalyticsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    Map<String, int> medicationCounts = {};
    Map<String, int> statusCounts = {};
    int totalDelayMinutes = 0;
    int lateCount = 0;

    for (var pill in pillHistory) {
      String med = pill["medication"];
      medicationCounts[med] = (medicationCounts[med] ?? 0) + 1;
      
      String status = pill["status"];
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      
      if (pill["delay"] != null && pill["delay"] > 0) {
        totalDelayMinutes += pill["delay"] as int;
        lateCount++;
      }
    }

    double avgDelay = lateCount > 0 ? totalDelayMinutes / lateCount : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Medication Breakdown",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...medicationCounts.entries.map((entry) => Container(
          margin: EdgeInsets.only(bottom: spXs),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Row(
            children: [
              Text(
                entry.key,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                "${entry.value} pills",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )),
        SizedBox(height: spMd),
        Text(
          "Timing Analysis",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Row(
            children: [
              Icon(Icons.access_time, color: warningColor),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Average Delay",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${avgDelay.toStringAsFixed(1)} minutes",
                    style: TextStyle(
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCalendarView() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Calendar View",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Calendar view would be implemented here with proper calendar widget",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPillDetails(Map<String, dynamic> pill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (pill["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      _getStatusIcon(pill["status"]),
                      color: pill["color"] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pill["medication"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${pill["dosage"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              _buildDetailRow("Date", "${pill["dayOfWeek"]}, ${pill["date"]}"),
              _buildDetailRow("Status", _getStatusText(pill["status"])),
              _buildDetailRow("Scheduled Time", "${pill["scheduledTime"]}"),
              if (pill["takenTime"] != null)
                _buildDetailRow("Taken Time", "${pill["takenTime"]}"),
              if (pill["delay"] != null && pill["delay"] != 0)
                _buildDetailRow("Delay", "${pill["delay"]} minutes"),
              if (pill["notes"].isNotEmpty)
                _buildDetailRow("Notes", "${pill["notes"]}"),
              if ((pill["sideEffects"] as List).isNotEmpty)
                _buildDetailRow("Side Effects", (pill["sideEffects"] as List).join(", ")),
              _buildDetailRow("Mood", "${pill["mood"]}"),
              if ((pill["symptoms"] as List).isNotEmpty)
                _buildDetailRow("Symptoms", (pill["symptoms"] as List).join(", ")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editPillEntry(Map<String, dynamic> pill) {
    // Navigate to edit entry
    Navigator.pop(context);
    si("Edit functionality would be implemented here");
  }
}
