import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaThirdPartyIntegrationView extends StatefulWidget {
  const FmaThirdPartyIntegrationView({super.key});

  @override
  State<FmaThirdPartyIntegrationView> createState() => _FmaThirdPartyIntegrationViewState();
}

class _FmaThirdPartyIntegrationViewState extends State<FmaThirdPartyIntegrationView> {
  int currentTab = 0;
  
  List<Map<String, dynamic>> integrations = [
    {
      "name": "Uber Eats",
      "type": "Delivery Platform",
      "status": "Connected",
      "revenue": 1250.75,
      "orders": 45,
      "commission": 15.0,
      "logo": "https://picsum.photos/60/60?random=1&keyword=uber",
      "color": "#000000",
      "lastSync": "2 minutes ago",
      "features": ["Order Management", "Menu Sync", "Analytics"],
    },
    {
      "name": "DoorDash",
      "type": "Delivery Platform",
      "status": "Connected",
      "revenue": 980.50,
      "orders": 32,
      "commission": 18.0,
      "logo": "https://picsum.photos/60/60?random=2&keyword=food",
      "color": "#FF3008",
      "lastSync": "5 minutes ago",
      "features": ["Order Management", "Menu Sync", "Promotions"],
    },
    {
      "name": "Grubhub",
      "type": "Delivery Platform",
      "status": "Disconnected",
      "revenue": 0.0,
      "orders": 0,
      "commission": 20.0,
      "logo": "https://picsum.photos/60/60?random=3&keyword=delivery",
      "color": "#F63440",
      "lastSync": "Never",
      "features": ["Order Management", "Menu Sync"],
    },
    {
      "name": "Square POS",
      "type": "Payment System",
      "status": "Connected",
      "revenue": 2847.25,
      "orders": 127,
      "commission": 2.9,
      "logo": "https://picsum.photos/60/60?random=4&keyword=payment",
      "color": "#3E4348",
      "lastSync": "Just now",
      "features": ["Payment Processing", "Inventory Sync", "Analytics"],
    },
    {
      "name": "Stripe",
      "type": "Payment Processor",
      "status": "Connected",
      "revenue": 1567.80,
      "orders": 89,
      "commission": 2.9,
      "logo": "https://picsum.photos/60/60?random=5&keyword=stripe",
      "color": "#635BFF",
      "lastSync": "1 minute ago",
      "features": ["Online Payments", "Subscriptions", "Reporting"],
    },
    {
      "name": "Mailchimp",
      "type": "Email Marketing",
      "status": "Connected",
      "revenue": 0.0,
      "orders": 0,
      "commission": 0.0,
      "logo": "https://picsum.photos/60/60?random=6&keyword=email",
      "color": "#FFE01B",
      "lastSync": "30 minutes ago",
      "features": ["Email Campaigns", "Customer Segmentation", "Analytics"],
    },
    {
      "name": "QuickBooks",
      "type": "Accounting",
      "status": "Pending",
      "revenue": 0.0,
      "orders": 0,
      "commission": 0.0,
      "logo": "https://picsum.photos/60/60?random=7&keyword=accounting",
      "color": "#0077C5",
      "lastSync": "Never",
      "features": ["Financial Reporting", "Tax Management", "Invoicing"],
    },
    {
      "name": "Google My Business",
      "type": "Local Listing",
      "status": "Connected",
      "revenue": 0.0,
      "orders": 23,
      "commission": 0.0,
      "logo": "https://picsum.photos/60/60?random=8&keyword=google",
      "color": "#4285F4",
      "lastSync": "10 minutes ago",
      "features": ["Business Listing", "Reviews Management", "Local SEO"],
    },
  ];

