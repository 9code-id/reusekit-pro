import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAssetAccountsView extends StatefulWidget {
  const AbaAssetAccountsView({super.key});

  @override
  State<AbaAssetAccountsView> createState() => _AbaAssetAccountsViewState();
}

class _AbaAssetAccountsViewState extends State<AbaAssetAccountsView> {
  String searchQuery = "";
  String selectedCategory = "";
  String sortBy = "name";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Assets", "value": ""},
    {"label": "Current Assets", "value": "current"},
    {"label": "Fixed Assets", "value": "fixed"},
    {"label": "Intangible Assets", "value": "intangible"},
    {"label": "Investments", "value": "investment"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Asset Name", "value": "name"},
    {"label": "Value (High to Low)", "value": "value_desc"},
    {"label": "Value (Low to High)", "value": "value_asc"},
    {"label": "Category", "value": "category"},
    {"label": "Date Acquired", "value": "date_desc"},
  ];

  List<Map<String, dynamic>> assetAccounts = [
    {
      "id": "1",
      "assetName": "Office Building - Main Location",
      "assetCategory": "Fixed Assets",
      "assetType": "Real Estate",
      "currentValue": 850000.00,
      "originalCost": 750000.00,
      "accumulatedDepreciation": 125000.00,
      "bookValue": 625000.00,
      "acquisitionDate": "2020-03-15",
      "depreciationMethod": "Straight Line",
      "usefulLife": 30,
      "location": "123 Business St, Downtown",
      "condition": "Excellent",
      "lastAppraisal": "2024-06-01",
      "insurance": true,
      "insuranceValue": 900000.00,
    },
    {
      "id": "2",
      "assetName": "Company Vehicles Fleet",
      "assetCategory": "Fixed Assets",
      "assetType": "Vehicles",
      "currentValue": 245000.00,
      "originalCost": 320000.00,
      "accumulatedDepreciation": 115000.00,
      "bookValue": 205000.00,
      "acquisitionDate": "2022-01-10",
      "depreciationMethod": "Declining Balance",
      "usefulLife": 8,
      "location": "Main Office Parking",
      "condition": "Good",
      "lastAppraisal": "2024-08-15",
      "insurance": true,
      "insuranceValue": 280000.00,
    },
    {
      "id": "3",
      "assetName": "Manufacturing Equipment",
      "assetCategory": "Fixed Assets",
      "assetType": "Machinery",
      "currentValue": 425000.00,
      "originalCost": 500000.00,
      "accumulatedDepreciation": 200000.00,
      "bookValue": 300000.00,
      "acquisitionDate": "2021-09-20",
      "depreciationMethod": "Units of Production",
      "usefulLife": 12,
      "location": "Factory Floor A",
      "condition": "Very Good",
      "lastAppraisal": "2024-05-10",
      "insurance": true,
      "insuranceValue": 450000.00,
    },
    {
      "id": "4",
      "assetName": "Investment Portfolio - Stocks",
      "assetCategory": "Investments",
      "assetType": "Securities",
      "currentValue": 186000.00,
      "originalCost": 150000.00,
      "accumulatedDepreciation": 0.00,
      "bookValue": 186000.00,
      "acquisitionDate": "2023-02-28",
      "depreciationMethod": "N/A",
      "usefulLife": 0,
      "location": "Portfolio Account #789",
      "condition": "Active",
      "lastAppraisal": "2024-12-15",
      "insurance": false,
      "insuranceValue": 0.00,
    },
    {
      "id": "5",
      "assetName": "Software Licenses & Patents",
      "assetCategory": "Intangible Assets",
      "assetType": "Intellectual Property",
      "currentValue": 95000.00,
      "originalCost": 120000.00,
      "accumulatedDepreciation": 48000.00,
      "bookValue": 72000.00,
      "acquisitionDate": "2022-11-05",
      "depreciationMethod": "Straight Line",
      "usefulLife": 5,
      "location": "Digital Assets",
      "condition": "Active",
      "lastAppraisal": "2024-07-20",
      "insurance": true,
      "insuranceValue": 100000.00,
    },
    {
      "id": "6",
      "assetName": "Cash & Cash Equivalents",
      "assetCategory": "Current Assets",
      "assetType": "Liquid Assets",
      "currentValue": 125000.00,
      "originalCost": 125000.00,
      "accumulatedDepreciation": 0.00,
      "bookValue": 125000.00,
      "acquisitionDate": "2024-12-01",
      "depreciationMethod": "N/A",
      "usefulLife": 0,
      "location": "Various Bank Accounts",
      "condition": "Available",
      "lastAppraisal": "2024-12-15",
      "insurance": true,
      "insuranceValue": 125000.00,
    },
  ];

