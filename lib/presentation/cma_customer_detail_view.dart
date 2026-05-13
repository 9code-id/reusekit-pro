import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerDetailView extends StatefulWidget {
  const CmaCustomerDetailView({super.key});

  @override
  State<CmaCustomerDetailView> createState() => _CmaCustomerDetailViewState();
}

class _CmaCustomerDetailViewState extends State<CmaCustomerDetailView> {
  int selectedTab = 0;
  bool loading = false;

  // Sample customer data
  Map<String, dynamic> customer = {
    "id": "CUST001",
    "name": "John Anderson",
    "email": "john.anderson@techcorp.com",
    "phone": "+1 (555) 123-4567",
    "company": "TechCorp Solutions",
    "position": "Chief Technology Officer",
    "status": "active",
    "customerType": "premium",
    "totalOrders": 47,
    "totalSpent": 28450.00,
    "outstandingBalance": 4200.00,
    "creditLimit": 75000.00,
    "lastOrderDate": "2025-06-18T14:30:00",
    "joinDate": "2023-03-15T10:00:00",
    "avatar": "https://picsum.photos/150/150?random=1&keyword=executive",
    "address": "1234 Technology Drive, Innovation City, IC 12345",
    "website": "www.techcorp.com",
    "industry": "Technology",
    "employeeCount": 250,
    "annualRevenue": 5000000.00,
    "preferredPayment": "Net 30",
    "taxId": "12-3456789",
    "rating": 4.8,
    "tags": ["VIP", "Technology", "Strategic", "High Value"],
    "notes": "Excellent customer with consistent large orders. Prefers bulk purchases and has expressed interest in enterprise solutions.",
  };

