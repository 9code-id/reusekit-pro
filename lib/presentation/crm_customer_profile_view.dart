import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomerProfileView extends StatefulWidget {
  const CrmCustomerProfileView({super.key});

  @override
  State<CrmCustomerProfileView> createState() => _CrmCustomerProfileViewState();
}

class _CrmCustomerProfileViewState extends State<CrmCustomerProfileView> {
  int selectedTab = 0;
  bool loading = false;

  Map<String, dynamic> customer = {
    "id": "CUST-001",
    "firstName": "John",
    "lastName": "Smith",
    "email": "john.smith@email.com",
    "phone": "+1 (555) 123-4567",
    "company": "Tech Solutions Inc",
    "position": "Marketing Director",
    "segment": "VIP Customer",
    "source": "Referral",
    "status": "Active",
    "profileImage": "https://picsum.photos/200/200?random=1&keyword=person",
    "totalOrders": 24,
    "totalSpent": 45230.00,
    "lastOrder": "2024-06-15",
    "joinDate": "2023-03-15",
    "address": "123 Business Ave, San Francisco, CA 94102",
    "notes": "High-value customer with multiple successful projects. Prefers premium services and has excellent payment history."
  };

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "ORD-2024-156",
      "date": "2024-06-15",
      "amount": 2850.00,
      "status": "Completed",
      "items": 5
    },
    {
      "id": "ORD-2024-143",
      "date": "2024-06-01",
      "amount": 1200.00,
      "status": "Delivered",
      "items": 3
    },
    {
      "id": "ORD-2024-128",
      "date": "2024-05-20",
      "amount": 3500.00,
      "status": "Completed",
      "items": 7
    }
  ];

  List<Map<String, dynamic>> interactions = [
    {
      "type": "Email",
      "date": "2024-06-18",
      "subject": "Order confirmation #ORD-2024-156",
      "status": "Sent"
    },
    {
      "type": "Phone Call",
      "date": "2024-06-10",
      "subject": "Product consultation",
      "status": "Completed"
    },
    {
      "type": "Meeting",
      "date": "2024-05-25",
      "subject": "Quarterly business review",
      "status": "Completed"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profile"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () => _editCustomer(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () => _showMoreOptions(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Customer Header
                  _buildCustomerHeader(),
                  
                  // Stats Overview
                  _buildStatsOverview(),
                  
                  // Tab Content
                  _buildTabContent(),
                ],
              ),
            ),
    );
  }

  Widget _buildCustomerHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          // Profile Image and Basic Info
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${customer["profileImage"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${customer["firstName"]} ${customer["lastName"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["position"]} at ${customer["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${customer["segment"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Contact Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${customer["email"]}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _sendEmail(),
                      child: Icon(Icons.send, size: 16, color: primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${customer["phone"]}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _makeCall(),
                      child: Icon(Icons.call, size: 16, color: primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${customer["address"]}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Orders",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${customer["totalOrders"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(customer["totalSpent"] as double).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Customer Since",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${DateTime.parse(customer["joinDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                _buildTabButton("Orders", 0),
                _buildTabButton("Interactions", 1),
                _buildTabButton("Notes", 2),
              ],
            ),
          ),
          
          // Tab Content
          Container(
            padding: EdgeInsets.all(spMd),
            child: _getTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildOrdersTab();
      case 1:
        return _buildInteractionsTab();
      case 2:
        return _buildNotesTab();
      default:
        return _buildOrdersTab();
    }
  }

  Widget _buildOrdersTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Orders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _viewAllOrders(),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...recentOrders.map((order) => _buildOrderItem(order)),
      ],
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.shopping_bag,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${order["id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${DateTime.parse(order["date"]).dMMMy} • ${order["items"]} items",
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
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(order["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${order["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(order["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Interactions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Add Note",
              size: bs.sm,
              onPressed: () => _addInteraction(),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...interactions.map((interaction) => _buildInteractionItem(interaction)),
      ],
    );
  }

  Widget _buildInteractionItem(Map<String, dynamic> interaction) {
    IconData icon;
    Color iconColor;
    
    switch (interaction["type"]) {
      case "Email":
        icon = Icons.email;
        iconColor = infoColor;
        break;
      case "Phone Call":
        icon = Icons.call;
        iconColor = successColor;
        break;
      case "Meeting":
        icon = Icons.people;
        iconColor = primaryColor;
        break;
      default:
        icon = Icons.note;
        iconColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${interaction["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${interaction["type"]} • ${DateTime.parse(interaction["date"]).dMMMy}",
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
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${interaction["status"]}",
              style: TextStyle(
                fontSize: 10,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer Notes",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Text(
            "${customer["notes"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Edit Notes",
            size: bs.md,
            onPressed: () => _editNotes(),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "delivered":
        return infoColor;
      case "pending":
        return warningColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _editCustomer() {
    // Navigate to edit customer
    si("Navigate to edit customer");
  }

  void _showMoreOptions() {
    // Show more options
    si("Show more options");
  }

  void _sendEmail() {
    ss("Email sent to customer");
  }

  void _makeCall() {
    si("Calling customer...");
  }

  void _viewAllOrders() {
    // Navigate to customer orders
    si("Navigate to customer orders");
  }

  void _addInteraction() {
    // Add new interaction
    si("Add new interaction");
  }

  void _editNotes() {
    // Edit customer notes
    si("Edit customer notes");
  }
}
