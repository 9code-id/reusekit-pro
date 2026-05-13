import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTravelChecklistView extends StatefulWidget {
  const TtaTravelChecklistView({super.key});

  @override
  State<TtaTravelChecklistView> createState() => _TtaTravelChecklistViewState();
}

class _TtaTravelChecklistViewState extends State<TtaTravelChecklistView> {
  int currentTab = 0;
  String newItemTitle = "";

  List<Map<String, dynamic>> checklists = [
    {
      "id": 1,
      "title": "Before Travel",
      "description": "Essential preparations before departure",
      "icon": Icons.event_note,
      "color": primaryColor,
      "items": [
        {"id": 1, "title": "Check passport validity (6+ months)", "completed": true, "category": "Documents"},
        {"id": 2, "title": "Apply for visa if required", "completed": true, "category": "Documents"},
        {"id": 3, "title": "Book accommodation", "completed": true, "category": "Booking"},
        {"id": 4, "title": "Purchase travel insurance", "completed": false, "category": "Insurance"},
        {"id": 5, "title": "Notify bank of travel plans", "completed": false, "category": "Financial"},
        {"id": 6, "title": "Check vaccination requirements", "completed": false, "category": "Health"},
        {"id": 7, "title": "Research local customs and laws", "completed": false, "category": "Research"},
        {"id": 8, "title": "Download offline maps", "completed": false, "category": "Technology"},
        {"id": 9, "title": "Backup important documents", "completed": false, "category": "Documents"},
        {"id": 10, "title": "Arrange airport transportation", "completed": false, "category": "Transportation"},
      ],
    },
    {
      "id": 2,
      "title": "Packing",
      "description": "What to pack for your trip",
      "icon": Icons.luggage,
      "color": secondaryColor,
      "items": [
        {"id": 11, "title": "Passport and travel documents", "completed": true, "category": "Documents"},
        {"id": 12, "title": "Flight tickets and boarding passes", "completed": true, "category": "Documents"},
        {"id": 13, "title": "Travel insurance documents", "completed": false, "category": "Documents"},
        {"id": 14, "title": "Emergency contact information", "completed": false, "category": "Safety"},
        {"id": 15, "title": "Clothing appropriate for weather", "completed": false, "category": "Clothing"},
        {"id": 16, "title": "Comfortable walking shoes", "completed": false, "category": "Clothing"},
        {"id": 17, "title": "Phone charger and adapters", "completed": false, "category": "Electronics"},
        {"id": 18, "title": "Medications and prescriptions", "completed": false, "category": "Health"},
        {"id": 19, "title": "Toiletries and personal care", "completed": false, "category": "Personal"},
        {"id": 20, "title": "Camera and extra batteries", "completed": false, "category": "Electronics"},
      ],
    },
    {
      "id": 3,
      "title": "At Destination",
      "description": "Things to do upon arrival",
      "icon": Icons.location_on,
      "color": successColor,
      "items": [
        {"id": 21, "title": "Check into accommodation", "completed": false, "category": "Accommodation"},
        {"id": 22, "title": "Register with local authorities if required", "completed": false, "category": "Legal"},
        {"id": 23, "title": "Get local SIM card or enable roaming", "completed": false, "category": "Communication"},
        {"id": 24, "title": "Exchange currency or find ATM", "completed": false, "category": "Financial"},
        {"id": 25, "title": "Locate nearest hospital/clinic", "completed": false, "category": "Safety"},
        {"id": 26, "title": "Download local transportation apps", "completed": false, "category": "Transportation"},
        {"id": 27, "title": "Find embassy/consulate location", "completed": false, "category": "Safety"},
        {"id": 28, "title": "Learn basic local phrases", "completed": false, "category": "Communication"},
      ],
    },
    {
      "id": 4,
      "title": "Before Return",
      "description": "Preparations before heading home",
      "icon": Icons.flight_takeoff,
      "color": warningColor,
      "items": [
        {"id": 29, "title": "Confirm return flight details", "completed": false, "category": "Travel"},
        {"id": 30, "title": "Check baggage restrictions", "completed": false, "category": "Travel"},
        {"id": 31, "title": "Pack souvenirs appropriately", "completed": false, "category": "Packing"},
        {"id": 32, "title": "Settle accommodation bills", "completed": false, "category": "Financial"},
        {"id": 33, "title": "Return rental items", "completed": false, "category": "Returns"},
        {"id": 34, "title": "Check customs regulations", "completed": false, "category": "Legal"},
        {"id": 35, "title": "Backup photos and memories", "completed": false, "category": "Personal"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentItems = checklists[currentTab]["items"];
    int completedCount = currentItems.where((item) => item["completed"] == true).length;
    double progress = completedCount / currentItems.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Checklist"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddItemDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(
                  children: List.generate(checklists.length, (index) {
                    bool isSelected = currentTab == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          currentTab = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? checklists[index]["color"] : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? checklists[index]["color"] : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                checklists[index]["icon"],
                                color: isSelected ? Colors.white : checklists[index]["color"],
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${checklists[index]["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: spMd),
                Container(
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
                          Icon(
                            checklists[currentTab]["icon"],
                            color: checklists[currentTab]["color"],
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${checklists[currentTab]["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${checklists[currentTab]["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${completedCount}/${currentItems.length}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: checklists[currentTab]["color"],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(checklists[currentTab]["color"]),
                          minHeight: 6,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(progress * 100).toInt()}% completed",
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
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Tasks",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Mark All Complete",
                        size: bs.sm,
                        onPressed: () {
                          _markAllComplete();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: _buildGroupedItems(currentItems),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog();
        },
        backgroundColor: checklists[currentTab]["color"],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  List<Widget> _buildGroupedItems(List<Map<String, dynamic>> items) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};
    
    for (var item in items) {
      String category = item["category"] ?? "Other";
      if (!groupedItems.containsKey(category)) {
        groupedItems[category] = [];
      }
      groupedItems[category]!.add(item);
    }

    List<Widget> widgets = [];
    
    groupedItems.forEach((category, categoryItems) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(bottom: spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: checklists[currentTab]["color"].withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: checklists[currentTab]["color"],
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Column(
                children: categoryItems.map((item) {
                  return _buildChecklistItem(item);
                }).toList(),
              ),
            ],
          ),
        ),
      );
    });

    return widgets;
  }

  Widget _buildChecklistItem(Map<String, dynamic> item) {
    bool isCompleted = item["completed"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isCompleted ? successColor : disabledOutlineBorderColor,
        ),
        boxShadow: isCompleted ? [] : [shadowXs],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              item["completed"] = !item["completed"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isCompleted ? successColor : disabledColor,
                size: 24,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: spSm),
              child: Text(
                "${item["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isCompleted ? disabledBoldColor : Colors.black87,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: disabledBoldColor,
              size: 20,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 16),
                    SizedBox(width: spSm),
                    Text("Edit"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 16, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Delete", style: TextStyle(color: dangerColor)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                _showEditItemDialog(item);
              } else if (value == 'delete') {
                _deleteItem(item);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog() {
    newItemTitle = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Task Title",
              value: newItemTitle,
              hint: "Enter task description",
              onChanged: (value) {
                newItemTitle = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Task",
            size: bs.sm,
            onPressed: () {
              if (newItemTitle.isNotEmpty) {
                _addNewItem(newItemTitle);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditItemDialog(Map<String, dynamic> item) {
    String editTitle = item["title"];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Task Title",
              value: editTitle,
              hint: "Enter task description",
              onChanged: (value) {
                editTitle = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              if (editTitle.isNotEmpty) {
                item["title"] = editTitle;
                setState(() {});
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _addNewItem(String title) {
    List<Map<String, dynamic>> currentItems = checklists[currentTab]["items"];
    int newId = currentItems.isNotEmpty 
        ? currentItems.map((item) => item["id"] as int).reduce((a, b) => a > b ? a : b) + 1
        : 1;
    
    currentItems.add({
      "id": newId,
      "title": title,
      "completed": false,
      "category": "Custom",
    });
    
    setState(() {});
    ss("Task added successfully");
  }

  void _deleteItem(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this task?");
    if (isConfirmed) {
      List<Map<String, dynamic>> currentItems = checklists[currentTab]["items"];
      currentItems.removeWhere((i) => i["id"] == item["id"]);
      setState(() {});
      ss("Task deleted successfully");
    }
  }

  void _markAllComplete() {
    List<Map<String, dynamic>> currentItems = checklists[currentTab]["items"];
    for (var item in currentItems) {
      item["completed"] = true;
    }
    setState(() {});
    ss("All tasks marked as complete");
  }
}
