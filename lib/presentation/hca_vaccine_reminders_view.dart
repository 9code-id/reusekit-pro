import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaVaccineRemindersView extends StatefulWidget {
  const HcaVaccineRemindersView({super.key});

  @override
  State<HcaVaccineRemindersView> createState() => _HcaVaccineRemindersViewState();
}

class _HcaVaccineRemindersViewState extends State<HcaVaccineRemindersView> {
  List<Map<String, dynamic>> vaccines = [
    {
      "id": "1",
      "name": "COVID-19 Booster",
      "nextDue": "2024-07-15",
      "lastReceived": "2024-01-15",
      "status": "Due Soon",
      "priority": "High",
      "dosesReceived": 4,
      "totalDoses": 5,
      "provider": "CVS Pharmacy",
      "notes": "Annual booster recommended",
      "color": warningColor,
      "icon": Icons.coronavirus,
    },
    {
      "id": "2",
      "name": "Flu Shot",
      "nextDue": "2024-09-01",
      "lastReceived": "2023-09-15",
      "status": "Upcoming",
      "priority": "Medium",
      "dosesReceived": 1,
      "totalDoses": 1,
      "provider": "Family Doctor",
      "notes": "Annual flu vaccination",
      "color": infoColor,
      "icon": Icons.medical_services,
    },
    {
      "id": "3",
      "name": "Tetanus",
      "nextDue": "2034-03-20",
      "lastReceived": "2024-03-20",
      "status": "Up to Date",
      "priority": "Low",
      "dosesReceived": 1,
      "totalDoses": 1,
      "provider": "Community Health Center",
      "notes": "Good for 10 years",
      "color": successColor,
      "icon": Icons.shield,
    },
    {
      "id": "4",
      "name": "HPV Series",
      "nextDue": "2024-08-10",
      "lastReceived": "2024-02-10",
      "status": "Series Incomplete",
      "priority": "High",
      "dosesReceived": 2,
      "totalDoses": 3,
      "provider": "Women's Health Clinic",
      "notes": "Dose 3 of 3 series",
      "color": dangerColor,
      "icon": Icons.vaccines,
    },
    {
      "id": "5",
      "name": "Hepatitis B",
      "nextDue": "2025-01-20",
      "lastReceived": "2024-01-20",
      "status": "Upcoming",
      "priority": "Medium",
      "dosesReceived": 2,
      "totalDoses": 3,
      "provider": "Travel Clinic",
      "notes": "Final dose in series",
      "color": infoColor,
      "icon": Icons.health_and_safety,
    },
    {
      "id": "6",
      "name": "Pneumonia",
      "nextDue": "2029-05-15",
      "lastReceived": "2024-05-15",
      "status": "Up to Date",
      "priority": "Low",
      "dosesReceived": 1,
      "totalDoses": 1,
      "provider": "Primary Care",
      "notes": "One-time adult dose",
      "color": successColor,
      "icon": Icons.air,
    },
  ];

  String selectedFilter = "All";
  bool showNotifications = true;
  bool showAddVaccineForm = false;

