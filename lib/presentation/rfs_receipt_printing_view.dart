import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsReceiptPrintingView extends StatefulWidget {
  const RfsReceiptPrintingView({super.key});

  @override
  State<RfsReceiptPrintingView> createState() => _RfsReceiptPrintingViewState();
}

class _RfsReceiptPrintingViewState extends State<RfsReceiptPrintingView> {
  int selectedTab = 0;
  String selectedPrinter = "Kitchen Printer 1";
  String receiptTemplate = "Standard";
  bool enableAutoPrint = true;
  bool printCustomerCopy = true;
  bool printKitchenCopy = true;
  bool includeItemDetails = true;
  bool includeTaxBreakdown = true;
  bool includeTipLine = true;
  String paperSize = "80mm";

  List<Map<String, dynamic>> printers = [
    {
      "name": "Kitchen Printer 1",
      "model": "Epson TM-T88VI",
      "status": "Online",
      "location": "Kitchen",
      "ipAddress": "192.168.1.101",
      "paperLevel": 85
    },
    {
      "name": "Bar Printer",
      "model": "Star TSP143III",
      "status": "Online", 
      "location": "Bar",
      "ipAddress": "192.168.1.102",
      "paperLevel": 92
    },
    {
      "name": "Customer Receipt",
      "model": "Epson TM-T20III",
      "status": "Low Paper",
      "location": "Front Counter",
      "ipAddress": "192.168.1.103",
      "paperLevel": 15
    },
    {
      "name": "Manager Office",
      "model": "Brother QL-820NWB",
      "status": "Offline",
      "location": "Office",
      "ipAddress": "192.168.1.104",
      "paperLevel": 0
    }
  ];

  List<Map<String, dynamic>> printHistory = [
    {
      "id": "RCP001",
      "orderNumber": "ORD-1234",
      "type": "Customer Receipt",
      "printer": "Customer Receipt",
      "timestamp": "2024-06-19 15:45",
      "status": "Printed",
      "copies": 1,
      "total": 67.80
    },
    {
      "id": "RCP002",
      "orderNumber": "ORD-1234",
      "type": "Kitchen Order",
      "printer": "Kitchen Printer 1",
      "timestamp": "2024-06-19 15:44",
      "status": "Printed",
      "copies": 1,
      "total": 67.80
    },
    {
      "id": "RCP003",
      "orderNumber": "ORD-1233",
      "type": "Customer Receipt",
      "printer": "Customer Receipt",
      "timestamp": "2024-06-19 15:30",
      "status": "Failed",
      "copies": 1,
      "total": 45.50
    },
    {
      "id": "RCP004",
      "orderNumber": "ORD-1232",
      "type": "Bar Order",
      "printer": "Bar Printer",
      "timestamp": "2024-06-19 15:15",
      "status": "Printed",
      "copies": 2,
      "total": 89.25
    }
  ];

  List<Map<String, dynamic>> printerOptions = [
    {"label": "Kitchen Printer 1", "value": "Kitchen Printer 1"},
    {"label": "Bar Printer", "value": "Bar Printer"},
    {"label": "Customer Receipt", "value": "Customer Receipt"},
    {"label": "Manager Office", "value": "Manager Office"}
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Standard", "value": "Standard"},
    {"label": "Detailed", "value": "Detailed"},
    {"label": "Compact", "value": "Compact"},
    {"label": "Custom", "value": "Custom"}
  ];

