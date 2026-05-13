import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaInspectionScheduleView extends StatefulWidget {
  const RmaInspectionScheduleView({super.key});

  @override
  State<RmaInspectionScheduleView> createState() => _RmaInspectionScheduleViewState();
}

class _RmaInspectionScheduleViewState extends State<RmaInspectionScheduleView> {
  String selectedFilter = "All";
  String selectedMonth = "November";
  String searchQuery = "";
  int selectedCalendarDay = 15;
  int currentTab = 0;

  List<Map<String, dynamic>> inspections = [
    {
      "id": "INS-001",
      "property": "Modern Downtown Condo",
      "address": "123 Main Street, Downtown",
      "type": "General Inspection",
      "date": "2024-11-15",
      "time": "10:00 AM",
      "duration": 180,
      "status": "Scheduled",
      "inspector": "Mike Johnson",
      "inspectorPhone": "+1 (555) 123-4567",
      "client": "John Anderson",
      "clientPhone": "+1 (555) 987-6543",
      "cost": 450,
      "propertyImage": "https://picsum.photos/100/80?random=1&keyword=condo",
      "priority": "High",
      "notes": "First-time buyer, comprehensive inspection needed",
      "checklist": ["Electrical", "Plumbing", "HVAC", "Structural", "Roofing"]
    },
    {
      "id": "INS-002",
      "property": "Luxury Family Home",
      "address": "456 Oak Avenue, Suburbs",
      "type": "Termite Inspection",
      "date": "2024-11-16",
      "time": "2:00 PM",
      "duration": 120,
      "status": "Confirmed",
      "inspector": "Sarah Davis",
      "inspectorPhone": "+1 (555) 234-5678",
      "client": "Maria Garcia",
      "clientPhone": "+1 (555) 876-5432",
      "cost": 275,
      "propertyImage": "https://picsum.photos/100/80?random=2&keyword=house",
      "priority": "Medium",
      "notes": "Focus on basement and foundation areas",
      "checklist": ["Foundation", "Basement", "Crawl Space", "Attic", "Wood Structures"]
    },
    {
      "id": "INS-003",
      "property": "Charming Townhouse",
      "address": "789 Pine Street, Midtown",
      "type": "Pre-Purchase Inspection",
      "date": "2024-11-17",
      "time": "9:00 AM",
      "duration": 240,
      "status": "In Progress",
      "inspector": "Robert Kim",
      "inspectorPhone": "+1 (555) 345-6789",
      "client": "Lisa Thompson",
      "clientPhone": "+1 (555) 765-4321",
      "cost": 550,
      "propertyImage": "https://picsum.photos/100/80?random=3&keyword=townhouse",
      "priority": "High",
      "notes": "Cash buyer, detailed inspection required",
      "checklist": ["Full Property Assessment", "Electrical", "Plumbing", "HVAC", "Structural", "Exterior"]
    },
    {
      "id": "INS-004",
      "property": "Waterfront Villa",
      "address": "321 Beach Road, Waterfront",
      "type": "Specialty Inspection",
      "date": "2024-11-18",
      "time": "11:00 AM",
      "duration": 300,
      "status": "Completed",
      "inspector": "Emily Wilson",
      "inspectorPhone": "+1 (555) 456-7890",
      "client": "David Parker",
      "clientPhone": "+1 (555) 654-3210",
      "cost": 750,
      "propertyImage": "https://picsum.photos/100/80?random=4&keyword=villa",
      "priority": "Medium",
      "notes": "Luxury property with special features",
      "checklist": ["Pool/Spa", "Dock/Waterfront", "Security Systems", "Smart Home", "High-End Appliances"]
    },
    {
      "id": "INS-005",
      "property": "Urban Loft Space",
      "address": "654 Industrial Way, Arts District",
      "type": "Electrical Inspection",
      "date": "2024-11-19",
      "time": "1:00 PM",
      "duration": 90,
      "status": "Cancelled",
      "inspector": "James Rodriguez",
      "inspectorPhone": "+1 (555) 567-8901",
      "client": "Jennifer Clark",
      "clientPhone": "+1 (555) 543-2109",
      "cost": 200,
      "propertyImage": "https://picsum.photos/100/80?random=5&keyword=loft",
      "priority": "Low",
      "notes": "Client rescheduled due to emergency",
      "checklist": ["Electrical Panel", "Wiring", "Outlets", "Fixtures", "Code Compliance"]
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"}
  ];

  List<Map<String, dynamic>> monthOptions = [
    {"label": "October", "value": "October"},
    {"label": "November", "value": "November"},
    {"label": "December", "value": "December"}
  ];

  List<Map<String, dynamic>> get filteredInspections {
    return inspections.where((inspection) {
      bool matchesFilter = selectedFilter == "All" || inspection["status"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          inspection["property"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          inspection["client"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          inspection["inspector"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "Confirmed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String getInspectionTypeIcon(String type) {
    switch (type) {
      case "General Inspection":
        return "🏠";
      case "Termite Inspection":
        return "🐛";
      case "Pre-Purchase Inspection":
        return "📋";
      case "Specialty Inspection":
        return "⭐";
      case "Electrical Inspection":
        return "⚡";
      default:
        return "🔍";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspection Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Open calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Schedule new inspection
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search inspections...",
                          value: searchQuery,
                          hint: "Property, client, or inspector",
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
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Month",
                          items: monthOptions,
                          value: selectedMonth,
                          onChanged: (value, label) {
                            selectedMonth = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Calendar Preview
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Text(
                        "November 2024",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_left, size: 20),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: List.generate(30, (index) {
                      int day = index + 1;
                      bool hasInspection = [15, 16, 17, 18, 19].contains(day);
                      bool isSelected = day == selectedCalendarDay;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedCalendarDay = day;
                          setState(() {});
                        },
                        child: Container(
                          width: 60,
                          height: 80,
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : (hasInspection ? infoColor.withAlpha(30) : Colors.grey.withAlpha(20)),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: hasInspection ? Border.all(color: infoColor, width: 1) : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$day",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : primaryColor,
                                ),
                              ),
                              if (hasInspection) ...[
                                SizedBox(height: 4),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : infoColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  "📋",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredInspections.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
                          textAlign: TextAlign.center,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${inspections.where((i) => i["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          textAlign: TextAlign.center,
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${inspections.where((i) => i["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          textAlign: TextAlign.center,
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

            // Today's Inspections
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "November 15, 2024",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: inspections.where((inspection) => inspection["date"] == "2024-11-15").map((inspection) {
                      return Container(
                        width: 300,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(inspection["status"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${inspection["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  getInspectionTypeIcon(inspection["type"]),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Text(
                              "${inspection["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${inspection["property"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Text(
                                  "${inspection["time"]} (${inspection["duration"]}min)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.person, size: 16, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Text(
                                  "Inspector: ${inspection["inspector"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 16, color: successColor),
                                SizedBox(width: 4),
                                Text(
                                  "\$${((inspection["cost"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
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

            // Inspector Performance
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inspector Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: [
                      "Mike Johnson",
                      "Sarah Davis", 
                      "Robert Kim",
                      "Emily Wilson",
                      "James Rodriguez"
                    ].map((inspector) {
                      int inspectionCount = inspections.where((i) => i["inspector"] == inspector).length;
                      int completedCount = inspections.where((i) => i["inspector"] == inspector && i["status"] == "Completed").length;
                      double completionRate = inspectionCount > 0 ? (completedCount / inspectionCount) * 100 : 0;
                      
                      return Container(
                        width: 180,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: primaryColor,
                                  child: Text(
                                    inspector.split(" ").map((n) => n[0]).join(""),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        inspector,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${completionRate.toStringAsFixed(0)}% completion",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total: $inspectionCount",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Done: $completedCount",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
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

            // All Inspections List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Text(
                        "All Inspections",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredInspections.length} inspections",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredInspections.map((inspection) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Property Image
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${inspection["propertyImage"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(150),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          getInspectionTypeIcon(inspection["type"]),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              
                              // Inspection Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(inspection["status"]),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${inspection["status"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: getPriorityColor(inspection["priority"]),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${inspection["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${inspection["property"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${inspection["address"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Inspection Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.access_time, size: 16, color: primaryColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${inspection["date"]} • ${inspection["time"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timer, size: 16, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "${inspection["duration"]} min",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                                          SizedBox(width: 4),
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
                                    Row(
                                      children: [
                                        Icon(Icons.attach_money, size: 16, color: successColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "\$${((inspection["cost"] as int).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Client: ${inspection["client"]}",
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
                          
                          // Inspection Checklist
                          if ((inspection["checklist"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Inspection Areas:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: 4,
                                    children: (inspection["checklist"] as List).map((item) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: infoColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$item",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          if (inspection["notes"] != null && inspection["notes"].isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${inspection["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.call,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.location_on,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
