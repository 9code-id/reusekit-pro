import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDriverSchedulingView extends StatefulWidget {
  const LtaDriverSchedulingView({super.key});

  @override
  State<LtaDriverSchedulingView> createState() => _LtaDriverSchedulingViewState();
}

class _LtaDriverSchedulingViewState extends State<LtaDriverSchedulingView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedDriver = "";
  String selectedShift = "";
  String selectedVehicle = "";
  String selectedDate = DateTime.now().toString();
  String notes = "";

  List<Map<String, dynamic>> drivers = [
    {
      "id": "D001",
      "name": "John Williams",
      "license": "CDL-A",
      "status": "Available",
      "rating": 4.8,
      "totalTrips": 156,
      "phone": "+1 234 567 8901",
      "experience": "5 years"
    },
    {
      "id": "D002", 
      "name": "Sarah Johnson",
      "license": "CDL-B",
      "status": "On Trip",
      "rating": 4.9,
      "totalTrips": 203,
      "phone": "+1 234 567 8902",
      "experience": "7 years"
    },
    {
      "id": "D003",
      "name": "Mike Chen",
      "license": "CDL-A",
      "status": "Off Duty",
      "rating": 4.7,
      "totalTrips": 134,
      "phone": "+1 234 567 8903",
      "experience": "3 years"
    },
    {
      "id": "D004",
      "name": "Emily Davis",
      "license": "CDL-B",
      "status": "Available",
      "rating": 4.6,
      "totalTrips": 89,
      "phone": "+1 234 567 8904",
      "experience": "2 years"
    }
  ];

  List<Map<String, dynamic>> schedules = [
    {
      "id": "S001",
      "driverId": "D001",
      "driverName": "John Williams",
      "shift": "Morning",
      "date": "2024-12-16",
      "startTime": "06:00",
      "endTime": "14:00",
      "vehicle": "Truck-001",
      "route": "City Center Route",
      "status": "Scheduled"
    },
    {
      "id": "S002",
      "driverId": "D002",
      "driverName": "Sarah Johnson",
      "shift": "Afternoon",
      "date": "2024-12-16",
      "startTime": "14:00",
      "endTime": "22:00",
      "vehicle": "Truck-002",
      "route": "Industrial Route",
      "status": "Active"
    },
    {
      "id": "S003",
      "driverId": "D003",
      "driverName": "Mike Chen",
      "shift": "Night",
      "date": "2024-12-16",
      "startTime": "22:00",
      "endTime": "06:00",
      "vehicle": "Truck-003",
      "route": "Highway Route",
      "status": "Rest"
    }
  ];

  List<Map<String, dynamic>> shiftOptions = [
    {"label": "Morning Shift (06:00-14:00)", "value": "morning"},
    {"label": "Afternoon Shift (14:00-22:00)", "value": "afternoon"},
    {"label": "Night Shift (22:00-06:00)", "value": "night"}
  ];

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "Truck-001 (Available)", "value": "truck001"},
    {"label": "Truck-002 (Maintenance)", "value": "truck002"},
    {"label": "Truck-003 (Available)", "value": "truck003"},
    {"label": "Van-001 (Available)", "value": "van001"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Driver Scheduling",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Drivers", icon: Icon(Icons.person)),
        Tab(text: "Assign", icon: Icon(Icons.assignment))
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildDriversTab(),
        _buildAssignTab()
      ],
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildScheduleHeader(),
          _buildScheduleList()
        ],
      ),
    );
  }

  Widget _buildScheduleHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm]
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor
                )
              ),
              Spacer(),
              Text(
                "December 16, 2024",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor
                )
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildScheduleStats("Active", "2", successColor)
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildScheduleStats("Scheduled", "5", primaryColor)
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildScheduleStats("Rest", "3", warningColor)
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildScheduleStats(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40))
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color
            )
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor
            )
          )
        ],
      ),
    );
  }

  Widget _buildScheduleList() {
    return Column(
      spacing: spSm,
      children: schedules.map((schedule) {
        Color statusColor = schedule["status"] == "Active" ? successColor :
                          schedule["status"] == "Scheduled" ? primaryColor :
                          warningColor;

        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(width: 4, color: statusColor)
            )
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      "${schedule["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor
                      )
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${schedule["shift"]} Shift",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor
                    )
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person, size: 20, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${schedule["driverName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Icon(Icons.local_shipping, size: 20, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${schedule["vehicle"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time, size: 18, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${schedule["startTime"]} - ${schedule["endTime"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  ),
                  Spacer(),
                  Icon(Icons.route, size: 18, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${schedule["route"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit Schedule",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDriversTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDriverSearch(),
          _buildDriverList()
        ],
      ),
    );
  }

  Widget _buildDriverSearch() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search drivers...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.filter_list,
          size: bs.sm,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildDriverList() {
    return Column(
      spacing: spSm,
      children: drivers.map((driver) {
        Color statusColor = driver["status"] == "Available" ? successColor :
                          driver["status"] == "On Trip" ? primaryColor :
                          warningColor;

        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm]
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Text(
                      "${driver["name"]}".split(" ").map((n) => n[0]).join(""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                      )
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${driver["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "ID: ${driver["id"]} • License: ${driver["license"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor
                          )
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm)
                    ),
                    child: Text(
                      "${driver["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor
                      )
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "${driver["rating"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  SizedBox(width: spMd),
                  Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${driver["totalTrips"]} trips",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  ),
                  Spacer(),
                  Text(
                    "${driver["experience"]} exp",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${driver["phone"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor
                    )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Schedule",
                      size: bs.sm,
                      onPressed: () {
                        selectedTabIndex = 2;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "View Profile",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAssignTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm]
        ),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create New Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor
              )
            ),
            QDropdownField(
              label: "Select Driver",
              items: drivers.map((driver) => {
                "label": "${driver["name"]} (${driver["id"]})",
                "value": driver["id"]
              }).toList(),
              value: selectedDriver,
              onChanged: (value, label) {
                selectedDriver = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Select Shift",
              items: shiftOptions,
              value: selectedShift,
              onChanged: (value, label) {
                selectedShift = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Assign Vehicle",
              items: vehicleOptions,
              value: selectedVehicle,
              onChanged: (value, label) {
                selectedVehicle = value;
                setState(() {});
              },
            ),
            QDatePicker(
              label: "Schedule Date",
              value: DateTime.parse(selectedDate),
              onChanged: (value) {
                selectedDate = value.toString();
                setState(() {});
              },
            ),
            QMemoField(
              label: "Notes",
              value: notes,
              hint: "Additional notes or special instructions...",
              onChanged: (value) {
                notes = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () {
                      selectedDriver = "";
                      selectedShift = "";
                      selectedVehicle = "";
                      notes = "";
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Create Schedule",
                    size: bs.md,
                    onPressed: () {
                      ss("Schedule created successfully");
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
