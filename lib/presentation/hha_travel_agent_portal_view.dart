import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaTravelAgentPortalView extends StatefulWidget {
  const HhaTravelAgentPortalView({super.key});

  @override
  State<HhaTravelAgentPortalView> createState() => _HhaTravelAgentPortalViewState();
}

class _HhaTravelAgentPortalViewState extends State<HhaTravelAgentPortalView> {
  String selectedTab = "Dashboard";
  String selectedStatus = "All";

  List<Map<String, dynamic>> travelAgents = [
    {
      "id": "TA001",
      "agencyName": "Global Travel Solutions",
      "agentName": "Emma Thompson",
      "email": "emma@globaltravelsolutions.com",
      "phone": "+1-555-0123",
      "country": "United States",
      "city": "New York",
      "status": "Active",
      "tier": "Premium",
      "commissionRate": 12.5,
      "totalBookings": 156,
      "totalRevenue": 245000.0,
      "pendingCommission": 18500.0,
      "joinDate": "2023-01-15",
      "lastActivity": "2024-06-14",
      "specialties": ["Corporate Travel", "Group Bookings", "Luxury Tours"],
      "performanceRating": 4.8,
    },
    {
      "id": "TA002",
      "agencyName": "Adventure Seekers Agency",
      "agentName": "Carlos Rodriguez",
      "email": "carlos@adventureseekers.com",
      "phone": "+34-666-789123",
      "country": "Spain",
      "city": "Barcelona",
      "status": "Active",
      "tier": "Standard",
      "commissionRate": 10.0,
      "totalBookings": 89,
      "totalRevenue": 132000.0,
      "pendingCommission": 8900.0,
      "joinDate": "2023-03-22",
      "lastActivity": "2024-06-13",
      "specialties": ["Adventure Tours", "Family Packages", "Cultural Trips"],
      "performanceRating": 4.6,
    },
    {
      "id": "TA003",
      "agencyName": "Business Travel Pro",
      "agentName": "Sarah Kim",
      "email": "sarah@businesstravelpro.com",
      "phone": "+82-10-1234-5678",
      "country": "South Korea",
      "city": "Seoul",
      "status": "Active",
      "tier": "Premium",
      "commissionRate": 15.0,
      "totalBookings": 203,
      "totalRevenue": 387000.0,
      "pendingCommission": 24500.0,
      "joinDate": "2022-11-08",
      "lastActivity": "2024-06-15",
      "specialties": ["Corporate Travel", "Executive Packages", "Conference Bookings"],
      "performanceRating": 4.9,
    },
    {
      "id": "TA004",
      "agencyName": "Luxury Escapes Ltd",
      "agentName": "James Wilson",
      "email": "james@luxuryescapes.co.uk",
      "phone": "+44-20-7123-4567",
      "country": "United Kingdom",
      "city": "London",
      "status": "Pending",
      "tier": "Premium",
      "commissionRate": 12.0,
      "totalBookings": 67,
      "totalRevenue": 189000.0,
      "pendingCommission": 15200.0,
      "joinDate": "2024-01-10",
      "lastActivity": "2024-06-10",
      "specialties": ["Luxury Travel", "Honeymoon Packages", "VIP Services"],
      "performanceRating": 4.7,
    },
    {
      "id": "TA005",
      "agencyName": "Family Fun Travel",
      "agentName": "Lisa Chen",
      "email": "lisa@familyfuntravel.com",
      "phone": "+1-555-0987",
      "country": "Canada",
      "city": "Toronto",
      "status": "Inactive",
      "tier": "Standard",
      "commissionRate": 8.5,
      "totalBookings": 34,
      "totalRevenue": 58000.0,
      "pendingCommission": 2800.0,
      "joinDate": "2023-08-17",
      "lastActivity": "2024-04-20",
      "specialties": ["Family Packages", "Theme Parks", "Educational Tours"],
      "performanceRating": 4.3,
    },
  ];

