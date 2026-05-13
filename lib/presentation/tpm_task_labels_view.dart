import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskLabelsView extends StatefulWidget {
  const TpmTaskLabelsView({super.key});

  @override
  State<TpmTaskLabelsView> createState() => _TpmTaskLabelsViewState();
}

class _TpmTaskLabelsViewState extends State<TpmTaskLabelsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedCategory = "All";
  bool showCreateLabelForm = false;
  
  // Form fields
  String labelName = "";
  String labelColor = "Blue";
  String labelCategory = "General";
  String labelDescription = "";
  bool isVisible = true;

  List<Map<String, dynamic>> labels = [
    {
      "id": "1",
      "name": "Frontend",
      "color": "#2196F3",
      "colorName": "Blue",
      "category": "Technology",
      "description": "Frontend development tasks and UI work",
      "taskCount": 28,
      "isVisible": true,
      "createdDate": "2024-11-15",
      "lastUsed": "2024-12-19",
      "usage": {
        "thisWeek": 12,
        "thisMonth": 35,
        "total": 156
      }
    },
    {
      "id": "2",
      "name": "Backend",
      "color": "#4CAF50",
      "colorName": "Green",
      "category": "Technology",
      "description": "Backend development, APIs, and server-side work",
      "taskCount": 34,
      "isVisible": true,
      "createdDate": "2024-11-15",
      "lastUsed": "2024-12-19",
      "usage": {
        "thisWeek": 15,
        "thisMonth": 42,
        "total": 203
      }
    },
    {
      "id": "3",
      "name": "Bug Fix",
      "color": "#F44336",
      "colorName": "Red",
      "category": "Issue",
      "description": "Bug fixes and error corrections",
      "taskCount": 19,
      "isVisible": true,
      "createdDate": "2024-11-10",
      "lastUsed": "2024-12-18",
      "usage": {
        "thisWeek": 8,
        "thisMonth": 23,
        "total": 187
      }
    },
    {
      "id": "4",
      "name": "Enhancement",
      "color": "#FF9800",
      "colorName": "Orange",
      "category": "Feature",
      "description": "Feature enhancements and improvements",
      "taskCount": 22,
      "isVisible": true,
      "createdDate": "2024-11-20",
      "lastUsed": "2024-12-17",
      "usage": {
        "thisWeek": 6,
        "thisMonth": 18,
        "total": 134
      }
    },
    {
      "id": "5",
      "name": "Documentation",
      "color": "#9C27B0",
      "colorName": "Purple",
      "category": "General",
      "description": "Documentation and knowledge base tasks",
      "taskCount": 11,
      "isVisible": true,
      "createdDate": "2024-12-01",
      "lastUsed": "2024-12-16",
      "usage": {
        "thisWeek": 3,
        "thisMonth": 9,
        "total": 67
      }
    },
    {
      "id": "6",
      "name": "Testing",
      "color": "#607D8B",
      "colorName": "Blue Gray",
      "category": "Quality",
      "description": "Testing, QA, and quality assurance tasks",
      "taskCount": 16,
      "isVisible": true,
      "createdDate": "2024-11-25",
      "lastUsed": "2024-12-15",
      "usage": {
        "thisWeek": 4,
        "thisMonth": 12,
        "total": 89
      }
    },
    {
      "id": "7",
      "name": "Research",
      "color": "#00BCD4",
      "colorName": "Cyan",
      "category": "Planning",
      "description": "Research and investigation tasks",
      "taskCount": 8,
      "isVisible": true,
      "createdDate": "2024-12-05",
      "lastUsed": "2024-12-14",
      "usage": {
        "thisWeek": 2,
        "thisMonth": 6,
        "total": 34
      }
    },
    {
      "id": "8",
      "name": "Meeting",
      "color": "#FFC107",
      "colorName": "Yellow",
      "category": "Communication",
      "description": "Meetings, discussions, and collaborative tasks",
      "taskCount": 13,
      "isVisible": true,
      "createdDate": "2024-11-30",
      "lastUsed": "2024-12-19",
      "usage": {
        "thisWeek": 7,
        "thisMonth": 21,
        "total": 98
      }
    },
    {
      "id": "9",
      "name": "Design",
      "color": "#E91E63",
      "colorName": "Pink",
      "category": "Creative",
      "description": "Design and creative work",
      "taskCount": 15,
      "isVisible": true,
      "createdDate": "2024-11-18",
      "lastUsed": "2024-12-13",
      "usage": {
        "thisWeek": 3,
        "thisMonth": 11,
        "total": 76
      }
    },
    {
      "id": "10",
      "name": "Archived Label",
      "color": "#9E9E9E",
      "colorName": "Gray",
      "category": "General",
      "description": "Old label no longer in active use",
      "taskCount": 0,
      "isVisible": false,
      "createdDate": "2024-10-15",
      "lastUsed": "2024-11-30",
      "usage": {
        "thisWeek": 0,
        "thisMonth": 0,
        "total": 45
      }
    },
  ];

  List<Map<String, dynamic>> colorOptions = [
    {"name": "Blue", "value": "#2196F3"},
    {"name": "Green", "value": "#4CAF50"},
    {"name": "Red", "value": "#F44336"},
    {"name": "Orange", "value": "#FF9800"},
    {"name": "Purple", "value": "#9C27B0"},
    {"name": "Cyan", "value": "#00BCD4"},
    {"name": "Pink", "value": "#E91E63"},
    {"name": "Yellow", "value": "#FFC107"},
    {"name": "Blue Gray", "value": "#607D8B"},
    {"name": "Teal", "value": "#009688"},
    {"name": "Deep Orange", "value": "#FF5722"},
    {"name": "Indigo", "value": "#3F51B5"},
    {"name": "Brown", "value": "#795548"},
    {"name": "Gray", "value": "#9E9E9E"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "General", "value": "General"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Feature", "value": "Feature"},
    {"label": "Issue", "value": "Issue"},
    {"label": "Quality", "value": "Quality"},
    {"label": "Planning", "value": "Planning"},
    {"label": "Communication", "value": "Communication"},
    {"label": "Creative", "value": "Creative"},
    {"label": "Management", "value": "Management"},
    {"label": "Marketing", "value": "Marketing"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Labels", "value": "All"},
    {"label": "Visible Only", "value": "Visible"},
    {"label": "Hidden Only", "value": "Hidden"},
    {"label": "Recently Used", "value": "Recent"},
    {"label": "Most Used", "value": "Popular"},
    {"label": "With Tasks", "value": "WithTasks"},
  ];

  List<Map<String, dynamic>> get categoryFilterOptions {
    Set<String> uniqueCategories = labels.map((label) => label["category"] as String).toSet();
    List<Map<String, dynamic>> options = [{"label": "All Categories", "value": "All"}];
    for (String category in uniqueCategories) {
      options.add({"label": category, "value": category});
    }
    return options;
  }

  List<Map<String, dynamic>> get filteredLabels {
    var filtered = labels.where((label) {
      bool matchesSearch = searchQuery.isEmpty ||
          (label["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (label["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (label["category"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Visible" && label["isVisible"] == true) ||
          (selectedFilter == "Hidden" && label["isVisible"] == false) ||
          (selectedFilter == "Recent" && 
           DateTime.parse("${label["lastUsed"]}").isAfter(DateTime.now().subtract(Duration(days: 7)))) ||
          (selectedFilter == "Popular" && 
           (label["usage"]["thisMonth"] as int) > 15) ||
          (selectedFilter == "WithTasks" && (label["taskCount"] as int) > 0);

      bool matchesCategory = selectedCategory == "All" || label["category"] == selectedCategory;

      return matchesSearch && matchesFilter && matchesCategory;
    }).toList();

    filtered.sort((a, b) {
      if (selectedFilter == "Popular") {
        return (b["usage"]["total"] as int).compareTo(a["usage"]["total"] as int);
      } else if (selectedFilter == "Recent") {
        return DateTime.parse("${b["lastUsed"]}").compareTo(DateTime.parse("${a["lastUsed"]}"));
      } else {
        return (a["name"] as String).compareTo(b["name"] as String);
      }
    });

    return filtered;
  }

  void _resetForm() {
    labelName = "";
    labelColor = "Blue";
    labelCategory = "General";
    labelDescription = "";
    isVisible = true;
    setState(() {});
  }

  void _saveLabel() {
    if (labelName.isEmpty) {
      se("Label name is required");
      return;
    }

    Map<String, dynamic> colorData = colorOptions.firstWhere(
      (color) => color["name"] == labelColor,
      orElse: () => colorOptions[0],
    );

    Map<String, dynamic> newLabel = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": labelName,
      "color": colorData["value"],
      "colorName": labelColor,
      "category": labelCategory,
      "description": labelDescription,
      "taskCount": 0,
      "isVisible": isVisible,
      "createdDate": DateTime.now().toString().split(' ')[0],
      "lastUsed": DateTime.now().toString().split(' ')[0],
      "usage": {
        "thisWeek": 0,
        "thisMonth": 0,
        "total": 0
      }
    };

    labels.insert(0, newLabel);
    _resetForm();
    showCreateLabelForm = false;
    setState(() {});
    ss("Label created successfully");
  }

  void _toggleLabelVisibility(String labelId) {
    int index = labels.indexWhere((l) => l["id"] == labelId);
    if (index != -1) {
      labels[index]["isVisible"] = !labels[index]["isVisible"];
      setState(() {});
      String status = labels[index]["isVisible"] ? "shown" : "hidden";
      ss("Label ${status} successfully");
    }
  }

  void _deleteLabel(String labelId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this label? This action cannot be undone.");
    if (isConfirmed) {
      labels.removeWhere((l) => l["id"] == labelId);
      setState(() {});
      ss("Label deleted successfully");
    }
  }

  Widget _buildLabelCard(Map<String, dynamic> label) {
    Color labelColor = Color(int.parse((label["color"] as String).replaceFirst('#', '0xFF')));
    bool isVisible = label["isVisible"] == true;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: !isVisible ? Border.all(color: disabledColor, width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: labelColor.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: labelColor, width: 1),
                  ),
                  child: Text(
                    "${label["name"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: labelColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${label["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!isVisible) ...[
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "HIDDEN",
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
                ),
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildLabelActions(label),
                    );
                  },
                ),
              ],
            ),
          ),
          if ((label["description"] as String).isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Text(
                "${label["description"]}",
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
                        "${label["taskCount"]}",
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
                        "${label["usage"]["thisMonth"]}",
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
                        "${label["usage"]["total"]}",
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

  Widget _buildLabelActions(Map<String, dynamic> label) {
    bool isVisible = label["isVisible"] == true;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Label Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ListTile(
            leading: Icon(Icons.edit, color: primaryColor),
            title: Text("Edit Label"),
            onTap: () {
              back();
              si("Edit functionality coming soon");
            },
          ),
          ListTile(
            leading: Icon(
              isVisible ? Icons.visibility_off : Icons.visibility,
              color: isVisible ? warningColor : successColor,
            ),
            title: Text(isVisible ? "Hide Label" : "Show Label"),
            onTap: () {
              back();
              _toggleLabelVisibility("${label["id"]}");
            },
          ),
          if ((label["taskCount"] as int) == 0)
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Label"),
              onTap: () {
                back();
                _deleteLabel("${label["id"]}");
              },
            ),
          SizedBox(height: spSm),
        ],
      ),
    );
  }

  Widget _buildCreateLabelForm() {
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
                "Create New Label",
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
                  showCreateLabelForm = false;
                  _resetForm();
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Label Name",
            value: labelName,
            hint: "Enter label name",
            onChanged: (value) {
              labelName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: labelCategory,
                  onChanged: (value, label) {
                    labelCategory = value;
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
                  value: labelColor,
                  onChanged: (value, label) {
                    labelColor = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Description",
            value: labelDescription,
            hint: "Describe the purpose of this label",
            onChanged: (value) {
              labelDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Visible to users",
                "value": true,
                "checked": isVisible,
              }
            ],
            value: [if (isVisible) {"label": "Visible to users", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isVisible = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Label",
              size: bs.md,
              onPressed: _saveLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelList() {
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
                      label: "Search labels",
                      value: searchQuery,
                      hint: "Search by name, category, or description",
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
                      showCreateLabelForm = true;
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter Labels",
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
                      label: "Category",
                      items: categoryFilterOptions,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        if (showCreateLabelForm) ...[
          _buildCreateLabelForm(),
          SizedBox(height: spMd),
        ],
        if (filteredLabels.isEmpty)
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
                  Icons.label,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No labels found",
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
                      : "Create your first label to get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredLabels.map((label) => _buildLabelCard(label)),
      ],
    );
  }

  Widget _buildCategoriesTab() {
    Map<String, List<Map<String, dynamic>>> groupedLabels = {};
    for (var label in labels.where((l) => l["isVisible"] == true)) {
      String category = "${label["category"]}";
      if (!groupedLabels.containsKey(category)) {
        groupedLabels[category] = [];
      }
      groupedLabels[category]!.add(label);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Labels by Category",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...groupedLabels.entries.map((entry) {
            String category = entry.key;
            List<Map<String, dynamic>> categoryLabels = entry.value;
            int totalTasks = categoryLabels.fold(0, (sum, label) => sum + (label["taskCount"] as int));

            return Container(
              margin: EdgeInsets.only(bottom: spMd),
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
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${categoryLabels.length} labels • $totalTasks tasks",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: categoryLabels.map((label) {
                      Color labelColor = Color(int.parse((label["color"] as String).replaceFirst('#', '0xFF')));
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: labelColor.withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: labelColor, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${label["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: labelColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                              ),
                            ),
                            if ((label["taskCount"] as int) > 0) ...[
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: labelColor.computeLuminance() > 0.5 ? Colors.black26 : Colors.white30,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${label["taskCount"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: labelColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    int totalLabels = labels.length;
    int visibleLabels = labels.where((l) => l["isVisible"] == true).length;
    int totalTasks = labels.fold(0, (sum, l) => sum + (l["taskCount"] as int));
    double avgTasksPerLabel = totalLabels > 0 ? totalTasks / totalLabels : 0;

    List<Map<String, dynamic>> topLabels = List.from(labels);
    topLabels.sort((a, b) => (b["usage"]["total"] as int).compareTo(a["usage"]["total"] as int));
    topLabels = topLabels.take(5).toList();

    Map<String, int> categoryStats = {};
    for (var label in labels.where((l) => l["isVisible"] == true)) {
      String category = "${label["category"]}";
      categoryStats[category] = (categoryStats[category] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Label Analytics",
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
                        Icon(Icons.label, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Total Labels",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalLabels",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "$visibleLabels visible",
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
                          "Tagged Tasks",
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
                      "${avgTasksPerLabel.toStringAsFixed(1)} avg per label",
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
                  "Most Used Labels",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...topLabels.map((label) {
                  Color labelColor = Color(int.parse((label["color"] as String).replaceFirst('#', '0xFF')));
                  double usagePercentage = totalTasks > 0 ? ((label["usage"]["total"] as int) / totalTasks * 100) : 0;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: labelColor.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: labelColor, width: 1),
                          ),
                          child: Text(
                            "${label["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: labelColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${label["usage"]["total"]} uses (${usagePercentage.toStringAsFixed(1)}%)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${label["taskCount"]} tasks",
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
                  "Category Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...categoryStats.entries.map((entry) {
                  String category = entry.key;
                  int count = entry.value;
                  double percentage = visibleLabels > 0 ? (count / visibleLabels * 100) : 0;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$count labels (${percentage.toStringAsFixed(0)}%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
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
      title: "Task Labels",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Labels", icon: Icon(Icons.label)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildLabelList(),
        ),
        _buildCategoriesTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
