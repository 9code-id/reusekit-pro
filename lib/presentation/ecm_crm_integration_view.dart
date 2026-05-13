import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCrmIntegrationView extends StatefulWidget {
  const EcmCrmIntegrationView({super.key});

  @override
  State<EcmCrmIntegrationView> createState() => _EcmCrmIntegrationViewState();
}

class _EcmCrmIntegrationViewState extends State<EcmCrmIntegrationView> {
  bool crmEnabled = true;
  String selectedCrmProvider = "Salesforce";
  bool autoSyncCustomers = true;
  bool syncOrderHistory = true;
  bool syncContactInfo = true;
  String syncFrequency = "Real-time";
  String lastSyncTime = "2 minutes ago";
  bool syncInProgress = false;
  
  Map<String, dynamic> connectionStatus = {
    "status": "Connected",
    "health": "Excellent",
    "lastActivity": "2 minutes ago",
    "dataPoints": 15420,
    "errors": 0,
  };

  List<Map<String, dynamic>> crmProviders = [
    {"label": "Salesforce", "value": "Salesforce"},
    {"label": "HubSpot", "value": "HubSpot"},
    {"label": "Zoho CRM", "value": "Zoho"},
    {"label": "Pipedrive", "value": "Pipedrive"},
    {"label": "Microsoft Dynamics", "value": "Dynamics"},
    {"label": "Custom CRM", "value": "Custom"},
  ];

