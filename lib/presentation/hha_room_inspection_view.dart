import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomInspectionView extends StatefulWidget {
  const HhaRoomInspectionView({super.key});

  @override
  State<HhaRoomInspectionView> createState() => _HhaRoomInspectionViewState();
}

class _HhaRoomInspectionViewState extends State<HhaRoomInspectionView> {
  int currentTab = 0;
  String selectedFloor = "all";
  String selectedInspector = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> inspections = [
    {
      "roomNumber": "205",
      "floor": 2,
      "type": "Deluxe",
      "status": "pending",
      "inspector": "Sarah Johnson",
      "cleanedBy": "Ana Rodriguez",
      "cleaningCompleted": "2:15 PM",
      "scheduledInspection": "2:30 PM",
      "priority": "high",
      "nextGuest": "4:00 PM",
      "checklist": {
        "bathroom": {"status": "pending", "score": 0},
        "bedroom": {"status": "pending", "score": 0},
        "amenities": {"status": "pending", "score": 0},
        "cleanliness": {"status": "pending", "score": 0},
        "supplies": {"status": "pending", "score": 0},
        "maintenance": {"status": "pending", "score": 0}
      },
      "overallScore": 0,
      "notes": "",
      "issues": []
    },
    {
      "roomNumber": "312",
      "floor": 3,
      "type": "Suite",
      "status": "in_progress",
      "inspector": "Michael Brown",
      "cleanedBy": "Carlos Lopez",
      "cleaningCompleted": "1:45 PM",
      "scheduledInspection": "2:00 PM",
      "priority": "medium",
      "nextGuest": "5:00 PM",
      "checklist": {
        "bathroom": {"status": "passed", "score": 9},
        "bedroom": {"status": "passed", "score": 8},
        "amenities": {"status": "failed", "score": 6},
        "cleanliness": {"status": "passed", "score": 9},
        "supplies": {"status": "pending", "score": 0},
        "maintenance": {"status": "pending", "score": 0}
      },
      "overallScore": 8,
      "notes": "Amenities need restocking",
      "issues": ["Missing coffee pods", "Low toilet paper"]
    },
    {
      "roomNumber": "418",
      "floor": 4,
      "type": "Executive",
      "status": "passed",
      "inspector": "Linda Davis",
      "cleanedBy": "Diana Chen",
      "cleaningCompleted": "1:30 PM",
      "scheduledInspection": "1:45 PM",
      "priority": "low",
      "nextGuest": "6:00 PM",
      "checklist": {
        "bathroom": {"status": "passed", "score": 10},
        "bedroom": {"status": "passed", "score": 9},
        "amenities": {"status": "passed", "score": 9},
        "cleanliness": {"status": "passed", "score": 10},
        "supplies": {"status": "passed", "score": 8},
        "maintenance": {"status": "passed", "score": 9}
      },
      "overallScore": 9,
      "notes": "Excellent work",
      "issues": []
    },
    {
      "roomNumber": "523",
      "floor": 5,
      "type": "Presidential",
      "status": "failed",
      "inspector": "Robert Wilson",
      "cleanedBy": "Elena Volkov",
      "cleaningCompleted": "12:30 PM",
      "scheduledInspection": "1:00 PM",
      "priority": "high",
      "nextGuest": "2:00 PM",
      "checklist": {
        "bathroom": {"status": "passed", "score": 8},
        "bedroom": {"status": "failed", "score": 5},
        "amenities": {"status": "failed", "score": 4},
        "cleanliness": {"status": "passed", "score": 7},
        "supplies": {"status": "failed", "score": 3},
        "maintenance": {"status": "passed", "score": 8}
      },
      "overallScore": 6,
      "notes": "Multiple issues found, requires re-cleaning",
      "issues": ["Dust on furniture", "Incomplete amenities setup", "Low supply levels"]
    }
  ];

  List<Map<String, dynamic>> floorOptions = [
    {"label": "All Floors", "value": "all"},
    {"label": "Floor 1", "value": "1"},
    {"label": "Floor 2", "value": "2"},
    {"label": "Floor 3", "value": "3"},
    {"label": "Floor 4", "value": "4"},
    {"label": "Floor 5", "value": "5"}
  ];