  List<Map<String, dynamic>> recentOrders = [
    {
      "id": "ORD2025001",
      "date": "2025-06-18T14:30:00",
      "amount": 3500.00,
      "status": "completed",
      "items": 12,
      "type": "Software Licenses",
    },
    {
      "id": "ORD2025002",
      "date": "2025-06-10T09:15:00",
      "amount": 8900.00,
      "status": "shipped",
      "items": 25,
      "type": "Hardware Equipment",
    },
    {
      "id": "ORD2025003",
      "date": "2025-05-28T16:45:00",
      "amount": 1200.00,
      "status": "completed",
      "items": 5,
      "type": "Support Services",
    },
    {
      "id": "ORD2025004",
      "date": "2025-05-15T11:20:00",
      "amount": 15600.00,
      "status": "completed",
      "items": 35,
      "type": "Cloud Services",
    },
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": "COMM001",
      "type": "email",
      "date": "2025-06-19T08:30:00",
      "subject": "Follow-up on recent order",
      "content": "Thank you for your recent order. We wanted to confirm everything is to your satisfaction.",
      "direction": "outbound",
      "status": "sent",
    },
    {
      "id": "COMM002",
      "type": "call",
      "date": "2025-06-17T14:15:00",
      "subject": "Technical support inquiry",
      "content": "Customer called regarding setup issues with new software licenses.",
      "direction": "inbound",
      "status": "resolved",
      "duration": "00:25:30",
    },
    {
      "id": "COMM003",
      "type": "meeting",
      "date": "2025-06-15T10:00:00",
      "subject": "Quarterly business review",
      "content": "Discussed future needs and potential expansion opportunities.",
      "direction": "scheduled",
      "status": "completed",
      "duration": "01:30:00",
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": "DOC001",
      "name": "Service Agreement 2025",
      "type": "contract",
      "date": "2025-01-15T09:00:00",
      "size": "2.4 MB",
      "status": "active",
    },
    {
      "id": "DOC002",
      "name": "Payment History Q1 2025",
      "type": "invoice",
      "date": "2025-03-31T17:00:00",
      "size": "856 KB",
      "status": "paid",
    },
    {
      "id": "DOC003",
      "name": "Technical Requirements",
      "type": "specification",
      "date": "2025-05-10T11:30:00",
      "size": "1.2 MB",
      "status": "approved",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details"),
        actions: [
          GestureDetector(
            onTap: () => _editCustomer(),
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(Icons.edit),
            ),
          ),
          GestureDetector(
            onTap: () => _showMoreActions(),
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                // Customer Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${customer["avatar"]}",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if ((customer["tags"] as List).contains("VIP"))
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${customer["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${customer["position"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${customer["company"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: customer["status"] == "active"
                                          ? successColor.withAlpha(20)
                                          : dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${customer["status"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: customer["status"] == "active"
                                            ? successColor
                                            : dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${customer["customerType"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      
                      // Customer Rating
                      Row(
                        children: [
                          Text(
                            "Customer Rating: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (customer["rating"] as double).floor()
                                  ? Icons.star
                                  : Icons.star_border,
                                size: 16,
                                color: warningColor,
                              );
                            }),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${customer["rating"]}/5.0",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Customer Tags
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (customer["tags"] as List).map<Widget>((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Quick Stats
                Container(
                  margin: EdgeInsets.all(spMd),
                  padding: EdgeInsets.all(spMd),
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
                              "${customer["totalOrders"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Orders",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((customer["totalSpent"] as double)).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Spent",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((customer["outstandingBalance"] as double)).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: (customer["outstandingBalance"] as double) > 0
                                  ? warningColor
                                  : successColor,
                              ),
                            ),
                            Text(
                              "Outstanding",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Quick Actions
                Container(
                  margin: EdgeInsets.symmetric(horizontal: spMd),
                  child: Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Customer",
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () => _callCustomer(),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Send Email",
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () => _sendEmail(),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "New Order",
                          icon: Icons.add_shopping_cart,
                          size: bs.sm,
                          onPressed: () => _createOrder(),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Tab Navigation
                Container(
                  margin: EdgeInsets.symmetric(horizontal: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
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
                              color: selectedTab == 0 ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Text(
                              "Information",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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
                              color: selectedTab == 1 ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Text(
                              "Orders",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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
                              color: selectedTab == 2 ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Text(
                              "Communications",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = 3;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: selectedTab == 3 ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Text(
                              "Documents",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedTab == 3 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Tab Content
                _buildTabContent(),
              ],
            ),
          ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildInformationTab();
      case 1:
        return _buildOrdersTab();
      case 2:
        return _buildCommunicationsTab();
      case 3:
        return _buildDocumentsTab();
      default:
        return Container();
    }
  }

  Widget _buildInformationTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow("Email", "${customer["email"]}", Icons.email),
          _buildInfoRow("Phone", "${customer["phone"]}", Icons.phone),
          _buildInfoRow("Website", "${customer["website"]}", Icons.web),
          _buildInfoRow("Address", "${customer["address"]}", Icons.location_on),
          
          SizedBox(height: spMd),
          Divider(),
          SizedBox(height: spMd),
          
          Text(
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow("Industry", "${customer["industry"]}", Icons.business),
          _buildInfoRow("Employees", "${customer["employeeCount"]}", Icons.people),
          _buildInfoRow("Annual Revenue", "\$${((customer["annualRevenue"] as double)).currency}", Icons.trending_up),
          _buildInfoRow("Tax ID", "${customer["taxId"]}", Icons.receipt),
          
          SizedBox(height: spMd),
          Divider(),
          SizedBox(height: spMd),
          
          Text(
            "Account Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow("Join Date", "${DateTime.parse(customer["joinDate"] as String).dMMMy}", Icons.calendar_today),
          _buildInfoRow("Last Order", "${DateTime.parse(customer["lastOrderDate"] as String).dMMMy}", Icons.shopping_cart),
          _buildInfoRow("Credit Limit", "\$${((customer["creditLimit"] as double)).currency}", Icons.credit_card),
          _buildInfoRow("Payment Terms", "${customer["preferredPayment"]}", Icons.payment),
          
          SizedBox(height: spMd),
          Divider(),
          SizedBox(height: spMd),
          
          Text(
            "Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${customer["notes"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryColor),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: recentOrders.map((order) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getOrderStatusColor(order["status"] as String).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: _getOrderStatusColor(order["status"] as String),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${order["id"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getOrderStatusColor(order["status"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${order["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: _getOrderStatusColor(order["status"] as String),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${order["type"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${DateTime.parse(order["date"] as String).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${order["items"]} items",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "\$${((order["amount"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
        }).toList(),
      ),
    );
  }

  Widget _buildCommunicationsTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: communications.map((comm) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getCommunicationTypeColor(comm["type"] as String).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getCommunicationIcon(comm["type"] as String),
                    color: _getCommunicationTypeColor(comm["type"] as String),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${comm["subject"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getCommunicationStatusColor(comm["status"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${comm["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: _getCommunicationStatusColor(comm["status"] as String),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${comm["content"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${DateTime.parse(comm["date"] as String).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          if (comm["duration"] != null) ...[
                            SizedBox(width: spMd),
                            Text(
                              "${comm["duration"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          Spacer(),
                          Text(
                            "${comm["direction"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
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
        }).toList(),
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: documents.map((doc) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getDocumentTypeColor(doc["type"] as String).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getDocumentIcon(doc["type"] as String),
                    color: _getDocumentTypeColor(doc["type"] as String),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${doc["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getDocumentStatusColor(doc["status"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${doc["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: _getDocumentStatusColor(doc["status"] as String),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${DateTime.parse(doc["date"] as String).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${doc["size"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () => _downloadDocument(doc),
                            child: Icon(
                              Icons.download,
                              color: primaryColor,
                              size: 20,
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
        }).toList(),
      ),
    );
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "shipped":
        return infoColor;
      case "pending":
        return warningColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCommunicationTypeColor(String type) {
    switch (type) {
      case "email":
        return primaryColor;
      case "call":
        return successColor;
      case "meeting":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCommunicationIcon(String type) {
    switch (type) {
      case "email":
        return Icons.email;
      case "call":
        return Icons.phone;
      case "meeting":
        return Icons.meeting_room;
      default:
        return Icons.chat;
    }
  }

  Color _getCommunicationStatusColor(String status) {
    switch (status) {
      case "sent":
      case "completed":
      case "resolved":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getDocumentTypeColor(String type) {
    switch (type) {
      case "contract":
        return primaryColor;
      case "invoice":
        return successColor;
      case "specification":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getDocumentIcon(String type) {
    switch (type) {
      case "contract":
        return Icons.description;
      case "invoice":
        return Icons.receipt;
      case "specification":
        return Icons.list_alt;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getDocumentStatusColor(String status) {
    switch (status) {
      case "active":
      case "paid":
      case "approved":
        return successColor;
      case "pending":
        return warningColor;
      case "expired":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  void _editCustomer() {
    ss("Opening customer edit form");
  }

  void _showMoreActions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _duplicateCustomer();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.copy, color: primaryColor),
                    SizedBox(width: spMd),
                    Text("Duplicate Customer", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _exportCustomerData();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.download, color: successColor),
                    SizedBox(width: spMd),
                    Text("Export Data", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _mergeCustomer();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.merge, color: infoColor),
                    SizedBox(width: spMd),
                    Text("Merge Customer", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                _deleteCustomer();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: dangerColor),
                    SizedBox(width: spMd),
                    Text("Delete Customer", style: TextStyle(fontSize: 16, color: dangerColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _callCustomer() {
    ss("Calling ${customer["name"]} at ${customer["phone"]}");
  }

  void _sendEmail() {
    ss("Sending email to ${customer["email"]}");
  }

  void _createOrder() {
    ss("Creating new order for ${customer["name"]}");
  }

  void _downloadDocument(Map<String, dynamic> doc) {
    ss("Downloading document: ${doc["name"]}");
  }

  void _duplicateCustomer() {
    ss("Duplicating customer profile");
  }

  void _exportCustomerData() {
    ss("Exporting customer data");
  }

  void _mergeCustomer() {
    ss("Opening customer merge tool");
  }

  void _deleteCustomer() async {
    bool isConfirmed = await confirm("Delete customer ${customer["name"]}? This action cannot be undone.");
    if (isConfirmed) {
      ss("Customer deleted successfully");
    }
  }
}
