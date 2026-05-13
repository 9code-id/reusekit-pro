import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsBillGenerationView extends StatefulWidget {
  const RfsBillGenerationView({super.key});

  @override
  State<RfsBillGenerationView> createState() => _RfsBillGenerationViewState();
}

class _RfsBillGenerationViewState extends State<RfsBillGenerationView> {
  int currentTab = 0;
  String selectedTable = "Table 5";
  String billType = "Dine-in";
  String taxRate = "10";
  bool includeServiceCharge = true;
  String discountAmount = "0";
  String customerName = "";
  String customerPhone = "";
  String customerEmail = "";
  String paymentMethod = "Cash";
  String billStatus = "Draft";

  List<Map<String, dynamic>> tableList = [
    {"label": "Table 1", "value": "Table 1"},
    {"label": "Table 2", "value": "Table 2"},
    {"label": "Table 3", "value": "Table 3"},
    {"label": "Table 4", "value": "Table 4"},
    {"label": "Table 5", "value": "Table 5"},
    {"label": "Table 6", "value": "Table 6"},
    {"label": "Takeaway", "value": "Takeaway"},
    {"label": "Delivery", "value": "Delivery"},
  ];

  List<Map<String, dynamic>> billTypeOptions = [
    {"label": "Dine-in", "value": "Dine-in"},
    {"label": "Takeaway", "value": "Takeaway"},
    {"label": "Delivery", "value": "Delivery"},
    {"label": "Room Service", "value": "Room Service"},
  ];

