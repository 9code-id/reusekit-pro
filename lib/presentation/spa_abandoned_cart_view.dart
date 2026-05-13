import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaAbandonedCartView extends StatefulWidget {
  const SpaAbandonedCartView({super.key});

  @override
  State<SpaAbandonedCartView> createState() => _SpaAbandonedCartViewState();
}

class _SpaAbandonedCartViewState extends State<SpaAbandonedCartView> {
  int selectedTab = 0;
  String searchQuery = "";
  String statusFilter = "All";
  String timeFilter = "Last 30 Days";
  String sortBy = "Most Recent";
  
  List<String> statusOptions = ["All", "Recent", "Recoverable", "Lost", "Recovered"];
  List<String> timeOptions = ["Last 7 Days", "Last 30 Days", "Last 90 Days", "All Time"];
  List<String> sortOptions = ["Most Recent", "Cart Value", "Customer Name", "Abandon Time"];

  List<Map<String, dynamic>> abandonedCarts = [
    {
      "id": "CART-2024-001",
      "customerName": "Emma Thompson",
      "customerEmail": "emma.thompson@email.com",
      "customerPhone": "+1 (555) 123-4567",
      "abandonedDate": "2024-12-15 14:30",
      "cartValue": 485.90,
      "itemCount": 3,
      "status": "Recoverable",
      "recoveryAttempts": 1,
      "lastContact": "2024-12-16 10:00",
      "stage": "Payment",
      "items": [
        {"name": "Aromatherapy Massage Oil Set", "price": 189.99, "quantity": 1},
        {"name": "Luxury Spa Towel Collection", "price": 149.95, "quantity": 2},
        {"name": "Premium Face Mask Kit", "price": 95.96, "quantity": 1}
      ],
      "customerHistory": {
        "totalOrders": 8,
        "totalSpent": 2450.75,
        "avgOrderValue": 306.34,
        "lastOrder": "2024-11-20"
      }
    },
    {
      "id": "CART-2024-002",
      "customerName": "Michael Rodriguez",
      "customerEmail": "m.rodriguez@email.com",
      "customerPhone": "+1 (555) 234-5678",
      "abandonedDate": "2024-12-14 16:45",
      "cartValue": 320.50,
      "itemCount": 2,
      "status": "Recent",
      "recoveryAttempts": 0,
      "lastContact": null,
      "stage": "Shipping",
      "items": [
        {"name": "Professional Massage Tools", "price": 225.00, "quantity": 1},
        {"name": "Relaxation Candle Set", "price": 95.50, "quantity": 1}
      ],
      "customerHistory": {
        "totalOrders": 3,
        "totalSpent": 890.25,
        "avgOrderValue": 296.75,
        "lastOrder": "2024-10-15"
      }
    },
    {
      "id": "CART-2024-003",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "customerPhone": "+1 (555) 345-6789",
      "abandonedDate": "2024-12-13 11:20",
      "cartValue": 165.75,
      "itemCount": 4,
      "status": "Lost",
      "recoveryAttempts": 3,
      "lastContact": "2024-12-14 09:30",
      "stage": "Browse",
      "items": [
        {"name": "Essential Oil Starter Kit", "price": 75.00, "quantity": 2},
        {"name": "Spa Gift Card", "price": 50.00, "quantity": 1},
        {"name": "Aromatherapy Diffuser", "price": 40.75, "quantity": 1}
      ],
      "customerHistory": {
        "totalOrders": 12,
        "totalSpent": 3200.50,
        "avgOrderValue": 266.71,
        "lastOrder": "2024-09-28"
      }
    },
    {
      "id": "CART-2024-004",
      "customerName": "Jessica Chen",
      "customerEmail": "j.chen@email.com",
      "customerPhone": "+1 (555) 456-7890",
      "abandonedDate": "2024-12-12 19:15",
      "cartValue": 750.25,
      "itemCount": 5,
      "status": "Recovered",
      "recoveryAttempts": 2,
      "lastContact": "2024-12-13 14:00",
      "stage": "Payment",
      "items": [
        {"name": "Luxury Spa Package", "price": 450.00, "quantity": 1},
        {"name": "Premium Skincare Set", "price": 189.99, "quantity": 1},
        {"name": "Spa Accessory Bundle", "price": 110.26, "quantity": 1}
      ],
      "customerHistory": {
        "totalOrders": 15,
        "totalSpent": 4850.75,
        "avgOrderValue": 323.38,
        "lastOrder": "2024-12-13"
      }
    }
  ];