  List<Map<String, dynamic>> paperSizeOptions = [
    {"label": "58mm", "value": "58mm"},
    {"label": "80mm", "value": "80mm"},
    {"label": "Letter", "value": "Letter"},
    {"label": "A4", "value": "A4"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Receipt Printing",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Print Receipt", icon: Icon(Icons.print)),
        Tab(text: "Printers", icon: Icon(Icons.local_print_shop)),
        Tab(text: "Print History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildPrintReceiptTab(),
        _buildPrintersTab(),
        _buildPrintHistoryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildPrintReceiptTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Order Preview
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Icon(Icons.receipt_long, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order #ORD-1235",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Table 7 • Dine In",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$67.80",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Divider(),
                // Sample receipt preview
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "RESTAURANT NAME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "123 Main Street, City, State 12345",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Phone: (555) 123-4567",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Order: #ORD-1235",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Table: 7",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Date: 2024-06-19 15:45",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Divider(),
                      _buildReceiptItem("Caesar Salad", 1, 12.50),
                      _buildReceiptItem("Grilled Salmon", 1, 28.00),
                      _buildReceiptItem("Chocolate Cake", 1, 8.50),
                      _buildReceiptItem("Coffee", 2, 3.50),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal:", style: TextStyle(fontSize: 14)),
                          Text("\$56.00", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax:", style: TextStyle(fontSize: 14)),
                          Text("\$4.48", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Service Charge:", style: TextStyle(fontSize: 14)),
                          Text("\$7.32", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TOTAL:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$67.80",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (includeTipLine) ...[
                        SizedBox(height: spSm),
                        Text("Tip: _____________"),
                        Text("Total: _____________"),
                      ],
                      SizedBox(height: spSm),
                      Text(
                        "Thank you for dining with us!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Print Options
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Print Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Select Printer",
                  items: printerOptions,
                  value: selectedPrinter,
                  onChanged: (value, label) {
                    selectedPrinter = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Receipt Template",
                  items: templateOptions,
                  value: receiptTemplate,
                  onChanged: (value, label) {
                    receiptTemplate = value;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Print customer copy",
                      "value": "customer_copy",
                      "checked": printCustomerCopy,
                    },
                    {
                      "label": "Print kitchen copy",
                      "value": "kitchen_copy",
                      "checked": printKitchenCopy,
                    }
                  ],
                  value: [
                    if (printCustomerCopy)
                      {"label": "Print customer copy", "value": "customer_copy", "checked": true},
                    if (printKitchenCopy)
                      {"label": "Print kitchen copy", "value": "kitchen_copy", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    printCustomerCopy = values.any((v) => v["value"] == "customer_copy");
                    printKitchenCopy = values.any((v) => v["value"] == "kitchen_copy");
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Quick Print Actions
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildPrintActionCard(
                "Customer Receipt",
                Icons.receipt,
                primaryColor,
                () => _printReceipt("customer"),
              ),
              _buildPrintActionCard(
                "Kitchen Order",
                Icons.restaurant,
                successColor,
                () => _printReceipt("kitchen"),
              ),
              _buildPrintActionCard(
                "Bar Order",
                Icons.local_bar,
                infoColor,
                () => _printReceipt("bar"),
              ),
              _buildPrintActionCard(
                "Duplicate Copy",
                Icons.content_copy,
                warningColor,
                () => _printReceipt("duplicate"),
              ),
            ],
          ),

          // Main Print Button
          QButton(
            label: "Print Receipt",
            size: bs.md,
            onPressed: () {
              showLoading();
              Future.delayed(Duration(seconds: 2), () {
                hideLoading();
                ss("Receipt printed successfully!");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptItem(String item, int qty, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "${qty}x ${item}",
            style: TextStyle(fontSize: 12),
          ),
        ),
        Text(
          "\$${(qty * price).toStringAsFixed(2)}",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPrintActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _printReceipt(String type) {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("${type.toUpperCase()} receipt printed successfully!");
    });
  }

  Widget _buildPrintersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Printer Status Overview
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
                      Icon(Icons.check_circle, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "3",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Online",
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
                      Icon(Icons.error, color: dangerColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Offline",
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

          // Printer List
          ...printers.map((printer) {
            Color statusColor;
            IconData statusIcon;
            
            switch (printer["status"] as String) {
              case "Online":
                statusColor = successColor;
                statusIcon = Icons.check_circle;
                break;
              case "Low Paper":
                statusColor = warningColor;
                statusIcon = Icons.warning;
                break;
              case "Offline":
                statusColor = dangerColor;
                statusIcon = Icons.error;
                break;
              default:
                statusColor = disabledBoldColor;
                statusIcon = Icons.help;
            }

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: statusColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.print, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${printer["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${printer["model"]} • ${printer["location"]}",
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
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, color: statusColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${printer["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.network_wifi, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${printer["ipAddress"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.description, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Paper: ${printer["paperLevel"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if ((printer["paperLevel"] as int) > 0)
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: (printer["paperLevel"] as int) / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: (printer["paperLevel"] as int) > 30 
                                ? successColor 
                                : (printer["paperLevel"] as int) > 15 
                                    ? warningColor 
                                    : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Test Print",
                          size: bs.sm,
                          onPressed: () {
                            si("Test print sent to ${printer["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.settings,
                        size: bs.sm,
                        onPressed: () {
                          si("Opening settings for ${printer["name"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPrintHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Stats Cards
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
                      Icon(Icons.print, color: primaryColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "24",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Printed Today",
                        textAlign: TextAlign.center,
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
                      Icon(Icons.error, color: dangerColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Failed",
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

          // Print History List
          ...printHistory.map((print) {
            Color statusColor = (print["status"] as String) == "Printed" 
                ? successColor 
                : dangerColor;
            
            IconData typeIcon;
            switch (print["type"] as String) {
              case "Customer Receipt":
                typeIcon = Icons.receipt;
                break;
              case "Kitchen Order":
                typeIcon = Icons.restaurant;
                break;
              case "Bar Order":
                typeIcon = Icons.local_bar;
                break;
              default:
                typeIcon = Icons.print;
            }
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: statusColor,
                  ),
                ),
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
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(typeIcon, size: 16, color: primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${print["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${print["type"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${print["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                          Text(
                            "${print["copies"]} copy",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_print_shop, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${print["printer"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${print["orderNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${print["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(print["total"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Print Settings
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Print Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable automatic printing",
                      "value": "auto_print",
                      "checked": enableAutoPrint,
                    }
                  ],
                  value: [
                    if (enableAutoPrint)
                      {"label": "Enable automatic printing", "value": "auto_print", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    enableAutoPrint = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Default Paper Size",
                  items: paperSizeOptions,
                  value: paperSize,
                  onChanged: (value, label) {
                    paperSize = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Receipt Content
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Receipt Content",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Include item details",
                      "value": "item_details",
                      "checked": includeItemDetails,
                    },
                    {
                      "label": "Include tax breakdown",
                      "value": "tax_breakdown",
                      "checked": includeTaxBreakdown,
                    },
                    {
                      "label": "Include tip line",
                      "value": "tip_line",
                      "checked": includeTipLine,
                    }
                  ],
                  value: [
                    if (includeItemDetails)
                      {"label": "Include item details", "value": "item_details", "checked": true},
                    if (includeTaxBreakdown)
                      {"label": "Include tax breakdown", "value": "tax_breakdown", "checked": true},
                    if (includeTipLine)
                      {"label": "Include tip line", "value": "tip_line", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    includeItemDetails = values.any((v) => v["value"] == "item_details");
                    includeTaxBreakdown = values.any((v) => v["value"] == "tax_breakdown");
                    includeTipLine = values.any((v) => v["value"] == "tip_line");
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Printer Network Settings
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Network Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Network Range",
                  value: "192.168.1.x",
                  hint: "Enter network range for printer discovery",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Scan for Printers",
                        size: bs.md,
                        onPressed: () {
                          showLoading();
                          Future.delayed(Duration(seconds: 3), () {
                            hideLoading();
                            si("Found 2 new printers on network");
                          });
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.md,
                      onPressed: () {
                        si("Refreshing printer status...");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          QButton(
            label: "Save Print Settings",
            size: bs.md,
            onPressed: () {
              ss("Print settings saved successfully!");
            },
          ),
        ],
      ),
    );
  }
}
