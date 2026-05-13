import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaStockAlertsView extends StatefulWidget {
  const SpaStockAlertsView({super.key});

  @override
  State<SpaStockAlertsView> createState() => _SpaStockAlertsViewState();
}

class _SpaStockAlertsViewState extends State<SpaStockAlertsView> {
  String selectedAlertType = "low_stock";
  bool pushNotifications = true;
  bool emailNotifications = false;
  String selectedProduct = "";
  String stockThreshold = "10";
  List<Map<String, dynamic>> stockAlerts = [
    {
      "id": 1,
      "product": "iPhone 15 Pro",
      "currentStock": 5,
      "threshold": 10,
      "alertType": "low_stock",
      "status": "active",
      "lastTriggered": "2024-01-15T10:30:00Z",
      "category": "Electronics"
    },
    {
      "id": 2,
      "product": "Samsung Galaxy S24",
      "currentStock": 15,
      "threshold": 20,
      "alertType": "low_stock",
      "status": "active",
      "lastTriggered": "2024-01-14T14:45:00Z",
      "category": "Electronics"
    },
    {
      "id": 3,
      "product": "MacBook Air M2",
      "currentStock": 0,
      "threshold": 5,
      "alertType": "out_of_stock",
      "status": "triggered",
      "lastTriggered": "2024-01-16T09:15:00Z",
      "category": "Computers"
    },
    {
      "id": 4,
      "product": "Nike Air Max 270",
      "currentStock": 3,
      "threshold": 15,
      "alertType": "low_stock",
      "status": "active",
      "lastTriggered": "2024-01-13T16:20:00Z",
      "category": "Fashion"
    }
  ];

  List<Map<String, dynamic>> alertTypeItems = [
    {"label": "Low Stock", "value": "low_stock"},
    {"label": "Out of Stock", "value": "out_of_stock"},
    {"label": "High Stock", "value": "high_stock"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Alerts"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _showAddAlertDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAlertSettings(),
            _buildActiveAlerts(),
            _buildAlertHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertSettings() {
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
            "Alert Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Alert Type",
                  items: alertTypeItems,
                  value: selectedAlertType,
                  onChanged: (value, label) {
                    selectedAlertType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Stock Threshold",
                  value: stockThreshold,
                  onChanged: (value) {
                    stockThreshold = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Push Notifications",
                      "value": true,
                      "checked": pushNotifications,
                    }
                  ],
                  value: [
                    if (pushNotifications)
                      {"label": "Push Notifications", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    pushNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Email Notifications",
                      "value": true,
                      "checked": emailNotifications,
                    }
                  ],
                  value: [
                    if (emailNotifications)
                      {"label": "Email Notifications", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    emailNotifications = values.isNotEmpty;
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

  Widget _buildActiveAlerts() {
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
                "Active Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${stockAlerts.where((alert) => alert["status"] == "triggered").length} Critical",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...stockAlerts.map((alert) => _buildAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color statusColor = alert["status"] == "triggered" ? dangerColor : warningColor;
    IconData statusIcon = alert["status"] == "triggered" ? Icons.error : Icons.warning;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                statusIcon,
                color: statusColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${alert["product"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${alert["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Stock: ${alert["currentStock"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Threshold: ${alert["threshold"]}",
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
                    "Last Alert",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${DateTime.parse(alert["lastTriggered"] as String).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editAlert(alert),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: QButton(
                  label: "Delete",
                  size: bs.sm,
                  onPressed: () => _deleteAlert(alert["id"]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertHistory() {
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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(3, (index) {
            return Container(
              padding: EdgeInsets.all(spXs),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Stock alert triggered for ${stockAlerts[index]["product"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "${DateTime.parse(stockAlerts[index]["lastTriggered"] as String).dMMMy}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showAddAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Stock Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Product Name",
              value: selectedProduct,
              onChanged: (value) {
                selectedProduct = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Stock Threshold",
              value: stockThreshold,
              onChanged: (value) {
                stockThreshold = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Add Alert",
            size: bs.sm,
            onPressed: () {
              _addAlert();
              back();
            },
          ),
        ],
      ),
    );
  }

  void _addAlert() {
    setState(() {
      stockAlerts.add({
        "id": stockAlerts.length + 1,
        "product": selectedProduct,
        "currentStock": 0,
        "threshold": int.tryParse(stockThreshold) ?? 10,
        "alertType": selectedAlertType,
        "status": "active",
        "lastTriggered": DateTime.now().toIso8601String(),
        "category": "General"
      });
    });
    ss("Stock alert added successfully");
  }

  void _editAlert(Map<String, dynamic> alert) {
    // Edit alert logic
    si("Alert settings updated");
  }

  void _deleteAlert(int id) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this alert?");
    if (isConfirmed) {
      setState(() {
        stockAlerts.removeWhere((alert) => alert["id"] == id);
      });
      ss("Alert deleted successfully");
    }
  }
}