  List<Map<String, dynamic>> inspectorOptions = [
    {"label": "All Inspectors", "value": "all"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Michael Brown", "value": "Michael Brown"},
    {"label": "Linda Davis", "value": "Linda Davis"},
    {"label": "Robert Wilson", "value": "Robert Wilson"}
  ];

  List<Map<String, dynamic>> get filteredInspections {
    return inspections.where((inspection) {
      bool matchesFloor = selectedFloor == "all" || inspection["floor"].toString() == selectedFloor;
      bool matchesInspector = selectedInspector == "all" || inspection["inspector"] == selectedInspector;
      bool matchesSearch = searchQuery.isEmpty || 
          inspection["roomNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (inspection["inspector"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesFloor && matchesInspector && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return warningColor;
      case 'in_progress':
        return infoColor;
      case 'passed':
        return successColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Inspection",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All", icon: Icon(Icons.checklist)),
        Tab(text: "Pending", icon: Icon(Icons.pending)),
        Tab(text: "In Progress", icon: Icon(Icons.hourglass_empty)),
        Tab(text: "Completed", icon: Icon(Icons.check_circle)),
      ],
      tabChildren: [
        _buildAllInspectionsTab(),
        _buildPendingTab(),
        _buildInProgressTab(),
        _buildCompletedTab(),
      ],
    );
  }

  Widget _buildAllInspectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search rooms or inspectors...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          // Filter Options
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Floor",
                  items: floorOptions,
                  value: selectedFloor,
                  onChanged: (value, label) {
                    selectedFloor = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Inspector",
                  items: inspectorOptions,
                  value: selectedInspector,
                  onChanged: (value, label) {
                    selectedInspector = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Inspections",
                "${inspections.length}",
                Icons.checklist,
                primaryColor,
              ),
              _buildSummaryCard(
                "Pending",
                "${inspections.where((i) => i["status"] == "pending").length}",
                Icons.pending,
                warningColor,
              ),
              _buildSummaryCard(
                "Passed",
                "${inspections.where((i) => i["status"] == "passed").length}",
                Icons.check_circle,
                successColor,
              ),
              _buildSummaryCard(
                "Failed",
                "${inspections.where((i) => i["status"] == "failed").length}",
                Icons.cancel,
                dangerColor,
              ),
            ],
          ),

