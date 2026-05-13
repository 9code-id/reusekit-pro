import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription10View extends StatefulWidget {
  @override
  State<GrlSubscription10View> createState() => _GrlSubscription10ViewState();
}

class _GrlSubscription10ViewState extends State<GrlSubscription10View> {
  bool loading = false;
  int currentPeriod = 0;
  String selectedCategory = "All";
  String selectedPlan = "";
  bool showExpiredPlans = false;
  
  List<Map<String, dynamic>> subscriptionReports = [
    {
      "period": "January 2025",
      "totalSpent": 2450.00,
      "activeSubscriptions": 12,
      "newSubscriptions": 3,
      "cancelledSubscriptions": 1,
      "savings": 320.00,
      "subscriptions": [
        {
          "name": "Netflix Premium",
          "category": "Entertainment",
          "amount": 199.00,
          "status": "Active",
          "nextBilling": "2025-02-15",
          "usage": 85,
          "savings": 0.00
        },
        {
          "name": "Spotify Family",
          "category": "Music",
          "amount": 79.00,
          "status": "Active",
          "nextBilling": "2025-02-12",
          "usage": 92,
          "savings": 20.00
        },
        {
          "name": "Adobe Creative Cloud",
          "category": "Productivity",
          "amount": 899.00,
          "status": "Active",
          "nextBilling": "2025-02-20",
          "usage": 78,
          "savings": 100.00
        },
        {
          "name": "Microsoft 365",
          "category": "Productivity",
          "amount": 169.00,
          "status": "Active",
          "nextBilling": "2025-02-18",
          "usage": 95,
          "savings": 0.00
        },
        {
          "name": "Dropbox Pro",
          "category": "Storage",
          "amount": 119.00,
          "status": "Active",
          "nextBilling": "2025-02-25",
          "usage": 67,
          "savings": 0.00
        }
      ]
    },
    {
      "period": "December 2024",
      "totalSpent": 2280.00,
      "activeSubscriptions": 10,
      "newSubscriptions": 2,
      "cancelledSubscriptions": 3,
      "savings": 450.00,
      "subscriptions": [
        {
          "name": "Netflix Premium",
          "category": "Entertainment",
          "amount": 199.00,
          "status": "Active",
          "nextBilling": "2025-01-15",
          "usage": 82,
          "savings": 0.00
        },
        {
          "name": "Spotify Family",
          "category": "Music",
          "amount": 79.00,
          "status": "Active",
          "nextBilling": "2025-01-12",
          "usage": 88,
          "savings": 20.00
        },
        {
          "name": "Amazon Prime",
          "category": "Shopping",
          "amount": 149.00,
          "status": "Cancelled",
          "nextBilling": "",
          "usage": 45,
          "savings": 149.00
        },
        {
          "name": "YouTube Premium",
          "category": "Entertainment",
          "amount": 119.00,
          "status": "Cancelled",
          "nextBilling": "",
          "usage": 35,
          "savings": 119.00
        }
      ]
    },
    {
      "period": "November 2024",
      "totalSpent": 2680.00,
      "activeSubscriptions": 11,
      "newSubscriptions": 1,
      "cancelledSubscriptions": 2,
      "savings": 280.00,
      "subscriptions": [
        {
          "name": "Netflix Premium",
          "category": "Entertainment",
          "amount": 199.00,
          "status": "Active",
          "nextBilling": "2024-12-15",
          "usage": 91,
          "savings": 0.00
        },
        {
          "name": "Disney+ Hotstar",
          "category": "Entertainment",
          "amount": 89.00,
          "status": "Active",
          "nextBilling": "2024-12-22",
          "usage": 72,
          "savings": 30.00
        },
        {
          "name": "Canva Pro",
          "category": "Design",
          "amount": 149.00,
          "status": "Active",
          "nextBilling": "2024-12-28",
          "usage": 84,
          "savings": 50.00
        }
      ]
    }
  ];

  List<String> categories = [
    "All",
    "Entertainment", 
    "Music",
    "Productivity",
    "Storage",
    "Shopping",
    "Design"
  ];

