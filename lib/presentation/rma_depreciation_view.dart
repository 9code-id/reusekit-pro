import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDepreciationView extends StatefulWidget {
  const RmaDepreciationView({super.key});

  @override
  State<RmaDepreciationView> createState() => _RmaDepreciationViewState();
}

class _RmaDepreciationViewState extends State<RmaDepreciationView> {
  final formKey = GlobalKey<FormState>();
  String selectedProperty = "";
  String assetName = "";
  String assetCost = "";
  String purchaseDate = "";
  String depreciationMethod = "straight_line";
  String usefulLife = "";
  String salvageValue = "0";
  String notes = "";
  bool loading = false;

  List<Map<String, dynamic>> properties = [
    {"label": "Sunset Apartments Unit 1A", "value": "sunset_1a"},
    {"label": "Downtown Loft 205", "value": "downtown_205"},
    {"label": "Garden View Villa", "value": "garden_villa"},
    {"label": "Metro Plaza Suite 12", "value": "metro_12"},
  ];

  List<Map<String, dynamic>> methodItems = [
    {"label": "Straight Line", "value": "straight_line"},
    {"label": "Declining Balance", "value": "declining_balance"},
    {"label": "MACRS", "value": "macrs"},
    {"label": "Units of Production", "value": "units_production"},
  ];

  List<Map<String, dynamic>> lifeItems = [
    {"label": "5 Years", "value": "5"},
    {"label": "7 Years", "value": "7"},
    {"label": "10 Years", "value": "10"},
    {"label": "15 Years", "value": "15"},
    {"label": "20 Years", "value": "20"},
    {"label": "27.5 Years (Residential)", "value": "27.5"},
    {"label": "39 Years (Commercial)", "value": "39"},
  ];

  List<Map<String, dynamic>> assets = [
    {
      "id": "DEP001",
      "property": "Sunset Apartments Unit 1A",
      "asset_name": "Building Structure",
      "original_cost": 250000.0,
      "purchase_date": "2020-01-15",
      "method": "straight_line",
      "useful_life": 27.5,
      "salvage_value": 25000.0,
      "annual_depreciation": 8181.82,
      "accumulated_depreciation": 32727.28,
      "book_value": 217272.72,
      "years_remaining": 23.5,
    },
    {
      "id": "DEP002",
      "property": "Downtown Loft 205",
      "asset_name": "HVAC System",
      "original_cost": 15000.0,
      "purchase_date": "2022-03-10",
      "method": "straight_line",
      "useful_life": 15.0,
      "salvage_value": 1500.0,
      "annual_depreciation": 900.0,
      "accumulated_depreciation": 1800.0,
      "book_value": 13200.0,
      "years_remaining": 13.0,
    },
    {
      "id": "DEP003",
      "property": "Garden View Villa",
      "asset_name": "Kitchen Appliances",
      "original_cost": 8500.0,
      "purchase_date": "2023-01-20",
      "method": "macrs",
      "useful_life": 7.0,
      "salvage_value": 0.0,
      "annual_depreciation": 1214.29,
      "accumulated_depreciation": 1214.29,
      "book_value": 7285.71,
      "years_remaining": 6.0,
    },
    {
      "id": "DEP004",
      "property": "Metro Plaza Suite 12",
      "asset_name": "Flooring",
      "original_cost": 12000.0,
      "purchase_date": "2021-05-15",
      "method": "straight_line",
      "useful_life": 10.0,
      "salvage_value": 1200.0,
      "annual_depreciation": 1080.0,
      "accumulated_depreciation": 3240.0,
      "book_value": 8760.0,
      "years_remaining": 7.0,
    },
    {
      "id": "DEP005",
      "property": "Sunset Apartments Unit 1A",
      "asset_name": "Water Heater",
      "original_cost": 2500.0,
      "purchase_date": "2023-06-01",
      "method": "straight_line",
      "useful_life": 10.0,
      "salvage_value": 250.0,
      "annual_depreciation": 225.0,
      "accumulated_depreciation": 112.50,
      "book_value": 2387.50,
      "years_remaining": 9.5,
    },
  ];

