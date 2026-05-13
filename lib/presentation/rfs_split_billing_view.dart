import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsSplitBillingView extends StatefulWidget {
  const RfsSplitBillingView({super.key});

  @override
  State<RfsSplitBillingView> createState() => _RfsSplitBillingViewState();
}

class _RfsSplitBillingViewState extends State<RfsSplitBillingView> {
  int currentTab = 0;
  String selectedTable = "Table 12";
  String splitType = "Equal Split";
  int numberOfSplits = 3;
  String customSplitAmount = "";
  bool applyTaxToAll = true;
  bool applyServiceChargeToAll = true;

  List<Map<String, dynamic>> tableList = [
    {"label": "Table 1", "value": "Table 1"},
    {"label": "Table 2", "value": "Table 2"},
    {"label": "Table 8", "value": "Table 8"},
    {"label": "Table 12", "value": "Table 12"},
    {"label": "Table 15", "value": "Table 15"},
    {"label": "VIP Room 1", "value": "VIP Room 1"},
    {"label": "VIP Room 2", "value": "VIP Room 2"},
  ];

  List<Map<String, dynamic>> splitTypeOptions = [
    {"label": "Equal Split", "value": "Equal Split"},
    {"label": "Custom Amount", "value": "Custom Amount"},
    {"label": "By Items", "value": "By Items"},
    {"label": "Percentage Split", "value": "Percentage Split"},
  ];

