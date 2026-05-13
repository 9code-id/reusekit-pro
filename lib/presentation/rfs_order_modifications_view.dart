import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderModificationsView extends StatefulWidget {
  const RfsOrderModificationsView({super.key});

  @override
  State<RfsOrderModificationsView> createState() => _RfsOrderModificationsViewState();
}

class _RfsOrderModificationsViewState extends State<RfsOrderModificationsView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> modifications = [
    {
      "id": "MOD001",
      "orderId": "ORDER-2024-001",
      "customerName": "Sarah Johnson",
      "originalItem": "Grilled Chicken Burger",
      "modification": "Extra cheese, no pickles, gluten-free bun",
      "reason": "Dietary restrictions",
      "status": "Pending",
      "timestamp": "2024-06-19 14:30:00",
      "priority": "High",
      "estimatedDelay": 5,
      "cost": 3.50,
      "notes": "Customer has celiac disease",
    },
    {
      "id": "MOD002",
      "orderId": "ORDER-2024-002",
      "customerName": "Mike Chen",
      "originalItem": "Margherita Pizza",
      "modification": "Add pepperoni, extra basil",
      "reason": "Customer preference",
      "status": "Processing",
      "timestamp": "2024-06-19 14:25:00",
      "priority": "Medium",
      "estimatedDelay": 3,
      "cost": 2.00,
      "notes": "Regular customer request",
    },
    {
      "id": "MOD003",
      "orderId": "ORDER-2024-003",
      "customerName": "Emma Wilson",
      "originalItem": "Caesar Salad",
      "modification": "No croutons, dressing on side, add grilled chicken",
      "reason": "Dietary preference",
      "status": "Completed",
      "timestamp": "2024-06-19 14:20:00",
      "priority": "Low",
      "estimatedDelay": 0,
      "cost": 4.00,
      "notes": "Health-conscious customer",
    },
    {
      "id": "MOD004",
      "orderId": "ORDER-2024-004",
      "customerName": "David Brown",
      "originalItem": "Beef Steak",
      "modification": "Change from medium to well-done",
      "reason": "Cooking preference",
      "status": "Processing",
      "timestamp": "2024-06-19 14:15:00",
      "priority": "High",
      "estimatedDelay": 8,
      "cost": 0.00,
      "notes": "Customer called to request change",
    },
    {
      "id": "MOD005",
      "orderId": "ORDER-2024-005",
      "customerName": "Lisa Garcia",
      "originalItem": "Vegetable Stir Fry",
      "modification": "Make it vegan, no fish sauce",
      "reason": "Dietary restrictions",
      "status": "Pending",
      "timestamp": "2024-06-19 14:10:00",
      "priority": "Medium",
      "estimatedDelay": 2,
      "cost": 0.00,
      "notes": "Vegan customer",
    },
  ];

  List<Map<String, dynamic>> get filteredModifications {
    return modifications.where((mod) {
      bool matchesSearch = "${mod["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${mod["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${mod["originalItem"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || mod["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending": return warningColor;
      case "Processing": return infoColor;
      case "Completed": return successColor;
      case "Cancelled": return dangerColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Modifications"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Add new modification
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search modifications...",
                    value: searchQuery,
                    hint: "Search by customer, order ID, or item",
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
                  onPressed: () {
                    // Show filter options
                  },
                ),
              ],
            ),

            // Status Filter
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: statusOptions,
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
                    label: "Time Period",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Cards
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
                        Text(
                          "${filteredModifications.where((m) => m["status"] == "Pending").length}",
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
                        Text(
                          "${filteredModifications.where((m) => m["status"] == "Processing").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Processing",
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
                        Text(
                          "${filteredModifications.where((m) => m["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
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

            // Modifications List
            ...filteredModifications.map((modification) {
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
                      color: _getStatusColor("${modification["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${modification["orderId"]}",
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
                            color: _getPriorityColor("${modification["priority"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${modification["priority"]}",
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
                            color: _getStatusColor("${modification["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${modification["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "Customer: ${modification["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Original: ${modification["originalItem"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Modification: ${modification["modification"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if ("${modification["notes"]}".isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.note,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${modification["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Est. delay: ${modification["estimatedDelay"]} min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Cost: \$${((modification["cost"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (modification["cost"] as num) > 0 ? successColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    if (modification["status"] != "Completed" && modification["status"] != "Cancelled")
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: modification["status"] == "Pending" ? "Start Processing" : "Mark Complete",
                              size: bs.sm,
                              onPressed: () {
                                // Update modification status
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              // Edit modification
                            },
                          ),
                          QButton(
                            icon: Icons.cancel,
                            size: bs.sm,
                            onPressed: () {
                              // Cancel modification
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),

            if (filteredModifications.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.edit_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No modifications found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Order modifications will appear here",
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
