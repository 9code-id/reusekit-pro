import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomerManagementView extends StatefulWidget {
  const PosCustomerManagementView({super.key});

  @override
  State<PosCustomerManagementView> createState() => _PosCustomerManagementViewState();
}

class _PosCustomerManagementViewState extends State<PosCustomerManagementView> {
  int currentTab = 0;

  // Customer Statistics
  Map<String, dynamic> customerStats = {
    "totalCustomers": 2847,
    "newThisMonth": 156,
    "activeCustomers": 1923,
    "vipCustomers": 84,
    "totalOrders": 15420,
    "totalRevenue": 847650.50,
    "averageOrderValue": 54.95,
    "repeatCustomers": 1456,
  };

  // Recent Activities
  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "registration",
      "customer": "Sarah Johnson",
      "action": "New customer registered",
      "timestamp": "2024-06-19T10:30:00",
      "icon": Icons.person_add,
      "color": successColor,
    },
    {
      "type": "purchase",
      "customer": "Mike Wilson",
      "action": "Completed purchase of \$127.50",
      "timestamp": "2024-06-19T09:45:00",
      "icon": Icons.shopping_cart,
      "color": primaryColor,
    },
    {
      "type": "vip_upgrade",
      "customer": "Emma Davis",
      "action": "Upgraded to VIP status",
      "timestamp": "2024-06-19T08:20:00",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "type": "complaint",
      "customer": "John Smith",
      "action": "Filed a complaint - Order #12345",
      "timestamp": "2024-06-18T16:30:00",
      "icon": Icons.report_problem,
      "color": dangerColor,
    },
    {
      "type": "review",
      "customer": "Lisa Chen",
      "action": "Left a 5-star review",
      "timestamp": "2024-06-18T14:15:00",
      "icon": Icons.star_rate,
      "color": successColor,
    },
  ];

  // Customer Segments
  List<Map<String, dynamic>> customerSegments = [
    {
      "name": "VIP Customers",
      "count": 84,
      "percentage": 2.9,
      "revenue": 289750.00,
      "color": warningColor,
      "description": "High-value customers with premium benefits",
    },
    {
      "name": "Regular Customers",
      "count": 1839,
      "percentage": 64.6,
      "revenue": 485900.50,
      "color": primaryColor,
      "description": "Active customers with regular purchases",
    },
    {
      "name": "New Customers",
      "count": 156,
      "percentage": 5.5,
      "revenue": 12750.00,
      "color": successColor,
      "description": "Customers registered in the last 30 days",
    },
    {
      "name": "Inactive Customers",
      "count": 768,
      "percentage": 27.0,
      "revenue": 59250.00,
      "color": disabledBoldColor,
      "description": "Customers with no activity in 90+ days",
    },
  ];

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Stats Cards
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Customers",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${customerStats["totalCustomers"]}",
                        style: TextStyle(
                          fontSize: fsH4,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_add,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "New This Month",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${customerStats["newThisMonth"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "VIP Customers",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${customerStats["vipCustomers"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((customerStats["totalRevenue"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Customer Segments
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Segments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...customerSegments.map((segment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: segment["color"],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${segment["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: segment["color"].withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${(segment["percentage"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: segment["color"],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${segment["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${segment["count"]} customers",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${((segment["revenue"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Recent Activities
          Container(
            padding: EdgeInsets.all(spSm),
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
                      "Recent Activities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('CustomerActivitiesView')
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...recentActivities.take(5).map((activity) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spXs),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: activity["color"].withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            activity["icon"],
                            size: 16,
                            color: activity["color"],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["customer"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${activity["action"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${DateTime.parse(activity["timestamp"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomersTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "All Customers",
                  icon: Icons.people,
                  onPressed: () {
                    //navigateTo('PosCustomerListView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Customer",
                  icon: Icons.person_add,
                  onPressed: () {
                    //navigateTo('PosAddCustomerView')
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Search Customers",
                  icon: Icons.search,
                  onPressed: () {
                    //navigateTo('PosCustomerSearchView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "VIP Customers",
                  icon: Icons.star,
                  onPressed: () {
                    //navigateTo('VipCustomersView')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Metrics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance Metrics",
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
                      child: Column(
                        children: [
                          Text(
                            "${customerStats["totalOrders"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Orders",
                            textAlign: TextAlign.center,
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
                            "\$${((customerStats["averageOrderValue"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Avg Order Value",
                            textAlign: TextAlign.center,
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
                            "${customerStats["repeatCustomers"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Repeat Customers",
                            textAlign: TextAlign.center,
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
              ],
            ),
          ),

          // Report Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Generate Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spXs,
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Customer Demographics Report",
                        icon: Icons.analytics,
                        onPressed: () {
                          //navigateTo('CustomerDemographicsReportView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Customer Lifetime Value Report",
                        icon: Icons.trending_up,
                        onPressed: () {
                          //navigateTo('CustomerLtvReportView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Customer Segmentation Report",
                        icon: Icons.pie_chart,
                        onPressed: () {
                          //navigateTo('CustomerSegmentationReportView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Inactive Customers Report",
                        icon: Icons.warning,
                        onPressed: () {
                          //navigateTo('InactiveCustomersReportView')
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Customers", icon: Icon(Icons.people)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCustomersTab(),
        _buildReportsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
