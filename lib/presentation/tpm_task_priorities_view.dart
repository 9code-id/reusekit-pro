import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskPrioritiesView extends StatefulWidget {
  const TpmTaskPrioritiesView({super.key});

  @override
  State<TpmTaskPrioritiesView> createState() => _TpmTaskPrioritiesViewState();
}

class _TpmTaskPrioritiesViewState extends State<TpmTaskPrioritiesView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  bool showCreatePriorityForm = false;
  
  // Form fields
  String priorityName = "";
  String priorityColor = "Red";
  String priorityLevel = "High";
  String priorityDescription = "";
  bool isDefault = false;
  bool isActive = true;

  List<Map<String, dynamic>> priorities = [
    {
      "id": "1",
      "name": "Critical",
      "level": "Critical",
      "color": "#FF0000",
      "colorName": "Red",
      "description": "Requires immediate attention and action",
      "taskCount": 12,
      "isDefault": false,
      "isActive": true,
      "createdDate": "2024-12-15",
      "lastUsed": "2024-12-19",
      "usage": {
        "thisWeek": 8,
        "thisMonth": 28,
        "total": 156
      }
    },
    {
      "id": "2",
      "name": "High Priority",
      "level": "High",
      "color": "#FF8C00",
      "colorName": "Orange",
      "description": "Important tasks that should be completed soon",
      "taskCount": 35,
      "isDefault": true,
      "isActive": true,
      "createdDate": "2024-11-20",
      "lastUsed": "2024-12-19",
      "usage": {
        "thisWeek": 15,
        "thisMonth": 42,
        "total": 287
      }
    },
    {
      "id": "3",
      "name": "Medium Priority",
      "level": "Medium",
      "color": "#FFD700",
      "colorName": "Yellow",
      "description": "Standard priority for regular tasks",
      "taskCount": 68,
      "isDefault": false,
      "isActive": true,
      "createdDate": "2024-11-20",
      "lastUsed": "2024-12-19",
      "usage": {
        "thisWeek": 22,
        "thisMonth": 65,
        "total": 445
      }
    },
    {
      "id": "4",
      "name": "Low Priority",
      "level": "Low",
      "color": "#90EE90",
      "colorName": "Green",
      "description": "Tasks that can be completed when time permits",
      "taskCount": 24,
      "isDefault": false,
      "isActive": true,
      "createdDate": "2024-11-20",
      "lastUsed": "2024-12-18",
      "usage": {
        "thisWeek": 5,
        "thisMonth": 18,
        "total": 189
      }
    },
    {
      "id": "5",
      "name": "Planning Phase",
      "level": "Medium",
      "color": "#9370DB",
      "colorName": "Purple",
      "description": "Tasks in planning or research phase",
      "taskCount": 16,
      "isDefault": false,
      "isActive": true,
      "createdDate": "2024-12-01",
      "lastUsed": "2024-12-17",
      "usage": {
        "thisWeek": 3,
        "thisMonth": 12,
        "total": 43
      }
    },
    {
      "id": "6",
      "name": "Archived Priority",
      "level": "Low",
      "color": "#808080",
      "colorName": "Gray",
      "description": "Old priority level no longer in use",
      "taskCount": 0,
      "isDefault": false,
      "isActive": false,
      "createdDate": "2024-10-15",
      "lastUsed": "2024-11-30",
      "usage": {
        "thisWeek": 0,
        "thisMonth": 0,
        "total": 67
      }
    },
  ];

  List<Map<String, dynamic>> colorOptions = [
    {"name": "Red", "value": "#FF0000"},
    {"name": "Orange", "value": "#FF8C00"},
    {"name": "Yellow", "value": "#FFD700"},
    {"name": "Green", "value": "#90EE90"},
    {"name": "Blue", "value": "#4169E1"},
    {"name": "Purple", "value": "#9370DB"},
    {"name": "Pink", "value": "#FF69B4"},
    {"name": "Teal", "value": "#20B2AA"},
    {"name": "Brown", "value": "#8B4513"},
    {"name": "Gray", "value": "#808080"},
  ];

  List<Map<String, dynamic>> levelOptions = [
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Priorities", "value": "All"},
    {"label": "Active Only", "value": "Active"},
    {"label": "Inactive Only", "value": "Inactive"},
    {"label": "Default Priorities", "value": "Default"},
    {"label": "Recently Used", "value": "Recent"},
    {"label": "Most Used", "value": "Popular"},
  ];

  List<Map<String, dynamic>> get filteredPriorities {
    var filtered = priorities.where((priority) {
      bool matchesSearch = searchQuery.isEmpty ||
          (priority["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (priority["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Active" && priority["isActive"] == true) ||
          (selectedFilter == "Inactive" && priority["isActive"] == false) ||
          (selectedFilter == "Default" && priority["isDefault"] == true) ||
          (selectedFilter == "Recent" && 
           DateTime.parse("${priority["lastUsed"]}").isAfter(DateTime.now().subtract(Duration(days: 7)))) ||
          (selectedFilter == "Popular" && 
           (priority["usage"]["thisMonth"] as int) > 30);

      return matchesSearch && matchesFilter;
    }).toList();

    filtered.sort((a, b) {
      if (selectedFilter == "Popular") {
        return (b["usage"]["total"] as int).compareTo(a["usage"]["total"] as int);
      } else if (selectedFilter == "Recent") {
        return DateTime.parse("${b["lastUsed"]}").compareTo(DateTime.parse("${a["lastUsed"]}"));
      } else {
        List<String> levelOrder = ["Critical", "High", "Medium", "Low"];
        int aIndex = levelOrder.indexOf("${a["level"]}");
        int bIndex = levelOrder.indexOf("${b["level"]}");
        if (aIndex != bIndex) {
          return aIndex.compareTo(bIndex);
        }
        return (a["name"] as String).compareTo(b["name"] as String);
      }
    });

    return filtered;
  }

  void _resetForm() {
    priorityName = "";
    priorityColor = "Red";
    priorityLevel = "High";
    priorityDescription = "";
    isDefault = false;
    isActive = true;
    setState(() {});
  }

  void _savePriority() {
    if (priorityName.isEmpty) {
      se("Priority name is required");
      return;
    }

    Map<String, dynamic> colorData = colorOptions.firstWhere(
      (color) => color["name"] == priorityColor,
      orElse: () => colorOptions[0],
    );

    Map<String, dynamic> newPriority = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": priorityName,
      "level": priorityLevel,
      "color": colorData["value"],
      "colorName": priorityColor,
      "description": priorityDescription,
      "taskCount": 0,
      "isDefault": isDefault,
      "isActive": isActive,
      "createdDate": DateTime.now().toString().split(' ')[0],
      "lastUsed": DateTime.now().toString().split(' ')[0],
      "usage": {
        "thisWeek": 0,
        "thisMonth": 0,
        "total": 0
      }
    };

    priorities.insert(0, newPriority);
    _resetForm();
    showCreatePriorityForm = false;
    setState(() {});
    ss("Priority created successfully");
  }

  void _togglePriorityStatus(String priorityId) {
    int index = priorities.indexWhere((p) => p["id"] == priorityId);
    if (index != -1) {
      priorities[index]["isActive"] = !priorities[index]["isActive"];
      setState(() {});
      String status = priorities[index]["isActive"] ? "activated" : "deactivated";
      ss("Priority ${status} successfully");
    }
  }

  void _setAsDefault(String priorityId) {
    for (var priority in priorities) {
      priority["isDefault"] = priority["id"] == priorityId;
    }
    setState(() {});
    ss("Default priority updated");
  }

  void _deletePriority(String priorityId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this priority? This action cannot be undone.");
    if (isConfirmed) {
      priorities.removeWhere((p) => p["id"] == priorityId);
      setState(() {});
      ss("Priority deleted successfully");
    }
  }

  Widget _buildPriorityCard(Map<String, dynamic> priority) {
    Color priorityColor = Color(int.parse((priority["color"] as String).replaceFirst('#', '0xFF')));
    bool isActive = priority["isActive"] == true;
    bool isDefault = priority["isDefault"] == true;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isDefault ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: priorityColor.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: priorityColor, width: 2),
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
                            "${priority["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: isActive ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          if (isDefault) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "DEFAULT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                          if (!isActive) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "INACTIVE",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Level: ${priority["level"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildPriorityActions(priority),
                    );
                  },
                ),
              ],
            ),
          ),
          if ((priority["description"] as String).isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Text(
                "${priority["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
            SizedBox(height: spSm),
          ],
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Tasks",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${priority["taskCount"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                        "This Month",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${priority["usage"]["thisMonth"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                        "Total Usage",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${priority["usage"]["total"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityActions(Map<String, dynamic> priority) {
    bool isActive = priority["isActive"] == true;
    bool isDefault = priority["isDefault"] == true;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Priority Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ListTile(
            leading: Icon(Icons.edit, color: primaryColor),
            title: Text("Edit Priority"),
            onTap: () {
              back();
              // Edit functionality would go here
              si("Edit functionality coming soon");
            },
          ),
          if (!isDefault)
            ListTile(
              leading: Icon(Icons.star, color: warningColor),
              title: Text("Set as Default"),
              onTap: () {
                back();
                _setAsDefault("${priority["id"]}");
              },
            ),
          ListTile(
            leading: Icon(
              isActive ? Icons.visibility_off : Icons.visibility,
              color: isActive ? warningColor : successColor,
            ),
            title: Text(isActive ? "Deactivate" : "Activate"),
            onTap: () {
              back();
              _togglePriorityStatus("${priority["id"]}");
            },
          ),
          if ((priority["taskCount"] as int) == 0)
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Priority"),
              onTap: () {
                back();
                _deletePriority("${priority["id"]}");
              },
            ),
          SizedBox(height: spSm),
        ],
      ),
    );
  }

  Widget _buildCreatePriorityForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Create New Priority",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  showCreatePriorityForm = false;
                  _resetForm();
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Priority Name",
            value: priorityName,
            hint: "Enter priority name",
            onChanged: (value) {
              priorityName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority Level",
                  items: levelOptions,
                  value: priorityLevel,
                  onChanged: (value, label) {
                    priorityLevel = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Color",
                  items: colorOptions.map((color) => {
                    "label": "${color["name"]}",
                    "value": "${color["name"]}",
                  }).toList(),
                  value: priorityColor,
                  onChanged: (value, label) {
                    priorityColor = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Description",
            value: priorityDescription,
            hint: "Describe when this priority should be used",
            onChanged: (value) {
              priorityDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Set as Default",
                      "value": true,
                      "checked": isDefault,
                    }
                  ],
                  value: [if (isDefault) {"label": "Set as Default", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isDefault = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Active",
                      "value": true,
                      "checked": isActive,
                    }
                  ],
                  value: [if (isActive) {"label": "Active", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isActive = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Priority",
              size: bs.md,
              onPressed: _savePriority,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityList() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search priorities",
                      value: searchQuery,
                      hint: "Search by name or description",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {
                      showCreatePriorityForm = true;
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Filter Priorities",
                items: filterOptions,
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        if (showCreatePriorityForm) ...[
          _buildCreatePriorityForm(),
          SizedBox(height: spMd),
        ],
        if (filteredPriorities.isEmpty)
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.priority_high,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No priorities found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  searchQuery.isNotEmpty
                      ? "Try adjusting your search criteria"
                      : "Create your first priority to get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredPriorities.map((priority) => _buildPriorityCard(priority)),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    int totalPriorities = priorities.length;
    int activePriorities = priorities.where((p) => p["isActive"] == true).length;
    int totalTasks = priorities.fold(0, (sum, p) => sum + (p["taskCount"] as int));
    double avgTasksPerPriority = totalPriorities > 0 ? totalTasks / totalPriorities : 0;

    List<Map<String, dynamic>> topPriorities = List.from(priorities);
    topPriorities.sort((a, b) => (b["usage"]["total"] as int).compareTo(a["usage"]["total"] as int));
    topPriorities = topPriorities.take(5).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Priority Analytics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
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
                        Icon(Icons.priority_high, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Total Priorities",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalPriorities",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "$activePriorities active",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                        Icon(Icons.task_alt, color: successColor),
                        SizedBox(width: spSm),
                        Text(
                          "Total Tasks",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalTasks",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "${avgTasksPerPriority.toStringAsFixed(1)} avg per priority",
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
          SizedBox(height: spMd),
          Container(
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
                  "Most Used Priorities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...topPriorities.map((priority) {
                  Color priorityColor = Color(int.parse((priority["color"] as String).replaceFirst('#', '0xFF')));
                  double usagePercentage = totalTasks > 0 ? ((priority["usage"]["total"] as int) / totalTasks * 100) : 0;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: priorityColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${priority["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${priority["usage"]["total"]} uses (${usagePercentage.toStringAsFixed(1)}%)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${priority["taskCount"]} tasks",
                          style: TextStyle(
                            fontSize: 14,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Task Priorities",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Priorities", icon: Icon(Icons.priority_high)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPriorityList(),
        ),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
