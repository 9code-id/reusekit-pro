import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsKitchenNotesView extends StatefulWidget {
  const RfsKitchenNotesView({super.key});

  @override
  State<RfsKitchenNotesView> createState() => _RfsKitchenNotesViewState();
}

class _RfsKitchenNotesViewState extends State<RfsKitchenNotesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Recipe", "value": "Recipe"},
    {"label": "Preparation", "value": "Preparation"},
    {"label": "Allergies", "value": "Allergies"},
    {"label": "Temperature", "value": "Temperature"},
    {"label": "Plating", "value": "Plating"},
    {"label": "Quality", "value": "Quality"},
    {"label": "Safety", "value": "Safety"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Archived", "value": "Archived"},
    {"label": "Priority", "value": "Priority"},
  ];

  List<Map<String, dynamic>> kitchenNotes = [
    {
      "id": "NOTE001",
      "title": "Gluten-Free Cross Contamination Protocol",
      "category": "Allergies",
      "content": "Use separate cutting boards, utensils, and prep areas for all gluten-free items. Clean all surfaces with dedicated cleaning supplies before preparation.",
      "author": "Chef Martinez",
      "priority": "High",
      "status": "Active",
      "createdDate": "2024-06-19 09:00:00",
      "lastUpdated": "2024-06-19 14:30:00",
      "attachedItems": ["All gluten-free menu items"],
      "tags": ["gluten-free", "cross-contamination", "allergens", "safety"],
      "views": 45,
      "likes": 12,
      "station": "All Stations",
      "shift": "All Shifts",
    },
    {
      "id": "NOTE002",
      "title": "Perfect Ribeye Steak Temperature Guide",
      "category": "Temperature",
      "content": "Rare: 120-125°F (2-3 min each side)\nMedium Rare: 130-135°F (3-4 min each side)\nMedium: 135-145°F (4-5 min each side)\nWell Done: 145°F+ (6+ min each side)\nAlways rest for 5 minutes before plating.",
      "author": "Grill Master Johnson",
      "priority": "Medium",
      "status": "Active",
      "createdDate": "2024-06-18 16:20:00",
      "lastUpdated": "2024-06-19 10:15:00",
      "attachedItems": ["Ribeye Steak", "NY Strip", "Filet Mignon"],
      "tags": ["steak", "temperature", "grilling", "cooking-times"],
      "views": 78,
      "likes": 24,
      "station": "Grill Station",
      "shift": "All Shifts",
    },
    {
      "id": "NOTE003",
      "title": "Signature Caesar Dressing Recipe Update",
      "category": "Recipe",
      "content": "New ratio: 3 egg yolks, 6 anchovy fillets, 2 garlic cloves, 1/4 cup lemon juice, 1/2 cup olive oil, 1/4 cup parmesan. Blend until smooth. Taste test before serving.",
      "author": "Sous Chef Davis",
      "priority": "High",
      "status": "Active",
      "createdDate": "2024-06-19 08:45:00",
      "lastUpdated": "2024-06-19 13:20:00",
      "attachedItems": ["Caesar Salad", "Chicken Caesar Wrap"],
      "tags": ["recipe", "dressing", "caesar", "update"],
      "views": 32,
      "likes": 8,
      "station": "Cold Prep",
      "shift": "All Shifts",
    },
    {
      "id": "NOTE004",
      "title": "Plating Standards - Main Courses",
      "category": "Plating",
      "content": "Protein at 6 o'clock, starch at 2 o'clock, vegetables at 10 o'clock. Sauce should complement, not drown. Garnish sparingly with fresh herbs. Ensure plate temperature is 140°F before plating.",
      "author": "Executive Chef Williams",
      "priority": "Medium",
      "status": "Active",
      "createdDate": "2024-06-17 11:30:00",
      "lastUpdated": "2024-06-18 15:45:00",
      "attachedItems": ["All main course items"],
      "tags": ["plating", "presentation", "standards", "main-course"],
      "views": 156,
      "likes": 42,
      "station": "All Stations",
      "shift": "All Shifts",
    },
    {
      "id": "NOTE005",
      "title": "Soup Consistency Quality Check",
      "category": "Quality",
      "content": "Check soup consistency every 30 minutes. If too thick, add hot stock gradually. If too thin, simmer uncovered to reduce. Taste for seasoning before each service.",
      "author": "Line Cook Williams",
      "priority": "Low",
      "status": "Active",
      "createdDate": "2024-06-19 12:15:00",
      "lastUpdated": "2024-06-19 12:15:00",
      "attachedItems": ["All soup items"],
      "tags": ["soup", "consistency", "quality", "seasoning"],
      "views": 23,
      "likes": 6,
      "station": "Hot Prep",
      "shift": "All Shifts",
    },
    {
      "id": "NOTE006",
      "title": "Deep Fryer Safety Protocol - URGENT",
      "category": "Safety",
      "content": "NEVER leave fryer unattended when heating oil. Check oil temperature before use - should be 350°F for most items. Replace oil when it becomes dark or smells off. Keep fire extinguisher nearby.",
      "author": "Kitchen Manager Brown",
      "priority": "High",
      "status": "Priority",
      "createdDate": "2024-06-19 07:00:00",
      "lastUpdated": "2024-06-19 14:00:00",
      "attachedItems": ["All fried items"],
      "tags": ["safety", "fryer", "urgent", "protocol"],
      "views": 89,
      "likes": 15,
      "station": "Fryer Station",
      "shift": "All Shifts",
    },
  ];

  List<Map<String, dynamic>> get filteredNotes {
    return kitchenNotes.where((note) {
      bool matchesSearch = "${note["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${note["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (note["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || note["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || note["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "Priority": return dangerColor;
      case "Archived": return disabledColor;
      default: return primaryColor;
    }
  }

  Icon _getCategoryIcon(String category) {
    switch (category) {
      case "Recipe": return Icon(Icons.restaurant_menu, color: primaryColor);
      case "Preparation": return Icon(Icons.kitchen, color: infoColor);
      case "Allergies": return Icon(Icons.warning, color: dangerColor);
      case "Temperature": return Icon(Icons.thermostat, color: warningColor);
      case "Plating": return Icon(Icons.dining, color: successColor);
      case "Quality": return Icon(Icons.star, color: primaryColor);
      case "Safety": return Icon(Icons.security, color: dangerColor);
      default: return Icon(Icons.note, color: disabledBoldColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitchen Notes"),
        actions: [
          QButton(
            icon: Icons.add_circle,
            size: bs.sm,
            onPressed: () {
              // Add new kitchen note
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search notes...",
              value: searchQuery,
              hint: "Search by title, content, or tags",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Quick Stats
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
                          "${filteredNotes.where((n) => n["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active Notes",
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
                          "${filteredNotes.where((n) => n["priority"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "High Priority",
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
                          "${(filteredNotes.fold(0, (sum, note) => sum + (note["views"] as int)) / filteredNotes.length).toInt()}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Avg Views",
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

            // Kitchen Notes List
            ...filteredNotes.map((note) {
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
                      color: _getPriorityColor("${note["priority"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        _getCategoryIcon("${note["category"]}"),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${note["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${note["priority"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${note["priority"]}",
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
                            color: _getStatusColor("${note["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${note["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${note["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                    ),

                    // Tags
                    if ((note["tags"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (note["tags"] as List).map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: infoColor, width: 1),
                          ),
                          child: Text(
                            "#$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),

                    // Attached Items
                    if ((note["attachedItems"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Applies to:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            ...((note["attachedItems"] as List).map((item) => Text(
                              "• $item",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                              ),
                            ))),
                          ],
                        ),
                      ),

                    // Author and Station Info
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${note["author"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${note["station"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    // Engagement Stats
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${note["views"]} views",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.thumb_up,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${note["likes"]} likes",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Updated: ${DateTime.parse("${note["lastUpdated"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      spacing: spXs,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // View full note details
                            },
                          ),
                        ),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit note
                          },
                        ),
                        QButton(
                          icon: Icons.thumb_up,
                          size: bs.sm,
                          onPressed: () {
                            // Like note
                          },
                        ),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            // Share note
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // More options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredNotes.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No kitchen notes found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Kitchen notes and instructions will appear here",
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
