import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaReworkManagementView extends StatefulWidget {
  const ComaReworkManagementView({super.key});

  @override
  State<ComaReworkManagementView> createState() => _ComaReworkManagementViewState();
}

class _ComaReworkManagementViewState extends State<ComaReworkManagementView> {
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  String selectedCategory = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> reworkItems = [
    {
      "id": "RW001",
      "title": "Electrical Panel Installation Revision",
      "description": "Panel mounting height does not meet code requirements. Needs to be lowered by 6 inches.",
      "category": "Electrical",
      "priority": "High",
      "status": "In Progress",
      "originalTask": "Install Main Electrical Panel",
      "issueDate": "2024-01-15",
      "dueDate": "2024-01-22",
      "estimatedHours": 8,
      "actualHours": 5,
      "assignedCrew": "Electrical Team A",
      "supervisor": "Mike Johnson",
      "originalCost": 2500.0,
      "reworkCost": 800.0,
      "reason": "Code Violation",
      "rootCause": "Incorrect specification interpretation",
      "preventiveMeasures": "Enhanced specification review process",
      "images": ["https://picsum.photos/300/200?random=201&keyword=electrical"],
      "notes": "Working with inspector to ensure compliance"
    },
    {
      "id": "RW002", 
      "title": "Drywall Texture Matching",
      "description": "New drywall texture doesn't match existing wall finish in adjacent areas.",
      "category": "Finishing",
      "priority": "Medium",
      "status": "Pending",
      "originalTask": "Drywall Installation - Conference Room",
      "issueDate": "2024-01-16",
      "dueDate": "2024-01-25",
      "estimatedHours": 12,
      "actualHours": 0,
      "assignedCrew": "Drywall Crew B",
      "supervisor": "Sarah Davis",
      "originalCost": 1800.0,
      "reworkCost": 450.0,
      "reason": "Quality Issue",
      "rootCause": "Inadequate sample matching",
      "preventiveMeasures": "Mandatory texture samples approval",
      "images": ["https://picsum.photos/300/200?random=202&keyword=wall"],
      "notes": "Client requested better texture matching"
    },
    {
      "id": "RW003",
      "title": "HVAC Duct Rerouting",
      "description": "Ductwork conflicts with structural beam. Requires complete rerouting of main supply line.",
      "category": "HVAC",
      "priority": "Critical",
      "status": "Planning",
      "originalTask": "HVAC Ductwork Installation",
      "issueDate": "2024-01-17",
      "dueDate": "2024-01-30",
      "estimatedHours": 24,
      "actualHours": 0,
      "assignedCrew": "HVAC Team A",
      "supervisor": "Tom Wilson",
      "originalCost": 3200.0,
      "reworkCost": 1200.0,
      "reason": "Design Conflict",
      "rootCause": "Incomplete coordination drawings",
      "preventiveMeasures": "Enhanced 3D modeling review",
      "images": ["https://picsum.photos/300/200?random=203&keyword=hvac"],
      "notes": "Coordinating with structural engineer"
    },
    {
      "id": "RW004",
      "title": "Tile Pattern Correction",
      "description": "Bathroom tile pattern installed incorrectly. Client wants herringbone pattern, not straight lay.",
      "category": "Tile Work",
      "priority": "Medium",
      "status": "Completed",
      "originalTask": "Master Bathroom Tile Installation",
      "issueDate": "2024-01-10",
      "dueDate": "2024-01-20",
      "estimatedHours": 16,
      "actualHours": 18,
      "assignedCrew": "Tile Crew A",
      "supervisor": "Carlos Rodriguez",
      "originalCost": 2200.0,
      "reworkCost": 950.0,
      "reason": "Client Change",
      "rootCause": "Miscommunication of design intent",
      "preventiveMeasures": "Detailed tile layout drawings",
      "images": ["https://picsum.photos/300/200?random=204&keyword=tile"],
      "notes": "Work completed to client satisfaction"
    },
    {
      "id": "RW005",
      "title": "Concrete Slab Leveling",
      "description": "Foundation slab has uneven areas exceeding tolerance. Requires grinding and leveling compound.",
      "category": "Concrete",
      "priority": "High",
      "status": "In Progress",
      "originalTask": "Foundation Slab Pour",
      "issueDate": "2024-01-12",
      "dueDate": "2024-01-28",
      "estimatedHours": 20,
      "actualHours": 12,
      "assignedCrew": "Concrete Team B",
      "supervisor": "David Kim",
      "originalCost": 4500.0,
      "reworkCost": 1100.0,
      "reason": "Quality Issue",
      "rootCause": "Inadequate concrete finishing",
      "preventiveMeasures": "Enhanced quality control checks",
      "images": ["https://picsum.photos/300/200?random=205&keyword=concrete"],
      "notes": "60% complete, on schedule"
    },
    {
      "id": "RW006",
      "title": "Window Frame Alignment",
      "description": "Kitchen windows are not properly aligned. Gaps visible and affecting weatherproofing.",
      "category": "Windows",
      "priority": "High",
      "status": "Assigned",
      "originalTask": "Window Installation - Kitchen",
      "issueDate": "2024-01-18",
      "dueDate": "2024-01-26",
      "estimatedHours": 10,
      "actualHours": 0,
      "assignedCrew": "Window Installation Team",
      "supervisor": "Lisa Chen",
      "originalCost": 1600.0,
      "reworkCost": 400.0,
      "reason": "Installation Error",
      "rootCause": "Improper rough opening preparation",
      "preventiveMeasures": "Pre-installation measurements verification",
      "images": ["https://picsum.photos/300/200?random=206&keyword=window"],
      "notes": "Crew assigned, materials ordered"
    }
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Planning", "value": "Planning"},
    {"label": "Assigned", "value": "Assigned"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Completed", "value": "Completed"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "HVAC", "value": "HVAC"},
    {"label": "Plumbing", "value": "Plumbing"},
    {"label": "Concrete", "value": "Concrete"},
    {"label": "Finishing", "value": "Finishing"},
    {"label": "Tile Work", "value": "Tile Work"},
    {"label": "Windows", "value": "Windows"},
  ];

  List<Map<String, dynamic>> get filteredReworkItems {
    return reworkItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "All" || item["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      
      return matchesSearch && matchesPriority && matchesStatus && matchesCategory;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Planning": return disabledColor;
      case "Assigned": return infoColor;
      case "In Progress": return warningColor;
      case "Pending": return secondaryColor;
      case "Completed": return successColor;
      default: return disabledColor;
    }
  }

  Widget _buildOverviewCards() {
    int totalItems = reworkItems.length;
    int inProgress = reworkItems.where((item) => item["status"] == "In Progress").length;
    int completed = reworkItems.where((item) => item["status"] == "Completed").length;
    double totalReworkCost = reworkItems.fold(0.0, (sum, item) => sum + (item["reworkCost"] as double));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
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
                      children: [
                        Icon(Icons.build_circle, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Rework Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalItems",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work_history, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$inProgress",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: Container(
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
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$completed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Rework Cost",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${totalReworkCost.currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReworkCard(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${item["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${item["status"]}"),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${item["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["priority"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor("${item["priority"]}"),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${item["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${item["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${item["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${item["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${item["assignedCrew"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Due: ${item["dueDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "\$${(item["reworkCost"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (item["actualHours"] > 0) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Text(
                  "Progress: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: (item["actualHours"] as int) / (item["estimatedHours"] as int),
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      (item["actualHours"] as int) / (item["estimatedHours"] as int) > 1 
                        ? dangerColor 
                        : primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${item["actualHours"]}/${item["estimatedHours"]}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
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
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.photo_camera,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReworkList() {
    List<Map<String, dynamic>> filtered = filteredReworkItems;
    
    if (filtered.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No rework items found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filtered.map((item) => _buildReworkCard(item)).toList(),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCards(),
          SizedBox(height: spLg),
          Text(
            "Recent Rework Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: reworkItems.take(3).map((item) => _buildReworkCard(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildManageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search rework items...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityItems,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
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
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          _buildReworkList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rework Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Manage", icon: Icon(Icons.build_circle)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildManageTab(),
      ],
    );
  }
}
