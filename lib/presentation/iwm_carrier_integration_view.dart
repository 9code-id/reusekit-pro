import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmCarrierIntegrationView extends StatefulWidget {
  const IwmCarrierIntegrationView({super.key});

  @override
  State<IwmCarrierIntegrationView> createState() => _IwmCarrierIntegrationViewState();
}

class _IwmCarrierIntegrationViewState extends State<IwmCarrierIntegrationView> {
  int selectedTab = 0;
  String selectedCarrier = "all";
  bool testingConnection = false;

  List<Map<String, dynamic>> carriers = [
    {
      "name": "FedEx",
      "logo": "https://picsum.photos/40/40?random=1&keyword=fedex",
      "status": "Connected",
      "accountId": "123456789",
      "services": ["Ground", "Express", "Overnight"],
      "rateDiscounts": 15,
      "lastSync": "2024-01-20 10:30",
      "apiVersion": "v1.2.1",
      "monthlyVolume": 450,
      "avgCost": 12.45,
      "isActive": true
    },
    {
      "name": "UPS",
      "logo": "https://picsum.photos/40/40?random=2&keyword=ups",
      "status": "Connected",
      "accountId": "UPS987654",
      "services": ["Ground", "Next Day Air", "2nd Day Air"],
      "rateDiscounts": 18,
      "lastSync": "2024-01-20 09:15",
      "apiVersion": "v2.0.3",
      "monthlyVolume": 325,
      "avgCost": 14.89,
      "isActive": true
    },
    {
      "name": "DHL",
      "logo": "https://picsum.photos/40/40?random=3&keyword=dhl",
      "status": "Error",
      "accountId": "DHL123ABC",
      "services": ["Express", "International"],
      "rateDiscounts": 12,
      "lastSync": "2024-01-19 16:45",
      "apiVersion": "v1.8.2",
      "monthlyVolume": 125,
      "avgCost": 18.75,
      "isActive": false
    },
    {
      "name": "USPS",
      "logo": "https://picsum.photos/40/40?random=4&keyword=usps",
      "status": "Disconnected",
      "accountId": "",
      "services": [],
      "rateDiscounts": 0,
      "lastSync": "",
      "apiVersion": "",
      "monthlyVolume": 0,
      "avgCost": 0,
      "isActive": false
    },
  ];

  List<Map<String, dynamic>> integrationStats = [
    {
      "title": "Connected Carriers",
      "value": 2,
      "subtitle": "of 4 available",
      "icon": Icons.link,
      "color": successColor
    },
    {
      "title": "API Calls Today",
      "value": 1250,
      "subtitle": "+8% from yesterday",
      "icon": Icons.api,
      "color": primaryColor
    },
    {
      "title": "Success Rate",
      "value": 98.5,
      "subtitle": "Last 24 hours",
      "icon": Icons.check_circle,
      "color": infoColor
    },
    {
      "title": "Avg Response",
      "value": 245,
      "subtitle": "milliseconds",
      "icon": Icons.speed,
      "color": warningColor
    },
  ];

  List<Map<String, dynamic>> apiLogs = [
    {
      "timestamp": "2024-01-20 10:45:23",
      "carrier": "FedEx",
      "endpoint": "/rates",
      "method": "POST",
      "status": 200,
      "responseTime": 234,
      "type": "Rate Quote"
    },
    {
      "timestamp": "2024-01-20 10:44:15",
      "carrier": "UPS",
      "endpoint": "/shipments",
      "method": "POST",
      "status": 201,
      "responseTime": 456,
      "type": "Create Label"
    },
    {
      "timestamp": "2024-01-20 10:43:02",
      "carrier": "DHL",
      "endpoint": "/tracking",
      "method": "GET",
      "status": 500,
      "responseTime": 1200,
      "type": "Track Package"
    },
    {
      "timestamp": "2024-01-20 10:41:55",
      "carrier": "FedEx",
      "endpoint": "/void",
      "method": "DELETE",
      "status": 200,
      "responseTime": 189,
      "type": "Void Label"
    },
  ];