  List<Map<String, dynamic>> filteredAssets = [];
  String searchQuery = "";
  String filterProperty = "";

  @override
  void initState() {
    super.initState();
    filteredAssets = List.from(assets);
    purchaseDate = DateTime.now().toString().split(' ')[0];
  }

  void _filterAssets() {
    filteredAssets = assets.where((asset) {
      bool matchesSearch = searchQuery.isEmpty ||
          (asset["asset_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (asset["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProperty = filterProperty.isEmpty || 
          properties.any((p) => p["value"] == filterProperty && p["label"] == asset["property"]);
      
      return matchesSearch && matchesProperty;
    }).toList();
    setState(() {});
  }

  void _addAsset() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 2));

      double cost = double.tryParse(assetCost) ?? 0.0;
      double salvage = double.tryParse(salvageValue) ?? 0.0;
      double life = double.tryParse(usefulLife) ?? 1.0;
      double annualDep = (cost - salvage) / life;

      assets.add({
        "id": "DEP${(assets.length + 1).toString().padLeft(3, '0')}",
        "property": properties.firstWhere((p) => p["value"] == selectedProperty)["label"],
        "asset_name": assetName,
        "original_cost": cost,
        "purchase_date": purchaseDate,
        "method": depreciationMethod,
        "useful_life": life,
        "salvage_value": salvage,
        "annual_depreciation": annualDep,
        "accumulated_depreciation": 0.0,
        "book_value": cost,
        "years_remaining": life,
      });

