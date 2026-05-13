import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsThirdPartyIntegrationView extends StatefulWidget {
  const RfsThirdPartyIntegrationView({super.key});

  @override
  State<RfsThirdPartyIntegrationView> createState() => _RfsThirdPartyIntegrationViewState();
}

class _RfsThirdPartyIntegrationViewState extends State<RfsThirdPartyIntegrationView> {
  int selectedTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> deliveryPlatforms = [
    {
      "id": "dp1",
      "name": "UberEats",
      "type": "delivery",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=1&keyword=uber",
      "description": "World's largest food delivery platform",
      "connectionDate": "2024-01-10",
      "lastSync": "2024-01-15 10:30 AM",
      "ordersToday": 45,
      "revenue": 1850.75,
      "commissionRate": 30.0,
      "features": ["Order Management", "Real-time Sync", "Analytics"],
      "isActive": true,
      "apiKey": "ue_api_key_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/ubereats",
      "settings": {
        "autoAcceptOrders": true,
        "syncMenu": true,
        "syncInventory": false,
        "notifyOnNewOrder": true,
      }
    },
    {
      "id": "dp2",
      "name": "DoorDash",
      "type": "delivery",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=2&keyword=door",
      "description": "Leading food delivery service",
      "connectionDate": "2024-01-08",
      "lastSync": "2024-01-15 10:25 AM",
      "ordersToday": 38,
      "revenue": 1620.50,
      "commissionRate": 28.5,
      "features": ["Order Management", "Menu Sync", "Customer Reviews"],
      "isActive": true,
      "apiKey": "dd_api_key_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/doordash",
      "settings": {
        "autoAcceptOrders": false,
        "syncMenu": true,
        "syncInventory": true,
        "notifyOnNewOrder": true,
      }
    },
    {
      "id": "dp3",
      "name": "Grubhub",
      "type": "delivery",
      "status": "disconnected",
      "logo": "https://picsum.photos/60/60?random=3&keyword=grub",
      "description": "Popular online food ordering platform",
      "connectionDate": null,
      "lastSync": null,
      "ordersToday": 0,
      "revenue": 0.0,
      "commissionRate": 25.0,
      "features": ["Order Management", "Promotional Tools", "Analytics"],
      "isActive": false,
      "apiKey": null,
      "webhookUrl": null,
      "settings": {
        "autoAcceptOrders": true,
        "syncMenu": true,
        "syncInventory": false,
        "notifyOnNewOrder": true,
      }
    },
    {
      "id": "dp4",
      "name": "Postmates",
      "type": "delivery",
      "status": "error",
      "logo": "https://picsum.photos/60/60?random=4&keyword=post",
      "description": "On-demand delivery platform",
      "connectionDate": "2024-01-05",
      "lastSync": "2024-01-14 3:45 PM",
      "ordersToday": 12,
      "revenue": 485.25,
      "commissionRate": 32.0,
      "features": ["Order Management", "Fleet Management"],
      "isActive": false,
      "apiKey": "pm_api_key_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/postmates",
      "settings": {
        "autoAcceptOrders": true,
        "syncMenu": false,
        "syncInventory": false,
        "notifyOnNewOrder": true,
      }
    },
  ];