  List<Map<String, dynamic>> paymentMethodOptions = [
    {"label": "Cash", "value": "Cash"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Debit Card", "value": "Debit Card"},
    {"label": "Digital Wallet", "value": "Digital Wallet"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
  ];

  List<Map<String, dynamic>> billStatusOptions = [
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Grilled Chicken Breast",
      "category": "Main Course",
      "quantity": 2,
      "price": 25.99,
      "total": 51.98,
      "notes": "Medium rare, no sauce"
    },
    {
      "name": "Caesar Salad",
      "category": "Appetizer",
      "quantity": 1,
      "price": 12.50,
      "total": 12.50,
      "notes": "Extra dressing"
    },
    {
      "name": "Coca Cola",
      "category": "Beverage",
      "quantity": 3,
      "price": 3.99,
      "total": 11.97,
      "notes": "With ice"
    },
    {
      "name": "Chocolate Cake",
      "category": "Dessert",
      "quantity": 1,
      "price": 8.99,
      "total": 8.99,
      "notes": "With vanilla ice cream"
    }
  ];

  List<Map<String, dynamic>> recentBills = [
    {
      "billId": "BILL-2024-001",
      "table": "Table 3",
      "amount": 89.45,
      "status": "Paid",
      "date": "2024-01-15",
      "time": "14:30",
      "items": 5,
      "customer": "John Smith",
      "paymentMethod": "Credit Card"
    },
    {
      "billId": "BILL-2024-002",
      "table": "Table 7",
      "amount": 156.78,
      "status": "Pending",
      "date": "2024-01-15",
      "time": "15:45",
      "items": 8,
      "customer": "Sarah Johnson",
      "paymentMethod": "Cash"
    },
    {
      "billId": "BILL-2024-003",
      "table": "Takeaway",
      "amount": 34.99,
      "status": "Paid",
      "date": "2024-01-15",
      "time": "16:20",
      "items": 3,
      "customer": "Mike Davis",
      "paymentMethod": "Digital Wallet"
    },
    {
      "billId": "BILL-2024-004",
      "table": "Table 12",
      "amount": 78.32,
      "status": "Draft",
      "date": "2024-01-15",
      "time": "17:10",
      "items": 4,
      "customer": "Emma Wilson",
      "paymentMethod": "Debit Card"
    }
  ];

  List<Map<String, dynamic>> billTemplates = [
    {
      "name": "Standard Dine-in",
      "type": "Dine-in",
      "taxRate": 10,
      "serviceCharge": true,
      "usage": 245
    },
    {
      "name": "Takeaway Quick",
      "type": "Takeaway",
      "taxRate": 8,
      "serviceCharge": false,
      "usage": 189
    },
    {
      "name": "Delivery Special",
      "type": "Delivery",
      "taxRate": 12,
      "serviceCharge": true,
      "usage": 167
    },
    {
      "name": "Room Service Premium",
      "type": "Room Service",
      "taxRate": 15,
      "serviceCharge": true,
      "usage": 98
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Bill Generation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Create Bill", icon: Icon(Icons.receipt_long)),
        Tab(text: "Recent Bills", icon: Icon(Icons.history)),
        Tab(text: "Templates", icon: Icon(Icons.bookmark)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildCreateBillTab(),
        _buildRecentBillsTab(),
        _buildTemplatesTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildCreateBillTab() {
    double subtotal = orderItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
    double discountValue = double.tryParse(discountAmount) ?? 0.0;
    double afterDiscount = subtotal - discountValue;
    double serviceCharge = includeServiceCharge ? afterDiscount * 0.10 : 0.0;
    double tax = afterDiscount * (double.tryParse(taxRate) ?? 0.0) / 100;
    double totalAmount = afterDiscount + serviceCharge + tax;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBillHeader(),
          _buildOrderItems(),
          _buildBillCalculation(subtotal, discountValue, serviceCharge, tax, totalAmount),
          _buildCustomerDetails(),
          _buildBillActions(),
        ],
      ),
    );
  }

  Widget _buildBillHeader() {
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
              Icon(Icons.receipt_long, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "New Bill",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  billStatus,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Table/Location",
                  items: tableList,
                  value: selectedTable,
                  onChanged: (value, label) {
                    selectedTable = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Bill Type",
                  items: billTypeOptions,
                  value: billType,
                  onChanged: (value, label) {
                    billType = value;
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

  Widget _buildOrderItems() {
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
              QButton(
                label: "Add Item",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
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
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                  "${item["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (item["notes"] != null && (item["notes"] as String).isNotEmpty)
                  Text(
                    "${item["notes"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: 50,
            child: Text(
              "x${item["quantity"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Container(
            width: 60,
            child: Text(
              "\$${(item["price"] as double).toStringAsFixed(2)}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              "\$${(item["total"] as double).toStringAsFixed(2)}",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.close,
              size: 16,
              color: dangerColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillCalculation(double subtotal, double discountValue, double serviceCharge, double tax, double totalAmount) {
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
              Icon(Icons.calculate, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Bill Calculation",
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
                child: QNumberField(
                  label: "Discount Amount (\$)",
                  value: discountAmount,
                  onChanged: (value) {
                    discountAmount = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Tax Rate (%)",
                  value: taxRate,
                  onChanged: (value) {
                    taxRate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Include 10% Service Charge",
                "value": true,
                "checked": includeServiceCharge,
              }
            ],
            value: [if (includeServiceCharge) {"label": "Include 10% Service Charge", "value": true, "checked": true}],
            onChanged: (values, ids) {
              includeServiceCharge = values.isNotEmpty;
              setState(() {});
            },
          ),
          Divider(),
          _buildCalculationRow("Subtotal", subtotal, false),
          if (discountValue > 0)
            _buildCalculationRow("Discount", -discountValue, false),
          if (serviceCharge > 0)
            _buildCalculationRow("Service Charge (10%)", serviceCharge, false),
          if (tax > 0)
            _buildCalculationRow("Tax (${taxRate}%)", tax, false),
          Divider(),
          _buildCalculationRow("Total Amount", totalAmount, true),
        ],
      ),
    );
  }

  Widget _buildCalculationRow(String label, double amount, bool isTotal) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : disabledBoldColor,
          ),
        ),
        Spacer(),
        Text(
          amount < 0 ? "-\$${(-amount).toStringAsFixed(2)}" : "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? primaryColor : (amount < 0 ? dangerColor : disabledBoldColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerDetails() {
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
              Icon(Icons.person, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Customer Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QTextField(
            label: "Customer Name",
            value: customerName,
            hint: "Enter customer name (optional)",
            onChanged: (value) {
              customerName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: customerPhone,
                  hint: "Customer phone",
                  onChanged: (value) {
                    customerPhone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Email",
                  value: customerEmail,
                  hint: "Customer email",
                  onChanged: (value) {
                    customerEmail = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Payment Method",
            items: paymentMethodOptions,
            value: paymentMethod,
            onChanged: (value, label) {
              paymentMethod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillActions() {
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
              Expanded(
                child: QDropdownField(
                  label: "Bill Status",
                  items: billStatusOptions,
                  value: billStatus,
                  onChanged: (value, label) {
                    billStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: () {
                    ss("Bill saved as draft");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Print Bill",
                  icon: Icons.print,
                  size: bs.md,
                  onPressed: () {
                    ss("Bill sent to printer");
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate & Process Payment",
              icon: Icons.payment,
              size: bs.md,
              onPressed: () {
                ss("Bill generated successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBillsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBillsOverview(),
          _buildBillsList(),
        ],
      ),
    );
  }

  Widget _buildBillsOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Today's Bills", "47", Icons.receipt, successColor),
        _buildOverviewCard("Total Revenue", "\$3,247.80", Icons.attach_money, primaryColor),
        _buildOverviewCard("Pending Bills", "8", Icons.pending, warningColor),
        _buildOverviewCard("Average Bill", "\$69.10", Icons.trending_up, infoColor),
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

  Widget _buildBillsList() {
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
                "Recent Bills",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...recentBills.map((bill) => _buildBillCard(bill)),
        ],
      ),
    );
  }

  Widget _buildBillCard(Map<String, dynamic> bill) {
    Color statusColor = bill["status"] == "Paid" ? successColor : 
                       bill["status"] == "Pending" ? warningColor : 
                       bill["status"] == "Draft" ? infoColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${bill["billId"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${bill["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.table_restaurant, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${bill["table"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${bill["customer"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ),
              Text(
                "\$${(bill["amount"] as double).toStringAsFixed(2)}",
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
                "${bill["date"]} ${bill["time"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              SizedBox(width: spSm),
              Text(
                "${bill["items"]} items",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  size: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
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
          _buildTemplateActions(),
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildTemplateActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.bookmark, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "Bill Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          QButton(
            label: "New Template",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: billTemplates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: primaryColor,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  size: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${template["type"]}",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: infoColor,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Tax: ${template["taxRate"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                template["serviceCharge"] ? Icons.check_circle : Icons.cancel,
                size: 12,
                color: template["serviceCharge"] ? successColor : dangerColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Service",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Used ${template["usage"]} times",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Use",
                size: bs.sm,
                onPressed: () {},
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
          _buildBillSettings(),
          _buildTaxSettings(),
          _buildPrintSettings(),
        ],
      ),
    );
  }

  Widget _buildBillSettings() {
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
                "Bill Settings",
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
                "label": "Auto-generate bill numbers",
                "value": "auto_generate",
                "checked": true,
              }
            ],
            value: [{"label": "Auto-generate bill numbers", "value": "auto_generate", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Include customer details by default",
                "value": "customer_details",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Show item notes on bill",
                "value": "item_notes",
                "checked": true,
              }
            ],
            value: [{"label": "Show item notes on bill", "value": "item_notes", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QTextField(
            label: "Bill Footer Text",
            value: "Thank you for dining with us!",
            hint: "Custom message on bill footer",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSettings() {
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
              Icon(Icons.percent, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Tax & Charges",
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
                child: QNumberField(
                  label: "Default Tax Rate (%)",
                  value: "10",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Service Charge (%)",
                  value: "10",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Apply service charge by default",
                "value": "default_service",
                "checked": true,
              }
            ],
            value: [{"label": "Apply service charge by default", "value": "default_service", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Tax inclusive pricing",
                "value": "tax_inclusive",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
        ],
      ),
    );
  }

  Widget _buildPrintSettings() {
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
              Icon(Icons.print, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Print Settings",
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
                "label": "Auto-print after bill generation",
                "value": "auto_print",
                "checked": true,
              }
            ],
            value: [{"label": "Auto-print after bill generation", "value": "auto_print", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Print customer copy",
                "value": "customer_copy",
                "checked": true,
              }
            ],
            value: [{"label": "Print customer copy", "value": "customer_copy", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QTextField(
            label: "Default Printer",
            value: "Kitchen Printer #1",
            hint: "Select default printer",
            onChanged: (value) {},
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Paper Width (mm)",
                  value: "80",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Print Copies",
                  value: "2",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
