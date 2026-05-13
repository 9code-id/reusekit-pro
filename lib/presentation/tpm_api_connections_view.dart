import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmApiConnectionsView extends StatefulWidget {
  const TpmApiConnectionsView({super.key});

  @override
  State<TpmApiConnectionsView> createState() => _TpmApiConnectionsViewState();
}

class _TpmApiConnectionsViewState extends State<TpmApiConnectionsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedType = "All";
  String selectedStatus = "All";
  
  List<String> connectionTypes = [
    "All",
    "REST API",
    "GraphQL",
    "WebSocket",
    "Webhook",
    "SOAP",
    "gRPC"
  ];

  List<String> statusFilters = [
    "All",
    "Active",
    "Inactive",
    "Error",
    "Testing"
  ];

  List<Map<String, dynamic>> apiConnections = [
    {
      "id": "api-001",
      "name": "Payment Gateway API",
      "description": "Stripe payment processing integration",
      "type": "REST API",
      "status": "active",
      "endpoint": "https://api.stripe.com/v1/",
      "method": "POST",
      "lastUsed": DateTime.now().subtract(Duration(minutes: 5)),
      "responseTime": 245,
      "successRate": 99.8,
      "totalRequests": 15420,
      "errorCount": 2,
      "rateLimit": "100/minute",
      "authentication": "API Key",
      "version": "v1",
      "environment": "Production",
      "createdBy": "John Smith",
      "createdAt": DateTime.now().subtract(Duration(days: 15)),
      "documentation": "https://stripe.com/docs/api",
      "headers": {
        "Content-Type": "application/json",
        "Authorization": "Bearer sk_live_***"
      }
    },
    {
      "id": "api-002",
      "name": "User Analytics GraphQL",
      "description": "User behavior and analytics data",
      "type": "GraphQL",
      "status": "active",
      "endpoint": "https://analytics.company.com/graphql",
      "method": "POST",
      "lastUsed": DateTime.now().subtract(Duration(hours: 1)),
      "responseTime": 180,
      "successRate": 97.5,
      "totalRequests": 8930,
      "errorCount": 12,
      "rateLimit": "1000/hour",
      "authentication": "Bearer Token",
      "version": "v2",
      "environment": "Production",
      "createdBy": "Sarah Johnson",
      "createdAt": DateTime.now().subtract(Duration(days: 8)),
      "documentation": "https://docs.company.com/graphql",
      "headers": {
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJ0eXAi***"
      }
    },
    {
      "id": "api-003",
      "name": "Real-time Notifications",
      "description": "WebSocket connection for live updates",
      "type": "WebSocket",
      "status": "error",
      "endpoint": "wss://notifications.company.com/ws",
      "method": "WS",
      "lastUsed": DateTime.now().subtract(Duration(hours: 6)),
      "responseTime": 0,
      "successRate": 85.2,
      "totalRequests": 2340,
      "errorCount": 48,
      "rateLimit": "Unlimited",
      "authentication": "JWT Token",
      "version": "v1",
      "environment": "Production",
      "createdBy": "Mike Davis",
      "createdAt": DateTime.now().subtract(Duration(days: 22)),
      "documentation": "https://docs.company.com/websocket",
      "headers": {
        "Authorization": "Bearer jwt_token_***"
      }
    },
    {
      "id": "api-004",
      "name": "Inventory Management",
      "description": "Product inventory and stock management",
      "type": "REST API",
      "status": "testing",
      "endpoint": "https://inventory.company.com/api/v2/",
      "method": "GET",
      "lastUsed": DateTime.now().subtract(Duration(minutes: 30)),
      "responseTime": 320,
      "successRate": 100.0,
      "totalRequests": 156,
      "errorCount": 0,
      "rateLimit": "500/hour",
      "authentication": "OAuth 2.0",
      "version": "v2",
      "environment": "Staging",
      "createdBy": "Emma Wilson",
      "createdAt": DateTime.now().subtract(Duration(days: 2)),
      "documentation": "https://docs.inventory.com/api",
      "headers": {
        "Content-Type": "application/json",
        "Authorization": "Bearer oauth_token_***"
      }
    },
    {
      "id": "api-005",
      "name": "Email Notification Webhook",
      "description": "Webhook for email delivery status",
      "type": "Webhook",
      "status": "inactive",
      "endpoint": "https://hooks.company.com/email-status",
      "method": "POST",
      "lastUsed": DateTime.now().subtract(Duration(days: 3)),
      "responseTime": 150,
      "successRate": 94.7,
      "totalRequests": 890,
      "errorCount": 5,
      "rateLimit": "200/minute",
      "authentication": "Webhook Secret",
      "version": "v1",
      "environment": "Production",
      "createdBy": "Alex Chen",
      "createdAt": DateTime.now().subtract(Duration(days: 45)),
      "documentation": "https://docs.company.com/webhooks",
      "headers": {
        "Content-Type": "application/json",
        "X-Webhook-Secret": "secret_***"
      }
    },
    {
      "id": "api-006",
      "name": "Customer Service SOAP",
      "description": "Legacy customer service integration",
      "type": "SOAP",
      "status": "active",
      "endpoint": "https://legacy.company.com/soap/CustomerService",
      "method": "SOAP",
      "lastUsed": DateTime.now().subtract(Duration(hours: 4)),
      "responseTime": 890,
      "successRate": 92.1,
      "totalRequests": 1240,
      "errorCount": 18,
      "rateLimit": "50/minute",
      "authentication": "Basic Auth",
      "version": "v1",
      "environment": "Production",
      "createdBy": "Lisa Anderson",
      "createdAt": DateTime.now().subtract(Duration(days: 120)),
      "documentation": "https://legacy.company.com/docs",
      "headers": {
        "SOAPAction": "GetCustomerInfo",
        "Authorization": "Basic dXNlcm5hbWU6***"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredConnections {
    return apiConnections.where((connection) {
      bool matchesSearch = connection["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          connection["description"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          connection["endpoint"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || connection["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || connection["status"] == selectedStatus;
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'error':
        return dangerColor;
      case 'inactive':
        return disabledColor;
      case 'testing':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Active';
      case 'error':
        return 'Error';
      case 'inactive':
        return 'Inactive';
      case 'testing':
        return 'Testing';
      default:
        return 'Unknown';
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'REST API':
        return primaryColor;
      case 'GraphQL':
        return infoColor;
      case 'WebSocket':
        return successColor;
      case 'Webhook':
        return warningColor;
      case 'SOAP':
        return disabledBoldColor;
      case 'gRPC':
        return secondaryColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'REST API':
        return Icons.api;
      case 'GraphQL':
        return Icons.hub;
      case 'WebSocket':
        return Icons.swap_horiz;
      case 'Webhook':
        return Icons.webhook;
      case 'SOAP':
        return Icons.soap;
      case 'gRPC':
        return Icons.api;
      default:
        return Icons.link;
    }
  }

  Color _getResponseTimeColor(int responseTime) {
    if (responseTime < 200) return successColor;
    if (responseTime < 500) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "API Connections",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Connections", icon: Icon(Icons.api)),
        Tab(text: "Monitoring", icon: Icon(Icons.monitor)),
      ],
      tabChildren: [
        _buildConnectionsTab(),
        _buildMonitoringTab(),
      ],
    );
  }

  Widget _buildConnectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search API connections...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: connectionTypes.map((type) => {
                    "label": type,
                    "value": type,
                  }).toList(),
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters.map((status) => {
                    "label": status,
                    "value": status,
                  }).toList(),
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // API Statistics
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active APIs",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${apiConnections.where((api) => api["status"] == "active").length}",
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
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Requests",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((apiConnections.map((api) => api["totalRequests"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
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
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg Response",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(apiConnections.map((api) => api["responseTime"] as int).reduce((a, b) => a + b) / apiConnections.length).round()}ms",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // API Connections List
          ...filteredConnections.map((connection) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _getTypeColor(connection["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getTypeIcon(connection["type"]),
                        color: _getTypeColor(connection["type"]),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${connection["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(connection["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusText(connection["status"]),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(connection["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${connection["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(connection["type"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${connection["method"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getTypeColor(connection["type"]),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${connection["endpoint"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Response Time",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _getResponseTimeColor(connection["responseTime"]),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${connection["responseTime"]}ms",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getResponseTimeColor(connection["responseTime"]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Success Rate",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${(connection["successRate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (connection["successRate"] as double) > 95 ? successColor : warningColor,
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
                            "Requests",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${((connection["totalRequests"] as int) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Last used: ${connection["lastUsed"].timeAgo}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Rate limit: ${connection["rateLimit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if ((connection["errorCount"] as int) > 0) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: dangerColor.withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 16,
                          color: dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${connection["errorCount"]} errors in last 24h",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    QButton(
                      label: "Test",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Configure",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Logs",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildMonitoringTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Uptime",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "99.9%",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Avg Response",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "284ms",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Error Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "0.3%",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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

          // Real-time Status
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Real-time Status",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: successColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "All Systems Operational",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...apiConnections.take(3).map((connection) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: _getStatusColor(connection["status"]).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getStatusColor(connection["status"]),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${connection["name"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "${connection["responseTime"]}ms",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          // Recent Errors
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Errors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                ...apiConnections
                    .where((api) => (api["errorCount"] as int) > 0)
                    .take(3)
                    .map((connection) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 16,
                        color: dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${connection["name"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${connection["errorCount"]} errors",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${connection["lastUsed"].timeAgo}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )),
                if (apiConnections.where((api) => (api["errorCount"] as int) > 0).isEmpty)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "No recent errors",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Usage Analytics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
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
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "2.4K",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "requests",
                              style: TextStyle(
                                fontSize: 11,
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
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "This Week",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "18.7K",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "requests",
                              style: TextStyle(
                                fontSize: 11,
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "This Month",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "86.3K",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "requests",
                              style: TextStyle(
                                fontSize: 11,
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
            ),
          ),
        ],
      ),
    );
  }
}