  List<Map<String, dynamic>> paymentGateways = [
    {
      "id": "pg1",
      "name": "Stripe",
      "type": "payment",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=5&keyword=stripe",
      "description": "Online payment processing platform",
      "connectionDate": "2024-01-01",
      "lastTransaction": "2024-01-15 11:45 AM",
      "transactionsToday": 95,
      "volumeToday": 3850.75,
      "fees": 2.9,
      "features": ["Credit Cards", "Digital Wallets", "Subscriptions"],
      "isActive": true,
      "apiKey": "sk_live_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/stripe",
      "settings": {
        "autoCapture": true,
        "saveCards": true,
        "enableRefunds": true,
        "sendReceipts": true,
      }
    },
    {
      "id": "pg2",
      "name": "PayPal",
      "type": "payment",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=6&keyword=paypal",
      "description": "Global online payment system",
      "connectionDate": "2024-01-01",
      "lastTransaction": "2024-01-15 11:30 AM",
      "transactionsToday": 42,
      "volumeToday": 1650.25,
      "fees": 3.5,
      "features": ["PayPal Payments", "Express Checkout", "Buyer Protection"],
      "isActive": true,
      "apiKey": "paypal_client_id_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/paypal",
      "settings": {
        "autoCapture": true,
        "saveCards": false,
        "enableRefunds": true,
        "sendReceipts": true,
      }
    },
    {
      "id": "pg3",
      "name": "Square",
      "type": "payment",
      "status": "disconnected",
      "logo": "https://picsum.photos/60/60?random=7&keyword=square",
      "description": "Payment processing and business tools",
      "connectionDate": null,
      "lastTransaction": null,
      "transactionsToday": 0,
      "volumeToday": 0.0,
      "fees": 2.6,
      "features": ["In-Person Payments", "Online Payments", "Invoicing"],
      "isActive": false,
      "apiKey": null,
      "webhookUrl": null,
      "settings": {
        "autoCapture": true,
        "saveCards": true,
        "enableRefunds": true,
        "sendReceipts": true,
      }
    },
  ];

  List<Map<String, dynamic>> posIntegrations = [
    {
      "id": "pos1",
      "name": "Toast POS",
      "type": "pos",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=8&keyword=toast",
      "description": "Restaurant point of sale system",
      "connectionDate": "2024-01-01",
      "lastSync": "2024-01-15 11:50 AM",
      "ordersProcessed": 156,
      "salesVolume": 4825.50,
      "features": ["Order Management", "Inventory Sync", "Staff Management"],
      "isActive": true,
      "apiKey": "toast_api_key_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/toast",
      "settings": {
        "syncOrders": true,
        "syncMenu": true,
        "syncInventory": true,
        "realTimeUpdates": true,
      }
    },
    {
      "id": "pos2",
      "name": "Square POS",
      "type": "pos",
      "status": "error",
      "logo": "https://picsum.photos/60/60?random=9&keyword=squarepos",
      "description": "All-in-one business management system",
      "connectionDate": "2024-01-03",
      "lastSync": "2024-01-14 8:20 PM",
      "ordersProcessed": 89,
      "salesVolume": 2150.75,
      "features": ["Payment Processing", "Inventory", "Analytics"],
      "isActive": false,
      "apiKey": "square_pos_api_xxxx",
      "webhookUrl": "https://api.restaurant.com/webhook/squarepos",
      "settings": {
        "syncOrders": true,
        "syncMenu": false,
        "syncInventory": true,
        "realTimeUpdates": false,
      }
    },
  ];

  List<Map<String, dynamic>> analyticsServices = [
    {
      "id": "as1",
      "name": "Google Analytics",
      "type": "analytics",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=10&keyword=google",
      "description": "Web analytics and reporting platform",
      "connectionDate": "2024-01-01",
      "lastDataSync": "2024-01-15 11:55 AM",
      "sessionsToday": 892,
      "conversionRate": 3.2,
      "features": ["Traffic Analysis", "Conversion Tracking", "Custom Reports"],
      "isActive": true,
      "apiKey": "ga_tracking_id_xxxx",
      "settings": {
        "trackOrders": true,
        "trackRevenue": true,
        "trackUserBehavior": true,
        "enableEcommerce": true,
      }
    },
    {
      "id": "as2",
      "name": "Mixpanel",
      "type": "analytics",
      "status": "connected",
      "logo": "https://picsum.photos/60/60?random=11&keyword=mixpanel",
      "description": "Advanced analytics for user tracking",
      "connectionDate": "2024-01-05",
      "lastDataSync": "2024-01-15 11:52 AM",
      "eventsToday": 2456,
      "activeUsers": 345,
      "features": ["Event Tracking", "Funnel Analysis", "Cohort Analysis"],
      "isActive": true,
      "apiKey": "mixpanel_token_xxxx",
      "settings": {
        "trackEvents": true,
        "trackUsers": true,
        "enableFunnels": true,
        "enableCohorts": true,
      }
    },
  ];

