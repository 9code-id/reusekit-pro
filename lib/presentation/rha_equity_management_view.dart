import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaEquityManagementView extends StatefulWidget {
  const RhaEquityManagementView({super.key});

  @override
  State<RhaEquityManagementView> createState() => _RhaEquityManagementViewState();
}

class _RhaEquityManagementViewState extends State<RhaEquityManagementView> {
  int currentTab = 0;
  String selectedDepartment = "All";
  String selectedEquityType = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool showVestedOnly = false;

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All"},
    {"label": "Executive", "value": "Executive"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Operations", "value": "Operations"},
  ];

  List<Map<String, dynamic>> equityTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "Stock Options", "value": "Options"},
    {"label": "Restricted Stock", "value": "RSU"},
    {"label": "Performance Stock", "value": "PSU"},
    {"label": "Employee Stock Purchase", "value": "ESPP"},
  ];

  List<Map<String, dynamic>> statusTypes = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Vesting", "value": "Vesting"},
    {"label": "Vested", "value": "Vested"},
    {"label": "Exercised", "value": "Exercised"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> equityGrants = [
    {
      "id": "EG001",
      "employeeId": "EMP001",
      "employeeName": "Sarah Johnson",
      "department": "Executive",
      "position": "VP Sales",
      "equityType": "Options",
      "grantDate": "2023-01-15",
      "totalShares": 5000,
      "vestedShares": 1250,
      "unvestedShares": 3750,
      "exercisedShares": 0,
      "strikePrice": 25.00,
      "currentPrice": 42.50,
      "vestingSchedule": "4 years, 25% annual",
      "cliff": "1 year",
      "expirationDate": "2033-01-15",
      "status": "Vesting",
      "value": 87500.0,
      "gainLoss": 21875.0,
    },
    {
      "id": "EG002",
      "employeeId": "EMP002",
      "employeeName": "David Chen",
      "department": "Engineering",
      "position": "Senior Engineer",
      "equityType": "RSU",
      "grantDate": "2023-03-01",
      "totalShares": 1200,
      "vestedShares": 300,
      "unvestedShares": 900,
      "exercisedShares": 150,
      "strikePrice": 0.00,
      "currentPrice": 42.50,
      "vestingSchedule": "4 years, quarterly",
      "cliff": "1 year",
      "expirationDate": "N/A",
      "status": "Vesting",
      "value": 51000.0,
      "gainLoss": 51000.0,
    },
    {
      "id": "EG003",
      "employeeId": "EMP003",
      "employeeName": "Lisa Rodriguez",
      "department": "Marketing",
      "position": "Marketing Manager",
      "equityType": "Options",
      "grantDate": "2022-06-01",
      "totalShares": 2000,
      "vestedShares": 1500,
      "unvestedShares": 500,
      "exercisedShares": 800,
      "strikePrice": 18.00,
      "currentPrice": 42.50,
      "vestingSchedule": "4 years, 25% annual",
      "cliff": "1 year",
      "expirationDate": "2032-06-01",
      "status": "Vested",
      "value": 85000.0,
      "gainLoss": 49000.0,
    },
    {
      "id": "EG004",
      "employeeId": "EMP004",
      "employeeName": "Michael Brown",
      "department": "Operations",
      "position": "Operations Lead",
      "equityType": "PSU",
      "grantDate": "2023-07-01",
      "totalShares": 800,
      "vestedShares": 0,
      "unvestedShares": 800,
      "exercisedShares": 0,
      "strikePrice": 0.00,
      "currentPrice": 42.50,
      "vestingSchedule": "3 years, performance based",
      "cliff": "1 year",
      "expirationDate": "N/A",
      "status": "Active",
      "value": 34000.0,
      "gainLoss": 34000.0,
    },
  ];

  List<Map<String, dynamic>> vestingEvents = [
    {
      "id": "VE001",
      "employeeId": "EMP001",
      "employeeName": "Sarah Johnson",
      "equityType": "Options",
      "grantId": "EG001",
      "vestingDate": "2025-01-15",
      "sharesVesting": 1250,
      "strikePrice": 25.00,
      "estimatedValue": 21875.0,
      "status": "Upcoming",
      "daysUntil": 15,
    },
    {
      "id": "VE002",
      "employeeId": "EMP002",
      "employeeName": "David Chen",
      "equityType": "RSU",
      "grantId": "EG002",
      "vestingDate": "2025-03-01",
      "sharesVesting": 75,
      "strikePrice": 0.00,
      "estimatedValue": 3187.50,
      "status": "Upcoming",
      "daysUntil": 60,
    },
    {
      "id": "VE003",
      "employeeId": "EMP003",
      "employeeName": "Lisa Rodriguez",
      "equityType": "Options",
      "grantId": "EG003",
      "vestingDate": "2024-12-20",
      "sharesVesting": 500,
      "strikePrice": 18.00,
      "estimatedValue": 12250.0,
      "status": "Processed",
      "daysUntil": 0,
    },
    {
      "id": "VE004",
      "employeeId": "EMP004",
      "employeeName": "Michael Brown",
      "equityType": "PSU",
      "grantId": "EG004",
      "vestingDate": "2025-07-01",
      "sharesVesting": 267,
      "strikePrice": 0.00,
      "estimatedValue": 11347.50,
      "status": "Pending",
      "daysUntil": 180,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Equity Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Grants", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Vesting", icon: Icon(Icons.schedule)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildGrantsTab(),
        _buildVestingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEquityMetrics(),
          _buildStockPrice(),
          _buildQuickActions(),
          _buildUpcomingVesting(),
        ],
      ),
    );
  }

  Widget _buildEquityMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Equity Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildMetricCard(
              "Total Shares Outstanding",
              "125.8K",
              "All equity grants",
              Icons.pie_chart,
              primaryColor,
              "+12.5% this year",
            ),
            _buildMetricCard(
              "Vested Shares",
              "48.2K",
              "38.3% of total",
              Icons.check_circle,
              successColor,
              "Ready to exercise",
            ),
            _buildMetricCard(
              "Current Value",
              "\$5.35M",
              "Market value",
              Icons.trending_up,
              infoColor,
              "Stock: \$42.50",
            ),
            _buildMetricCard(
              "Participants",
              "89",
              "Employees with equity",
              Icons.people,
              warningColor,
              "68% of workforce",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    String trend,
  ) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockPrice() {
    return Container(
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
          Row(
            children: [
              Text(
                "Stock Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "+8.2% YTD",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$42.50",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Current Price",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPriceItem("52W High", "\$45.80", successColor),
                        ),
                        Expanded(
                          child: _buildPriceItem("52W Low", "\$28.90", dangerColor),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPriceItem("Volume", "2.3M", infoColor),
                        ),
                        Expanded(
                          child: _buildPriceItem("Market Cap", "\$1.2B", warningColor),
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
    );
  }

  Widget _buildPriceItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
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
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildActionCard(
              "Grant Equity",
              "Create new equity grant",
              Icons.card_giftcard,
              primaryColor,
              () {
                //navigateTo('CreateEquityGrantView')
              },
            ),
            _buildActionCard(
              "Process Vesting",
              "Handle vesting events",
              Icons.schedule,
              successColor,
              () {
                //navigateTo('ProcessVestingView')
              },
            ),
            _buildActionCard(
              "Stock Split",
              "Manage stock adjustments",
              Icons.call_split,
              infoColor,
              () {
                //navigateTo('StockSplitView')
              },
            ),
            _buildActionCard(
              "Reports",
              "Generate equity reports",
              Icons.assessment,
              warningColor,
              () {
                //navigateTo('EquityReportsView')
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingVesting() {
    List<Map<String, dynamic>> upcomingEvents = vestingEvents
        .where((event) => event["status"] == "Upcoming")
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Upcoming Vesting Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                //navigateTo('VestingCalendarView')
              },
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: upcomingEvents.map((event) {
              Color urgencyColor = (event["daysUntil"] as int) <= 30
                  ? dangerColor
                  : (event["daysUntil"] as int) <= 90
                      ? warningColor
                      : successColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: urgencyColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${event["employeeName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${((event["estimatedValue"] as double) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${event["sharesVesting"]} ${event["equityType"]} shares",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Vests in ${event["daysUntil"]} days",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: urgencyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " • ${event["vestingDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.arrow_forward,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('VestingEventDetailsView')
                      },
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

  Widget _buildGrantsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGrantsFilters(),
          _buildGrantsList(),
        ],
      ),
    );
  }

  Widget _buildGrantsFilters() {
    return Container(
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
              Expanded(
                child: QTextField(
                  label: "Search Employees",
                  value: searchQuery,
                  hint: "Search by name or employee ID",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreateEquityGrantView')
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departments,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Equity Type",
                  items: equityTypes,
                  value: selectedEquityType,
                  onChanged: (value, label) {
                    selectedEquityType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusTypes,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Vested Only",
                      "value": true,
                      "checked": showVestedOnly,
                    }
                  ],
                  value: [
                    if (showVestedOnly)
                      {"label": "Show Vested Only", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    showVestedOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrantsList() {
    List<Map<String, dynamic>> filteredGrants = equityGrants.where((grant) {
      bool matchesSearch = searchQuery.isEmpty ||
          (grant["employeeName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (grant["employeeId"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesDepartment = selectedDepartment == "All" ||
          grant["department"] == selectedDepartment;

      bool matchesType = selectedEquityType == "All" ||
          grant["equityType"] == selectedEquityType;

      bool matchesStatus = selectedStatus == "All" ||
          grant["status"] == selectedStatus;

      bool matchesVested = !showVestedOnly ||
          (grant["vestedShares"] as int) > 0;

      return matchesSearch && matchesDepartment && matchesType && matchesStatus && matchesVested;
    }).toList();

    return Column(
      children: filteredGrants.map((grant) {
        Color statusColor = grant["status"] == "Active"
            ? primaryColor
            : grant["status"] == "Vesting"
                ? successColor
                : grant["status"] == "Vested"
                    ? infoColor
                    : grant["status"] == "Exercised"
                        ? warningColor
                        : disabledBoldColor;

        double vestingProgress = ((grant["vestedShares"] as int) / (grant["totalShares"] as int)) * 100;
        bool isInTheMoney = (grant["currentPrice"] as double) > (grant["strikePrice"] as double);

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${grant["employeeName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${grant["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${grant["employeeId"]} • ${grant["department"]} • ${grant["position"]}",
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
                        "\$${((grant["value"] as double) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${grant["equityType"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Vesting Progress",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${vestingProgress.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: vestingProgress / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    ),
                    Row(
                      children: [
                        Text(
                          "Vested: ${grant["vestedShares"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Total: ${grant["totalShares"]} shares",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildGrantInfoItem(
                    "Strike Price",
                    "\$${(grant["strikePrice"] as double).toStringAsFixed(2)}",
                    Icons.attach_money,
                    grant["equityType"] == "Options" ? primaryColor : disabledBoldColor,
                  ),
                  _buildGrantInfoItem(
                    "Current Price",
                    "\$${(grant["currentPrice"] as double).toStringAsFixed(2)}",
                    Icons.trending_up,
                    isInTheMoney ? successColor : dangerColor,
                  ),
                  _buildGrantInfoItem(
                    "Grant Date",
                    "${grant["grantDate"]}",
                    Icons.calendar_today,
                    infoColor,
                  ),
                  _buildGrantInfoItem(
                    "Gain/Loss",
                    "\$${((grant["gainLoss"] as double) / 1000).toStringAsFixed(0)}K",
                    isInTheMoney ? Icons.trending_up : Icons.trending_down,
                    isInTheMoney ? successColor : dangerColor,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Vesting: ${grant["vestingSchedule"]} • Cliff: ${grant["cliff"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (grant["expirationDate"] != "N/A")
                      Text(
                        "Expires: ${grant["expirationDate"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    if ((grant["exercisedShares"] as int) > 0)
                      Text(
                        "Exercised: ${grant["exercisedShares"]} shares",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('EquityGrantDetailsView')
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('GrantActionsView')
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGrantInfoItem(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVestingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildVestingFilters(),
          _buildVestingEventsList(),
        ],
      ),
    );
  }

  Widget _buildVestingFilters() {
    return Container(
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
              Expanded(
                child: QTextField(
                  label: "Search Events",
                  value: searchQuery,
                  hint: "Search by employee name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.calendar_today,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('VestingCalendarView')
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${vestingEvents.length} vesting events",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Total Value: \$${(vestingEvents.map((e) => e["estimatedValue"] as double).reduce((a, b) => a + b) / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVestingEventsList() {
    return Column(
      children: vestingEvents.map((event) {
        Color statusColor = event["status"] == "Processed"
            ? successColor
            : event["status"] == "Upcoming"
                ? warningColor
                : event["status"] == "Pending"
                    ? infoColor
                    : disabledBoldColor;

        Color urgencyColor = (event["daysUntil"] as int) <= 30
            ? dangerColor
            : (event["daysUntil"] as int) <= 90
                ? warningColor
                : successColor;

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
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
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 50,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${event["employeeName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${event["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${event["equityType"]} • Grant ${event["grantId"]}",
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
                        "\$${((event["estimatedValue"] as double) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${event["sharesVesting"]} shares",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: urgencyColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: urgencyColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Vesting Date: ${event["vestingDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: urgencyColor,
                      ),
                    ),
                    if ((event["daysUntil"] as int) > 0) ...[
                      Text(
                        " • ${event["daysUntil"]} days remaining",
                        style: TextStyle(
                          fontSize: 12,
                          color: urgencyColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if ((event["strikePrice"] as double) > 0)
                Row(
                  children: [
                    Text(
                      "Strike Price: \$${(event["strikePrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Current Price: \$42.50",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: event["status"] == "Processed" ? "View Details" : "Process",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('VestingEventDetailsView')
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.receipt,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('VestingDocumentsView')
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEquityAnalytics(),
          _buildEquityDistribution(),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildEquityAnalytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Equity Analytics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildAnalyticsCard(
              "Dilution Rate",
              "12.8%",
              "Total equity dilution",
              Icons.pie_chart,
              warningColor,
              "125.8K shares outstanding",
            ),
            _buildAnalyticsCard(
              "Exercise Rate",
              "68.2%",
              "Of vested options exercised",
              Icons.trending_up,
              successColor,
              "Higher than industry avg",
            ),
            _buildAnalyticsCard(
              "Retention Impact",
              "94.5%",
              "Equity holder retention",
              Icons.people_alt,
              infoColor,
              "vs 78% without equity",
            ),
            _buildAnalyticsCard(
              "Underwater Options",
              "8.3%",
              "Options below strike price",
              Icons.trending_down,
              dangerColor,
              "Consider repricing",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    String trend,
  ) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquityDistribution() {
    List<Map<String, dynamic>> distributionData = [
      {
        "type": "Stock Options",
        "shares": 65000,
        "percentage": 51.7,
        "value": 2762500.0,
        "color": primaryColor,
      },
      {
        "type": "Restricted Stock",
        "shares": 35000,
        "percentage": 27.8,
        "value": 1487500.0,
        "color": successColor,
      },
      {
        "type": "Performance Stock",
        "shares": 18000,
        "percentage": 14.3,
        "value": 765000.0,
        "color": infoColor,
      },
      {
        "type": "ESPP",
        "shares": 7800,
        "percentage": 6.2,
        "value": 331500.0,
        "color": warningColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Equity Distribution by Type",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: distributionData.map((data) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: data["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${data["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(data["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${((data["shares"] as int) / 1000).toStringAsFixed(0)}K shares",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${((data["value"] as double) / 1000000).toStringAsFixed(1)}M value",
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
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics() {
    List<Map<String, dynamic>> performanceData = [
      {"metric": "Stock Price Growth", "value": "+68.5%", "period": "Last 12 months"},
      {"metric": "Employee Participation", "value": "89/131", "period": "68% participation rate"},
      {"metric": "Average Grant Value", "value": "\$60.1K", "period": "Per employee"},
      {"metric": "Vesting Completion", "value": "38.3%", "period": "Of total grants"},
      {"metric": "Exercise Activity", "value": "68.2%", "period": "Of vested options"},
      {"metric": "Retention Rate", "value": "94.5%", "period": "Equity holders"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Performance Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: performanceData.map((metric) {
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
                  Text(
                    "${metric["metric"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${metric["value"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${metric["period"]}",
                    style: TextStyle(
                      fontSize: 11,
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
}