  String newVaccineName = "";
  String newVaccineDate = "";
  String newVaccineProvider = "";
  String newVaccineNotes = "";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Due Soon", "value": "Due Soon"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "Up to Date", "value": "Up to Date"},
    {"label": "Series Incomplete", "value": "Series Incomplete"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccine Reminders"),
        actions: [
          IconButton(
            icon: Icon(showNotifications ? Icons.notifications : Icons.notifications_off),
            onPressed: () {
              showNotifications = !showNotifications;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showAddVaccineForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildVaccineOverview(),
            _buildFilterSection(),
            _buildVaccinesList(),
            if (showAddVaccineForm) _buildAddVaccineForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccineOverview() {
    int dueSoon = vaccines.where((v) => v["status"] == "Due Soon").length;
    int upToDate = vaccines.where((v) => v["status"] == "Up to Date").length;
    int incomplete = vaccines.where((v) => v["status"] == "Series Incomplete").length;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.vaccines,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Vaccine Status Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard("Due Soon", dueSoon, dangerColor, Icons.warning),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Up to Date", upToDate, successColor, Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Incomplete", incomplete, warningColor, Icons.pending),
              ),
            ],
          ),
          if (showNotifications)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notification_important,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You have $dueSoon vaccines due soon. Check your reminders!",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            "$count",
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
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QDropdownField(
        label: "Filter by Status",
        items: filterOptions,
        value: selectedFilter,
        onChanged: (value, label) {
          selectedFilter = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildVaccinesList() {
    List<Map<String, dynamic>> filteredVaccines = vaccines.where((vaccine) {
      if (selectedFilter == "All") return true;
      return vaccine["status"] == selectedFilter;
    }).toList();

    // Sort by priority and due date
    filteredVaccines.sort((a, b) {
      Map<String, int> priorityOrder = {"High": 0, "Medium": 1, "Low": 2};
      int priorityComparison = (priorityOrder[a["priority"]] ?? 3)
          .compareTo(priorityOrder[b["priority"]] ?? 3);
      
      if (priorityComparison != 0) return priorityComparison;
      
      return DateTime.parse(a["nextDue"] as String)
          .compareTo(DateTime.parse(b["nextDue"] as String));
    });

    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Showing ${filteredVaccines.length} vaccines",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ...filteredVaccines.map((vaccine) => _buildVaccineCard(vaccine)),
      ],
    );
  }

  Widget _buildVaccineCard(Map<String, dynamic> vaccine) {
    DateTime nextDue = DateTime.parse(vaccine["nextDue"] as String);
    DateTime lastReceived = DateTime.parse(vaccine["lastReceived"] as String);
    int daysUntilDue = nextDue.difference(DateTime.now()).inDays;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: vaccine["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (vaccine["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  vaccine["icon"] as IconData,
                  color: vaccine["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vaccine["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${vaccine["status"]} - ${vaccine["priority"]} Priority",
                      style: TextStyle(
                        fontSize: 12,
                        color: vaccine["color"] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: (vaccine["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  daysUntilDue > 0 ? "${daysUntilDue}d" : "Overdue",
                  style: TextStyle(
                    fontSize: 10,
                    color: vaccine["color"] as Color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Next Due:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            nextDue.dMMMy,
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
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
                            "Last Received:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            lastReceived.dMMMy,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Progress:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${vaccine["dosesReceived"]}/${vaccine["totalDoses"]} doses",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
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
                            "Provider:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${vaccine["provider"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if ((vaccine["notes"] as String).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notes:",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vaccine["notes"]}",
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule",
                  size: bs.sm,
                  onPressed: () => _scheduleVaccine(vaccine),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Mark Received",
                  size: bs.sm,
                  onPressed: () => _markVaccineReceived(vaccine),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddVaccineForm() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Add New Vaccine",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showAddVaccineForm = false;
                  _clearForm();
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Vaccine Name",
            value: newVaccineName,
            hint: "Enter vaccine name",
            onChanged: (value) {
              newVaccineName = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Next Due Date",
            value: newVaccineDate.isNotEmpty ? DateTime.parse(newVaccineDate) : DateTime.now(),
            onChanged: (value) {
              newVaccineDate = value.toIso8601String();
              setState(() {});
            },
          ),
          QTextField(
            label: "Healthcare Provider",
            value: newVaccineProvider,
            hint: "Enter provider name",
            onChanged: (value) {
              newVaccineProvider = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Notes",
            value: newVaccineNotes,
            hint: "Add any additional notes",
            onChanged: (value) {
              newVaccineNotes = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    showAddVaccineForm = false;
                    _clearForm();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Vaccine",
                  size: bs.sm,
                  onPressed: () {
                    if (newVaccineName.isNotEmpty && newVaccineDate.isNotEmpty) {
                      _saveNewVaccine();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    newVaccineName = "";
    newVaccineDate = "";
    newVaccineProvider = "";
    newVaccineNotes = "";
  }

  void _saveNewVaccine() {
    vaccines.add({
      "id": "${vaccines.length + 1}",
      "name": newVaccineName,
      "nextDue": newVaccineDate,
      "lastReceived": DateTime.now().toIso8601String(),
      "status": "Upcoming",
      "priority": "Medium",
      "dosesReceived": 0,
      "totalDoses": 1,
      "provider": newVaccineProvider,
      "notes": newVaccineNotes,
      "color": infoColor,
      "icon": Icons.medical_services,
    });

    showAddVaccineForm = false;
    _clearForm();
    setState(() {});
    ss("Vaccine reminder added successfully");
  }

  void _scheduleVaccine(Map<String, dynamic> vaccine) {
    si("Scheduling appointment for ${vaccine["name"]}");
  }

  void _markVaccineReceived(Map<String, dynamic> vaccine) {
    vaccine["lastReceived"] = DateTime.now().toIso8601String();
    vaccine["dosesReceived"] = (vaccine["dosesReceived"] as int) + 1;
    
    if (vaccine["dosesReceived"] >= vaccine["totalDoses"]) {
      vaccine["status"] = "Up to Date";
      vaccine["color"] = successColor;
    }
    
    setState(() {});
    ss("Vaccine marked as received");
  }
}