  List<Map<String, dynamic>> get allIntegrations {
    List<Map<String, dynamic>> all = [
      ...deliveryPlatforms,
      ...paymentGateways,
      ...posIntegrations,
      ...analyticsServices,
    ];
    
    if (searchQuery.isNotEmpty) {
      all = all.where((integration) =>
          "${integration["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${integration["description"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return all;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "connected":
        return successColor;
      case "disconnected":
        return disabledBoldColor;
      case "error":
        return dangerColor;
      default:
        return warningColor;
    }
  }

  Widget _buildIntegrationCard(Map<String, dynamic> integration) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${integration["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${integration["logo"]}"),
                    fit: BoxFit.cover,
                  ),
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
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${integration["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                  color: _getStatusColor("${integration["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${integration["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${integration["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          if (integration["features"] != null)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (integration["features"] as List).map((feature) =>
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$feature",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).toList(),
            ),
          SizedBox(height: spSm),
          if (integration["status"] == "connected") ...[
            _buildConnectedStats(integration),
            SizedBox(height: spSm),
          ],
          Row(
            children: [
              if (integration["status"] == "connected") ...[
                QButton(
                  label: "Configure",
                  size: bs.sm,
                  onPressed: () => _showConfigurationDialog(integration),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Disconnect",
                  size: bs.sm,
                  onPressed: () => _disconnectIntegration(integration),
                ),
              ] else if (integration["status"] == "error") ...[
                QButton(
                  label: "Retry",
                  size: bs.sm,
                  onPressed: () => _retryConnection(integration),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "View Logs",
                  size: bs.sm,
                  onPressed: () => _showErrorLogs(integration),
                ),
              ] else ...[
                QButton(
                  label: "Connect",
                  size: bs.sm,
                  onPressed: () => _connectIntegration(integration),
                ),
              ],
              Spacer(),
              QButton(
                label: "Details",
                size: bs.sm,
                onPressed: () => _showIntegrationDetails(integration),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedStats(Map<String, dynamic> integration) {
    switch (integration["type"]) {
      case "delivery":
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Orders Today",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${integration["ordersToday"]}",
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
                    "Revenue",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((integration["revenue"] as double)).currency}",
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
                    "Commission",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(integration["commissionRate"] as double).toStringAsFixed(1)}%",
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
        );
      case "payment":
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${integration["transactionsToday"]}",
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
                    "Volume",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((integration["volumeToday"] as double)).currency}",
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
                    "Fees",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(integration["fees"] as double).toStringAsFixed(1)}%",
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
        );
      case "pos":
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Orders",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${integration["ordersProcessed"]}",
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
                    "Sales",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((integration["salesVolume"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case "analytics":
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    integration["sessionsToday"] != null ? "Sessions" : "Events",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${integration["sessionsToday"] ?? integration["eventsToday"]}",
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
                    integration["conversionRate"] != null ? "Conversion" : "Users",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    integration["conversionRate"] != null 
                        ? "${(integration["conversionRate"] as double).toStringAsFixed(1)}%"
                        : "${integration["activeUsers"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildSummaryCards() {
    int connectedCount = allIntegrations.where((i) => i["status"] == "connected").length;
    int errorCount = allIntegrations.where((i) => i["status"] == "error").length;
    double totalRevenue = deliveryPlatforms
        .where((p) => p["status"] == "connected")
        .fold(0.0, (sum, platform) => sum + (platform["revenue"] as double));

    return Column(
      children: [
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
                  children: [
                    Text(
                      "$connectedCount",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Connected",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                  children: [
                    Text(
                      "$errorCount",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Errors",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                  children: [
                    Text(
                      "\$${totalRevenue.currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
            ),
          ],
        ),
      ],
    );
  }

  void _showConfigurationDialog(Map<String, dynamic> integration) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Configure ${integration["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Connection Settings", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              if (integration["apiKey"] != null) ...[
                Text("API Key: ${integration["apiKey"]}"),
                SizedBox(height: spXs),
              ],
              if (integration["webhookUrl"] != null) ...[
                Text("Webhook URL: ${integration["webhookUrl"]}"),
                SizedBox(height: spSm),
              ],
              Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              if (integration["settings"] != null)
                ...(integration["settings"] as Map<String, dynamic>).entries.map((entry) =>
                  Row(
                    children: [
                      Expanded(child: Text("${entry.key}:")),
                      Text("${entry.value}", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Edit Settings",
            size: bs.sm,
            onPressed: () {
              back();
              _showEditSettingsDialog(integration);
            },
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _showEditSettingsDialog(Map<String, dynamic> integration) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit ${integration["name"]} Settings"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "API Key",
                value: "${integration["apiKey"] ?? ""}",
                onChanged: (value) {},
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Webhook URL",
                value: "${integration["webhookUrl"] ?? ""}",
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Settings updated for ${integration["name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _disconnectIntegration(Map<String, dynamic> integration) {
    integration["status"] = "disconnected";
    integration["isActive"] = false;
    setState(() {});
    ss("Disconnected from ${integration["name"]}");
  }

  void _connectIntegration(Map<String, dynamic> integration) {
    integration["status"] = "connected";
    integration["isActive"] = true;
    integration["connectionDate"] = "2024-01-15";
    setState(() {});
    ss("Connected to ${integration["name"]}");
  }

  void _retryConnection(Map<String, dynamic> integration) {
    integration["status"] = "connected";
    integration["isActive"] = true;
    setState(() {});
    ss("Reconnected to ${integration["name"]}");
  }

  void _showErrorLogs(Map<String, dynamic> integration) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error Logs - ${integration["name"]}"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent Errors:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("2024-01-15 10:30 AM - API Rate limit exceeded"),
              Text("2024-01-15 09:15 AM - Connection timeout"),
              Text("2024-01-14 11:45 PM - Invalid API key"),
              Text("2024-01-14 09:30 AM - Webhook verification failed"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Export Logs",
            size: bs.sm,
            onPressed: () => si("Exporting error logs..."),
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _showIntegrationDetails(Map<String, dynamic> integration) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${integration["name"]} Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Status: ${integration["status"]}"),
              SizedBox(height: spXs),
              if (integration["connectionDate"] != null)
                Text("Connected: ${integration["connectionDate"]}"),
              if (integration["lastSync"] != null)
                Text("Last Sync: ${integration["lastSync"]}"),
              SizedBox(height: spSm),
              Text("Features:", style: TextStyle(fontWeight: FontWeight.bold)),
              if (integration["features"] != null)
                ...(integration["features"] as List).map((feature) => Text("• $feature")),
              SizedBox(height: spSm),
              Text("Type: ${integration["type"]}"),
              Text("Active: ${integration["isActive"]}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Third Party Integration",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All", icon: Icon(Icons.apps)),
        Tab(text: "Delivery", icon: Icon(Icons.local_shipping)),
        Tab(text: "Payment", icon: Icon(Icons.payment)),
        Tab(text: "POS", icon: Icon(Icons.point_of_sale)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        // All Integrations Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(),
              SizedBox(height: spMd),
              QTextField(
                label: "Search integrations...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Text(
                "All Integrations (${allIntegrations.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...allIntegrations.map((integration) => _buildIntegrationCard(integration)),
            ],
          ),
        ),
        
        // Delivery Platforms Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Platform Integrations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...deliveryPlatforms.map((platform) => _buildIntegrationCard(platform)),
            ],
          ),
        ),
        
        // Payment Gateways Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Gateway Integrations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...paymentGateways.map((gateway) => _buildIntegrationCard(gateway)),
            ],
          ),
        ),
        
        // POS Integrations Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "POS System Integrations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...posIntegrations.map((pos) => _buildIntegrationCard(pos)),
            ],
          ),
        ),
        
        // Analytics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Analytics Service Integrations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              ...analyticsServices.map((service) => _buildIntegrationCard(service)),
            ],
          ),
        ),
      ],
    );
  }
}
