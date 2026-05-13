import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsFoodReadyView extends StatefulWidget {
  const RfsFoodReadyView({super.key});

  @override
  State<RfsFoodReadyView> createState() => _RfsFoodReadyViewState();
}

class _RfsFoodReadyViewState extends State<RfsFoodReadyView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Appetizer", "value": "Appetizer"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Beverage", "value": "Beverage"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Ready", "value": "Ready"},
    {"label": "Preparing", "value": "Preparing"},
    {"label": "Served", "value": "Served"},
  ];

  List<Map<String, dynamic>> foodItems = [
    {
      "id": "FD001",
      "name": "Grilled Salmon",
      "category": "Main Course",
      "status": "Ready",
      "preparedTime": "2025-06-19T14:30:00",
      "servingTime": "15 mins",
      "temperature": 145,
      "quantity": 3,
      "chef": "Chef Marco",
      "table": "Table 12",
      "priority": "high",
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon"
    },
    {
      "id": "FD002", 
      "name": "Caesar Salad",
      "category": "Appetizer",
      "status": "Preparing",
      "preparedTime": "2025-06-19T14:45:00",
      "servingTime": "5 mins",
      "temperature": 40,
      "quantity": 2,
      "chef": "Chef Anna",
      "table": "Table 8",
      "priority": "medium",
      "image": "https://picsum.photos/300/200?random=2&keyword=salad"
    },
    {
      "id": "FD003",
      "name": "Chocolate Cake",
      "category": "Dessert", 
      "status": "Ready",
      "preparedTime": "2025-06-19T13:15:00",
      "servingTime": "Ready",
      "temperature": 68,
      "quantity": 1,
      "chef": "Chef Maria",
      "table": "Table 5",
      "priority": "low",
      "image": "https://picsum.photos/300/200?random=3&keyword=cake"
    },
    {
      "id": "FD004",
      "name": "Beef Steak",
      "category": "Main Course",
      "status": "Ready",
      "preparedTime": "2025-06-19T14:20:00", 
      "servingTime": "10 mins",
      "temperature": 160,
      "quantity": 2,
      "chef": "Chef John",
      "table": "Table 15",
      "priority": "high",
      "image": "https://picsum.photos/300/200?random=4&keyword=steak"
    },
    {
      "id": "FD005",
      "name": "Fresh Juice",
      "category": "Beverage",
      "status": "Served",
      "preparedTime": "2025-06-19T14:00:00",
      "servingTime": "Served",
      "temperature": 45,
      "quantity": 4,
      "chef": "Staff Tom",
      "table": "Table 3",
      "priority": "low",
      "image": "https://picsum.photos/300/200?random=5&keyword=juice"
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return foodItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Ready": return successColor;
      case "Preparing": return warningColor;
      case "Served": return infoColor;
      default: return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "high": return dangerColor;
      case "medium": return warningColor;
      case "low": return successColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Ready Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Food Items",
                    value: searchQuery,
                    hint: "Search by name or ID...",
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
                    label: "Category",
                    items: categories,
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

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${foodItems.where((item) => item["status"] == "Ready").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Ready",
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${foodItems.where((item) => item["status"] == "Preparing").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Preparing",
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
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.restaurant, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${foodItems.where((item) => item["status"] == "Served").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Served",
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

            // Food Items List
            ...filteredItems.map((item) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getPriorityColor("${item["priority"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          bottomLeft: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${item["image"]}",
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["name"]}",
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
                                      color: getStatusColor("${item["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getStatusColor("${item["status"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${item["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getStatusColor("${item["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${item["id"]} • ${item["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.thermostat, size: 14, color: dangerColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${item["temperature"]}°F",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.schedule, size: 14, color: warningColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${item["servingTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${item["chef"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.table_restaurant, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${item["table"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Qty: ${item["quantity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "${item["status"]}" == "Ready" ? "Serve" : "Update",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