  List<Map<String, dynamic>> get filteredAssets {
    var filtered = assetAccounts.where((asset) {
      final matchesSearch = searchQuery.isEmpty ||
          (asset["assetName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (asset["assetType"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (asset["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory.isEmpty ||
          (asset["assetCategory"] as String).toLowerCase().contains(selectedCategory);
      
      return matchesSearch && matchesCategory;
    }).toList();

    switch (sortBy) {
      case "value_desc":
        filtered.sort((a, b) => (b["currentValue"] as double).compareTo(a["currentValue"] as double));
        break;
      case "value_asc":
        filtered.sort((a, b) => (a["currentValue"] as double).compareTo(b["currentValue"] as double));
        break;
      case "category":
        filtered.sort((a, b) => (a["assetCategory"] as String).compareTo(b["assetCategory"] as String));
        break;
      case "date_desc":
        filtered.sort((a, b) => DateTime.parse(b["acquisitionDate"]).compareTo(DateTime.parse(a["acquisitionDate"])));
        break;
      default:
        filtered.sort((a, b) => (a["assetName"] as String).compareTo(b["assetName"] as String));
    }

    return filtered;
  }

  double get totalAssetValue {
    return assetAccounts.fold(0.0, (sum, asset) => sum + (asset["currentValue"] as double));
  }

  double get totalBookValue {
    return assetAccounts.fold(0.0, (sum, asset) => sum + (asset["bookValue"] as double));
  }

  double get totalInsuranceValue {
    return assetAccounts
        .where((asset) => asset["insurance"] as bool)
        .fold(0.0, (sum, asset) => sum + (asset["insuranceValue"] as double));
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'current assets':
        return successColor;
      case 'fixed assets':
        return primaryColor;
      case 'intangible assets':
        return infoColor;
      case 'investments':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'current assets':
        return Icons.account_balance_wallet;
      case 'fixed assets':
        return Icons.business;
      case 'intangible assets':
        return Icons.psychology;
      case 'investments':
        return Icons.trending_up;
      default:
        return Icons.account_balance;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asset Accounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add asset
            },
          ),
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              // Navigate to asset reports
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Asset Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Asset Value",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(230),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.account_balance,
                        color: Colors.white.withAlpha(230),
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "\$${totalAssetValue.currency}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Book Value: \$${totalBookValue.currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${assetAccounts.length} Assets",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Current",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${assetAccounts.where((a) => a["assetCategory"] == "Current Assets").fold(0.0, (sum, a) => sum + (a["currentValue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.business,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Fixed",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${assetAccounts.where((a) => a["assetCategory"] == "Fixed Assets").fold(0.0, (sum, a) => sum + (a["currentValue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Investments",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${assetAccounts.where((a) => a["assetCategory"] == "Investments").fold(0.0, (sum, a) => sum + (a["currentValue"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
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
                        child: QTextField(
                          label: "Search assets",
                          value: searchQuery,
                          hint: "Search by name, type, or location",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Category",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortItems,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Assets Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Asset Accounts (${filteredAssets.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Asset",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to add asset
                  },
                ),
              ],
            ),

            // Assets List
            ...filteredAssets.map((asset) {
              final category = asset["assetCategory"] as String;
              final categoryColor = _getCategoryColor(category);
              final categoryIcon = _getCategoryIcon(category);
              final currentValue = asset["currentValue"] as double;
              final bookValue = asset["bookValue"] as double;
              final originalCost = asset["originalCost"] as double;
              final accumulatedDepreciation = asset["accumulatedDepreciation"] as double;
              final depreciationRate = originalCost > 0 ? (accumulatedDepreciation / originalCost) * 100 : 0.0;
              final hasInsurance = asset["insurance"] as bool;
              
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: categoryColor.withAlpha(30), width: 2),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(10),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: categoryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              categoryIcon,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${asset["assetName"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: categoryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: categoryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${asset["assetType"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: disabledBoldColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${asset["location"]}",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${currentValue.currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: categoryColor,
                                ),
                              ),
                              Text(
                                "Current Value",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Details Section
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        spacing: spMd,
                        children: [
                          // Financial Details Grid
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Book Value",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${bookValue.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
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
                                      "Original Cost",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${originalCost.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: infoColor,
                                        fontWeight: FontWeight.bold,
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
                                      "Depreciation",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${depreciationRate.toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dangerColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Asset Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: infoColor.withAlpha(30)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Acquired: ${DateTime.parse(asset["acquisitionDate"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Condition: ${asset["condition"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (asset["depreciationMethod"] != "N/A")
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${asset["depreciationMethod"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${asset["usefulLife"]} years",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Insurance Info
                          if (hasInsurance)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: successColor.withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.security,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Insured Asset",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Coverage: \$${(asset["insuranceValue"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to asset details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Update Value",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to update asset value
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show more options
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Add Asset Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Asset",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {
                  // Navigate to add asset
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