  List<Map<String, dynamic>> recoveryTemplates = [
    {
      "id": "template_1",
      "name": "Gentle Reminder",
      "type": "Email",
      "subject": "You left something special behind...",
      "timing": "1 hour after abandon",
      "conversionRate": 12.5,
      "usage": 245
    },
    {
      "id": "template_2", 
      "name": "Discount Incentive",
      "type": "Email",
      "subject": "Complete your purchase & save 10%",
      "timing": "24 hours after abandon",
      "conversionRate": 18.3,
      "usage": 189
    },
    {
      "id": "template_3",
      "name": "Limited Time Offer",
      "type": "SMS",
      "subject": "Items in your cart are selling fast!",
      "timing": "3 days after abandon",
      "conversionRate": 22.1,
      "usage": 156
    },
    {
      "id": "template_4",
      "name": "Personal Touch",
      "type": "Phone Call",
      "subject": "Personal consultation offer",
      "timing": "7 days after abandon",
      "conversionRate": 35.7,
      "usage": 78
    }
  ];

  Map<String, dynamic> analyticsData = {
    "totalAbandonedCarts": 1247,
    "totalAbandonedValue": 428750.95,
    "averageCartValue": 343.85,
    "recoveryRate": 28.4,
    "totalRecovered": 354,
    "recoveredValue": 121830.50,
    "revenueRecovered": 121830.50,
    "averageRecoveryTime": "2.3 days",
    "topAbandonStage": "Payment (45%)",
    "monthlyTrend": [
      {"month": "Jan", "abandoned": 98, "recovered": 28, "value": 33840.50},
      {"month": "Feb", "abandoned": 112, "recovered": 35, "value": 38520.75},
      {"month": "Mar", "abandoned": 89, "recovered": 25, "value": 30585.25},
      {"month": "Apr", "abandoned": 105, "recovered": 32, "value": 36120.00},
      {"month": "May", "abandoned": 126, "recovered": 38, "value": 43290.50},
      {"month": "Jun", "abandoned": 134, "recovered": 41, "value": 46085.75},
      {"month": "Jul", "abandoned": 118, "recovered": 34, "value": 40570.25},
      {"month": "Aug", "abandoned": 142, "recovered": 45, "value": 48830.00},
      {"month": "Sep", "abandoned": 156, "recovered": 48, "value": 53640.75},
      {"month": "Oct", "abandoned": 168, "recovered": 52, "value": 57780.50},
      {"month": "Nov", "abandoned": 145, "recovered": 43, "value": 49865.25},
      {"month": "Dec", "abandoned": 154, "recovered": 48, "value": 52965.50}
    ]
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Abandoned Cart Recovery",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Abandoned Carts", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Recovery", icon: Icon(Icons.restore)),
        Tab(text: "Templates", icon: Icon(Icons.email)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildAbandonedCartsTab(),
        _buildRecoveryTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildAbandonedCartsTab() {
    List<Map<String, dynamic>> filteredCarts = abandonedCarts.where((cart) {
      bool matchesSearch = cart["customerName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          cart["customerEmail"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          cart["id"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = statusFilter == "All" || cart["status"] == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QTextField(
                  label: "Search abandoned carts...",
                  value: searchQuery,
                  hint: "Customer name, email, or cart ID",
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
                        items: statusOptions.map((status) => {"label": status, "value": status}).toList(),
                        value: statusFilter,
                        onChanged: (value, label) {
                          statusFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: timeOptions.map((time) => {"label": time, "value": time}).toList(),
                        value: timeFilter,
                        onChanged: (value, label) {
                          timeFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort By",
                        items: sortOptions.map((sort) => {"label": sort, "value": sort}).toList(),
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildQuickStat("Total Abandoned", "${abandonedCarts.length}", warningColor, Icons.shopping_cart_outlined),
                _buildQuickStat("Recoverable", "${abandonedCarts.where((c) => c["status"] == "Recoverable").length}", successColor, Icons.restore),
                _buildQuickStat("Lost Value", "\$${abandonedCarts.fold(0.0, (sum, cart) => sum + (cart["cartValue"] as double)).currency}", dangerColor, Icons.trending_down),
                _buildQuickStat("Avg Cart Value", "\$${(abandonedCarts.fold(0.0, (sum, cart) => sum + (cart["cartValue"] as double)) / abandonedCarts.length).currency}", primaryColor, Icons.attach_money),
              ],
            ),
          ),

          // Abandoned Carts List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Abandoned Carts (${filteredCarts.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Bulk Recovery",
                      size: bs.sm,
                      icon: Icons.email,
                      onPressed: () {
                        _bulkRecoveryAction();
                      },
                    ),
                  ],
                ),
                ...filteredCarts.map((cart) => _buildAbandonedCartCard(cart)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Recovery Campaign Setup
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Recovery Campaign Setup",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Campaign Name",
                  value: "",
                  hint: "Enter campaign name",
                  onChanged: (value) {},
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Target Audience",
                        items: [
                          {"label": "All Abandoned Carts", "value": "all"},
                          {"label": "High Value Carts", "value": "high_value"},
                          {"label": "Repeat Customers", "value": "repeat"},
                          {"label": "New Customers", "value": "new"},
                        ],
                        value: "all",
                        onChanged: (value, label) {},
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Recovery Method",
                        items: [
                          {"label": "Email", "value": "email"},
                          {"label": "SMS", "value": "sms"},
                          {"label": "Phone Call", "value": "phone"},
                          {"label": "Multi-Channel", "value": "multi"},
                        ],
                        value: "email",
                        onChanged: (value, label) {},
                      ),
                    ),
                  ],
                ),
                QButton(
                  label: "Launch Campaign",
                  size: bs.md,
                  icon: Icons.launch,
                  onPressed: () {
                    _launchRecoveryCampaign();
                  },
                ),
              ],
            ),
          ),

          // Active Recovery Campaigns
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Active Recovery Campaigns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildRecoveryCampaignCard("Holiday Recovery Campaign", "Email", "Active", 145, 28, 19.3),
                _buildRecoveryCampaignCard("VIP Customer Recovery", "Multi-Channel", "Active", 89, 31, 34.8),
                _buildRecoveryCampaignCard("Weekend Special Recovery", "SMS", "Paused", 67, 12, 17.9),
              ],
            ),
          ),

          // Recovery Performance
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Recovery Performance",
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
                    _buildPerformanceCard("Total Recovered", "354", "\$121,831", successColor, Icons.restore),
                    _buildPerformanceCard("Recovery Rate", "28.4%", "+5.2% vs last month", primaryColor, Icons.trending_up),
                    _buildPerformanceCard("Avg Recovery Time", "2.3 days", "-0.5 days improvement", infoColor, Icons.schedule),
                    _buildPerformanceCard("Best Method", "Phone Call", "35.7% conversion", warningColor, Icons.phone),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Create New Template
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Recovery Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Create Template",
                      size: bs.sm,
                      icon: Icons.add,
                      onPressed: () {
                        _createTemplate();
                      },
                    ),
                  ],
                ),
                Text(
                  "Create and manage email templates for cart recovery campaigns",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Template List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Email Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...recoveryTemplates.map((template) => _buildTemplateCard(template)).toList(),
              ],
            ),
          ),

          // Template Performance
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Template Performance",
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
                    _buildTemplatePerformanceCard("Best Performer", "Personal Touch", "35.7%", successColor),
                    _buildTemplatePerformanceCard("Most Used", "Gentle Reminder", "245 times", primaryColor),
                    _buildTemplatePerformanceCard("Highest Open Rate", "Limited Time Offer", "68.5%", infoColor),
                    _buildTemplatePerformanceCard("Best Timing", "24 hours", "18.3% avg rate", warningColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Key Metrics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Key Metrics",
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
                    _buildMetricCard("Total Abandoned", "${analyticsData["totalAbandonedCarts"]}", "carts this year", dangerColor, Icons.shopping_cart_outlined),
                    _buildMetricCard("Abandoned Value", "\$${(analyticsData["totalAbandonedValue"] as double).currency}", "potential revenue", warningColor, Icons.trending_down),
                    _buildMetricCard("Recovery Rate", "${analyticsData["recoveryRate"]}%", "conversion rate", successColor, Icons.restore),
                    _buildMetricCard("Revenue Recovered", "\$${(analyticsData["revenueRecovered"] as double).currency}", "this year", primaryColor, Icons.trending_up),
                  ],
                ),
              ],
            ),
          ),

          // Monthly Trends
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Monthly Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Abandoned vs Recovered Carts",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Abandoned",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Recovered",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Expanded(
                        child: QHorizontalScroll(
                          children: (analyticsData["monthlyTrend"] as List).map((month) {
                            return Container(
                              width: 80,
                              margin: EdgeInsets.only(right: spSm),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: ((month["abandoned"] as int) / 170 * 200).toDouble(),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Container(
                                          width: 30,
                                          height: ((month["recovered"] as int) / 170 * 200).toDouble(),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${month["month"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Abandon Reasons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Common Abandon Reasons",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildReasonBar("High Shipping Costs", 0.35, dangerColor),
                _buildReasonBar("Unexpected Fees", 0.28, warningColor),
                _buildReasonBar("Complex Checkout", 0.22, infoColor),
                _buildReasonBar("Payment Issues", 0.18, primaryColor),
                _buildReasonBar("Just Browsing", 0.15, successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbandonedCartCard(Map<String, dynamic> cart) {
    Color statusColor = cart["status"] == "Recoverable" ? successColor :
                       cart["status"] == "Recent" ? primaryColor :
                       cart["status"] == "Recovered" ? infoColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: statusColor.withAlpha(60)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: statusColor,
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
                          "${cart["customerName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${cart["status"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${cart["customerEmail"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildCartDetail("Cart Value", "\$${(cart["cartValue"] as double).currency}", primaryColor, Icons.attach_money),
              ),
              Expanded(
                child: _buildCartDetail("Items", "${cart["itemCount"]}", infoColor, Icons.inventory),
              ),
              Expanded(
                child: _buildCartDetail("Stage", "${cart["stage"]}", warningColor, Icons.place),
              ),
              Expanded(
                child: _buildCartDetail("Attempts", "${cart["recoveryAttempts"]}", successColor, Icons.email),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Send Recovery Email",
                  size: bs.sm,
                  icon: Icons.email,
                  onPressed: () {
                    _sendRecoveryEmail(cart);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  icon: Icons.info,
                  color: infoColor,
                  onPressed: () {
                    _viewCartDetails(cart);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                color: successColor,
                onPressed: () {
                  _callCustomer(cart);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartDetail(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryCampaignCard(String name, String method, String status, int sent, int recovered, double rate) {
    Color statusColor = status == "Active" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.campaign,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$method • $sent sent • $recovered recovered • $rate% rate",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              template["type"] == "Email" ? Icons.email :
              template["type"] == "SMS" ? Icons.sms :
              Icons.phone,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${template["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${template["timing"]} • ${template["conversionRate"]}% conversion • Used ${template["usage"]} times",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              _editTemplate(template);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatePerformanceCard(String title, String value, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonBar(String reason, double percentage, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                reason,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(percentage * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
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
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bulkRecoveryAction() {
    ss("Launching bulk recovery campaign...");
  }

  void _sendRecoveryEmail(Map<String, dynamic> cart) {
    ss("Sending recovery email to ${cart["customerName"]}...");
  }

  void _viewCartDetails(Map<String, dynamic> cart) {
    ss("Viewing cart details for ${cart["id"]}...");
  }

  void _callCustomer(Map<String, dynamic> cart) {
    ss("Calling ${cart["customerName"]} at ${cart["customerPhone"]}...");
  }

  void _launchRecoveryCampaign() {
    ss("Launching new recovery campaign...");
  }

  void _createTemplate() {
    ss("Creating new recovery template...");
  }

  void _editTemplate(Map<String, dynamic> template) {
    ss("Editing template: ${template["name"]}...");
  }
}
