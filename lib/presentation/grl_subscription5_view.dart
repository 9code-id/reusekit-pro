import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription5View extends StatefulWidget {
  @override
  State<GrlSubscription5View> createState() => _GrlSubscription5ViewState();
}

class _GrlSubscription5ViewState extends State<GrlSubscription5View> {
  List<Map<String, dynamic>> subscriptions = [
    {
      "id": "netflix",
      "name": "Netflix",
      "category": "Entertainment",
      "price": 15.99,
      "period": "month",
      "nextBilling": "2025-07-15",
      "status": "active",
      "icon": Icons.movie,
      "color": dangerColor,
      "description": "Premium streaming service",
    },
    {
      "id": "spotify",
      "name": "Spotify Premium",
      "category": "Music",
      "price": 9.99,
      "period": "month",
      "nextBilling": "2025-07-08",
      "status": "active",
      "icon": Icons.music_note,
      "color": successColor,
      "description": "Music streaming platform",
    },
    {
      "id": "adobe",
      "name": "Adobe Creative Cloud",
      "category": "Design",
      "price": 52.99,
      "period": "month",
      "nextBilling": "2025-07-25",
      "status": "active",
      "icon": Icons.design_services,
      "color": primaryColor,
      "description": "Creative suite for professionals",
    },
    {
      "id": "github",
      "name": "GitHub Pro",
      "category": "Development",
      "price": 4.00,
      "period": "month",
      "nextBilling": "2025-07-10",
      "status": "active",
      "icon": Icons.code,
      "color": disabledBoldColor,
      "description": "Code repository hosting",
    },
    {
      "id": "notion",
      "name": "Notion Pro",
      "category": "Productivity",
      "price": 8.00,
      "period": "month",
      "nextBilling": "2025-07-20",
      "status": "cancelled",
      "icon": Icons.note,
      "color": warningColor,
      "description": "All-in-one workspace",
    },
  ];

  String selectedCategory = "All";
  String selectedPeriod = "All";
  
  List<String> categories = ["All", "Entertainment", "Music", "Design", "Development", "Productivity"];
  List<String> periods = ["All", "Monthly", "Annual"];

  @override
  Widget build(BuildContext context) {
    final filteredSubscriptions = _getFilteredSubscriptions();
    final totalMonthly = _calculateTotalMonthly();
    final totalAnnual = _calculateTotalAnnual();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("My Subscriptions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Add new subscription");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOverviewCards(totalMonthly, totalAnnual),
            _buildFilters(),
            _buildSubscriptionList(filteredSubscriptions),
            _buildInsights(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCards(double totalMonthly, double totalAnnual) {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Monthly",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$${totalMonthly.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${subscriptions.where((s) => s["status"] == "active").length} active",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [secondaryColor, secondaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Annual",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$${totalAnnual.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "projected yearly",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter & Sort",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods.map((period) => {"label": period, "value": period}).toList(),
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
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

  Widget _buildSubscriptionList(List<Map<String, dynamic>> filteredSubs) {
    if (filteredSubs.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No subscriptions found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Subscriptions (${filteredSubs.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: filteredSubs.map((subscription) {
              final nextBilling = DateTime.parse(subscription["nextBilling"]);
              final daysUntilBilling = nextBilling.difference(DateTime.now()).inDays;
              final isActive = subscription["status"] == "active";
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isActive ? Colors.grey.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isActive ? disabledOutlineBorderColor : dangerColor.withAlpha(100),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (subscription["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            subscription["icon"] as IconData,
                            color: subscription["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${subscription["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isActive ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isActive ? successColor : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      isActive ? "ACTIVE" : "CANCELLED",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${subscription["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(subscription["price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isActive ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            Text(
                              "/${subscription["period"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (isActive)
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: daysUntilBilling <= 7 ? warningColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Next billing in $daysUntilBilling days",
                            style: TextStyle(
                              fontSize: 12,
                              color: daysUntilBilling <= 7 ? warningColor : disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Row(
                            spacing: spXs,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  si("Manage ${subscription["name"]}");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Manage",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool isConfirmed = await confirm("Cancel ${subscription["name"]} subscription?");
                                  if (isConfirmed) {
                                    subscription["status"] = "cancelled";
                                    setState(() {});
                                    ss("Subscription cancelled");
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (!isActive)
                      Row(
                        children: [
                          Icon(
                            Icons.cancel,
                            size: 14,
                            color: dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Subscription cancelled",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              subscription["status"] = "active";
                              setState(() {});
                              ss("Subscription reactivated");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Reactivate",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
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
    );
  }

  Widget _buildInsights() {
    final categorySpending = _getCategorySpending();
    final upcomingBills = _getUpcomingBills();
    
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Spending by Category",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: categorySpending.entries.map((entry) {
                  final percentage = (entry.value / _calculateTotalMonthly()) * 100;
                  return Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${entry.value.toStringAsFixed(2)} (${percentage.toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: percentage / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Upcoming Bills (Next 7 Days)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (upcomingBills.isEmpty)
                Text(
                  "No bills due in the next 7 days",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                )
              else
                Column(
                  spacing: spXs,
                  children: upcomingBills.map((bill) {
                    final daysUntil = DateTime.parse(bill["nextBilling"]).difference(DateTime.now()).inDays;
                    return Row(
                      children: [
                        Icon(
                          bill["icon"] as IconData,
                          size: 16,
                          color: bill["color"] as Color,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${bill["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(bill["price"] as double).toStringAsFixed(2)} in $daysUntil days",
                          style: TextStyle(
                            fontSize: 12,
                            color: daysUntil <= 3 ? dangerColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
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
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  child: QButton(
                    label: "Add Subscription",
                    size: bs.sm,
                    onPressed: () {
                      si("Add new subscription");
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: QButton(
                    label: "Export Data",
                    size: bs.sm,
                    onPressed: () {
                      ss("Data exported successfully");
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  child: QButton(
                    label: "Set Budget",
                    size: bs.sm,
                    onPressed: () {
                      si("Budget settings");
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: QButton(
                    label: "Notifications",
                    size: bs.sm,
                    onPressed: () {
                      si("Notification settings");
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredSubscriptions() {
    return subscriptions.where((sub) {
      bool categoryMatch = selectedCategory == "All" || sub["category"] == selectedCategory;
      bool periodMatch = selectedPeriod == "All" || 
          (selectedPeriod == "Monthly" && sub["period"] == "month") ||
          (selectedPeriod == "Annual" && sub["period"] == "year");
      return categoryMatch && periodMatch;
    }).toList();
  }

  double _calculateTotalMonthly() {
    return subscriptions
        .where((sub) => sub["status"] == "active")
        .fold(0.0, (sum, sub) => sum + (sub["price"] as double));
  }

  double _calculateTotalAnnual() {
    return _calculateTotalMonthly() * 12;
  }

  Map<String, double> _getCategorySpending() {
    Map<String, double> spending = {};
    for (var sub in subscriptions.where((s) => s["status"] == "active")) {
      String category = sub["category"];
      spending[category] = (spending[category] ?? 0) + (sub["price"] as double);
    }
    return spending;
  }

  List<Map<String, dynamic>> _getUpcomingBills() {
    final now = DateTime.now();
    final sevenDaysFromNow = now.add(Duration(days: 7));
    
    return subscriptions
        .where((sub) => 
            sub["status"] == "active" && 
            DateTime.parse(sub["nextBilling"]).isBefore(sevenDaysFromNow))
        .toList()
        ..sort((a, b) => DateTime.parse(a["nextBilling"]).compareTo(DateTime.parse(b["nextBilling"])));
  }
}