  List<Map<String, dynamic>> activeBills = [
    {
      "billId": "BILL-2024-035",
      "table": "Table 8",
      "totalAmount": 156.90,
      "items": 8,
      "customers": 4,
      "status": "Active",
      "startTime": "18:30",
      "duration": "45 mins"
    },
    {
      "billId": "BILL-2024-036",
      "table": "Table 12",
      "totalAmount": 234.75,
      "items": 12,
      "customers": 6,
      "status": "Active",
      "startTime": "19:15",
      "duration": "30 mins"
    },
    {
      "billId": "BILL-2024-037",
      "table": "VIP Room 1",
      "totalAmount": 445.20,
      "items": 15,
      "customers": 8,
      "status": "Active",
      "startTime": "17:45",
      "duration": "1 hr 20 mins"
    },
    {
      "billId": "BILL-2024-038",
      "table": "Table 15",
      "totalAmount": 89.40,
      "items": 5,
      "customers": 2,
      "status": "Active",
      "startTime": "19:45",
      "duration": "15 mins"
    }
  ];

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Grilled Salmon",
      "category": "Main Course",
      "price": 28.99,
      "quantity": 2,
      "total": 57.98,
      "assignedTo": ["Customer 1", "Customer 3"],
      "selected": false
    },
    {
      "name": "Caesar Salad",
      "category": "Appetizer",
      "price": 14.50,
      "quantity": 3,
      "total": 43.50,
      "assignedTo": ["Customer 1", "Customer 2", "Customer 3"],
      "selected": false
    },
    {
      "name": "Beef Tenderloin",
      "category": "Main Course",
      "price": 35.99,
      "quantity": 1,
      "total": 35.99,
      "assignedTo": ["Customer 2"],
      "selected": false
    },
    {
      "name": "Wine Bottle - Cabernet",
      "category": "Beverage",
      "price": 45.00,
      "quantity": 1,
      "total": 45.00,
      "assignedTo": ["Shared"],
      "selected": false
    },
    {
      "name": "Chocolate Dessert Platter",
      "category": "Dessert",
      "price": 18.99,
      "quantity": 1,
      "total": 18.99,
      "assignedTo": ["Shared"],
      "selected": false
    },
    {
      "name": "Sparkling Water",
      "category": "Beverage",
      "price": 4.50,
      "quantity": 4,
      "total": 18.00,
      "assignedTo": ["Customer 1", "Customer 2", "Customer 3", "Customer 4"],
      "selected": false
    }
  ];

  List<Map<String, dynamic>> customers = [
    {
      "id": 1,
      "name": "Customer 1",
      "items": ["Grilled Salmon", "Caesar Salad", "Sparkling Water"],
      "subtotal": 33.32,
      "tax": 3.33,
      "serviceCharge": 3.33,
      "total": 39.98,
      "paymentMethod": "Credit Card",
      "status": "Pending"
    },
    {
      "id": 2,
      "name": "Customer 2",
      "items": ["Caesar Salad", "Beef Tenderloin", "Sparkling Water"],
      "subtotal": 64.83,
      "tax": 6.48,
      "serviceCharge": 6.48,
      "total": 77.79,
      "paymentMethod": "Cash",
      "status": "Pending"
    },
    {
      "id": 3,
      "name": "Customer 3",
      "items": ["Grilled Salmon", "Caesar Salad", "Sparkling Water"],
      "subtotal": 33.32,
      "tax": 3.33,
      "serviceCharge": 3.33,
      "total": 39.98,
      "paymentMethod": "Digital Wallet",
      "status": "Pending"
    },
    {
      "id": 4,
      "name": "Customer 4",
      "items": ["Sparkling Water"],
      "subtotal": 4.50,
      "tax": 0.45,
      "serviceCharge": 0.45,
      "total": 5.40,
      "paymentMethod": "Cash",
      "status": "Pending"
    }
  ];

  List<Map<String, dynamic>> splitHistory = [
    {
      "billId": "BILL-2024-033",
      "table": "Table 5",
      "originalAmount": 187.60,
      "splits": 4,
      "splitType": "Equal Split",
      "date": "2024-01-15",
      "time": "16:45",
      "status": "Completed"
    },
    {
      "billId": "BILL-2024-034",
      "table": "VIP Room 2",
      "originalAmount": 512.90,
      "splits": 6,
      "splitType": "By Items",
      "date": "2024-01-15",
      "time": "17:20",
      "status": "Completed"
    },
    {
      "billId": "BILL-2024-032",
      "table": "Table 3",
      "originalAmount": 96.40,
      "splits": 2,
      "splitType": "Custom Amount",
      "date": "2024-01-15",
      "time": "15:30",
      "status": "Completed"
    },
    {
      "billId": "BILL-2024-031",
      "table": "Table 10",
      "originalAmount": 234.75,
      "splits": 3,
      "splitType": "Percentage Split",
      "date": "2024-01-15",
      "time": "14:15",
      "status": "Completed"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Split Billing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Split Bill", icon: Icon(Icons.call_split)),
        Tab(text: "Active Bills", icon: Icon(Icons.receipt)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildSplitBillTab(),
        _buildActiveBillsTab(),
        _buildHistoryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildSplitBillTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBillSelection(),
          _buildSplitConfiguration(),
          _buildOrderItemsList(),
          _buildCustomerSplits(),
          _buildSplitActions(),
        ],
      ),
    );
  }

  Widget _buildBillSelection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.receipt_long, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Select Bill to Split",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QDropdownField(
            label: "Table/Bill",
            items: tableList,
            value: selectedTable,
            onChanged: (value, label) {
              selectedTable = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Current Bill: BILL-2024-036",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Amount: \$234.75 • 12 Items • 6 Customers",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitConfiguration() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.call_split, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Split Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Split Type",
                  items: splitTypeOptions,
                  value: splitType,
                  onChanged: (value, label) {
                    splitType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Number of Splits",
                  value: numberOfSplits.toString(),
                  onChanged: (value) {
                    numberOfSplits = int.tryParse(value) ?? 3;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (splitType == "Custom Amount")
            QNumberField(
              label: "Custom Split Amount (\$)",
              value: customSplitAmount,
              hint: "Enter amount for this split",
              onChanged: (value) {
                customSplitAmount = value;
                setState(() {});
              },
            ),
          QSwitch(
            items: [
              {
                "label": "Apply tax to all splits",
                "value": "apply_tax",
                "checked": applyTaxToAll,
              }
            ],
            value: [if (applyTaxToAll) {"label": "Apply tax to all splits", "value": "apply_tax", "checked": true}],
            onChanged: (values, ids) {
              applyTaxToAll = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Apply service charge to all splits",
                "value": "apply_service",
                "checked": applyServiceChargeToAll,
              }
            ],
            value: [if (applyServiceChargeToAll) {"label": "Apply service charge to all splits", "value": "apply_service", "checked": true}],
            onChanged: (values, ids) {
              applyServiceChargeToAll = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsList() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.restaurant_menu, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Order Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Assign to customers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Divider(),
          ...orderItems.map((item) => _buildOrderItemCard(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItemCard(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["category"]} • \$${(item["price"] as double).toStringAsFixed(2)} x ${item["quantity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(item["total"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Assigned to: ${(item["assignedTo"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ),
              QButton(
                label: "Reassign",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSplits() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.people, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Customer Splits",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Total: \$234.75",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          ...customers.map((customer) => _buildCustomerSplitCard(customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerSplitCard(Map<String, dynamic> customer) {
    Color statusColor = customer["status"] == "Paid" ? successColor : 
                       customer["status"] == "Pending" ? warningColor : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${customer["id"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${(customer["items"] as List).length} items • ${customer["paymentMethod"]}",
                      style: TextStyle(
                        fontSize: 12,
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${customer["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("Subtotal:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(customer["subtotal"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Text("Tax:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(customer["tax"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Text("Service Charge:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(customer["serviceCharge"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(customer["total"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Modify",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Process Payment",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSplitActions() {
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
          Row(
            children: [
              Icon(Icons.payment, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Split Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Split",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: () {
                    ss("Split configuration saved");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Print Bills",
                  icon: Icons.print,
                  size: bs.md,
                  onPressed: () {
                    ss("Split bills sent to printer");
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Process All Payments",
              icon: Icons.credit_card,
              size: bs.md,
              onPressed: () {
                ss("Processing payments for all splits");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBillsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActiveBillsOverview(),
          _buildActiveBillsList(),
        ],
      ),
    );
  }

  Widget _buildActiveBillsOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Active Bills", "12", Icons.receipt, primaryColor),
        _buildOverviewCard("Total Value", "\$2,456.80", Icons.attach_money, successColor),
        _buildOverviewCard("Customers", "38", Icons.people, infoColor),
        _buildOverviewCard("Avg. Bill Size", "\$204.73", Icons.trending_up, warningColor),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
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

  Widget _buildActiveBillsList() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.receipt, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Active Bills for Splitting",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...activeBills.map((bill) => _buildActiveBillCard(bill)),
        ],
      ),
    );
  }

  Widget _buildActiveBillCard(Map<String, dynamic> bill) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${bill["billId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${bill["table"]} • ${bill["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${bill["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.people, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${bill["customers"]} customers",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.restaurant_menu, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${bill["items"]} items",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Text(
                "\$${(bill["totalAmount"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "Started at ${bill["startTime"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              Spacer(),
              QButton(
                label: "Split Bill",
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                    selectedTable = bill["table"];
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryFilters(),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Filter Split History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "From Date",
                  value: DateTime.now().subtract(Duration(days: 7)),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "To Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Split Type",
                  items: [
                    {"label": "All Types", "value": "All"},
                    {"label": "Equal Split", "value": "Equal Split"},
                    {"label": "By Items", "value": "By Items"},
                    {"label": "Custom Amount", "value": "Custom Amount"},
                    {"label": "Percentage Split", "value": "Percentage Split"},
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "All"},
                    {"label": "Completed", "value": "Completed"},
                    {"label": "Partial", "value": "Partial"},
                    {"label": "Cancelled", "value": "Cancelled"},
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Split History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${splitHistory.length} records",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Divider(),
          ...splitHistory.map((record) => _buildHistoryCard(record)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> record) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${record["billId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${record["table"]} • ${record["splitType"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${record["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.call_split, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${record["splits"]} splits",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.attach_money, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "\$${(record["originalAmount"] as double).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Text(
                "${record["date"]} ${record["time"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Duplicate Split",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSplitSettings(),
          _buildPaymentSettings(),
          _buildNotificationSettings(),
        ],
      ),
    );
  }

  Widget _buildSplitSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Split Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QSwitch(
            items: [
              {
                "label": "Auto-split tax across all customers",
                "value": "auto_split_tax",
                "checked": true,
              }
            ],
            value: [{"label": "Auto-split tax across all customers", "value": "auto_split_tax", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Auto-split service charge",
                "value": "auto_split_service",
                "checked": true,
              }
            ],
            value: [{"label": "Auto-split service charge", "value": "auto_split_service", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Round split amounts to nearest cent",
                "value": "round_amounts",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
          QNumberField(
            label: "Maximum Splits Per Bill",
            value: "10",
            hint: "Maximum number of splits allowed",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.payment, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Payment Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QSwitch(
            items: [
              {
                "label": "Allow partial payments for splits",
                "value": "partial_payments",
                "checked": true,
              }
            ],
            value: [{"label": "Allow partial payments for splits", "value": "partial_payments", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Require payment before bill completion",
                "value": "require_payment",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
          QDropdownField(
            label: "Default Payment Method for Splits",
            items: [
              {"label": "Cash", "value": "Cash"},
              {"label": "Credit Card", "value": "Credit Card"},
              {"label": "Digital Wallet", "value": "Digital Wallet"},
              {"label": "Ask Customer", "value": "Ask Customer"},
            ],
            value: "Ask Customer",
            onChanged: (value, label) {},
          ),
          QNumberField(
            label: "Payment Timeout (minutes)",
            value: "15",
            hint: "Time limit for split payment",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(Icons.notifications, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QSwitch(
            items: [
              {
                "label": "Notify customers via SMS",
                "value": "sms_notifications",
                "checked": true,
              }
            ],
            value: [{"label": "Notify customers via SMS", "value": "sms_notifications", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Send email receipts for each split",
                "value": "email_receipts",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Alert staff when split is completed",
                "value": "staff_alerts",
                "checked": true,
              }
            ],
            value: [{"label": "Alert staff when split is completed", "value": "staff_alerts", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QTextField(
            label: "SMS Template for Splits",
            value: "Your bill split is ready. Amount: {amount}. Pay at counter or scan QR code.",
            hint: "Custom SMS message template",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
