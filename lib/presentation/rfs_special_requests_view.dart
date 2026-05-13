import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsSpecialRequestsView extends StatefulWidget {
  const RfsSpecialRequestsView({super.key});

  @override
  State<RfsSpecialRequestsView> createState() => _RfsSpecialRequestsViewState();
}

class _RfsSpecialRequestsViewState extends State<RfsSpecialRequestsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Dietary", "value": "Dietary"},
    {"label": "Allergies", "value": "Allergies"},
    {"label": "Presentation", "value": "Presentation"},
    {"label": "Temperature", "value": "Temperature"},
    {"label": "Portion", "value": "Portion"},
    {"label": "Timing", "value": "Timing"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "New"},
    {"label": "Acknowledged", "value": "Acknowledged"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Unable to Fulfill", "value": "Unable to Fulfill"},
  ];

  List<Map<String, dynamic>> specialRequests = [
    {
      "id": "REQ001",
      "orderId": "ORDER-2024-001",
      "customerName": "Sarah Johnson",
      "tableNumber": 15,
      "requestType": "Dietary",
      "category": "Allergies",
      "description": "Gluten-free preparation, separate cutting board and utensils",
      "urgency": "High",
      "status": "New",
      "timestamp": "2024-06-19 14:45:00",
      "estimatedTime": 10,
      "assignedTo": "",
      "customerNotes": "Severe celiac disease - cross contamination critical",
      "kitchenNotes": "",
      "items": ["Grilled Chicken Salad", "Gluten-free bread"],
    },
    {
      "id": "REQ002",
      "orderId": "ORDER-2024-002",
      "customerName": "Mike Chen",
      "tableNumber": 8,
      "requestType": "Presentation",
      "category": "Special Occasion",
      "description": "Anniversary dessert with personalized message",
      "urgency": "Medium",
      "status": "Acknowledged",
      "timestamp": "2024-06-19 14:40:00",
      "estimatedTime": 15,
      "assignedTo": "Chef Martinez",
      "customerNotes": "Celebrating 10th wedding anniversary",
      "kitchenNotes": "Use gold leaf, prepare chocolate writing",
      "items": ["Chocolate Lava Cake"],
    },
    {
      "id": "REQ003",
      "orderId": "ORDER-2024-003",
      "customerName": "Emma Wilson",
      "tableNumber": 22,
      "requestType": "Temperature",
      "category": "Cooking Style",
      "description": "Extra hot soup, ensure serving temperature above 140°F",
      "urgency": "Low",
      "status": "In Progress",
      "timestamp": "2024-06-19 14:35:00",
      "estimatedTime": 5,
      "assignedTo": "Cook Johnson",
      "customerNotes": "Prefers very hot food",
      "kitchenNotes": "Heat bowl before serving",
      "items": ["Tomato Basil Soup"],
    },
    {
      "id": "REQ004",
      "orderId": "ORDER-2024-004",
      "customerName": "David Brown",
      "tableNumber": 5,
      "requestType": "Portion",
      "category": "Size Adjustment",
      "description": "Half portion for elderly customer with small appetite",
      "urgency": "Medium",
      "status": "Completed",
      "timestamp": "2024-06-19 14:30:00",
      "estimatedTime": 0,
      "assignedTo": "Cook Williams",
      "customerNotes": "Senior citizen, small appetite",
      "kitchenNotes": "Adjust price accordingly",
      "items": ["Fish and Chips"],
    },
    {
      "id": "REQ005",
      "orderId": "ORDER-2024-005",
      "customerName": "Lisa Garcia",
      "tableNumber": 12,
      "requestType": "Timing",
      "category": "Synchronized Service",
      "description": "Delay main course by 20 minutes, guest arriving late",
      "urgency": "High",
      "status": "Acknowledged",
      "timestamp": "2024-06-19 14:25:00",
      "estimatedTime": 20,
      "assignedTo": "Sous Chef Davis",
      "customerNotes": "Business meeting, important client running late",
      "kitchenNotes": "Hold all items, coordinate with service",
      "items": ["Ribeye Steak", "Lobster Tail", "Caesar Salad"],
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return specialRequests.where((request) {
      bool matchesSearch = "${request["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${request["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${request["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || request["requestType"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || request["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New": return dangerColor;
      case "Acknowledged": return warningColor;
      case "In Progress": return infoColor;
      case "Completed": return successColor;
      case "Unable to Fulfill": return Colors.grey;
      default: return disabledColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  Icon _getCategoryIcon(String category) {
    switch (category) {
      case "Dietary": return Icon(Icons.restaurant, color: primaryColor);
      case "Allergies": return Icon(Icons.warning, color: dangerColor);
      case "Presentation": return Icon(Icons.cake, color: infoColor);
      case "Temperature": return Icon(Icons.thermostat, color: warningColor);
      case "Portion": return Icon(Icons.scale, color: successColor);
      case "Timing": return Icon(Icons.schedule, color: primaryColor);
      default: return Icon(Icons.note, color: disabledBoldColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Requests"),
        actions: [
          QButton(
            icon: Icons.add_comment,
            size: bs.sm,
            onPressed: () {
              // Add new special request
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
              label: "Search requests...",
              value: searchQuery,
              hint: "Search by customer, order, or description",
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
                          "${filteredRequests.where((r) => r["status"] == "New").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "New",
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
                          "${filteredRequests.where((r) => r["urgency"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Urgent",
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
                          "${filteredRequests.where((r) => r["status"] == "In Progress").length}",
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
                ),
              ],
            ),

            // Special Requests List
            ...filteredRequests.map((request) {
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
                      color: _getUrgencyColor("${request["urgency"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        _getCategoryIcon("${request["requestType"]}"),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${request["orderId"]} - Table ${request["tableNumber"]}",
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
                            color: _getUrgencyColor("${request["urgency"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${request["urgency"]}",
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
                            color: _getStatusColor("${request["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${request["status"]}",
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
                      "Customer: ${request["customerName"]}",
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
                            "Request: ${request["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          if ("${request["customerNotes"]}".isNotEmpty)
                            Text(
                              "Customer Notes: ${request["customerNotes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Affected Items
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Affected Items:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          ...((request["items"] as List).map((item) => Text(
                            "• $item",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ))),
                        ],
                      ),
                    ),

                    if ("${request["assignedTo"]}".isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Assigned to: ${request["assignedTo"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                    if ("${request["kitchenNotes"]}".isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.kitchen,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Kitchen Notes: ${request["kitchenNotes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Est. time: ${request["estimatedTime"]} min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${DateTime.parse("${request["timestamp"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    if (request["status"] != "Completed" && request["status"] != "Unable to Fulfill")
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: request["status"] == "New" ? "Acknowledge" : 
                                     request["status"] == "Acknowledged" ? "Start Work" : "Complete",
                              size: bs.sm,
                              onPressed: () {
                                // Update request status
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.edit_note,
                            size: bs.sm,
                            onPressed: () {
                              // Add kitchen notes
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
                            icon: Icons.block,
                            size: bs.sm,
                            onPressed: () {
                              // Mark as unable to fulfill
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }).toList(),

            if (filteredRequests.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No special requests found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Customer special requests will appear here",
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