  List<Map<String, dynamic>> syncFrequencies = [
    {"label": "Real-time", "value": "Real-time"},
    {"label": "Every 5 minutes", "value": "5min"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Every hour", "value": "1hour"},
    {"label": "Daily", "value": "daily"},
  ];

  List<Map<String, dynamic>> syncedData = [
    {
      "category": "Customer Profiles",
      "count": 8450,
      "lastSync": "2 minutes ago",
      "status": "synced",
      "icon": Icons.person,
      "color": "#2196F3",
    },
    {
      "category": "Order History",
      "count": 3280,
      "lastSync": "5 minutes ago",
      "status": "synced",
      "icon": Icons.shopping_bag,
      "color": "#4CAF50",
    },
    {
      "category": "Contact Information",
      "count": 9120,
      "lastSync": "1 minute ago",
      "status": "synced",
      "icon": Icons.contact_phone,
      "color": "#FF9800",
    },
    {
      "category": "Purchase Behavior",
      "count": 15600,
      "lastSync": "3 minutes ago",
      "status": "synced",
      "icon": Icons.analytics,
      "color": "#9C27B0",
    },
    {
      "category": "Support Tickets",
      "count": 890,
      "lastSync": "10 minutes ago",
      "status": "pending",
      "icon": Icons.support_agent,
      "color": "#F44336",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "action": "New customer profile created",
      "details": "John Smith registered and profile synced to CRM",
      "time": "2 minutes ago",
      "type": "create",
      "icon": Icons.person_add,
    },
    {
      "action": "Order data synchronized",
      "details": "Order #12345 information updated in CRM",
      "time": "5 minutes ago",
      "type": "update",
      "icon": Icons.sync,
    },
    {
      "action": "Customer information updated",
      "details": "Contact details for 15 customers synchronized",
      "time": "8 minutes ago",
      "type": "update",
      "icon": Icons.update,
    },
    {
      "action": "Bulk data synchronization",
      "details": "852 customer records processed successfully",
      "time": "1 hour ago",
      "type": "bulk",
      "icon": Icons.cloud_sync,
    },
    {
      "action": "CRM connection established",
      "details": "Successfully connected to Salesforce API",
      "time": "2 hours ago",
      "type": "connection",
      "icon": Icons.link,
    },
  ];

  Widget _buildConnectionStatus() {
    final isConnected = connectionStatus["status"] == "Connected";
    final statusColor = isConnected ? successColor : dangerColor;
    final healthScore = connectionStatus["health"] == "Excellent" ? 95 :
                       connectionStatus["health"] == "Good" ? 80 :
                       connectionStatus["health"] == "Fair" ? 60 : 30;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CRM Connection",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${connectionStatus["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Provider",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      selectedCrmProvider,
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
                      "Health Score",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "$healthScore%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: healthScore > 80 ? successColor : healthScore > 60 ? warningColor : dangerColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${connectionStatus["health"]}",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data Points Synced",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(connectionStatus["dataPoints"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
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
                      "Last Activity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${connectionStatus["lastActivity"]}",
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
          ),
        ],
      ),
    );
  }

  Widget _buildSyncDataCard(Map<String, dynamic> data) {
    final statusColor = data["status"] == "synced" ? successColor :
                       data["status"] == "pending" ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Color(int.parse("0xFF${data["color"].substring(1)}")).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              data["icon"],
              color: Color(int.parse("0xFF${data["color"].substring(1)}")),
              size: 22,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${data["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${(data["count"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} records",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Last sync: ${data["lastSync"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              data["status"] == "synced" ? Icons.sync : Icons.sync_problem,
              color: statusColor,
              size: 20,
            ),
            onPressed: () {
              if (data["status"] != "synced") {
                si("Syncing ${data["category"]}...");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...recentActivities.take(5).map((activity) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    activity["icon"],
                    color: primaryColor,
                    size: 18,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${activity["action"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void _performManualSync() async {
    syncInProgress = true;
    setState(() {});
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 3));
    
    lastSyncTime = "Just now";
    syncInProgress = false;
    setState(() {});
    
    ss("CRM sync completed successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRM Integration"),
        actions: [
          if (syncInProgress) ...[
            Container(
              width: 40,
              height: 40,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: _performManualSync,
            ),
          ],
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("CRM integration settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CRM Toggle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: crmEnabled ? primaryColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: crmEnabled ? primaryColor : warningColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    crmEnabled ? Icons.link : Icons.link_off,
                    color: crmEnabled ? primaryColor : warningColor,
                    size: 30,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CRM Integration",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: crmEnabled ? primaryColor : warningColor,
                          ),
                        ),
                        Text(
                          crmEnabled 
                              ? "Sync customer data with your CRM system"
                              : "CRM integration is currently disabled",
                          style: TextStyle(
                            fontSize: 12,
                            color: crmEnabled ? primaryColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: crmEnabled,
                    onChanged: (value) {
                      crmEnabled = value;
                      setState(() {});
                      if (value) {
                        ss("CRM integration enabled");
                      } else {
                        sw("CRM integration disabled");
                      }
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Connection Status
            _buildConnectionStatus(),
            SizedBox(height: spLg),

            // CRM Settings
            Text(
              "Integration Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QDropdownField(
                    label: "CRM Provider",
                    items: crmProviders,
                    value: selectedCrmProvider,
                    onChanged: (value, label) {
                      if (crmEnabled) {
                        selectedCrmProvider = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Sync Frequency",
                    items: syncFrequencies,
                    value: syncFrequency,
                    onChanged: (value, label) {
                      if (crmEnabled) {
                        syncFrequency = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Auto Sync Customers",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Automatically sync new customer profiles",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: autoSyncCustomers,
                        onChanged: crmEnabled ? (value) {
                          autoSyncCustomers = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Order History",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Include order data in customer profiles",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: syncOrderHistory,
                        onChanged: crmEnabled ? (value) {
                          syncOrderHistory = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sync Contact Info",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Keep contact information up to date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: syncContactInfo,
                        onChanged: crmEnabled ? (value) {
                          syncContactInfo = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Synced Data
            Text(
              "Synced Data",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...syncedData.map((data) => _buildSyncDataCard(data)).toList(),
            SizedBox(height: spLg),

            // Recent Activity
            _buildRecentActivity(),
            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Manual Sync",
                    size: bs.md,
                    onPressed: crmEnabled && !syncInProgress ? _performManualSync : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Test Connection",
                    size: bs.md,
                    onPressed: crmEnabled ? () {
                      si("Testing CRM connection...");
                    } : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "View CRM Dashboard",
                size: bs.md,
                onPressed: crmEnabled ? () {
                  si("Opening CRM dashboard in external browser...");
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
