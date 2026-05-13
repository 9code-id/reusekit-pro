import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaCorporateAccountsView extends StatefulWidget {
  const HhaCorporateAccountsView({super.key});

  @override
  State<HhaCorporateAccountsView> createState() => _HhaCorporateAccountsViewState();
}

class _HhaCorporateAccountsViewState extends State<HhaCorporateAccountsView> {
  String selectedStatus = "All";
  String searchQuery = "";
  String selectedCategory = "All";

  List<Map<String, dynamic>> corporateAccounts = [
    {
      "id": "CA001",
      "companyName": "TechCorp Solutions",
      "industry": "Technology",
      "contactPerson": "Sarah Johnson",
      "email": "sarah.johnson@techcorp.com",
      "phone": "+1-555-0123",
      "address": "123 Tech Street, Silicon Valley, CA 94000",
      "accountManager": "John Smith",
      "contractValue": 150000.0,
      "discountRate": 20,
      "creditLimit": 50000.0,
      "currentBalance": 12500.0,
      "status": "Active",
      "contractStart": "2024-01-01",
      "contractEnd": "2024-12-31",
      "totalBookings": 45,
      "totalRevenue": 87500.0,
      "paymentTerms": "Net 30",
      "preferredRooms": ["Executive Suite", "Business Deluxe"],
      "specialServices": ["Airport Transfer", "Conference Room", "Catering"],
    },
    {
      "id": "CA002",
      "companyName": "Global Manufacturing Inc",
      "industry": "Manufacturing",
      "contactPerson": "Michael Chen",
      "email": "m.chen@globalmanuf.com",
      "phone": "+1-555-0456",
      "address": "456 Industrial Blvd, Detroit, MI 48000",
      "accountManager": "Lisa Brown",
      "contractValue": 200000.0,
      "discountRate": 25,
      "creditLimit": 75000.0,
      "currentBalance": 8900.0,
      "status": "Active",
      "contractStart": "2023-06-01",
      "contractEnd": "2025-05-31",
      "totalBookings": 78,
      "totalRevenue": 145000.0,
      "paymentTerms": "Net 15",
      "preferredRooms": ["Standard Business", "Executive Suite"],
      "specialServices": ["Equipment Storage", "Early Check-in", "Extended Hours"],
    },
    {
      "id": "CA003",
      "companyName": "Healthcare Partners",
      "industry": "Healthcare",
      "contactPerson": "Dr. Emily Davis",
      "email": "e.davis@healthpartners.com",
      "phone": "+1-555-0789",
      "address": "789 Medical Center Dr, Houston, TX 77000",
      "accountManager": "David Wilson",
      "contractValue": 120000.0,
      "discountRate": 18,
      "creditLimit": 40000.0,
      "currentBalance": 15600.0,
      "status": "Active",
      "contractStart": "2024-03-01",
      "contractEnd": "2025-02-28",
      "totalBookings": 32,
      "totalRevenue": 58000.0,
      "paymentTerms": "Net 45",
      "preferredRooms": ["Standard", "Deluxe"],
      "specialServices": ["Medical Equipment Storage", "Quiet Floors", "24/7 Room Service"],
    },
    {
      "id": "CA004",
      "companyName": "Financial Advisors LLC",
      "industry": "Finance",
      "contactPerson": "Robert Taylor",
      "email": "r.taylor@finadvisors.com",
      "phone": "+1-555-0321",
      "address": "321 Wall Street, New York, NY 10000",
      "accountManager": "Jennifer Lee",
      "contractValue": 180000.0,
      "discountRate": 22,
      "creditLimit": 60000.0,
      "currentBalance": 22100.0,
      "status": "Pending Review",
      "contractStart": "2024-01-15",
      "contractEnd": "2024-12-31",
      "totalBookings": 56,
      "totalRevenue": 98000.0,
      "paymentTerms": "Net 30",
      "preferredRooms": ["Executive Suite", "Premium Business"],
      "specialServices": ["Private Dining", "Meeting Rooms", "Concierge Services"],
    },
    {
      "id": "CA005",
      "companyName": "Education Solutions Corp",
      "industry": "Education",
      "contactPerson": "Maria Rodriguez",
      "email": "m.rodriguez@edusolutions.com",
      "phone": "+1-555-0654",
      "address": "654 Campus Drive, Boston, MA 02000",
      "accountManager": "Tom Anderson",
      "contractValue": 95000.0,
      "discountRate": 15,
      "creditLimit": 30000.0,
      "currentBalance": 5400.0,
      "status": "Suspended",
      "contractStart": "2023-09-01",
      "contractEnd": "2024-08-31",
      "totalBookings": 28,
      "totalRevenue": 42000.0,
      "paymentTerms": "Net 60",
      "preferredRooms": ["Standard", "Group Rooms"],
      "specialServices": ["Group Rates", "Educational Discounts", "Flexible Cancellation"],
    },
  ];

  List<Map<String, dynamic>> get filteredAccounts {
    return corporateAccounts.where((account) {
      final matchesStatus = selectedStatus == "All" || account["status"] == selectedStatus;
      final matchesCategory = selectedCategory == "All" || account["industry"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          (account["companyName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["contactPerson"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          account["id"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesCategory && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending Review":
        return warningColor;
      case "Suspended":
        return dangerColor;
      case "Expired":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corporate Accounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateCorporateAccountView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Dashboard Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.business,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Accounts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${corporateAccounts.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active Accounts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${corporateAccounts.where((acc) => acc["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Contract Value",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((corporateAccounts.fold(0.0, (sum, acc) => sum + (acc["contractValue"] as double))) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Outstanding Balance",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((corporateAccounts.fold(0.0, (sum, acc) => sum + (acc["currentBalance"] as double))) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search and Filters
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search accounts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "Active", "value": "Active"},
                          {"label": "Pending Review", "value": "Pending Review"},
                          {"label": "Suspended", "value": "Suspended"},
                          {"label": "Expired", "value": "Expired"},
                        ],
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
                        label: "Industry",
                        items: [
                          {"label": "All", "value": "All"},
                          {"label": "Technology", "value": "Technology"},
                          {"label": "Manufacturing", "value": "Manufacturing"},
                          {"label": "Healthcare", "value": "Healthcare"},
                          {"label": "Finance", "value": "Finance"},
                          {"label": "Education", "value": "Education"},
                        ],
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Accounts List
            ...filteredAccounts.map((account) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${account["companyName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${account["industry"]} • ID: ${account["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                              color: getStatusColor(account["status"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${account["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Contact Information
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${account["contactPerson"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Account Manager: ${account["accountManager"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.email, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${account["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${account["phone"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Contract Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contract Value",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((account["contractValue"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discount Rate",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${account["discountRate"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Credit Limit",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((account["creditLimit"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Performance Metrics
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Bookings",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${account["totalBookings"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Revenue",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((account["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Balance",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((account["currentBalance"] as double) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Contract Period
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "Contract: ${account["contractStart"]} - ${account["contractEnd"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Payment Terms: ${account["paymentTerms"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('CorporateAccountDetailView', arguments: account)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Manage",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('ManageCorporateAccountView', arguments: account)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              //showAccountOptionsMenu(account)
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
