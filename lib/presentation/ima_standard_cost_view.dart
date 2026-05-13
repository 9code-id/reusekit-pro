import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaStandardCostView extends StatefulWidget {
  const ImaStandardCostView({super.key});

  @override
  State<ImaStandardCostView> createState() => _ImaStandardCostViewState();
}

class _ImaStandardCostViewState extends State<ImaStandardCostView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedProduct = "";
  String selectedCategory = "";
  String itemCode = "";
  String itemName = "";
  String description = "";
  double materialCost = 0.0;
  double laborCost = 0.0;
  double overheadCost = 0.0;
  double setupCost = 0.0;
  String costCenter = "";
  String revisionNote = "";
  bool isActive = true;
  
  List<Map<String, dynamic>> productList = [
    {"label": "Laptop Computer", "value": "LAP001"},
    {"label": "Desktop Computer", "value": "DES001"},
    {"label": "Monitor 24 inch", "value": "MON001"},
    {"label": "Keyboard Wireless", "value": "KEY001"},
    {"label": "Mouse Optical", "value": "MOU001"},
  ];
  
  List<Map<String, dynamic>> categoryList = [
    {"label": "Electronics", "value": "ELEC"},
    {"label": "Computer Hardware", "value": "COMP"},
    {"label": "Accessories", "value": "ACC"},
    {"label": "Peripherals", "value": "PER"},
    {"label": "Components", "value": "COMP"},
  ];
  
  List<Map<String, dynamic>> costCenterList = [
    {"label": "Production Center 1", "value": "PC001"},
    {"label": "Production Center 2", "value": "PC002"},
    {"label": "Assembly Line A", "value": "ALA001"},
    {"label": "Assembly Line B", "value": "ALB001"},
    {"label": "Quality Control", "value": "QC001"},
  ];
  
  List<Map<String, dynamic>> standardCosts = [
    {
      "itemCode": "LAP001",
      "itemName": "Laptop Computer",
      "category": "Electronics",
      "materialCost": 450.00,
      "laborCost": 120.00,
      "overheadCost": 85.00,
      "totalCost": 655.00,
      "status": "Active",
      "lastUpdated": DateTime.now().subtract(Duration(days: 5)),
    },
    {
      "itemCode": "DES001",
      "itemName": "Desktop Computer", 
      "category": "Electronics",
      "materialCost": 380.00,
      "laborCost": 95.00,
      "overheadCost": 70.00,
      "totalCost": 545.00,
      "status": "Active",
      "lastUpdated": DateTime.now().subtract(Duration(days: 12)),
    },
    {
      "itemCode": "MON001",
      "itemName": "Monitor 24 inch",
      "category": "Computer Hardware",
      "materialCost": 180.00,
      "laborCost": 45.00,
      "overheadCost": 32.00,
      "totalCost": 257.00,
      "status": "Active",
      "lastUpdated": DateTime.now().subtract(Duration(days: 8)),
    },
    {
      "itemCode": "KEY001",
      "itemName": "Keyboard Wireless",
      "category": "Accessories",
      "materialCost": 25.00,
      "laborCost": 8.00,
      "overheadCost": 5.50,
      "totalCost": 38.50,
      "status": "Inactive",
      "lastUpdated": DateTime.now().subtract(Duration(days: 30)),
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Standard Cost Management"),
        actions: [
          IconButton(
            onPressed: () {
              _showAddCostDialog();
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
            _buildCostTable(),
            _buildCostAnalysisChart(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Products",
          "${standardCosts.length}",
          Icons.inventory,
          primaryColor,
        ),
        _buildSummaryCard(
          "Active Costs",
          "${standardCosts.where((c) => c["status"] == "Active").length}",
          Icons.check_circle,
          successColor,
        ),
        _buildSummaryCard(
          "Avg Material Cost",
          "\$${(standardCosts.map((c) => c["materialCost"] as double).reduce((a, b) => a + b) / standardCosts.length).toStringAsFixed(2)}",
          Icons.build,
          infoColor,
        ),
        _buildSummaryCard(
          "Total Standard Value",
          "\$${standardCosts.map((c) => c["totalCost"] as double).reduce((a, b) => a + b).toStringAsFixed(2)}",
          Icons.attach_money,
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
            "Filter Standard Costs",
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
                  label: "Product",
                  items: productList,
                  value: selectedProduct,
                  onChanged: (value, label) {
                    selectedProduct = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryList,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
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
  
  Widget _buildCostTable() {
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
            "Standard Cost Details",
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
            itemCount: standardCosts.length,
            itemBuilder: (context, index) {
              final cost = standardCosts[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                                "${cost["itemName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Code: ${cost["itemCode"]} | ${cost["category"]}",
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
                            color: cost["status"] == "Active" ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${cost["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: cost["status"] == "Active" ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCostItem("Material", cost["materialCost"] as double),
                        ),
                        Expanded(
                          child: _buildCostItem("Labor", cost["laborCost"] as double),
                        ),
                        Expanded(
                          child: _buildCostItem("Overhead", cost["overheadCost"] as double),
                        ),
                        Expanded(
                          child: _buildCostItem("Total", cost["totalCost"] as double),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Last Updated: ${(cost["lastUpdated"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _editStandardCost(cost);
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
  
  Widget _buildCostItem(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCostAnalysisChart() {
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
            "Cost Breakdown Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: standardCosts.length,
              itemBuilder: (context, index) {
                final cost = standardCosts[index];
                final materialPercent = (cost["materialCost"] as double) / (cost["totalCost"] as double) * 100;
                final laborPercent = (cost["laborCost"] as double) / (cost["totalCost"] as double) * 100;
                final overheadPercent = (cost["overheadCost"] as double) / (cost["totalCost"] as double) * 100;
                
                return Container(
                  width: 180,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cost["itemCode"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      _buildPercentageBar("Material", materialPercent, primaryColor),
                      SizedBox(height: spXs),
                      _buildPercentageBar("Labor", laborPercent, successColor),
                      SizedBox(height: spXs),
                      _buildPercentageBar("Overhead", overheadPercent, warningColor),
                      SizedBox(height: spSm),
                      Text(
                        "Total: \$${(cost["totalCost"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPercentageBar(String label, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Spacer(),
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  void _showAddCostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: EdgeInsets.all(spMd),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Standard Cost",
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
                  QDropdownField(
                    label: "Cost Center",
                    items: costCenterList,
                    value: costCenter,
                    validator: Validator.required,
                    onChanged: (value, label) {
                      costCenter = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Material Cost (\$)",
                          value: materialCost.toString(),
                          validator: Validator.required,
                          onChanged: (value) {
                            materialCost = double.tryParse("$value") ?? 0.0;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Labor Cost (\$)",
                          value: laborCost.toString(),
                          validator: Validator.required,
                          onChanged: (value) {
                            laborCost = double.tryParse("$value") ?? 0.0;
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
                          label: "Overhead Cost (\$)",
                          value: overheadCost.toString(),
                          validator: Validator.required,
                          onChanged: (value) {
                            overheadCost = double.tryParse("$value") ?? 0.0;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Setup Cost (\$)",
                          value: setupCost.toString(),
                          onChanged: (value) {
                            setupCost = double.tryParse("$value") ?? 0.0;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Revision Note",
                    value: revisionNote,
                    onChanged: (value) {
                      revisionNote = value;
                      setState(() {});
                    },
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
                          label: "Save Standard Cost",
                          size: bs.sm,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _saveStandardCost();
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
        );
      },
    );
  }
  
  void _editStandardCost(Map<String, dynamic> cost) {
    itemCode = cost["itemCode"];
    itemName = cost["itemName"];
    materialCost = cost["materialCost"];
    laborCost = cost["laborCost"];
    overheadCost = cost["overheadCost"];
    
    _showAddCostDialog();
  }
  
  void _saveStandardCost() {
    ss("Standard cost saved successfully");
    
    // Reset form
    itemCode = "";
    itemName = "";
    materialCost = 0.0;
    laborCost = 0.0;
    overheadCost = 0.0;
    setupCost = 0.0;
    revisionNote = "";
    
    setState(() {});
  }
}