  List<Map<String, dynamic>> availableIntegrations = [
    {
      "name": "Postmates",
      "type": "Delivery Platform",
      "description": "Connect with Postmates delivery network",
      "logo": "https://picsum.photos/60/60?random=9&keyword=postmates",
      "commission": 22.0,
      "features": ["Order Management", "Real-time Tracking"],
    },
    {
      "name": "Yelp",
      "type": "Review Platform",
      "description": "Manage your Yelp business profile and reviews",
      "logo": "https://picsum.photos/60/60?random=10&keyword=reviews",
      "commission": 0.0,
      "features": ["Review Management", "Business Profile", "Analytics"],
    },
    {
      "name": "Toast POS",
      "type": "Point of Sale",
      "description": "Restaurant-specific POS system integration",
      "logo": "https://picsum.photos/60/60?random=11&keyword=pos",
      "commission": 2.5,
      "features": ["POS Integration", "Kitchen Display", "Staff Management"],
    },
    {
      "name": "OpenTable",
      "type": "Reservation System",
      "description": "Table booking and reservation management",
      "logo": "https://picsum.photos/60/60?random=12&keyword=reservation",
      "commission": 0.0,
      "features": ["Table Reservations", "Guest Management", "Waitlist"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Third-Party Integrations",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Connected", icon: Icon(Icons.link)),
        Tab(text: "Available", icon: Icon(Icons.add_link)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildConnectedTab(),
        _buildAvailableTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildConnectedTab() {
    List<Map<String, dynamic>> connectedIntegrations = integrations
        .where((integration) => integration["status"] == "Connected")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Integration Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${connectedIntegrations.length} Active Integrations",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "All systems operational and syncing properly",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Sync All",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Connected Integrations List
          Text(
            "Active Integrations",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Column(
            spacing: spSm,
            children: connectedIntegrations.map((integration) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    // Integration Header
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${integration["logo"]}",
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
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
                                    "${integration["name"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${integration["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${integration["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Last sync: ${integration["lastSync"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            QButton(
                              icon: Icons.settings,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(height: spXs),
                            QButton(
                              icon: Icons.sync,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Integration Stats
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "\$${(integration["revenue"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Revenue",
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
                                  "${integration["orders"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Orders",
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
                                  "${(integration["commission"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Commission",
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
                    ),

                    // Features
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (integration["features"] as List<String>).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Action Buttons
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Configure",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "View Logs",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Disconnect",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Pending/Disconnected Integrations
          if (integrations.any((i) => i["status"] != "Connected"))
            Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Setup",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: integrations
                      .where((integration) => integration["status"] != "Connected")
                      .map((integration) {
                    Color statusColor = integration["status"] == "Pending" ? warningColor : dangerColor;
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${integration["logo"]}",
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${integration["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${integration["type"]} • ${integration["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: integration["status"] == "Pending" ? "Complete Setup" : "Reconnect",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAvailableTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.add_circle, color: primaryColor, size: 32),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expand Your Reach",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Connect with popular platforms to increase sales and streamline operations",
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
          ),

          // Category Filter
          QCategoryPicker(
            label: "Filter by Category",
            items: [
              {"label": "All", "value": "all"},
              {"label": "Delivery Platforms", "value": "delivery"},
              {"label": "Payment Systems", "value": "payment"},
              {"label": "Marketing Tools", "value": "marketing"},
              {"label": "Analytics", "value": "analytics"},
            ],
            value: "all",
            onChanged: (index, label, value, item) {},
          ),

          // Available Integrations
          Text(
            "Available Integrations",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.all(spSm),
            minItemWidth: 200,
            children: availableIntegrations.map((integration) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Integration Header
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${integration["logo"]}",
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${integration["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${integration["type"]}",
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

                    // Description
                    Text(
                      "${integration["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Commission Info
                    if ((integration["commission"] as double) > 0)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Commission: ${(integration["commission"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Features
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (integration["features"] as List<String>).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Connect Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Connect Now",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Integration Benefits
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Why Integrate?",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...[
                  {
                    "title": "Increase Revenue",
                    "description": "Reach more customers through multiple platforms",
                    "icon": Icons.trending_up,
                  },
                  {
                    "title": "Automate Operations",
                    "description": "Sync orders, inventory, and analytics automatically",
                    "icon": Icons.auto_awesome,
                  },
                  {
                    "title": "Better Insights",
                    "description": "Get comprehensive analytics across all channels",
                    "icon": Icons.insights,
                  },
                  {
                    "title": "Save Time",
                    "description": "Manage everything from one central dashboard",
                    "icon": Icons.schedule,
                  },
                ].map((benefit) => Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          benefit["icon"] as IconData,
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
                              "${benefit["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${benefit["description"]}",
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
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    List<Map<String, dynamic>> connectedIntegrations = integrations
        .where((integration) => integration["status"] == "Connected")
        .toList();

    double totalRevenue = connectedIntegrations
        .fold(0.0, (sum, integration) => sum + (integration["revenue"] as double));
    
    int totalOrders = connectedIntegrations
        .fold(0, (sum, integration) => sum + (integration["orders"] as int));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Stats
          Text(
            "Integration Performance",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.all(spSm),
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Total Revenue", "\$${totalRevenue.currency}", Icons.attach_money, successColor),
              _buildAnalyticsCard("Total Orders", "$totalOrders", Icons.receipt, primaryColor),
              _buildAnalyticsCard("Active Platforms", "${connectedIntegrations.length}", Icons.link, infoColor),
              _buildAnalyticsCard("Avg Commission", "${_calculateAvgCommission().toStringAsFixed(1)}%", Icons.percent, warningColor),
            ],
          ),

          // Revenue by Platform
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Revenue by Platform",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: connectedIntegrations.map((integration) {
                    double percentage = totalRevenue > 0 ? ((integration["revenue"] as double) / totalRevenue * 100) : 0;
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${integration["logo"]}",
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${integration["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${integration["orders"]} orders",
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
                                "\$${(integration["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "${percentage.toStringAsFixed(1)}%",
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
              ],
            ),
          ),

          // Commission Breakdown
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Commission Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: connectedIntegrations.map((integration) {
                    double commissionAmount = (integration["revenue"] as double) * ((integration["commission"] as double) / 100);
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${integration["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${(integration["commission"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "\$${commissionAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Sync Status
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Synchronization Status",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Sync All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: connectedIntegrations.map((integration) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: successColor,
                              size: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${integration["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${integration["lastSync"]}",
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateAvgCommission() {
    List<Map<String, dynamic>> connectedIntegrations = integrations
        .where((integration) => integration["status"] == "Connected")
        .toList();
    
    if (connectedIntegrations.isEmpty) return 0.0;
    
    double totalCommission = connectedIntegrations
        .fold(0.0, (sum, integration) => sum + (integration["commission"] as double));
    
    return totalCommission / connectedIntegrations.length;
  }
}
