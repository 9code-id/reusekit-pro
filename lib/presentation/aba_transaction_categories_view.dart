import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTransactionCategoriesView extends StatefulWidget {
  const AbaTransactionCategoriesView({super.key});

  @override
  State<AbaTransactionCategoriesView> createState() => _AbaTransactionCategoriesViewState();
}

class _AbaTransactionCategoriesViewState extends State<AbaTransactionCategoriesView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedGroup = "All";
  bool loading = false;

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Income", "value": "Income"},
    {"label": "Expense", "value": "Expense"},
    {"label": "Asset", "value": "Asset"},
    {"label": "Liability", "value": "Liability"},
  ];

  List<Map<String, dynamic>> groupOptions = [
    {"label": "All", "value": "All"},
    {"label": "Operating", "value": "Operating"},
    {"label": "Administrative", "value": "Administrative"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Financial", "value": "Financial"},
    {"label": "Capital", "value": "Capital"},
  ];

  List<Map<String, dynamic>> categories = [
    {
      "id": "cat001",
      "name": "Office Supplies",
      "code": "OFF-SUP",
      "type": "Expense",
      "group": "Operating",
      "description": "Stationery, printer supplies, and general office materials",
      "color": "#FF6B6B",
      "isActive": true,
      "transactionCount": 45,
      "totalAmount": 2890.50,
      "lastUsed": "2024-12-18",
      "parent": null,
      "subcategories": 3
    },
    {
      "id": "cat002",
      "name": "Marketing & Advertising",
      "code": "MKT-ADV",
      "type": "Expense",
      "group": "Marketing",
      "description": "Online ads, print materials, promotional campaigns",
      "color": "#4ECDC4",
      "isActive": true,
      "transactionCount": 28,
      "totalAmount": 8750.00,
      "lastUsed": "2024-12-19",
      "parent": null,
      "subcategories": 5
    },
    {
      "id": "cat003",
      "name": "Travel & Transportation",
      "code": "TRV-TRP",
      "type": "Expense",
      "group": "Operating",
      "description": "Business travel, fuel, parking, public transport",
      "color": "#45B7D1",
      "isActive": true,
      "transactionCount": 32,
      "totalAmount": 4200.75,
      "lastUsed": "2024-12-17",
      "parent": null,
      "subcategories": 4
    },
    {
      "id": "cat004",
      "name": "Professional Services",
      "code": "PRO-SRV",
      "type": "Expense",
      "group": "Administrative",
      "description": "Legal, accounting, consulting, and other professional fees",
      "color": "#96CEB4",
      "isActive": true,
      "transactionCount": 18,
      "totalAmount": 12500.00,
      "lastUsed": "2024-12-15",
      "parent": null,
      "subcategories": 3
    },
    {
      "id": "cat005",
      "name": "Equipment & Software",
      "code": "EQP-SFT",
      "type": "Asset",
      "group": "Capital",
      "description": "Computer hardware, software licenses, office equipment",
      "color": "#FECA57",
      "isActive": true,
      "transactionCount": 15,
      "totalAmount": 25000.00,
      "lastUsed": "2024-12-10",
      "parent": null,
      "subcategories": 6
    },
    {
      "id": "cat006",
      "name": "Sales Revenue",
      "code": "SAL-REV",
      "type": "Income",
      "group": "Operating",
      "description": "Product sales, service fees, subscription revenue",
      "color": "#6C5CE7",
      "isActive": true,
      "transactionCount": 125,
      "totalAmount": 89500.00,
      "lastUsed": "2024-12-19",
      "parent": null,
      "subcategories": 4
    },
    {
      "id": "cat007",
      "name": "Consulting Revenue",
      "code": "CON-REV",
      "type": "Income",
      "group": "Operating",
      "description": "Professional consulting and advisory services",
      "color": "#A29BFE",
      "isActive": true,
      "transactionCount": 38,
      "totalAmount": 45000.00,
      "lastUsed": "2024-12-18",
      "parent": null,
      "subcategories": 2
    },
    {
      "id": "cat008",
      "name": "Rent & Utilities",
      "code": "RNT-UTL",
      "type": "Expense",
      "group": "Operating",
      "description": "Office rent, electricity, water, internet, phone",
      "color": "#FD79A8",
      "isActive": true,
      "transactionCount": 24,
      "totalAmount": 18000.00,
      "lastUsed": "2024-12-01",
      "parent": null,
      "subcategories": 5
    },
    {
      "id": "cat009",
      "name": "Insurance",
      "code": "INS",
      "type": "Expense",
      "group": "Administrative",
      "description": "Business insurance, liability, property coverage",
      "color": "#E17055",
      "isActive": true,
      "transactionCount": 12,
      "totalAmount": 3600.00,
      "lastUsed": "2024-12-05",
      "parent": null,
      "subcategories": 3
    },
    {
      "id": "cat010",
      "name": "Bank Charges",
      "code": "BNK-CHG",
      "type": "Expense",
      "group": "Financial",
      "description": "Transaction fees, service charges, interest payments",
      "color": "#00B894",
      "isActive": true,
      "transactionCount": 35,
      "totalAmount": 890.25,
      "lastUsed": "2024-12-16",
      "parent": null,
      "subcategories": 2
    },
    {
      "id": "cat011",
      "name": "Miscellaneous Income",
      "code": "MSC-INC",
      "type": "Income",
      "group": "Financial",
      "description": "Interest earned, refunds, other miscellaneous income",
      "color": "#FDCB6E",
      "isActive": true,
      "transactionCount": 8,
      "totalAmount": 1250.00,
      "lastUsed": "2024-12-08",
      "parent": null,
      "subcategories": 1
    },
    {
      "id": "cat012",
      "name": "Depreciation",
      "code": "DEP",
      "type": "Expense",
      "group": "Financial",
      "description": "Asset depreciation and amortization",
      "color": "#74B9FF",
      "isActive": false,
      "transactionCount": 4,
      "totalAmount": 5000.00,
      "lastUsed": "2024-11-30",
      "parent": null,
      "subcategories": 0
    }
  ];

  List<Map<String, dynamic>> get filteredCategories {
    return categories.where((category) {
      bool matchesSearch = "${category["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${category["code"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || category["type"] == selectedType;
      bool matchesGroup = selectedGroup == "All" || category["group"] == selectedGroup;
      return matchesSearch && matchesType && matchesGroup;
    }).toList();
  }

  Color _parseColor(String colorHex) {
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Income":
        return successColor;
      case "Expense":
        return dangerColor;
      case "Asset":
        return infoColor;
      case "Liability":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Income":
        return Icons.trending_up;
      case "Expense":
        return Icons.trending_down;
      case "Asset":
        return Icons.account_balance_wallet;
      case "Liability":
        return Icons.credit_card;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Categories"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('CategoryReportsView')
            },
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AddCategoryView')
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filter Section
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search categories...",
                                value: searchQuery,
                                hint: "Category name or code",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Type",
                                items: typeOptions,
                                value: selectedType,
                                onChanged: (value, label) {
                                  selectedType = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: QDropdownField(
                                label: "Group",
                                items: groupOptions,
                                value: selectedGroup,
                                onChanged: (value, label) {
                                  selectedGroup = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Categories",
                        "${categories.length}",
                        Icons.category,
                        primaryColor,
                      ),
                      _buildSummaryCard(
                        "Active Categories",
                        "${categories.where((c) => c["isActive"] == true).length}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Income Categories",
                        "${categories.where((c) => c["type"] == "Income").length}",
                        Icons.trending_up,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Expense Categories",
                        "${categories.where((c) => c["type"] == "Expense").length}",
                        Icons.trending_down,
                        dangerColor,
                      ),
                    ],
                  ),

                  // Categories List
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Categories (${filteredCategories.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredCategories.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final category = filteredCategories[index];
                            bool isActive = category["isActive"] as bool;
                            Color categoryColor = _parseColor("${category["color"]}");

                            return GestureDetector(
                              onTap: () {
                                //navigateTo('CategoryDetailView', category)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                color: !isActive ? disabledColor.withAlpha(5) : Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: categoryColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        _getTypeIcon("${category["type"]}"),
                                        color: categoryColor,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${category["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: isActive ? primaryColor : disabledBoldColor,
                                                  ),
                                                ),
                                              ),
                                              if (!isActive) ...[
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: spXs,
                                                    vertical: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: disabledColor.withAlpha(20),
                                                    borderRadius: BorderRadius.circular(radiusXs),
                                                  ),
                                                  child: Text(
                                                    "INACTIVE",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Text(
                                                "${category["code"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: disabledColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getTypeColor("${category["type"]}").withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${category["type"]}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: _getTypeColor("${category["type"]}"),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: disabledColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Text(
                                                "${category["group"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (category["description"] != null) ...[
                                            SizedBox(height: 2),
                                            Text(
                                              "${category["description"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                          SizedBox(height: spXs),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.receipt,
                                                color: disabledColor,
                                                size: 12,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${category["transactionCount"]} transactions",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              if ((category["subcategories"] as int) > 0) ...[
                                                SizedBox(width: spSm),
                                                Container(
                                                  width: 4,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    color: disabledColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                Icon(
                                                  Icons.folder,
                                                  color: disabledColor,
                                                  size: 12,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "${category["subcategories"]} subcategories",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                              ],
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
                                          "${(category["totalAmount"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _getTypeColor("${category["type"]}"),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Last: ${DateTime.parse("${category["lastUsed"]}").dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: disabledColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('AddCategoryView')
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.category,
                color: color,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