  List<Map<String, dynamic>> get filteredAgents {
    return travelAgents.where((agent) {
      final matchesStatus = selectedStatus == "All" || agent["status"] == selectedStatus;
      return matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getTierColor(String tier) {
    switch (tier) {
      case "Premium":
        return primaryColor;
      case "Standard":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Agent Portal"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('AddTravelAgentView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Dashboard", "value": "Dashboard"},
                {"label": "Agents", "value": "Agents"},
                {"label": "Commissions", "value": "Commissions"},
                {"label": "Reports", "value": "Reports"},
              ],
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  if (selectedTab == "Dashboard") ...[
                    // Dashboard Stats
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
                                  Icon(Icons.people, color: primaryColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Total Agents",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${travelAgents.length}",
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
                                  Icon(Icons.trending_up, color: successColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Active Agents",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${travelAgents.where((a) => a["status"] == "Active").length}",
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
                                  Icon(Icons.attach_money, color: infoColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Total Revenue",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${((travelAgents.fold(0.0, (sum, a) => sum + (a["totalRevenue"] as double))) / 1000).toStringAsFixed(0)}K",
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
                                  Icon(Icons.account_balance_wallet, color: warningColor, size: 20),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Pending Commissions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${((travelAgents.fold(0.0, (sum, a) => sum + (a["pendingCommission"] as double))) / 1000).toStringAsFixed(1)}K",
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

                    // Recent Activity
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
                            "Top Performing Agents",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          ...travelAgents
                              .where((a) => a["status"] == "Active")
                              .take(3)
                              .map((agent) {
                            return Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${agent["agentName"]}".substring(0, 1).toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${agent["agentName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${agent["agencyName"]}",
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
                                      "\$${((agent["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${agent["performanceRating"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],

                  if (selectedTab == "Agents") ...[
                    // Filter
                    QDropdownField(
                      label: "Filter by Status",
                      items: [
                        {"label": "All", "value": "All"},
                        {"label": "Active", "value": "Active"},
                        {"label": "Pending", "value": "Pending"},
                        {"label": "Inactive", "value": "Inactive"},
                      ],
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),

                    // Agents List
                    ...filteredAgents.map((agent) {
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
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${agent["agentName"]}".substring(0, 1).toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${agent["agentName"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${agent["agencyName"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${agent["city"]}, ${agent["country"]}",
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: getStatusColor(agent["status"]),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${agent["status"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: getTierColor(agent["tier"]),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${agent["tier"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Performance Metrics
                              ResponsiveGridView(
                                padding: EdgeInsets.zero,
                                minItemWidth: 200,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
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
                                          "${agent["totalBookings"]}",
                                          style: TextStyle(
                                            fontSize: 16,
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
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
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
                                          "\$${((agent["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                                          style: TextStyle(
                                            fontSize: 16,
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
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Commission Rate",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${agent["commissionRate"]}%",
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

                              // Specialties
                              if ((agent["specialties"] as List).isNotEmpty) ...[
                                Text(
                                  "Specialties:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (agent["specialties"] as List<String>).map((specialty) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        specialty,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],

                              // Actions
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        //navigateTo('TravelAgentDetailView', arguments: agent)
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: "Manage",
                                      size: bs.sm,
                                      onPressed: () {
                                        //navigateTo('ManageTravelAgentView', arguments: agent)
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],

                  if (selectedTab == "Commissions") ...[
                    // Commission Summary
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
                            "Commission Summary",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          ...travelAgents.map((agent) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${agent["agentName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${agent["agencyName"]}",
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
                                      "\$${((agent["pendingCommission"] as double) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      "${agent["commissionRate"]}% rate",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],

                  if (selectedTab == "Reports") ...[
                    // Reports Section
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
                            "Performance Reports",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Generate detailed reports on travel agent performance, commissions, and booking trends.",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          QButton(
                            label: "Generate Report",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('GenerateReportView')
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
