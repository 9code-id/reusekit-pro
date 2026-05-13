import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCapitalGainsView extends StatefulWidget {
  const RmaCapitalGainsView({super.key});

  @override
  State<RmaCapitalGainsView> createState() => _RmaCapitalGainsViewState();
}

class _RmaCapitalGainsViewState extends State<RmaCapitalGainsView> {
  final formKey = GlobalKey<FormState>();
  String propertyAddress = "";
  String purchasePrice = "";
  String purchaseDate = "";
  String salePrice = "";
  String saleDate = "";
  String improvementCosts = "0";
  String sellingExpenses = "0";
  String notes = "";
  bool loading = false;

  List<Map<String, dynamic>> capitalGains = [
    {
      "id": "CG001",
      "property_address": "123 Sunset Boulevard, Apt 1A",
      "purchase_date": "2018-03-15",
      "purchase_price": 180000.0,
      "sale_date": "2024-01-20",
      "sale_price": 265000.0,
      "improvement_costs": 15000.0,
      "selling_expenses": 18550.0,
      "adjusted_basis": 195000.0,
      "net_proceeds": 246450.0,
      "capital_gain": 51450.0,
      "holding_period": 2137, // days
      "gain_type": "long_term",
      "depreciation_recapture": 8500.0,
    },
    {
      "id": "CG002",
      "property_address": "456 Downtown Plaza, Unit 205",
      "purchase_date": "2020-08-10",
      "purchase_price": 220000.0,
      "sale_date": "2024-03-15",
      "sale_price": 280000.0,
      "improvement_costs": 12000.0,
      "selling_expenses": 19600.0,
      "adjusted_basis": 232000.0,
      "net_proceeds": 260400.0,
      "capital_gain": 28400.0,
      "holding_period": 1313, // days
      "gain_type": "long_term",
      "depreciation_recapture": 6200.0,
    },
    {
      "id": "CG003",
      "property_address": "789 Garden View Drive",
      "purchase_date": "2023-01-05",
      "purchase_price": 350000.0,
      "sale_date": "2024-05-30",
      "sale_price": 380000.0,
      "improvement_costs": 8000.0,
      "selling_expenses": 26600.0,
      "adjusted_basis": 358000.0,
      "net_proceeds": 353400.0,
      "capital_gain": -4600.0, // Capital loss
      "holding_period": 511, // days
      "gain_type": "short_term",
      "depreciation_recapture": 0.0,
    },
  ];

  List<Map<String, dynamic>> filteredGains = [];
  String searchQuery = "";
  String selectedYear = "";

  @override
  void initState() {
    super.initState();
    filteredGains = List.from(capitalGains);
    purchaseDate = DateTime.now().subtract(Duration(days: 365)).toString().split(' ')[0];
    saleDate = DateTime.now().toString().split(' ')[0];
    selectedYear = DateTime.now().year.toString();
  }

  void _filterGains() {
    filteredGains = capitalGains.where((gain) {
      bool matchesSearch = searchQuery.isEmpty ||
          (gain["property_address"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (gain["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesYear = selectedYear.isEmpty ||
          (gain["sale_date"] as String).startsWith(selectedYear);
      
      return matchesSearch && matchesYear;
    }).toList();
    setState(() {});
  }

  void _addCapitalGain() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 2));

      double purchase = double.tryParse(purchasePrice) ?? 0.0;
      double sale = double.tryParse(salePrice) ?? 0.0;
      double improvements = double.tryParse(improvementCosts) ?? 0.0;
      double expenses = double.tryParse(sellingExpenses) ?? 0.0;
      
      double adjustedBasis = purchase + improvements;
      double netProceeds = sale - expenses;
      double capitalGain = netProceeds - adjustedBasis;
      
      DateTime purchaseDt = DateTime.parse(purchaseDate);
      DateTime saleDt = DateTime.parse(saleDate);
      int holdingPeriod = saleDt.difference(purchaseDt).inDays;
      String gainType = holdingPeriod > 365 ? "long_term" : "short_term";

      capitalGains.add({
        "id": "CG${(capitalGains.length + 1).toString().padLeft(3, '0')}",
        "property_address": propertyAddress,
        "purchase_date": purchaseDate,
        "purchase_price": purchase,
        "sale_date": saleDate,
        "sale_price": sale,
        "improvement_costs": improvements,
        "selling_expenses": expenses,
        "adjusted_basis": adjustedBasis,
        "net_proceeds": netProceeds,
        "capital_gain": capitalGain,
        "holding_period": holdingPeriod,
        "gain_type": gainType,
        "depreciation_recapture": 0.0,
      });

      _resetForm();
      _filterGains();
      loading = false;
      setState(() {});
      ss("Capital gain calculation added successfully");
    }
  }

  void _resetForm() {
    propertyAddress = "";
    purchasePrice = "";
    purchaseDate = DateTime.now().subtract(Duration(days: 365)).toString().split(' ')[0];
    salePrice = "";
    saleDate = DateTime.now().toString().split(' ')[0];
    improvementCosts = "0";
    sellingExpenses = "0";
    notes = "";
  }

  Color _getGainColor(double gain) {
    if (gain > 0) return successColor;
    if (gain < 0) return dangerColor;
    return disabledBoldColor;
  }

  String _getGainTypeLabel(String type) {
    switch (type) {
      case 'long_term':
        return 'Long-term';
      case 'short_term':
        return 'Short-term';
      default:
        return type;
    }
  }

