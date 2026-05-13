import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPrepListView extends StatefulWidget {
  const RfsPrepListView({super.key});

  @override
  State<RfsPrepListView> createState() => _RfsPrepListViewState();
}

class _RfsPrepListViewState extends State<RfsPrepListView> {
  String selectedDate = "Today";
  String selectedStation = "All";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> dateOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Tomorrow", "value": "Tomorrow"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Next Week", "value": "Next Week"},
  ];

  List<Map<String, dynamic>> stationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Cold Prep", "value": "Cold Prep"},
    {"label": "Hot Prep", "value": "Hot Prep"},
    {"label": "Bakery", "value": "Bakery"},
    {"label": "Butcher", "value": "Butcher"},
    {"label": "Pantry", "value": "Pantry"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> prepItems = [
    {
      "id": "PREP001",
      "item": "Caesar Dressing",
      "category": "Sauce",
      "station": "Cold Prep",
      "quantity": "2 liters",
      "priority": "High",
      "status": "Pending",
      "estimatedTime": 30,
      "assignedTo": "Prep Cook Davis",
      "dueDate": "2024-06-19 16:00:00",
      "startTime": "",
      "completionTime": "",
      "ingredients": [
        "6 egg yolks",
        "12 anchovy fillets",
        "4 garlic cloves",
        "1/2 cup lemon juice",
        "1 cup olive oil",
        "1/2 cup parmesan cheese"
      ],
      "instructions": [
        "Blend egg yolks, anchovies, and garlic",
        "Slowly add lemon juice while blending",
        "Drizzle olive oil slowly to emulsify",
        "Fold in grated parmesan cheese",
        "Season to taste and refrigerate"
      ],
      "notes": "Make extra batch for weekend rush",
      "allergens": ["Eggs", "Fish", "Dairy"],
      "shelfLife": "3 days refrigerated",
      "portionYield": 40,
    },
    {
      "id": "PREP002",
      "item": "Bread Rolls",
      "category": "Baked Goods",
      "station": "Bakery",
      "quantity": "50 pieces",
      "priority": "Critical",
      "status": "In Progress",
      "estimatedTime": 180,
      "assignedTo": "Baker Johnson",
      "dueDate": "2024-06-19 15:30:00",
      "startTime": "2024-06-19 13:00:00",
      "completionTime": "",
      "ingredients": [
        "2 kg bread flour",
        "20g salt",
        "15g yeast",
        "30ml olive oil",
        "1.2L warm water"
      ],
      "instructions": [
        "Mix flour, salt, and yeast in large bowl",
        "Add water and olive oil, mix until dough forms",
        "Knead for 10 minutes until smooth",
        "First rise: 1 hour in covered bowl",
        "Shape into rolls, second rise: 45 minutes",
        "Bake at 220°C for 15-18 minutes"
      ],
      "notes": "Double batch for dinner service",
      "allergens": ["Gluten"],
      "shelfLife": "2 days at room temperature",
      "portionYield": 50,
    },
    {
      "id": "PREP003",
      "item": "Chicken Stock",
      "category": "Base",
      "station": "Hot Prep",
      "quantity": "10 liters",
      "priority": "Normal",
      "status": "Completed",
      "estimatedTime": 240,
      "assignedTo": "Line Cook Williams",
      "dueDate": "2024-06-19 14:00:00",
      "startTime": "2024-06-19 10:00:00",
      "completionTime": "2024-06-19 14:00:00",
      "ingredients": [
        "3 kg chicken bones",
        "2 onions",
        "3 carrots",
        "3 celery stalks",
        "Bay leaves",
        "Peppercorns",
        "Fresh thyme"
      ],
      "instructions": [
        "Roast chicken bones at 200°C for 30 minutes",
        "Add vegetables to roasting pan, roast 15 more minutes",
        "Transfer to stock pot, cover with cold water",
        "Bring to simmer, skim foam regularly",
        "Simmer for 3-4 hours with herbs",
        "Strain through fine mesh, cool rapidly"
      ],
      "notes": "Store in 1L containers for easy portioning",
      "allergens": [],
      "shelfLife": "5 days refrigerated, 3 months frozen",
      "portionYield": 100,
    },
    {
      "id": "PREP004",
      "item": "Mashed Potatoes",
      "category": "Side Dish",
      "station": "Hot Prep",
      "quantity": "5 kg",
      "priority": "High",
      "status": "Pending",
      "estimatedTime": 45,
      "assignedTo": "Sous Chef Thompson",
      "dueDate": "2024-06-19 17:00:00",
      "startTime": "",
      "completionTime": "",
      "ingredients": [
        "8 kg russet potatoes",
        "200ml heavy cream",
        "150g butter",
        "Salt to taste",
        "White pepper"
      ],
      "instructions": [
        "Peel and cut potatoes into even pieces",
        "Boil in salted water until fork tender",
        "Drain thoroughly and let steam dry",
        "Pass through ricer for smooth texture",
        "Fold in warm cream and butter",
        "Season with salt and white pepper"
      ],
      "notes": "Keep warm in steam table until service",
      "allergens": ["Dairy"],
      "shelfLife": "Same day service only",
      "portionYield": 25,
    },
    {
      "id": "PREP005",
      "item": "Salmon Portions",
      "category": "Protein",
      "station": "Butcher",
      "quantity": "20 portions",
      "priority": "High",
      "status": "In Progress",
      "estimatedTime": 60,
      "assignedTo": "Butcher Martinez",
      "dueDate": "2024-06-19 16:30:00",
      "startTime": "2024-06-19 14:45:00",
      "completionTime": "",
      "ingredients": [
        "3 kg fresh salmon fillet",
        "Plastic wrap",
        "Labels"
      ],
      "instructions": [
        "Check salmon for bones using tweezers",
        "Remove skin if required",
        "Cut into 150g portions",
        "Wrap each portion individually",
        "Label with date and portion weight",
        "Store in refrigerated prep area"
      ],
      "notes": "Reserve trim for staff meal soup",
      "allergens": ["Fish"],
      "shelfLife": "2 days refrigerated",
      "portionYield": 20,
    },
    {
      "id": "PREP006",
      "item": "Herb Oil",
      "category": "Garnish",
      "station": "Cold Prep",
      "quantity": "500ml",
      "priority": "Low",
      "status": "Pending",
      "estimatedTime": 20,
      "assignedTo": "",
      "dueDate": "2024-06-19 18:00:00",
      "startTime": "",
      "completionTime": "",
      "ingredients": [
        "200g mixed herbs (basil, parsley, chives)",
        "400ml neutral oil",
        "Pinch of salt"
      ],
      "instructions": [
        "Blanch herbs in boiling water for 30 seconds",
        "Shock in ice water, drain thoroughly",
        "Blend herbs with oil until smooth",
        "Strain through fine mesh",
        "Store in squeeze bottles",
        "Label and refrigerate"
      ],
      "notes": "Use for plating and garnish",
      "allergens": [],
      "shelfLife": "1 week refrigerated",
      "portionYield": 200,
    },
  ];

  List<Map<String, dynamic>> get filteredPrepItems {
    return prepItems.where((item) {
      bool matchesStation = selectedStation == "All" || item["station"] == selectedStation;
      bool matchesPriority = selectedPriority == "All" || item["priority"] == selectedPriority;
      // Date filtering would be implemented based on dueDate
      
      return matchesStation && matchesPriority;
    }).toList()..sort((a, b) {
      // Sort by priority and due date
      int priorityOrder(String priority) {
        switch (priority) {
          case "Critical": return 0;
          case "High": return 1;
          case "Normal": return 2;
          case "Low": return 3;
          default: return 4;
        }
      }
      
      int priorityCompare = priorityOrder("${a["priority"]}").compareTo(priorityOrder("${b["priority"]}"));
      if (priorityCompare != 0) return priorityCompare;
      
      return DateTime.parse("${a["dueDate"]}").compareTo(DateTime.parse("${b["dueDate"]}"));
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending": return warningColor;
      case "In Progress": return infoColor;
      case "Completed": return successColor;
      case "Overdue": return dangerColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return dangerColor;
      case "Normal": return primaryColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Icon _getCategoryIcon(String category) {
    switch (category) {
      case "Sauce": return Icon(Icons.water_drop, color: infoColor);
      case "Baked Goods": return Icon(Icons.cake, color: warningColor);
      case "Base": return Icon(Icons.soup_kitchen, color: primaryColor);
      case "Side Dish": return Icon(Icons.rice_bowl, color: successColor);
      case "Protein": return Icon(Icons.set_meal, color: dangerColor);
      case "Garnish": return Icon(Icons.grass, color: successColor);
      default: return Icon(Icons.kitchen, color: disabledBoldColor);
    }
  }

  String _getTimeUntilDue(String dueDate) {
    DateTime due = DateTime.parse(dueDate);
    DateTime now = DateTime.now();
    Duration difference = due.difference(now);
    
    if (difference.isNegative) {
      return "Overdue";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} min";
    } else {
      return "${difference.inHours}h ${difference.inMinutes % 60}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prep List"),
        actions: [
          QButton(
            icon: Icons.add_task,
            size: bs.sm,
            onPressed: () {
              // Add new prep item
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Date Range",
                    items: dateOptions,
                    value: selectedDate,
                    onChanged: (value, label) {
                      selectedDate = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Station",
                    items: stationOptions,
                    value: selectedStation,
                    onChanged: (value, label) {
                      selectedStation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredPrepItems.where((p) => p["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredPrepItems.where((p) => p["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredPrepItems.where((p) => p["priority"] == "Critical" || p["priority"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(filteredPrepItems.fold(0, (sum, item) => sum + (item["estimatedTime"] as int)) / 60).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Time",
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

            // Prep Items List
            ...filteredPrepItems.map((item) {
              String timeUntilDue = _getTimeUntilDue("${item["dueDate"]}");
              bool isOverdue = timeUntilDue == "Overdue";

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: isOverdue ? dangerColor : _getPriorityColor("${item["priority"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        _getCategoryIcon("${item["category"]}"),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["item"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${item["category"]} - ${item["station"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isOverdue ? dangerColor : _getPriorityColor("${item["priority"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            isOverdue ? "OVERDUE" : "${item["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${item["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Quantity and Time Info
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quantity: ${item["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Yield: ${item["portionYield"]} portions",
                                  style: TextStyle(
                                    fontSize: 11,
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
                                "Est. Time: ${item["estimatedTime"]} min",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Due in: $timeUntilDue",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isOverdue ? dangerColor : disabledBoldColor,
                                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Assignment Info
                    if ("${item["assignedTo"]}".isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Assigned to: ${item["assignedTo"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                    // Progress Info
                    if ("${item["startTime"]}".isNotEmpty && item["status"] == "In Progress")
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Started: ${DateTime.parse("${item["startTime"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Ingredients (Expandable)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          ...((item["ingredients"] as List).take(3).map((ingredient) => Text(
                            "• $ingredient",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                            ),
                          ))),
                          if ((item["ingredients"] as List).length > 3)
                            Text(
                              "... and ${(item["ingredients"] as List).length - 3} more",
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Allergens Warning
                    if ((item["allergens"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              size: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Allergens: ${(item["allergens"] as List).join(", ")}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Notes
                    if ("${item["notes"]}".isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.note,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${item["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Storage Info
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Shelf life: ${item["shelfLife"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Due: ${DateTime.parse("${item["dueDate"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    if (item["status"] != "Completed")
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: item["status"] == "Pending" ? "Start Prep" : "Mark Complete",
                              size: bs.sm,
                              onPressed: () {
                                // Update prep status
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () {
                              // View full recipe/instructions
                            },
                          ),
                          QButton(
                            icon: Icons.person_add,
                            size: bs.sm,
                            onPressed: () {
                              // Assign to staff
                            },
                          ),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              // Edit prep item
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),

            if (filteredPrepItems.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.checklist,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No prep items found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Prep list items will appear here",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
