import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsDashboardView extends StatefulWidget {
  const DmsDashboardView({super.key});

  @override
  State<DmsDashboardView> createState() => _DmsDashboardViewState();
}

class _DmsDashboardViewState extends State<DmsDashboardView> {
  int selectedTabIndex = 0;
  String selectedPeriod = "This Month";
  bool loading = false;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> overviewStats = [
    {
      "title": "Total Sales",
      "value": "\$2,847,500",
      "change": "+12.5%",
      "changeType": "positive",
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Vehicles Sold",
      "value": "187",
      "change": "+8.2%",
      "changeType": "positive",
      "icon": Icons.directions_car,
      "color": primaryColor,
    },
    {
      "title": "Service Orders",
      "value": "342",
      "change": "+15.3%",
      "changeType": "positive",
      "icon": Icons.build,
      "color": infoColor,
    },
    {
      "title": "Customer Satisfaction",
      "value": "94.8%",
      "change": "+2.1%",
      "changeType": "positive",
      "icon": Icons.star,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> recentSales = [
    {
      "customer": "John Smith",
      "vehicle": "2024 Honda Accord",
      "price": 32500.0,
      "date": "2024-01-15",
      "status": "Completed",
      "salesperson": "Mike Johnson",
    },
    {
      "customer": "Sarah Wilson",
      "vehicle": "2024 Toyota Camry",
      "price": 28750.0,
      "date": "2024-01-14",
      "status": "Pending",
      "salesperson": "Lisa Chen",
    },
    {
      "customer": "Robert Davis",
      "vehicle": "2024 BMW X5",
      "price": 65200.0,
      "date": "2024-01-14",
      "status": "Completed",
      "salesperson": "David Brown",
    },
    {
      "customer": "Emily Johnson",
      "vehicle": "2024 Mercedes C-Class",
      "price": 48900.0,
      "date": "2024-01-13",
      "status": "In Progress",
      "salesperson": "Jennifer Lee",
    },
  ];

  List<Map<String, dynamic>> inventoryAlerts = [
    {
      "vehicle": "2024 Honda Civic",
      "stock": 2,
      "threshold": 5,
      "status": "Low Stock",
      "priority": "High",
    },
    {
      "vehicle": "2024 Toyota RAV4",
      "stock": 1,
      "threshold": 3,
      "status": "Critical",
      "priority": "Critical",
    },
    {
      "vehicle": "2024 Ford F-150",
      "stock": 3,
      "threshold": 8,
      "status": "Low Stock",
      "priority": "Medium",
    },
  ];

  List<Map<String, dynamic>> serviceAppointments = [
    {
      "customer": "Mark Thompson",
      "service": "Oil Change",
      "time": "09:00 AM",
      "date": "2024-01-15",
      "technician": "Tom Wilson",
      "status": "Scheduled",
    },
    {
      "customer": "Lisa Garcia",
      "service": "Brake Inspection",
      "time": "10:30 AM",
      "date": "2024-01-15",
      "technician": "Alex Johnson",
      "status": "In Progress",
    },
    {
      "customer": "James Miller",
      "service": "Engine Diagnostics",
      "time": "02:00 PM",
      "date": "2024-01-15",
      "technician": "Sarah Davis",
      "status": "Scheduled",
    },
  ];

  List<Map<String, dynamic>> salesTargets = [
    {
      "period": "Daily",
      "target": 12,
      "achieved": 8,
      "percentage": 66.7,
    },
    {
      "period": "Weekly",
      "target": 50,
      "achieved": 42,
      "percentage": 84.0,
    },
    {
      "period": "Monthly",
      "target": 200,
      "achieved": 187,
      "percentage": 93.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "DMS Dashboard",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sales", icon: Icon(Icons.point_of_sale)),
        Tab(text: "Service", icon: Icon(Icons.build)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSalesTab(),
        _buildServiceTab(),
        _buildInventoryTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodFilter(),
          _buildOverviewStats(),
          _buildQuickActions(),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildSalesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSalesTargets(),
          _buildRecentSales(),
          _buildSalesChart(),
        ],
      ),
    );
  }

  Widget _buildServiceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildServiceStats(),
          _buildTodayAppointments(),
          _buildServiceMetrics(),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInventoryOverview(),
          _buildInventoryAlerts(),
          _buildTopSellingVehicles(),
        ],
      ),
    );
  }

  Widget _buildPeriodFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Text(
            "Period:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              items: periodItems,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 200,
          children: overviewStats.map((stat) {
            return Container(
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          stat["icon"],
                          color: stat["color"],
                          size: 24,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: stat["changeType"] == "positive" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${stat["change"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: stat["changeType"] == "positive" ? successColor : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${stat["value"]}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${stat["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {
        "title": "New Sale",
        "icon": Icons.add_shopping_cart,
        "color": primaryColor,
        "description": "Record new vehicle sale",
      },
      {
        "title": "Service Appointment",
        "icon": Icons.schedule,
        "color": infoColor,
        "description": "Schedule service",
      },
      {
        "title": "Add Vehicle",
        "icon": Icons.directions_car,
        "color": successColor,
        "description": "Add to inventory",
      },
      {
        "title": "Customer Management",
        "icon": Icons.people,
        "color": warningColor,
        "description": "Manage customers",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 200,
          children: actions.map((action) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (action["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      action["icon"],
                      color: action["color"],
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${action["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${action["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: List.generate(4, (index) {
              List<Map<String, dynamic>> activities = [
                {
                  "type": "Sale",
                  "description": "John Smith purchased 2024 Honda Accord",
                  "time": "2 hours ago",
                  "icon": Icons.shopping_cart,
                  "color": successColor,
                },
                {
                  "type": "Service",
                  "description": "Oil change completed for Lisa Garcia",
                  "time": "4 hours ago",
                  "icon": Icons.build,
                  "color": infoColor,
                },
                {
                  "type": "Inventory",
                  "description": "Low stock alert: 2024 Honda Civic",
                  "time": "6 hours ago",
                  "icon": Icons.warning,
                  "color": warningColor,
                },
                {
                  "type": "Customer",
                  "description": "New customer registration: Emily Johnson",
                  "time": "8 hours ago",
                  "icon": Icons.person_add,
                  "color": primaryColor,
                },
              ];

              final activity = activities[index];
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index < activities.length - 1 ? disabledOutlineBorderColor : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (activity["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        activity["icon"],
                        color: activity["color"],
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: activity["color"],
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${activity["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSalesTargets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sales Targets",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: salesTargets.map((target) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${target["period"]} Target",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${target["achieved"]}/${target["target"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (target["percentage"] as num) / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (target["percentage"] as num) >= 90 ? successColor : 
                        (target["percentage"] as num) >= 70 ? warningColor : dangerColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(target["percentage"] as num).toStringAsFixed(1)}% Complete",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Sales",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: recentSales.map((sale) {
              Color statusColor = sale["status"] == "Completed" ? successColor :
                                 sale["status"] == "Pending" ? warningColor : infoColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: recentSales.indexOf(sale) < recentSales.length - 1 ? 
                             disabledOutlineBorderColor : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sale["customer"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${sale["vehicle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Sales: ${sale["salesperson"]}",
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
                          "\$${((sale["price"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${sale["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${sale["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSalesChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sales Performance Chart",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          height: 200,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Sales Chart Placeholder",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Chart component would be integrated here",
                  textAlign: TextAlign.center,
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
    );
  }

  Widget _buildServiceStats() {
    List<Map<String, dynamic>> serviceStats = [
      {
        "title": "Today's Appointments",
        "value": "23",
        "icon": Icons.schedule,
        "color": infoColor,
      },
      {
        "title": "In Progress",
        "value": "8",
        "icon": Icons.build,
        "color": warningColor,
      },
      {
        "title": "Completed Today",
        "value": "15",
        "icon": Icons.check_circle,
        "color": successColor,
      },
      {
        "title": "Average Time",
        "value": "2.5h",
        "icon": Icons.timer,
        "color": primaryColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 200,
          children: serviceStats.map((stat) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      stat["icon"],
                      color: stat["color"],
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${stat["value"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${stat["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTodayAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Appointments",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: serviceAppointments.map((appointment) {
              Color statusColor = appointment["status"] == "Completed" ? successColor :
                                 appointment["status"] == "In Progress" ? infoColor : warningColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: serviceAppointments.indexOf(appointment) < serviceAppointments.length - 1 ? 
                             disabledOutlineBorderColor : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.schedule,
                        color: statusColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${appointment["customer"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${appointment["service"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Tech: ${appointment["technician"]}",
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
                          "${appointment["time"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${appointment["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
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
        ),
      ],
    );
  }

  Widget _buildServiceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          height: 200,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Service Metrics Chart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Service performance analytics would be displayed here",
                  textAlign: TextAlign.center,
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
    );
  }

  Widget _buildInventoryOverview() {
    List<Map<String, dynamic>> inventoryStats = [
      {
        "title": "Total Vehicles",
        "value": "248",
        "icon": Icons.directions_car,
        "color": primaryColor,
      },
      {
        "title": "Low Stock",
        "value": "12",
        "icon": Icons.warning,
        "color": warningColor,
      },
      {
        "title": "New Arrivals",
        "value": "8",
        "icon": Icons.new_releases,
        "color": successColor,
      },
      {
        "title": "Sold This Month",
        "value": "187",
        "icon": Icons.trending_up,
        "color": infoColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 200,
          children: inventoryStats.map((stat) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      stat["icon"],
                      color: stat["color"],
                      size: 32,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${stat["value"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${stat["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInventoryAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Alerts",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: inventoryAlerts.map((alert) {
              Color priorityColor = alert["priority"] == "Critical" ? dangerColor :
                                   alert["priority"] == "High" ? warningColor : infoColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: priorityColor,
                    ),
                    bottom: BorderSide(
                      color: inventoryAlerts.indexOf(alert) < inventoryAlerts.length - 1 ? 
                             disabledOutlineBorderColor : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.warning,
                        color: priorityColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alert["vehicle"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${alert["status"]} - Stock: ${alert["stock"]}/${alert["threshold"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${alert["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTopSellingVehicles() {
    List<Map<String, dynamic>> topVehicles = [
      {
        "model": "2024 Honda Accord",
        "sold": 45,
        "stock": 12,
        "revenue": 1432500.0,
      },
      {
        "model": "2024 Toyota Camry",
        "sold": 38,
        "stock": 8,
        "revenue": 1092500.0,
      },
      {
        "model": "2024 BMW X5",
        "sold": 22,
        "stock": 5,
        "revenue": 1434400.0,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Selling Vehicles",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: topVehicles.map((vehicle) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: topVehicles.indexOf(vehicle) < topVehicles.length - 1 ? 
                             disabledOutlineBorderColor : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.directions_car,
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
                            "${vehicle["model"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Sold: ${vehicle["sold"]} | Stock: ${vehicle["stock"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((vehicle["revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