  Color _getGainTypeColor(String type) {
    switch (type) {
      case 'long_term':
        return successColor;
      case 'short_term':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Map<String, double> _getCapitalGainsSummary() {
    double totalGains = filteredGains.where((g) => (g["capital_gain"] as double) > 0)
        .fold(0.0, (sum, gain) => sum + (gain["capital_gain"] as double));
    double totalLosses = filteredGains.where((g) => (g["capital_gain"] as double) < 0)
        .fold(0.0, (sum, gain) => sum + (gain["capital_gain"] as double).abs());
    double longTermGains = filteredGains.where((g) => g["gain_type"] == "long_term" && (g["capital_gain"] as double) > 0)
        .fold(0.0, (sum, gain) => sum + (gain["capital_gain"] as double));
    double shortTermGains = filteredGains.where((g) => g["gain_type"] == "short_term" && (g["capital_gain"] as double) > 0)
        .fold(0.0, (sum, gain) => sum + (gain["capital_gain"] as double));
    double depreciationRecapture = filteredGains.fold(0.0, (sum, gain) => sum + (gain["depreciation_recapture"] as double));

    return {
      "total_gains": totalGains,
      "total_losses": totalLosses,
      "net_gains": totalGains - totalLosses,
      "long_term_gains": longTermGains,
      "short_term_gains": shortTermGains,
      "depreciation_recapture": depreciationRecapture,
    };
  }

  @override
  Widget build(BuildContext context) {
    final summary = _getCapitalGainsSummary();

    return Scaffold(
      appBar: AppBar(
        title: Text("Capital Gains"),
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
                        "Add Capital Gain/Loss",
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
                            QTextField(
                              label: "Property Address",
                              value: propertyAddress,
                              validator: Validator.required,
                              onChanged: (value) {
                                propertyAddress = value;
                                setState(() {});
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: QNumberField(
                                    label: "Purchase Price (\$)",
                                    value: purchasePrice,
                                    validator: Validator.required,
                                    onChanged: (value) {
                                      purchasePrice = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QDatePicker(
                                    label: "Purchase Date",
                                    value: DateTime.parse(purchaseDate),
                                    onChanged: (value) {
                                      purchaseDate = value.toString().split(' ')[0];
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: QNumberField(
                                    label: "Sale Price (\$)",
                                    value: salePrice,
                                    validator: Validator.required,
                                    onChanged: (value) {
                                      salePrice = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QDatePicker(
                                    label: "Sale Date",
                                    value: DateTime.parse(saleDate),
                                    onChanged: (value) {
                                      saleDate = value.toString().split(' ')[0];
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            QNumberField(
                              label: "Improvement Costs (\$)",
                              value: improvementCosts,
                              onChanged: (value) {
                                improvementCosts = value;
                                setState(() {});
                              },
                            ),
                            QNumberField(
                              label: "Selling Expenses (\$)",
                              value: sellingExpenses,
                              onChanged: (value) {
                                sellingExpenses = value;
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
                              label: loading ? "Adding..." : "Calculate",
                              size: bs.md,
                              onPressed: loading ? null : _addCapitalGain,
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
                            Icons.trending_up,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Gains",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["total_gains"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Capital gains realized",
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
                            "Total Losses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["total_losses"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Capital losses realized",
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
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Net Gains",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["net_gains"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: _getGainColor(summary["net_gains"]!),
                        ),
                      ),
                      Text(
                        "Net capital gains",
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
                            Icons.access_time,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Long-term Gains",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(summary["long_term_gains"]!).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Held > 1 year",
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
                      label: "Search properties...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        _filterGains();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Sale Year (YYYY)",
                      value: selectedYear,
                      onChanged: (value) {
                        selectedYear = value;
                        _filterGains();
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Capital Gains/Losses List
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
                      "Capital Gains & Losses (${filteredGains.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredGains.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final gain = filteredGains[index];
                      double capitalGain = gain["capital_gain"];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 120,
                              decoration: BoxDecoration(
                                color: _getGainColor(capitalGain),
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
                                          "${gain["property_address"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getGainTypeColor(gain["gain_type"]).withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getGainTypeLabel(gain["gain_type"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _getGainTypeColor(gain["gain_type"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "ID: ${gain["id"]} • Held: ${((gain["holding_period"] as int) / 365).toStringAsFixed(1)} years",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Purchase: \$${(gain["purchase_price"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "Sale: \$${(gain["sale_price"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "Improvements: \$${(gain["improvement_costs"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: infoColor,
                                              ),
                                            ),
                                            Text(
                                              "Selling Costs: \$${(gain["selling_expenses"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: warningColor,
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
                                            "Adjusted Basis:",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(gain["adjusted_basis"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Net Proceeds:",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(gain["net_proceeds"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${capitalGain >= 0 ? 'Capital Gain' : 'Capital Loss'}: ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "\$${capitalGain.abs().currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _getGainColor(capitalGain),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if ((gain["depreciation_recapture"] as double) > 0)
                                    Text(
                                      "Depreciation Recapture: \$${(gain["depreciation_recapture"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Text(
                                        "Purchase: ${DateTime.parse(gain["purchase_date"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • Sale: ${DateTime.parse(gain["sale_date"]).dMMMy}",
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
                                          "Capital Gain Actions",
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
                                              label: "View Calculation",
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Viewing detailed calculation");
                                              },
                                            ),
                                            QButton(
                                              label: "Generate Form 8949",
                                              color: successColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Generating Form 8949");
                                              },
                                            ),
                                            QButton(
                                              label: "1031 Exchange Info",
                                              color: infoColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Showing 1031 exchange information");
                                              },
                                            ),
                                            QButton(
                                              label: "Export Tax Report",
                                              color: warningColor,
                                              size: bs.md,
                                              onPressed: () {
                                                back();
                                                si("Exporting capital gains report");
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
