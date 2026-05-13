import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDineInOrdersView extends StatefulWidget {
  const RmaDineInOrdersView({super.key});

  @override
  State<RmaDineInOrdersView> createState() => _RmaDineInOrdersViewState();
}

class _RmaDineInOrdersViewState extends State<RmaDineInOrdersView> {
  String selectedFilter = "all";
  String sortBy = "table_number";
  bool showDetails = true;
  
  List<Map<String, dynamic>> dineInOrders = [
    {
      "id": "DIN-001",
      "orderNumber": "#DI12001",
      "tableNumber": "T-05",
      "customerCount": 4,
      "customerName": "Johnson Family",
      "waiterName": "Sarah Davis",
      "items": [
        {"name": "Ribeye Steak", "quantity": 2, "price": 28.99, "customizations": ["Medium rare", "Extra sauce"], "status": "preparing"},
        {"name": "Grilled Salmon", "quantity": 1, "price": 24.99, "customizations": ["No lemon"], "status": "preparing"},
        {"name": "Caesar Salad", "quantity": 2, "price": 11.25, "customizations": ["Extra dressing"], "status": "served"},
        {"name": "Red Wine", "quantity": 1, "price": 12.99, "customizations": [], "status": "served"},
        {"name": "Sparkling Water", "quantity": 4, "price": 2.99, "customizations": [], "status": "served"},
      ],
      "totalAmount": 114.19,
      "orderTime": "2024-03-15 18:30:00",
      "seatedTime": "2024-03-15 18:25:00",
      "status": "dining",
      "tableStatus": "occupied",
      "paymentStatus": "pending",
      "paymentMethod": "card",
      "specialRequests": "Birthday celebration, please bring dessert with candles",
      "allergies": "Nut allergy - Table 5",
      "estimatedDiningTime": 90,
      "currentCourse": "main",
    },
    {
      "id": "DIN-002",
      "orderNumber": "#DI12002",
      "tableNumber": "T-12",
      "customerCount": 2,
      "customerName": "Mike & Lisa",
      "waiterName": "Emma Taylor",
      "items": [
        {"name": "Pasta Carbonara", "quantity": 1, "price": 14.75, "customizations": ["Extra cheese"], "status": "served"},
        {"name": "Margherita Pizza", "quantity": 1, "price": 16.50, "customizations": ["Thin crust"], "status": "served"},
        {"name": "Garlic Bread", "quantity": 1, "price": 5.99, "customizations": [], "status": "served"},
        {"name": "House Wine", "quantity": 2, "price": 8.99, "customizations": [], "status": "served"},
      ],
      "totalAmount": 55.22,
      "orderTime": "2024-03-15 19:00:00",
      "seatedTime": "2024-03-15 18:55:00",
      "status": "completed",
      "tableStatus": "cleaning",
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "specialRequests": "",
      "allergies": "",
      "estimatedDiningTime": 60,
      "currentCourse": "finished",
    },
    {
      "id": "DIN-003",
      "orderNumber": "#DI12003",
      "tableNumber": "T-08",
      "customerCount": 6,
      "customerName": "Corporate Lunch",
      "waiterName": "James Anderson",
      "items": [
        {"name": "Chicken Caesar Salad", "quantity": 3, "price": 12.99, "customizations": ["Dressing on side"], "status": "served"},
        {"name": "Grilled Chicken", "quantity": 2, "price": 18.99, "customizations": ["Well done"], "status": "preparing"},
        {"name": "Vegetarian Pasta", "quantity": 1, "price": 15.99, "customizations": ["No cheese"], "status": "confirmed"},
        {"name": "Soft Drinks", "quantity": 6, "price": 2.99, "customizations": ["Mix of sodas"], "status": "served"},
        {"name": "Dessert Platter", "quantity": 1, "price": 22.99, "customizations": ["No nuts"], "status": "ordered"},
      ],
      "totalAmount": 128.93,
      "orderTime": "2024-03-15 12:30:00",
      "seatedTime": "2024-03-15 12:25:00",
      "status": "dining",
      "tableStatus": "occupied",
      "paymentStatus": "pending",
      "paymentMethod": "corporate_card",
      "specialRequests": "Business meeting, please keep noise levels low around table",
      "allergies": "Nut allergy - one guest",
      "estimatedDiningTime": 120,
      "currentCourse": "main",
    },
    {
      "id": "DIN-004",
      "orderNumber": "#DI12004",
      "tableNumber": "T-15",
      "customerCount": 2,
      "customerName": "David & Carol",
      "waiterName": "John Smith",
      "items": [
        {"name": "Soup of the Day", "quantity": 2, "price": 6.99, "customizations": [], "status": "served"},
        {"name": "Fish & Chips", "quantity": 1, "price": 16.99, "customizations": ["Extra tartar sauce"], "status": "served"},
        {"name": "Shepherd's Pie", "quantity": 1, "price": 15.99, "customizations": [], "status": "served"},
        {"name": "Beer", "quantity": 2, "price": 4.99, "customizations": ["Cold"], "status": "served"},
        {"name": "Coffee", "quantity": 2, "price": 2.99, "customizations": ["One decaf"], "status": "preparing"},
      ],
      "totalAmount": 61.93,
      "orderTime": "2024-03-15 20:15:00",
      "seatedTime": "2024-03-15 20:10:00",
      "status": "dining",
      "tableStatus": "occupied",
      "paymentStatus": "pending",
      "paymentMethod": "card",
      "specialRequests": "Quiet corner table requested",
      "allergies": "",
      "estimatedDiningTime": 75,
      "currentCourse": "dessert",
    },
    {
      "id": "DIN-005",
      "orderNumber": "#DI12005",
      "tableNumber": "T-03",
      "customerCount": 1,
      "customerName": "Robert Wilson",
      "waiterName": "Sarah Davis",
      "items": [
        {"name": "Club Sandwich", "quantity": 1, "price": 12.99, "customizations": ["No tomatoes"], "status": "served"},
        {"name": "French Fries", "quantity": 1, "price": 4.99, "customizations": [], "status": "served"},
        {"name": "Iced Tea", "quantity": 2, "price": 2.99, "customizations": ["Lemon"], "status": "served"},
      ],
      "totalAmount": 23.96,
      "orderTime": "2024-03-15 14:45:00",
      "seatedTime": "2024-03-15 14:40:00",
      "status": "completed",
      "tableStatus": "available",
      "paymentStatus": "paid",
      "paymentMethod": "cash",
      "specialRequests": "",
      "allergies": "",
      "estimatedDiningTime": 45,
      "currentCourse": "finished",
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Tables", "value": "all"},
    {"label": "Occupied", "value": "occupied"},
    {"label": "Dining", "value": "dining"},
    {"label": "Completed", "value": "completed"},
    {"label": "Payment Pending", "value": "payment_pending"},
    {"label": "Special Requests", "value": "special_requests"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Table Number", "value": "table_number"},
    {"label": "Seated Time", "value": "seated_time"},
    {"label": "Order Value", "value": "amount"},
    {"label": "Party Size", "value": "party_size"},
  ];

  Widget _buildDineInOverview() {
    final totalTables = dineInOrders.length;
    final occupiedTables = dineInOrders.where((order) => order["tableStatus"] == "occupied").length;
    final totalRevenue = dineInOrders.map((order) => order["totalAmount"] as double).reduce((a, b) => a + b);
    final avgPartySize = dineInOrders.map((order) => order["customerCount"] as int).reduce((a, b) => a + b) / totalTables;
    
    return Container(
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
            "Dine-In Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Active Tables",
                "$totalTables",
                Icons.restaurant,
                primaryColor,
              ),
              _buildOverviewCard(
                "Occupied",
                "$occupiedTables",
                Icons.event_seat,
                warningColor,
              ),
              _buildOverviewCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildOverviewCard(
                "Avg Party Size",
                "${avgPartySize.toStringAsFixed(0)} people",
                Icons.group,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QDropdownField(
                  label: "Filter Tables",
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
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Order Details",
                      "value": true,
                      "checked": showDetails,
                    }
                  ],
                  value: [
                    if (showDetails)
                      {
                        "label": "Show Order Details",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Table Layout",
                icon: Icons.grid_view,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('TableLayoutView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDineInOrderCard(Map<String, dynamic> order) {
    final statusColor = order["status"] == "completed" ? successColor :
                       order["status"] == "dining" ? warningColor : primaryColor;
    
    final tableStatusColor = order["tableStatus"] == "occupied" ? warningColor :
                            order["tableStatus"] == "cleaning" ? infoColor : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${order["tableNumber"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${order["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: tableStatusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${order["tableStatus"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: tableStatusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.group, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${order["customerName"]} (${order["customerCount"]} guests)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.person_pin, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Served by: ${order["waiterName"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((order["totalAmount"] as double)).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Order: ${order["orderNumber"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Seated: ${order["seatedTime"].substring(11, 16)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.timer, color: primaryColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Dining: ${order["estimatedDiningTime"]} min",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.restaurant_menu, color: infoColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Course: ${order["currentCourse"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (order["paymentStatus"] == "pending")
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "PAYMENT PENDING",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),
          if (order["allergies"] != "" || order["specialRequests"] != "") ...[
            SizedBox(height: spSm),
            if (order["allergies"] != "")
              Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "⚠️ ${order["allergies"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (order["specialRequests"] != "")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.note, color: warningColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${order["specialRequests"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          if (showDetails) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Items:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...((order["items"] as List).map((item) => Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${item["quantity"]}x",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: item["status"] == "served" ? successColor.withAlpha(20) :
                                       item["status"] == "preparing" ? warningColor.withAlpha(20) :
                                       item["status"] == "confirmed" ? infoColor.withAlpha(20) : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${item["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: item["status"] == "served" ? successColor :
                                         item["status"] == "preparing" ? warningColor :
                                         item["status"] == "confirmed" ? infoColor : disabledBoldColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((item["price"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        if ((item["customizations"] as List).isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Padding(
                            padding: EdgeInsets.only(left: spMd),
                            child: Text(
                              "• ${(item["customizations"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ))).toList(),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              if (order["status"] == "dining") ...[
                if (order["paymentStatus"] == "pending")
                  Expanded(
                    child: QButton(
                      label: "Process Payment",
                      icon: Icons.payment,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('ProcessPayment')
                      },
                    ),
                  )
                else
                  Expanded(
                    child: QButton(
                      label: "Add Items",
                      icon: Icons.add_shopping_cart,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('AddItems')
                      },
                    ),
                  ),
              ] else if (order["status"] == "completed") ...[
                Expanded(
                  child: QButton(
                    label: "View Receipt",
                    icon: Icons.receipt,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ViewReceipt')
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Table Status",
                    icon: Icons.table_restaurant,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('TableStatus')
                    },
                  ),
                ),
              ],
              SizedBox(width: spSm),
              QButton(
                icon: Icons.kitchen,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('KitchenStatus')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditOrder')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = List.from(dineInOrders);
    
    // Apply filters
    if (selectedFilter != "all") {
      if (selectedFilter == "occupied") {
        filtered = filtered.where((order) => order["tableStatus"] == "occupied").toList();
      } else if (selectedFilter == "payment_pending") {
        filtered = filtered.where((order) => order["paymentStatus"] == "pending").toList();
      } else if (selectedFilter == "special_requests") {
        filtered = filtered.where((order) => 
          order["specialRequests"] != "" || order["allergies"] != "").toList();
      } else {
        filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
      }
    }
    
    // Apply sorting
    switch (sortBy) {
      case "seated_time":
        filtered.sort((a, b) => a["seatedTime"].compareTo(b["seatedTime"]));
        break;
      case "amount":
        filtered.sort((a, b) => (b["totalAmount"] as double).compareTo(a["totalAmount"] as double));
        break;
      case "party_size":
        filtered.sort((a, b) => (b["customerCount"] as int).compareTo(a["customerCount"] as int));
        break;
      default: // table_number
        filtered.sort((a, b) => a["tableNumber"].compareTo(b["tableNumber"]));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dine-In Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {
              //navigateTo('TableLayoutView')
            },
          ),
          IconButton(
            icon: Icon(Icons.kitchen),
            onPressed: () {
              //navigateTo('KitchenDisplay')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDineInOverview(),
            _buildFilters(),
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
                      Text(
                        "Dine-In Tables (${filteredOrders.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "New Order",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('NewDineInOrder')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredOrders.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No dine-in orders found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredOrders.map((order) => _buildDineInOrderCard(order)).toList(),
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
