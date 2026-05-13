import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaVehicleInspectionView extends StatefulWidget {
  const LtaVehicleInspectionView({super.key});

  @override
  State<LtaVehicleInspectionView> createState() => _LtaVehicleInspectionViewState();
}

class _LtaVehicleInspectionViewState extends State<LtaVehicleInspectionView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedVehicleType = "All";
  String selectedInspectionType = "All";
  
  List<Map<String, dynamic>> inspections = [
    {
      "id": "INS-2024-001",
      "vehicleId": "TXI-001",
      "vehiclePlate": "ABC-1234",
      "vehicleType": "Sedan",
      "vehicleModel": "Toyota Camry 2023",
      "inspectionType": "Safety",
      "scheduledDate": "2024-12-20",
      "scheduledTime": "09:00",
      "status": "Scheduled",
      "inspector": "John Mitchell - LTA Inspector",
      "location": "LTA Inspection Center - Downtown",
      "estimatedDuration": "45 minutes",
      "lastInspection": "2024-06-20",
      "nextDueDate": "2025-06-20",
      "mileage": 45000,
      "ownerName": "Premium Transport Co.",
      "driverName": "Michael Johnson",
      "checklistItems": [
        {"item": "Brake System", "status": "Pending", "notes": ""},
        {"item": "Lights & Signals", "status": "Pending", "notes": ""},
        {"item": "Steering System", "status": "Pending", "notes": ""},
        {"item": "Suspension", "status": "Pending", "notes": ""},
        {"item": "Exhaust System", "status": "Pending", "notes": ""},
        {"item": "Tires & Wheels", "status": "Pending", "notes": ""},
        {"item": "Interior Safety", "status": "Pending", "notes": ""},
        {"item": "Documentation", "status": "Pending", "notes": ""},
      ],
      "priority": "Medium",
    },
    {
      "id": "INS-2024-002",
      "vehicleId": "TXI-002",
      "vehiclePlate": "XYZ-5678",
      "vehicleType": "SUV",
      "vehicleModel": "Honda Pilot 2024",
      "inspectionType": "Annual",
      "scheduledDate": "2024-12-18",
      "scheduledTime": "11:30",
      "status": "In Progress",
      "inspector": "Sarah Davis - LTA Inspector",
      "location": "LTA Inspection Center - Uptown",
      "estimatedDuration": "60 minutes",
      "lastInspection": "2023-12-18",
      "nextDueDate": "2025-12-18",
      "mileage": 32000,
      "ownerName": "City Cab Services",
      "driverName": "Robert Wilson",
      "checklistItems": [
        {"item": "Brake System", "status": "Passed", "notes": "Good condition"},
        {"item": "Lights & Signals", "status": "Passed", "notes": "All functional"},
        {"item": "Steering System", "status": "In Progress", "notes": "Currently testing"},
        {"item": "Suspension", "status": "Pending", "notes": ""},
        {"item": "Exhaust System", "status": "Pending", "notes": ""},
        {"item": "Tires & Wheels", "status": "Passed", "notes": "Tread depth OK"},
        {"item": "Interior Safety", "status": "Pending", "notes": ""},
        {"item": "Documentation", "status": "Passed", "notes": "All documents valid"},
      ],
      "priority": "High",
    },
    {
      "id": "INS-2024-003",
      "vehicleId": "TXI-003",
      "vehiclePlate": "DEF-9012",
      "vehicleType": "Van",
      "vehicleModel": "Ford Transit 2022",
      "inspectionType": "Random",
      "scheduledDate": "2024-12-15",
      "scheduledTime": "14:00",
      "status": "Completed",
      "inspector": "David Chen - LTA Inspector",
      "location": "LTA Mobile Inspection Unit",
      "estimatedDuration": "30 minutes",
      "lastInspection": "2024-06-15",
      "nextDueDate": "2025-06-15",
      "mileage": 58000,
      "ownerName": "Express Logistics",
      "driverName": "Jennifer Martinez",
      "checklistItems": [
        {"item": "Brake System", "status": "Passed", "notes": "Excellent condition"},
        {"item": "Lights & Signals", "status": "Passed", "notes": "All working properly"},
        {"item": "Steering System", "status": "Passed", "notes": "Responsive and smooth"},
        {"item": "Suspension", "status": "Passed", "notes": "No issues found"},
        {"item": "Exhaust System", "status": "Passed", "notes": "Emissions within limits"},
        {"item": "Tires & Wheels", "status": "Passed", "notes": "Good tread depth"},
        {"item": "Interior Safety", "status": "Passed", "notes": "Safety equipment present"},
        {"item": "Documentation", "status": "Passed", "notes": "All certificates valid"},
      ],
      "priority": "Low",
    },
    {
      "id": "INS-2024-004",
      "vehicleId": "TXI-004",
      "vehiclePlate": "GHI-3456",
      "vehicleType": "Compact",
      "vehicleModel": "Nissan Versa 2023",
      "inspectionType": "Safety",
      "scheduledDate": "2024-12-12",
      "scheduledTime": "10:15",
      "status": "Failed",
      "inspector": "Maria Garcia - LTA Inspector",
      "location": "LTA Inspection Center - Westside",
      "estimatedDuration": "45 minutes",
      "lastInspection": "2024-06-12",
      "nextDueDate": "2024-12-30",
      "mileage": 67000,
      "ownerName": "Budget Rides",
      "driverName": "Amanda Thompson",
      "checklistItems": [
        {"item": "Brake System", "status": "Failed", "notes": "Brake pads worn, need replacement"},
        {"item": "Lights & Signals", "status": "Passed", "notes": "All functional"},
        {"item": "Steering System", "status": "Passed", "notes": "Good condition"},
        {"item": "Suspension", "status": "Failed", "notes": "Front shock absorbers need replacement"},
        {"item": "Exhaust System", "status": "Passed", "notes": "Within emission limits"},
        {"item": "Tires & Wheels", "status": "Warning", "notes": "Front tires showing uneven wear"},
        {"item": "Interior Safety", "status": "Passed", "notes": "Safety equipment OK"},
        {"item": "Documentation", "status": "Passed", "notes": "Valid documents"},
      ],
      "priority": "High",
    },
    {
      "id": "INS-2024-005",
      "vehicleId": "TXI-005",
      "vehiclePlate": "JKL-7890",
      "vehicleType": "Luxury",
      "vehicleModel": "BMW 5 Series 2024",
      "inspectionType": "Pre-Service",
      "scheduledDate": "2024-12-22",
      "scheduledTime": "15:30",
      "status": "Scheduled",
      "inspector": "Robert Lee - LTA Inspector",
      "location": "LTA Premium Inspection Center",
      "estimatedDuration": "90 minutes",
      "lastInspection": "New Vehicle",
      "nextDueDate": "2025-12-22",
      "mileage": 1200,
      "ownerName": "Elite Transport Services",
      "driverName": "Christopher Davis",
      "checklistItems": [
        {"item": "Brake System", "status": "Pending", "notes": ""},
        {"item": "Lights & Signals", "status": "Pending", "notes": ""},
        {"item": "Steering System", "status": "Pending", "notes": ""},
        {"item": "Suspension", "status": "Pending", "notes": ""},
        {"item": "Exhaust System", "status": "Pending", "notes": ""},
        {"item": "Tires & Wheels", "status": "Pending", "notes": ""},
        {"item": "Interior Safety", "status": "Pending", "notes": ""},
        {"item": "Documentation", "status": "Pending", "notes": ""},
        {"item": "Luxury Features", "status": "Pending", "notes": ""},
        {"item": "Technology Systems", "status": "Pending", "notes": ""},
      ],
      "priority": "Medium",
    },
  ];

  List<Map<String, dynamic>> upcomingInspections = [
    {
      "date": "2024-12-19",
      "count": 3,
      "vehicles": ["ABC-1234", "XYZ-5678", "DEF-9012"],
    },
    {
      "date": "2024-12-20",
      "count": 2,
      "vehicles": ["GHI-3456", "JKL-7890"],
    },
    {
      "date": "2024-12-21",
      "count": 1,
      "vehicles": ["MNO-1122"],
    },
  ];

  List<String> statusOptions = ["All", "Scheduled", "In Progress", "Completed", "Failed"];
  List<String> vehicleTypeOptions = ["All", "Sedan", "SUV", "Van", "Compact", "Luxury"];
  List<String> inspectionTypeOptions = ["All", "Safety", "Annual", "Random", "Pre-Service"];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Vehicle Inspection",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Inspections", icon: Icon(Icons.assignment)),
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        // Inspections Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Status Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [infoColor.withAlpha(25), infoColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: infoColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${inspections.where((insp) => insp["status"] == "Scheduled").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Scheduled",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Upcoming Inspections",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor.withAlpha(25), warningColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.build,
                                color: warningColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${inspections.where((insp) => insp["status"] == "In Progress").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Active Inspections",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [successColor.withAlpha(25), successColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${inspections.where((insp) => insp["status"] == "Completed").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "This Month",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [dangerColor.withAlpha(25), dangerColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: dangerColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${inspections.where((insp) => insp["status"] == "Failed").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Failed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Requires Action",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions.map((status) => {
                        "label": status,
                        "value": status,
                      }).toList(),
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Vehicle Type",
                      items: vehicleTypeOptions.map((type) => {
                        "label": type,
                        "value": type,
                      }).toList(),
                      value: selectedVehicleType,
                      onChanged: (value, label) {
                        selectedVehicleType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QDropdownField(
                label: "Inspection Type",
                items: inspectionTypeOptions.map((type) => {
                  "label": type,
                  "value": type,
                }).toList(),
                value: selectedInspectionType,
                onChanged: (value, label) {
                  selectedInspectionType = value;
                  setState(() {});
                },
              ),

              // Inspections List
              Column(
                children: inspections
                    .where((inspection) {
                      if (selectedStatus != "All" && inspection["status"] != selectedStatus) return false;
                      if (selectedVehicleType != "All" && inspection["vehicleType"] != selectedVehicleType) return false;
                      if (selectedInspectionType != "All" && inspection["inspectionType"] != selectedInspectionType) return false;
                      return true;
                    })
                    .map((inspection) {
                  Color statusColor = inspection["status"] == "Scheduled" ? infoColor :
                                     inspection["status"] == "In Progress" ? warningColor :
                                     inspection["status"] == "Completed" ? successColor : dangerColor;

                  Color priorityColor = inspection["priority"] == "High" ? dangerColor :
                                        inspection["priority"] == "Medium" ? warningColor : successColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${inspection["id"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: priorityColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${inspection["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${inspection["vehiclePlate"]} - ${inspection["vehicleModel"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${inspection["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Inspection Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.category,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${inspection["inspectionType"]} Inspection",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.access_time,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${inspection["estimatedDuration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${inspection["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Inspector Info
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${inspection["inspector"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        // Schedule Info
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${inspection["scheduledDate"]} at ${inspection["scheduledTime"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        // Vehicle Details
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.speed,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${inspection["mileage"]} km",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${inspection["ownerName"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Checklist Progress
                        if (inspection["status"] == "In Progress" || inspection["status"] == "Completed" || inspection["status"] == "Failed")
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Inspection Checklist:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (inspection["checklistItems"] as List).map((item) {
                                    Color itemColor = item["status"] == "Passed" ? successColor :
                                                     item["status"] == "Failed" ? dangerColor :
                                                     item["status"] == "Warning" ? warningColor :
                                                     item["status"] == "In Progress" ? infoColor : disabledColor;

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: itemColor.withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${item["item"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: itemColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            if (inspection["status"] == "Scheduled")
                              QButton(
                                label: "Start Inspection",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            if (inspection["status"] == "Failed")
                              QButton(
                                label: "Reschedule",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Schedule Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Upcoming Inspections",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: upcomingInspections.map((schedule) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: infoColor,
                          width: 4,
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
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateTime.parse(schedule["date"]).day}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "DEC",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${schedule["date"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${schedule["count"]} inspections scheduled",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: "View Schedule",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicles:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                (schedule["vehicles"] as List).join(", "),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Schedule New Inspection",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Reports Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Inspection Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              // Pass Rate
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Overall Pass Rate",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Passed (80%)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Failed (20%)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Common Issues
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Common Failure Reasons",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Brake System Issues",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "35%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: 0.35,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(dangerColor),
                        ),
                        SizedBox(height: spSm),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Tire Condition",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "25%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: 0.25,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                        ),
                        SizedBox(height: spSm),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Lighting & Signals",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "20%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: 0.20,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Export Reports
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Export Reports",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Monthly Report",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Yearly Report",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Custom Report",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
