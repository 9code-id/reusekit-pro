import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaLandedCostView extends StatefulWidget {
  const ImaLandedCostView({super.key});

  @override
  State<ImaLandedCostView> createState() => _ImaLandedCostViewState();
}

class _ImaLandedCostViewState extends State<ImaLandedCostView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedPO = "";
  String selectedSupplier = "";
  String selectedShipment = "";
  String itemCode = "";
  String itemName = "";
  double unitCost = 0.0;
  double shippingCost = 0.0;
  double insuranceCost = 0.0;
  double customsDuty = 0.0;
  double handlingCost = 0.0;
  double otherCosts = 0.0;
  int quantity = 0;
  String currencyCode = "USD";
  
  List<Map<String, dynamic>> poList = [
    {"label": "PO-2024-001", "value": "PO001"},
    {"label": "PO-2024-002", "value": "PO002"},
    {"label": "PO-2024-003", "value": "PO003"},
    {"label": "PO-2024-004", "value": "PO004"},
    {"label": "PO-2024-005", "value": "PO005"},
  ];
  
  List<Map<String, dynamic>> supplierList = [
    {"label": "TechSupply Corp", "value": "SUP001"},
    {"label": "Global Electronics", "value": "SUP002"},
    {"label": "Asia Components Ltd", "value": "SUP003"},
    {"label": "Euro Parts Inc", "value": "SUP004"},
    {"label": "American Hardware Co", "value": "SUP005"},
  ];
  
  List<Map<String, dynamic>> shipmentList = [
    {"label": "SHIP-001 (Sea Freight)", "value": "SHIP001"},
    {"label": "SHIP-002 (Air Freight)", "value": "SHIP002"},
    {"label": "SHIP-003 (Express)", "value": "SHIP003"},
    {"label": "SHIP-004 (Ground)", "value": "SHIP004"},
  ];
  
  List<Map<String, dynamic>> landedCosts = [
    {
      "poNumber": "PO-2024-001",
      "supplier": "TechSupply Corp",
      "itemCode": "LAP001",
      "itemName": "Laptop Computer",
      "quantity": 50,
      "unitCost": 450.00,
      "shippingCost": 2500.00,
      "insuranceCost": 450.00,
      "customsDuty": 1350.00,
      "handlingCost": 250.00,
      "totalLandedCost": 27000.00,
      "landedCostPerUnit": 540.00,
      "shipmentDate": DateTime.now().subtract(Duration(days: 15)),
      "status": "Completed",
    },
    {
      "poNumber": "PO-2024-002",
      "supplier": "Global Electronics",
      "itemCode": "MON001",
      "itemName": "Monitor 24 inch",
      "quantity": 100,
      "unitCost": 180.00,
      "shippingCost": 1200.00,
      "insuranceCost": 180.00,
      "customsDuty": 540.00,
      "handlingCost": 150.00,
      "totalLandedCost": 20070.00,
      "landedCostPerUnit": 200.70,
      "shipmentDate": DateTime.now().subtract(Duration(days: 8)),
      "status": "In Transit",
    },
    {
      "poNumber": "PO-2024-003",
      "supplier": "Asia Components Ltd",
      "itemCode": "KEY001",
      "itemName": "Keyboard Wireless",
      "quantity": 200,
      "unitCost": 25.00,
      "shippingCost": 800.00,
      "insuranceCost": 100.00,
      "customsDuty": 300.00,
      "handlingCost": 100.00,
      "totalLandedCost": 6300.00,
      "landedCostPerUnit": 31.50,
      "shipmentDate": DateTime.now().subtract(Duration(days: 22)),
      "status": "Completed",
    },
    {
      "poNumber": "PO-2024-004",
      "supplier": "Euro Parts Inc",
      "itemCode": "MOU001",
      "itemName": "Mouse Optical",
      "quantity": 150,
      "unitCost": 15.00,
      "shippingCost": 450.00,
      "insuranceCost": 45.00,
      "customsDuty": 135.00,
      "handlingCost": 75.00,
      "totalLandedCost": 2955.00,
      "landedCostPerUnit": 19.70,
      "shipmentDate": DateTime.now().subtract(Duration(days: 3)),
      "status": "Processing",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landed Cost Management"),
        actions: [
          IconButton(
            onPressed: () {
              _showAddLandedCostDialog();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            _buildFilterSection(),
            _buildLandedCostTable(),
            _buildCostBreakdownChart(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryCards() {
    final totalShipments = landedCosts.length;
    final avgLandedCost = landedCosts.map((c) => c["landedCostPerUnit"] as double).reduce((a, b) => a + b) / landedCosts.length;
    final totalShippingCost = landedCosts.map((c) => c["shippingCost"] as double).reduce((a, b) => a + b);
    final totalCustomsDuty = landedCosts.map((c) => c["customsDuty"] as double).reduce((a, b) => a + b);
    
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Shipments",
          "$totalShipments",
          Icons.local_shipping,
          primaryColor,
        ),
        _buildSummaryCard(
          "Avg Landed Cost/Unit",
          "\$${avgLandedCost.toStringAsFixed(2)}",
          Icons.calculate,
          successColor,
        ),
        _buildSummaryCard(
          "Total Shipping Cost",
          "\$${totalShippingCost.toStringAsFixed(2)}",
          Icons.flight,
          infoColor,
        ),
        _buildSummaryCard(
          "Total Customs Duty",
          "\$${totalCustomsDuty.toStringAsFixed(2)}",
          Icons.account_balance,
          warningColor,
        ),
      ],
    );
  }
  
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
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
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
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
  
  Widget _buildFilterSection() {
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
          Text(
            "Filter Landed Costs",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Purchase Order",
                  items: poList,
                  value: selectedPO,
                  onChanged: (value, label) {
                    selectedPO = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Supplier",
                  items: supplierList,
                  value: selectedSupplier,
                  onChanged: (value, label) {
                    selectedSupplier = value;
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
  
  Widget _buildLandedCostTable() {
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
          Text(
            "Landed Cost Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: landedCosts.length,
            itemBuilder: (context, index) {
              final cost = landedCosts[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cost["poNumber"]} - ${cost["itemName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Supplier: ${cost["supplier"]} | Code: ${cost["itemCode"]}",
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
                            color: _getStatusColor(cost["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${cost["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(cost["status"]),
                            ),
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
                                "Quantity",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${cost["quantity"]} units",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Unit Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(cost["unitCost"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Landed Cost/Unit",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(cost["landedCostPerUnit"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
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
                          child: _buildCostBreakdownItem("Shipping", cost["shippingCost"] as double),
                        ),
                        Expanded(
                          child: _buildCostBreakdownItem("Insurance", cost["insuranceCost"] as double),
                        ),
                        Expanded(
                          child: _buildCostBreakdownItem("Customs", cost["customsDuty"] as double),
                        ),
                        Expanded(
                          child: _buildCostBreakdownItem("Handling", cost["handlingCost"] as double),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Shipment Date: ${(cost["shipmentDate"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Total: \$${(cost["totalLandedCost"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            _editLandedCost(cost);
                          },
                          child: Icon(
                            Icons.edit,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildCostBreakdownItem(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: infoColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCostBreakdownChart() {
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
          Text(
            "Cost Impact Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: landedCosts.map((cost) {
              final unitCost = cost["unitCost"] as double;
              final landedCost = cost["landedCostPerUnit"] as double;
              final costIncrease = landedCost - unitCost;
              final increasePercentage = (costIncrease / unitCost) * 100;
              
              return Container(
                width: 200,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${cost["poNumber"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${cost["itemCode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unit Cost",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${unitCost.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Landed Cost",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${landedCost.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: increasePercentage > 25 ? dangerColor.withAlpha(20) : warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: increasePercentage > 25 ? dangerColor : warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "+${increasePercentage.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: increasePercentage > 25 ? dangerColor : warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Transit":
        return infoColor;
      case "Processing":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _showAddLandedCostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 600,
            padding: EdgeInsets.all(spMd),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Landed Cost",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Purchase Order",
                            items: poList,
                            value: selectedPO,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedPO = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Shipment",
                            items: shipmentList,
                            value: selectedShipment,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedShipment = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Item Code",
                            value: itemCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              itemCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Item Name",
                            value: itemName,
                            validator: Validator.required,
                            onChanged: (value) {
                              itemName = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Quantity",
                            value: quantity.toString(),
                            validator: Validator.required,
                            onChanged: (value) {
                              quantity = int.tryParse("$value") ?? 0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Unit Cost (\$)",
                            value: unitCost.toString(),
                            validator: Validator.required,
                            onChanged: (value) {
                              unitCost = double.tryParse("$value") ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Shipping Cost (\$)",
                            value: shippingCost.toString(),
                            validator: Validator.required,
                            onChanged: (value) {
                              shippingCost = double.tryParse("$value") ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Insurance Cost (\$)",
                            value: insuranceCost.toString(),
                            onChanged: (value) {
                              insuranceCost = double.tryParse("$value") ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Customs Duty (\$)",
                            value: customsDuty.toString(),
                            onChanged: (value) {
                              customsDuty = double.tryParse("$value") ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Handling Cost (\$)",
                            value: handlingCost.toString(),
                            onChanged: (value) {
                              handlingCost = double.tryParse("$value") ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QNumberField(
                      label: "Other Costs (\$)",
                      value: otherCosts.toString(),
                      onChanged: (value) {
                        otherCosts = double.tryParse("$value") ?? 0.0;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cost Summary",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "Total Additional Costs:",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${(shippingCost + insuranceCost + customsDuty + handlingCost + otherCosts).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Landed Cost Per Unit:",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${quantity > 0 ? ((unitCost * quantity + shippingCost + insuranceCost + customsDuty + handlingCost + otherCosts) / quantity).toStringAsFixed(2) : "0.00"}",
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
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        QButton(
                          label: "Cancel",
                          size: bs.sm,
                          onPressed: () {
                            back();
                          },
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Save Landed Cost",
                            size: bs.sm,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _saveLandedCost();
                                back();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  void _editLandedCost(Map<String, dynamic> cost) {
    itemCode = cost["itemCode"];
    itemName = cost["itemName"];
    quantity = cost["quantity"];
    unitCost = cost["unitCost"];
    shippingCost = cost["shippingCost"];
    insuranceCost = cost["insuranceCost"];
    customsDuty = cost["customsDuty"];
    handlingCost = cost["handlingCost"];
    
    _showAddLandedCostDialog();
  }
  
  void _saveLandedCost() {
    ss("Landed cost saved successfully");
    
    // Reset form
    itemCode = "";
    itemName = "";
    quantity = 0;
    unitCost = 0.0;
    shippingCost = 0.0;
    insuranceCost = 0.0;
    customsDuty = 0.0;
    handlingCost = 0.0;
    otherCosts = 0.0;
    
    setState(() {});
  }
}