          // Inspection List
          ...filteredInspections.map((inspection) => _buildInspectionCard(inspection)),
        ],
      ),
    );
  }

  Widget _buildPendingTab() {
    List<Map<String, dynamic>> pendingInspections = inspections.where((inspection) => 
        inspection["status"] == "pending"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Pending Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.pending, color: warningColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending Inspections",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${pendingInspections.length} rooms awaiting inspection",
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
          ),

          // Pending Inspections
          ...pendingInspections.map((inspection) => _buildPendingInspectionCard(inspection)),
        ],
      ),
    );
  }

  Widget _buildInProgressTab() {
    List<Map<String, dynamic>> inProgressInspections = inspections.where((inspection) => 
        inspection["status"] == "in_progress"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // In Progress Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.hourglass_empty, color: infoColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "In Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${inProgressInspections.length} rooms being inspected",
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
          ),

          // In Progress Inspections
          ...inProgressInspections.map((inspection) => _buildInProgressInspectionCard(inspection)),
        ],
      ),
    );
  }

  Widget _buildCompletedTab() {
    List<Map<String, dynamic>> completedInspections = inspections.where((inspection) => 
        inspection["status"] == "passed" || inspection["status"] == "failed"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(60)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${inspections.where((i) => i["status"] == "passed").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Passed",
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
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: dangerColor.withAlpha(60)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel, color: dangerColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "${inspections.where((i) => i["status"] == "failed").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Failed",
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

          // Completed Inspections
          ...completedInspections.map((inspection) => _buildCompletedInspectionCard(inspection)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    return Container(
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
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(inspection["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Room ${inspection["roomNumber"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(inspection["status"]),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(inspection["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${inspection["status"]}".toUpperCase().replaceAll("_", " "),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(inspection["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Room Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${inspection["type"]} - Floor ${inspection["floor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Inspector: ${inspection["inspector"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Cleaned by: ${inspection["cleanedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (inspection["overallScore"] > 0)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${inspection["overallScore"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Score",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Time Information
          Row(
            children: [
              Icon(Icons.access_time, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Scheduled: ${inspection["scheduledInspection"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Next guest: ${inspection["nextGuest"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          // Issues
          if (inspection["issues"] != null && (inspection["issues"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Issues Found:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  ...(inspection["issues"] as List).map((issue) => Text(
                    "• $issue",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  )),
                ],
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showInspectionDetails(inspection);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit inspection
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingInspectionCard(Map<String, dynamic> inspection) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.pending, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Room ${inspection["roomNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Spacer(),
              Text(
                "URGENT",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
            ],
          ),

          Text(
            "${inspection["type"]} • Inspector: ${inspection["inspector"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Scheduled: ${inspection["scheduledInspection"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Next guest: ${inspection["nextGuest"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: dangerColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Start Inspection",
                  size: bs.sm,
                  onPressed: () {
                    // Start inspection
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.schedule,
                size: bs.sm,
                onPressed: () {
                  // Reschedule
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInProgressInspectionCard(Map<String, dynamic> inspection) {
    Map<String, dynamic> checklist = inspection["checklist"] as Map<String, dynamic>;
    int completedItems = (checklist.values as Iterable).where((item) => 
        item["status"] != "pending").length;
    int totalItems = (checklist.length as int);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: infoColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.hourglass_empty, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Room ${inspection["roomNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Spacer(),
              Text(
                "IN PROGRESS",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ],
          ),

          Text(
            "${inspection["inspector"]} • ${inspection["type"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Inspection Progress",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$completedItems/$totalItems",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: completedItems / totalItems,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(infoColor),
              ),
            ],
          ),

          // Current Score
          if (inspection["overallScore"] > 0)
            Row(
              children: [
                Text(
                  "Current Score: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${inspection["overallScore"]}/10",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Next guest: ${inspection["nextGuest"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Continue Inspection",
                  size: bs.sm,
                  onPressed: () {
                    _showInspectionDetails(inspection);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.pause,
                size: bs.sm,
                onPressed: () {
                  // Pause inspection
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedInspectionCard(Map<String, dynamic> inspection) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: _getStatusColor(inspection["status"]).withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                inspection["status"] == "passed" ? Icons.check_circle : Icons.cancel,
                color: _getStatusColor(inspection["status"]),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Room ${inspection["roomNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(inspection["status"]),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${inspection["overallScore"]}/10",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
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
                      "${inspection["type"]} - Floor ${inspection["floor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Inspector: ${inspection["inspector"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${inspection["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(inspection["status"]),
                    ),
                  ),
                  Text(
                    "Next guest: ${inspection["nextGuest"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (inspection["notes"] != null && (inspection["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${inspection["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Report",
                  size: bs.sm,
                  onPressed: () {
                    _showInspectionDetails(inspection);
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (inspection["status"] == "failed")
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {
                    // Request re-cleaning
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showInspectionDetails(Map<String, dynamic> inspection) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Room ${inspection["roomNumber"]} Inspection",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: spSm,
                  children: [
                    // Inspection checklist
                    ...(inspection["checklist"] as Map<String, dynamic>).entries.map((entry) {
                      String category = entry.key;
                      Map<String, dynamic> item = entry.value;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item["status"] == "passed"
                                  ? Icons.check_circle
                                  : item["status"] == "failed"
                                      ? Icons.cancel
                                      : Icons.radio_button_unchecked,
                              color: item["status"] == "passed"
                                  ? successColor
                                  : item["status"] == "failed"
                                      ? dangerColor
                                      : disabledColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                category.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (item["score"] > 0)
                              Text(
                                "${item["score"]}/10",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