  List<Map<String, dynamic>> get filteredSubscriptions {
    var currentData = subscriptionReports[currentPeriod];
    var subscriptions = currentData["subscriptions"] as List<Map<String, dynamic>>;
    
    var filtered = subscriptions.where((sub) {
      bool categoryMatch = selectedCategory == "All" || 
                          sub["category"] == selectedCategory;
      bool statusMatch = showExpiredPlans || sub["status"] != "Cancelled";
      bool planMatch = selectedPlan.isEmpty || 
                      (sub["name"] as String).toLowerCase().contains(selectedPlan.toLowerCase());
      
      return categoryMatch && statusMatch && planMatch;
    }).toList();
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    var currentData = subscriptionReports[currentPeriod];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Analytics"),
        actions: [
          GestureDetector(
            onTap: () => _exportReport(),
            child: Container(
              padding: EdgeInsets.all(spXs),
              child: Icon(Icons.download),
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _shareReport(),
            child: Container(
              padding: EdgeInsets.all(spXs),
              child: Icon(Icons.share),
            ),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reporting Period",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: List.generate(subscriptionReports.length, (index) {
                      final period = subscriptionReports[index];
                      final isSelected = currentPeriod == index;
                      
                      return GestureDetector(
                        onTap: () {
                          currentPeriod = index;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          margin: EdgeInsets.only(
                            right: index < subscriptionReports.length - 1 ? spSm : 0,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${period["period"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Summary Cards
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Period Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Total Spent",
                          "\$${((currentData["totalSpent"] as num).toDouble()).currency}",
                          Icons.attach_money,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Active Plans",
                          "${currentData["activeSubscriptions"]}",
                          Icons.subscriptions,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "New This Period",
                          "${currentData["newSubscriptions"]}",
                          Icons.add_circle,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Total Savings",
                          "\$${((currentData["savings"] as num).toDouble()).currency}",
                          Icons.savings,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search Subscriptions",
                    value: selectedPlan,
                    hint: "Enter subscription name...",
                    onChanged: (value) {
                      selectedPlan = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories.map((cat) => {
                            "label": cat,
                            "value": cat,
                          }).toList(),
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          label: "Show Cancelled",
                          items: [
                            {
                              "label": "Include cancelled subscriptions",
                              "value": true,
                              "checked": showExpiredPlans,
                            }
                          ],
                          value: [
                            if (showExpiredPlans)
                              {
                                "label": "Include cancelled subscriptions",
                                "value": true,
                                "checked": true,
                              }
                          ],
                          onChanged: (values, ids) {
                            showExpiredPlans = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Subscription List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subscription Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredSubscriptions.length} subscriptions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  if (filteredSubscriptions.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No subscriptions found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredSubscriptions.map((subscription) {
                        return _buildSubscriptionItem(subscription);
                      }).toList(),
                    ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Usage Analytics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Usage Analytics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Column(
                    children: filteredSubscriptions.where((sub) => sub["status"] == "Active").map((subscription) {
                      return _buildUsageItem(subscription);
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    onPressed: () => _generateDetailedReport(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set Alerts",
                    onPressed: () => _setupAlerts(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionItem(Map<String, dynamic> subscription) {
    Color statusColor = subscription["status"] == "Active" ? successColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
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
                    Text(
                      "${subscription["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${subscription["category"]}",
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
                    "\$${((subscription["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
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
                      "${subscription["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          if (subscription["status"] == "Active") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Billing",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${subscription["nextBilling"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if ((subscription["savings"] as num) > 0) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Savings",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((subscription["savings"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsageItem(Map<String, dynamic> subscription) {
    int usage = subscription["usage"] as int;
    Color usageColor = usage >= 80 ? successColor : 
                      usage >= 50 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${subscription["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "$usage% usage",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: usageColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: usage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: usageColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exportReport() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Report exported successfully");
  }

  void _shareReport() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    si("Report shared successfully");
  }

  void _generateDetailedReport() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Detailed report generated successfully");
  }

  void _setupAlerts() async {
    bool isConfirmed = await confirm("Do you want to set up spending alerts for your subscriptions?");
    
    if (isConfirmed) {
      loading = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Subscription alerts configured successfully");
    }
  }
}