      _resetForm();
      _filterAssets();
      loading = false;
      setState(() {});
      ss("Depreciation asset added successfully");
    }
  }

  void _resetForm() {
    selectedProperty = "";
    assetName = "";
    assetCost = "";
    purchaseDate = DateTime.now().toString().split(' ')[0];
    depreciationMethod = "straight_line";
    usefulLife = "";
    salvageValue = "0";
    notes = "";
  }

  String _getMethodLabel(String method) {
    switch (method) {
      case 'straight_line':
        return 'Straight Line';
      case 'declining_balance':
        return 'Declining Balance';
      case 'macrs':
        return 'MACRS';
      case 'units_production':
        return 'Units of Production';
      default:
        return method;
    }
  }

  Map<String, double> _getDepreciationSummary() {
    double totalOriginalCost = assets.fold(0.0, (sum, asset) => sum + (asset["original_cost"] as double));
    double totalAccumulated = assets.fold(0.0, (sum, asset) => sum + (asset["accumulated_depreciation"] as double));
    double totalBookValue = assets.fold(0.0, (sum, asset) => sum + (asset["book_value"] as double));
    double totalAnnual = assets.fold(0.0, (sum, asset) => sum + (asset["annual_depreciation"] as double));

    return {
      "original_cost": totalOriginalCost,
      "accumulated": totalAccumulated,
      "book_value": totalBookValue,
      "annual": totalAnnual,
    };
  }

  @override
  Widget build(BuildContext context) {
    final summary = _getDepreciationSummary();

    return Scaffold(
      appBar: AppBar(
        title: Text("Depreciation"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Add Depreciable Asset",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Form(
                        key: formKey,
                        child: Column(
                          spacing: spSm,
                          children: [
                            QDropdownField(
                              label: "Property",
                              items: properties,
                              value: selectedProperty,
                              validator: Validator.required,
                              onChanged: (value, label) {
                                selectedProperty = value;
                                setState(() {});
                              },
                            ),
                            QTextField(
                              label: "Asset Name",
                              value: assetName,
                              validator: Validator.required,
                              onChanged: (value) {
                                assetName = value;
                                setState(() {});
                              },
                            ),
                            QNumberField(
                              label: "Original Cost (\$)",
                              value: assetCost,
                              validator: Validator.required,
                              onChanged: (value) {
                                assetCost = value;
                                setState(() {});
                              },
                            ),
                            QDatePicker(
                              label: "Purchase Date",
                              value: DateTime.parse(purchaseDate),
                              onChanged: (value) {
                                purchaseDate = value.toString().split(' ')[0];
                                setState(() {});
                              },
                            ),
                            QDropdownField(
                              label: "Depreciation Method",
                              items: methodItems,
                              value: depreciationMethod,
                              onChanged: (value, label) {
                                depreciationMethod = value;
                                setState(() {});
                              },
                            ),
                            QDropdownField(
                              label: "Useful Life",
                              items: lifeItems,
                              value: usefulLife,
                              validator: Validator.required,
                              onChanged: (value, label) {
                                usefulLife = value;
                                setState(() {});
                              },
                            ),
                            QNumberField(
                              label: "Salvage Value (\$)",
                              value: salvageValue,
                              onChanged: (value) {
                                salvageValue = value;
                                setState(() {});
                              },
                            ),
                            QMemoField(
                              label: "Notes",
                              value: notes,
                              onChanged: (value) {
                                notes = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              color: disabledBoldColor,
                              size: bs.md,
                              onPressed: () {
                                back();
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: loading ? "Adding..." : "Add Asset",
                              size: bs.md,
                              onPressed: loading ? null : _addAsset,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Asset Value",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["original_cost"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Original cost basis",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Accumulated Depreciation",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["accumulated"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Total depreciated",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Current Book Value",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["book_value"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Remaining value",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Annual Depreciation",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["annual"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Tax deduction",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: QTextField(
                      label: "Search assets...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        _filterAssets();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Filter Property",
                      items: [
                        {"label": "All Properties", "value": ""},
                        ...properties,
                      ],
                      value: filterProperty,
                      onChanged: (value, label) {
                        filterProperty = value;
                        _filterAssets();
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Assets List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Text(
                      "Depreciable Assets (${filteredAssets.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredAssets.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final asset = filteredAssets[index];
                      double depreciationPercent = ((asset["accumulated_depreciation"] as double) / (asset["original_cost"] as double)) * 100;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 100,
                              decoration: BoxDecoration(
                                color: depreciationPercent < 25 ? successColor :
                                       depreciationPercent < 75 ? warningColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${asset["asset_name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "ID: ${asset["id"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${asset["property"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getMethodLabel(asset["method"]),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${(asset["useful_life"] as double).toStringAsFixed(1)} years",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Original Cost: \$${(asset["original_cost"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "Accumulated: \$${(asset["accumulated_depreciation"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: dangerColor,
                                              ),
                                            ),
                                            Text(
                                              "Book Value: \$${(asset["book_value"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        spacing: 2,
                                        children: [
                                          Text(
                                            "Annual: \$${(asset["annual_depreciation"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: warningColor,
                                            ),
                                          ),
                                          Text(
                                            "${(asset["years_remaining"] as double).toStringAsFixed(1)} years left",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${depreciationPercent.toStringAsFixed(1)}% depreciated",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Purchase Date: ${DateTime.parse(asset["purchase_date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.more_vert,
                              color: primaryColor,
                              size: bs.sm,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    padding: EdgeInsets.all(spMd),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: disabledColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        Text(
                                          "Asset Actions",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        Column(
                                          spacing: spSm,
                                          children: [
                                            QButton(
                                              label: "View Details",
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Viewing asset details");
                                              },
                                            ),
                                            QButton(
                                              label: "Depreciation Schedule",
                                              color: successColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Viewing depreciation schedule");
                                              },
                                            ),
                                            QButton(
                                              label: "Update Asset",
                                              color: warningColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Updating asset information");
                                              },
                                            ),
                                            QButton(
                                              label: "Export Tax Report",
                                              color: infoColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Exporting tax report");
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
