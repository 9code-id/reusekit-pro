import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerDetailView extends StatefulWidget {
  const AbaCustomerDetailView({super.key});

  @override
  State<AbaCustomerDetailView> createState() => _AbaCustomerDetailViewState();
}

class _AbaCustomerDetailViewState extends State<AbaCustomerDetailView> {
  int selectedTab = 0;
  bool loading = false;

  Map<String, dynamic> customer = {
    "id": "CUST-001",
    "name": "John Smith",
    "email": "john.smith@email.com",
    "phone": "+1 (555) 123-4567",
    "company": "Acme Corporation",
    "status": "Active",
    "segment": "Enterprise",
    "totalSpent": 45000.00,
    "orders": 28,
    "lastOrder": "2024-01-18",
    "joinDate": "2023-03-15",
    "avatar": "https://picsum.photos/120/120?random=1",
    "location": "New York, NY",
    "address": "123 Business Street, Suite 400, New York, NY 10001",
    "website": "www.acme.com",
    "industry": "Technology",
    "employeeCount": "500-1000",
    "tags": ["Premium", "VIP", "Enterprise"],
    "notes": "Key enterprise customer with regular bulk orders",
    "assignedManager": "Sarah Johnson",
    "rating": 4.8,
    "loyaltyPoints": 2450
  };

  List<Map<String, dynamic>> orderHistory = [
    {
      "id": "ORD-001",
      "orderNumber": "ACM-2024-001",
      "date": "2024-01-18",
      "amount": 2500.00,
      "status": "Delivered",
      "items": 5,
      "description": "Software licenses and support"
    },
    {
      "id": "ORD-002",
      "orderNumber": "ACM-2024-002",
      "date": "2024-01-10",
      "amount": 1800.00,
      "status": "Delivered",
      "items": 3,
      "description": "Hardware equipment"
    },
    {
      "id": "ORD-003",
      "orderNumber": "ACM-2023-045",
      "date": "2023-12-22",
      "amount": 3200.00,
      "status": "Delivered",
      "items": 7,
      "description": "Year-end bulk purchase"
    },
    {
      "id": "ORD-004",
      "orderNumber": "ACM-2023-044",
      "date": "2023-12-15",
      "amount": 950.00,
      "status": "Delivered",
      "items": 2,
      "description": "Maintenance services"
    }
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "PAY-001",
      "date": "2024-01-20",
      "amount": 2500.00,
      "method": "Bank Transfer",
      "status": "Completed",
      "reference": "BT-2024-001"
    },
    {
      "id": "PAY-002",
      "date": "2024-01-12",
      "amount": 1800.00,
      "method": "Credit Card",
      "status": "Completed",
      "reference": "CC-2024-002"
    },
    {
      "id": "PAY-003",
      "date": "2023-12-25",
      "amount": 3200.00,
      "method": "Bank Transfer",
      "status": "Completed",
      "reference": "BT-2023-045"
    }
  ];

  List<Map<String, dynamic>> supportTickets = [
    {
      "id": "TIC-001",
      "title": "License activation issue",
      "status": "Resolved",
      "priority": "Medium",
      "created": "2024-01-15",
      "resolved": "2024-01-16",
      "agent": "Mike Support"
    },
    {
      "id": "TIC-002",
      "title": "Feature request for bulk operations",
      "status": "In Progress",
      "priority": "Low",
      "created": "2024-01-12",
      "resolved": null,
      "agent": "Lisa Technical"
    },
    {
      "id": "TIC-003",
      "title": "Integration assistance needed",
      "status": "Resolved",
      "priority": "High",
      "created": "2023-12-20",
      "resolved": "2023-12-21",
      "agent": "David Expert"
    }
  ];

  List<Map<String, dynamic>> interactions = [
    {
      "type": "Call",
      "description": "Discussed renewal options",
      "date": "2024-01-19",
      "duration": "30 minutes",
      "outcome": "Positive",
      "agent": "Sarah Johnson"
    },
    {
      "type": "Email",
      "description": "Sent product catalog",
      "date": "2024-01-17",
      "duration": null,
      "outcome": "Delivered",
      "agent": "Marketing Team"
    },
    {
      "type": "Meeting",
      "description": "Quarterly business review",
      "date": "2024-01-10",
      "duration": "2 hours",
      "outcome": "Excellent",
      "agent": "Account Team"
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
      case "Delivered":
      case "Completed":
      case "Resolved":
        return successColor;
      case "Inactive":
      case "Cancelled":
        return dangerColor;
      case "Pending":
      case "In Progress":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // navigateTo EditCustomerView
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Customer Profile Header
            Container(
              padding: EdgeInsets.all(spSm),
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
                      ClipOval(
                        child: Image.network(
                          "${customer["avatar"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${customer["name"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${customer["company"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${customer["id"]} • ${customer["segment"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${customer["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${customer["status"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${customer["status"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Rating and loyalty points
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${customer["rating"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            " Customer Rating",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "${customer["loyaltyPoints"]} Loyalty Points",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Key Metrics
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
                          "\$${(customer["totalSpent"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Spent",
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
                          "${customer["orders"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Orders",
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
                          "${DateTime.parse("${customer["lastOrder"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Last Order",
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

            // Contact Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 18,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${customer["email"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 18,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${customer["phone"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.web,
                                  size: 18,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${customer["website"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${customer["address"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  size: 18,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${customer["industry"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 18,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${customer["employeeCount"]} employees",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Tab Headers
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = 0;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedTab == 0 ? primaryColor : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              "Orders",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 0 ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = 1;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedTab == 1 ? primaryColor : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              "Payments",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 1 ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = 2;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedTab == 2 ? primaryColor : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              "Support",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 2 ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Tab Content
                  if (selectedTab == 0)
                    // Orders Tab
                    Column(
                      spacing: spSm,
                      children: orderHistory.take(3).map((order) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
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
                                      "${order["orderNumber"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${order["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse("${order["date"]}").dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                    "\$${(order["amount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${order["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${order["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _getStatusColor("${order["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                  if (selectedTab == 1)
                    // Payments Tab
                    Column(
                      spacing: spSm,
                      children: paymentHistory.take(3).map((payment) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
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
                                      "${payment["reference"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${payment["method"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse("${payment["date"]}").dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                                    "\$${(payment["amount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${payment["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${payment["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _getStatusColor("${payment["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                  if (selectedTab == 2)
                    // Support Tab
                    Column(
                      spacing: spSm,
                      children: supportTickets.take(3).map((ticket) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
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
                                      "${ticket["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Agent: ${ticket["agent"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse("${ticket["created"]}").dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${ticket["priority"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${ticket["priority"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _getPriorityColor("${ticket["priority"]}"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${ticket["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${ticket["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _getStatusColor("${ticket["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "New Order",
                          icon: Icons.add_shopping_cart,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo CreateOrderView
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Send Email",
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            // Send email to customer
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule Call",
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            // Schedule call
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Reports",
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo CustomerReportsView
                          },
                        ),
                      ),
                    ],
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
