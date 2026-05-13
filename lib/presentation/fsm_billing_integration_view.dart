import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmBillingIntegrationView extends StatefulWidget {
  const FsmBillingIntegrationView({super.key});

  @override
  State<FsmBillingIntegrationView> createState() => _FsmBillingIntegrationViewState();
}

class _FsmBillingIntegrationViewState extends State<FsmBillingIntegrationView> {
  String selectedIntegration = "QuickBooks";
  String apiKey = "";
  String apiSecret = "";
  String webhookUrl = "";
  bool autoSync = true;
  bool syncTaxes = true;
  bool syncCustomers = true;
  bool syncInvoices = true;
  String syncFrequency = "Real-time";
  bool testConnection = false;

  List<Map<String, dynamic>> integrationOptions = [
    {
      "label": "QuickBooks",
      "value": "QuickBooks",
    },
    {
      "label": "Xero",
      "value": "Xero",
    },
    {
      "label": "SAP",
      "value": "SAP",
    },
    {
      "label": "Oracle NetSuite",
      "value": "Oracle NetSuite",
    },
    {
      "label": "Sage",
      "value": "Sage",
    },
  ];

  List<Map<String, dynamic>> syncFrequencyOptions = [
    {
      "label": "Real-time",
      "value": "Real-time",
    },
    {
      "label": "Every 15 minutes",
      "value": "Every 15 minutes",
    },
    {
      "label": "Hourly",
      "value": "Hourly",
    },
    {
      "label": "Daily",
      "value": "Daily",
    },
    {
      "label": "Weekly",
      "value": "Weekly",
    },
  ];

  List<Map<String, dynamic>> integrationStatus = [
    {
      "system": "QuickBooks",
      "status": "Connected",
      "lastSync": "2024-01-15 14:30",
      "recordsSynced": 1250,
      "errors": 0,
    },
    {
      "system": "Xero",
      "status": "Disconnected",
      "lastSync": "2024-01-10 09:15",
      "recordsSynced": 890,
      "errors": 3,
    },
    {
      "system": "SAP",
      "status": "Error",
      "lastSync": "2024-01-14 16:45",
      "recordsSynced": 2100,
      "errors": 12,
    },
  ];

  List<Map<String, dynamic>> syncLogs = [
    {
      "timestamp": "2024-01-15 14:30:25",
      "system": "QuickBooks",
      "operation": "Invoice Sync",
      "status": "Success",
      "records": 45,
      "message": "Successfully synced 45 invoices",
    },
    {
      "timestamp": "2024-01-15 14:25:12",
      "system": "QuickBooks",
      "operation": "Customer Sync",
      "status": "Success",
      "records": 12,
      "message": "Successfully synced 12 customers",
    },
    {
      "timestamp": "2024-01-15 14:20:05",
      "system": "Xero",
      "operation": "Tax Sync",
      "status": "Failed",
      "records": 0,
      "message": "Authentication failed - API key expired",
    },
    {
      "timestamp": "2024-01-15 14:15:33",
      "system": "SAP",
      "operation": "Invoice Sync",
      "status": "Warning",
      "records": 23,
      "message": "Synced with 3 validation warnings",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Integration"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: _syncNow,
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Show help documentation
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildIntegrationSetup(),
            _buildSyncSettings(),
            _buildIntegrationStatus(),
            _buildSyncLogs(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntegrationSetup() {
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
          Text(
            "Integration Setup",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Billing System",
            items: integrationOptions,
            value: selectedIntegration,
            onChanged: (value, label) {
              selectedIntegration = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "API Key",
            value: apiKey,
            hint: "Enter your API key",
            validator: Validator.required,
            onChanged: (value) {
              apiKey = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "API Secret",
            value: apiSecret,
            hint: "Enter your API secret",
            obscureText: true,
            validator: Validator.required,
            onChanged: (value) {
              apiSecret = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Webhook URL",
            value: webhookUrl,
            hint: "https://your-domain.com/webhook",
            onChanged: (value) {
              webhookUrl = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: testConnection ? "Testing..." : "Test Connection",
                  size: bs.sm,
                  onPressed: testConnection ? null : _testConnection,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Configuration",
                  size: bs.sm,
                  onPressed: _saveConfiguration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSettings() {
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
          Text(
            "Sync Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Sync Frequency",
            items: syncFrequencyOptions,
            value: syncFrequency,
            onChanged: (value, label) {
              syncFrequency = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Auto Sync",
                "value": true,
                "checked": autoSync,
              }
            ],
            value: [
              if (autoSync)
                {
                  "label": "Auto Sync",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                autoSync = values.isNotEmpty;
              });
            },
          ),
          Text(
            "Data to Sync:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Customers",
                "value": true,
                "checked": syncCustomers,
              }
            ],
            value: [
              if (syncCustomers)
                {
                  "label": "Customers",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                syncCustomers = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Invoices",
                "value": true,
                "checked": syncInvoices,
              }
            ],
            value: [
              if (syncInvoices)
                {
                  "label": "Invoices",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                syncInvoices = values.isNotEmpty;
              });
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Tax Rates",
                "value": true,
                "checked": syncTaxes,
              }
            ],
            value: [
              if (syncTaxes)
                {
                  "label": "Tax Rates",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                syncTaxes = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationStatus() {
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
          Text(
            "Integration Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...integrationStatus.map((status) => _buildStatusItem(status)),
        ],
      ),
    );
  }

  Widget _buildStatusItem(Map<String, dynamic> status) {
    Color statusColor;
    IconData statusIcon;
    
    switch (status["status"]) {
      case "Connected":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Disconnected":
        statusColor = disabledBoldColor;
        statusIcon = Icons.cancel;
        break;
      case "Error":
        statusColor = dangerColor;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = warningColor;
        statusIcon = Icons.warning;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
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
                  "${status["system"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Last sync: ${status["lastSync"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Records: ${status["recordsSynced"]} • Errors: ${status["errors"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${status["status"]}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncLogs() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sync Logs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View all logs
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
          ...syncLogs.take(4).map((log) => _buildLogItem(log)),
        ],
      ),
    );
  }

  Widget _buildLogItem(Map<String, dynamic> log) {
    Color statusColor;
    IconData statusIcon;
    
    switch (log["status"]) {
      case "Success":
        statusColor = successColor;
        statusIcon = Icons.check;
        break;
      case "Failed":
        statusColor = dangerColor;
        statusIcon = Icons.close;
        break;
      case "Warning":
        statusColor = warningColor;
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = infoColor;
        statusIcon = Icons.info;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log["operation"]} - ${log["system"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${log["message"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${log["timestamp"]} • ${log["records"]} records",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _testConnection() async {
    testConnection = true;
    setState(() {});

    // Simulate connection test
    await Future.delayed(Duration(seconds: 2));

    testConnection = false;
    setState(() {});

    ss("Connection test successful!");
  }

  void _saveConfiguration() {
    ss("Configuration saved successfully!");
  }

  void _syncNow() {
    si("Manual sync initiated");
  }
}