  List<Map<String, dynamic>> webhookEvents = [
    {
      "event": "shipment.delivered",
      "carrier": "FedEx",
      "timestamp": "2024-01-20 10:30",
      "trackingNumber": "1234567890123456",
      "status": "processed"
    },
    {
      "event": "shipment.in_transit",
      "carrier": "UPS",
      "timestamp": "2024-01-20 09:15",
      "trackingNumber": "1Z999AA1234567890",
      "status": "processed"
    },
    {
      "event": "shipment.exception",
      "carrier": "DHL",
      "timestamp": "2024-01-20 08:45",
      "trackingNumber": "DHL123456789",
      "status": "failed"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Carrier Integration",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Carriers", icon: Icon(Icons.local_shipping)),
        Tab(text: "API Logs", icon: Icon(Icons.code)),
        Tab(text: "Webhooks", icon: Icon(Icons.webhook)),
      ],
      tabChildren: [
        _buildCarriersTab(),
        _buildApiLogsTab(),
        _buildWebhooksTab(),
      ],
    );
  }

  Widget _buildCarriersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntegrationStats(),
          _buildCarriersList(),
          _buildAddCarrierSection(),
        ],
      ),
    );
  }

  Widget _buildApiLogsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApiFilters(),
          _buildApiLogsList(),
        ],
      ),
    );
  }

  Widget _buildWebhooksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWebhookHeader(),
          _buildWebhookEventsList(),
        ],
      ),
    );
  }

  Widget _buildIntegrationStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Integration Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: integrationStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
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
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            stat["title"] == "Success Rate" 
                ? "${stat["value"]}%"
                : "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarriersList() {
    return Column(
      spacing: spSm,
      children: carriers.map((carrier) => _buildCarrierCard(carrier)).toList(),
    );
  }

  Widget _buildCarrierCard(Map<String, dynamic> carrier) {
    Color statusColor = _getStatusColor(carrier["status"]);
    
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${carrier["logo"]}",
                    fit: BoxFit.cover,
                  ),
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
                          "${carrier["name"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${carrier["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (carrier["accountId"].toString().isNotEmpty)
                      Text(
                        "Account: ${carrier["accountId"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (carrier["isActive"]) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Monthly Volume",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${carrier["monthlyVolume"]} packages",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
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
                              "Avg Cost",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(carrier["avgCost"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
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
                              "Discount",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${carrier["rateDiscounts"]}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if ((carrier["services"] as List).isNotEmpty) ...[
                    Divider(color: disabledOutlineBorderColor),
                    Row(
                      children: [
                        Text(
                          "Services: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (carrier["services"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          Row(
            children: [
              if (carrier["lastSync"].toString().isNotEmpty)
                Text(
                  "Last sync: ${carrier["lastSync"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              Spacer(),
              QButton(
                label: testingConnection ? "Testing..." : "Test",
                icon: Icons.sync,
                size: bs.sm,
                onPressed: testingConnection ? null : () => _testConnection(carrier),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () => _showCarrierSettings(carrier),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddCarrierSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 48,
            color: primaryColor,
          ),
          Text(
            "Add New Carrier",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Connect with additional shipping carriers to expand your shipping options and get better rates.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          QButton(
            label: "Browse Carriers",
            icon: Icons.explore,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildApiFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Carrier",
              items: [
                {"label": "All Carriers", "value": "all"},
                ...carriers.map((c) => {"label": c["name"], "value": c["name"].toString().toLowerCase()}),
              ],
              value: selectedCarrier,
              onChanged: (value, label) {
                selectedCarrier = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildApiLogsList() {
    return Column(
      spacing: spSm,
      children: apiLogs.map((log) => _buildApiLogCard(log)).toList(),
    );
  }

  Widget _buildApiLogCard(Map<String, dynamic> log) {
    Color statusColor = _getHttpStatusColor(log["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${log["method"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${log["endpoint"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${log["status"]}",
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${log["carrier"]} • ${log["type"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${log["responseTime"]}ms",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            "${log["timestamp"]}",
            style: TextStyle(
              color: disabledColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebhookHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "Webhook Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "Configure",
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWebhookEventsList() {
    return Column(
      spacing: spSm,
      children: webhookEvents.map((event) => _buildWebhookEventCard(event)).toList(),
    );
  }

  Widget _buildWebhookEventCard(Map<String, dynamic> event) {
    Color statusColor = event["status"] == "processed" ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
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
                      "${event["event"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${event["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${event["carrier"]} • ${event["trackingNumber"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${event["timestamp"]}",
                  style: TextStyle(
                    color: disabledColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _testConnection(Map<String, dynamic> carrier) async {
    testingConnection = true;
    setState(() {});
    
    // Simulate API test
    await Future.delayed(Duration(seconds: 2));
    
    testingConnection = false;
    setState(() {});
    
    ss("Connection test successful for ${carrier["name"]}");
  }

  void _showCarrierSettings(Map<String, dynamic> carrier) {
    // Show carrier settings dialog
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return successColor;
      case 'error':
        return dangerColor;
      case 'disconnected':
        return disabledBoldColor;
      default:
        return warningColor;
    }
  }

  Color _getHttpStatusColor(int status) {
    if (status >= 200 && status < 300) {
      return successColor;
    } else if (status >= 400 && status < 500) {
      return warningColor;
    } else if (status >= 500) {
      return dangerColor;
    } else {
      return infoColor;
    }
  }
}
