import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCategoryAnalysisView extends StatefulWidget {
  const PosCategoryAnalysisView({super.key});

  @override
  State<PosCategoryAnalysisView> createState() => _PosCategoryAnalysisViewState();
}

class _PosCategoryAnalysisViewState extends State<PosCategoryAnalysisView> {
  String selectedPeriod = "this_month";
  String selectedCategory = "all";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "This Year", "value": "this_year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Food & Beverages", "value": "food_beverage"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home_garden"},
    {"label": "Books & Media", "value": "books_media"},
  ];

  List<Map<String, dynamic>> categoryData = [
    {
      "id": "1",
      "name": "Food & Beverages",
      "revenue": 45600.0,
      "units_sold": 1234,
      "profit_margin": 32.5,
      "growth_rate": 8.2,
      "color": Colors.green,
      "icon": Icons.restaurant,
      "subcategories": [
        {"name": "Beverages", "revenue": 18500.0, "percentage": 40.6},
        {"name": "Snacks", "revenue": 12300.0, "percentage": 27.0},
        {"name": "Fresh Food", "revenue": 10200.0, "percentage": 22.4},
        {"name": "Frozen Items", "revenue": 4600.0, "percentage": 10.1},
      ]
    },
    {
      "id": "2",
      "name": "Electronics",
      "revenue": 38200.0,
      "units_sold": 567,
      "profit_margin": 24.8,
      "growth_rate": -2.1,
      "color": Colors.blue,
      "icon": Icons.devices,
      "subcategories": [
        {"name": "Mobile Accessories", "revenue": 15200.0, "percentage": 39.8},
        {"name": "Audio Equipment", "revenue": 11400.0, "percentage": 29.8},
        {"name": "Computing", "revenue": 7800.0, "percentage": 20.4},
        {"name": "Gaming", "revenue": 3800.0, "percentage": 9.9},
      ]
    },
    {
      "id": "3",
      "name": "Clothing",
      "revenue": 28900.0,
      "units_sold": 890,
      "profit_margin": 45.2,
      "growth_rate": 12.7,
      "color": Colors.purple,
      "icon": Icons.checkroom,
      "subcategories": [
        {"name": "Men's Fashion", "revenue": 12600.0, "percentage": 43.6},
        {"name": "Women's Fashion", "revenue": 10800.0, "percentage": 37.4},
        {"name": "Accessories", "revenue": 3900.0, "percentage": 13.5},
        {"name": "Kids Clothing", "revenue": 1600.0, "percentage": 5.5},
      ]
    },
    {
      "id": "4",
      "name": "Home & Garden",
      "revenue": 22100.0,
      "units_sold": 445,
      "profit_margin": 28.4,
      "growth_rate": 5.8,
      "color": Colors.orange,
      "icon": Icons.home,
      "subcategories": [
        {"name": "Home Decor", "revenue": 8900.0, "percentage": 40.3},
        {"name": "Kitchen Items", "revenue": 6700.0, "percentage": 30.3},
        {"name": "Garden Tools", "revenue": 4200.0, "percentage": 19.0},
        {"name": "Furniture", "revenue": 2300.0, "percentage": 10.4},
      ]
    },
    {
      "id": "5",
      "name": "Books & Media",
      "revenue": 15400.0,
      "units_sold": 678,
      "profit_margin": 35.6,
      "growth_rate": -5.3,
      "color": Colors.teal,
      "icon": Icons.book,
      "subcategories": [
        {"name": "Books", "revenue": 7800.0, "percentage": 50.6},
        {"name": "Magazines", "revenue": 3200.0, "percentage": 20.8},
        {"name": "Digital Media", "revenue": 2800.0, "percentage": 18.2},
        {"name": "Stationery", "revenue": 1600.0, "percentage": 10.4},
      ]
    },
  ];

  List<Map<String, dynamic>> topPerformingProducts = [
    {
      "name": "Premium Coffee Blend",
      "category": "Food & Beverages",
      "revenue": 8900.0,
      "units_sold": 245,
      "profit_margin": 42.5,
    },
    {
      "name": "Wireless Earbuds Pro",
      "category": "Electronics",
      "revenue": 7600.0,
      "units_sold": 76,
      "profit_margin": 35.2,
    },
    {
      "name": "Designer Jeans",
      "category": "Clothing",
      "revenue": 6800.0,
      "units_sold": 68,
      "profit_margin": 55.8,
    },
    {
      "name": "Smart Home Speaker",
      "category": "Electronics",
      "revenue": 5400.0,
      "units_sold": 54,
      "profit_margin": 28.9,
    },
    {
      "name": "Organic Tea Collection",
      "category": "Food & Beverages",
      "revenue": 4200.0,
      "units_sold": 168,
      "profit_margin": 38.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Analysis"),
        actions: [
          QButton(
            icon: Icons.file_download,
            size: bs.sm,
            onPressed: () {
              ss("Category analysis report exported");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildOverviewCards(),
            _buildCategoryPerformanceChart(),
            _buildCategoryBreakdown(),
            _buildSubcategoryAnalysis(),
            _buildTopPerformingProducts(),
            _buildTrendAnalysis(),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
                Icons.filter_list,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Analysis Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
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

  Widget _buildOverviewCards() {
    return Row(
      children: [
        Expanded(
          child: _buildOverviewCard(
            "Total Categories",
            "${categoryData.length}",
            Icons.category,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildOverviewCard(
            "Best Performing",
            categoryData.first["name"],
            Icons.trending_up,
            successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
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
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPerformanceChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Revenue Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildPieChart(),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildChartLegend(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    double totalRevenue = categoryData.fold(0.0, (sum, item) => sum + (item["revenue"] as double));
    
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: disabledColor,
          width: 1,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Total Revenue",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${totalRevenue.currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryData.map((category) {
        double totalRevenue = categoryData.fold(0.0, (sum, item) => sum + (item["revenue"] as double));
        double percentage = ((category["revenue"] as double) / totalRevenue) * 100;
        
        return Container(
          margin: EdgeInsets.only(bottom: spXs),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: category["color"],
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${percentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Category Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...categoryData.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: category["color"],
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  category["icon"],
                  color: category["color"],
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${category["units_sold"]} units sold",
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
                    "\$${(category["revenue"] as double).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: (category["growth_rate"] as double) >= 0 ? 
                        successColor.withAlpha(20) : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(category["growth_rate"] as double) >= 0 ? '+' : ''}${(category["growth_rate"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: (category["growth_rate"] as double) >= 0 ? 
                          successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  "Profit Margin",
                  "${(category["profit_margin"] as double).toStringAsFixed(1)}%",
                  Icons.trending_up,
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledColor,
              ),
              Expanded(
                child: _buildMetricItem(
                  "Units Sold",
                  "${category["units_sold"]}",
                  Icons.shopping_cart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubcategoryAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.account_tree,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Subcategory Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...categoryData.take(3).map((category) => _buildSubcategorySection(category)),
        ],
      ),
    );
  }

  Widget _buildSubcategorySection(Map<String, dynamic> category) {
    List subcategories = category["subcategories"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${category["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...subcategories.map((sub) => _buildSubcategoryItem(sub, category["color"])),
        ],
      ),
    );
  }

  Widget _buildSubcategoryItem(Map<String, dynamic> subcategory, Color categoryColor) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: categoryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${subcategory["name"]}",
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${(subcategory["percentage"] as double).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "\$${(subcategory["revenue"] as double).currency}",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformingProducts() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.star,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Top Performing Products",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...topPerformingProducts.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> product = entry.value;
            return _buildTopProductItem(product, index + 1);
          }),
        ],
      ),
    );
  }

  Widget _buildTopProductItem(Map<String, dynamic> product, int rank) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: rank <= 3 ? primaryColor : disabledBoldColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$rank",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${product["category"]}",
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
                "\$${(product["revenue"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${product["units_sold"]} sold",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.show_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Category Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildTrendCard(
                  "Growing Categories",
                  "3",
                  Icons.trending_up,
                  successColor,
                  "Clothing leading with +12.7%",
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildTrendCard(
                  "Declining Categories",
                  "2",
                  Icons.trending_down,
                  dangerColor,
                  "Books & Media -5.3%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Smart Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildRecommendationItem(
            "Focus on Clothing Category",
            "Clothing shows highest growth (+12.7%) and profit margin (45.2%). Consider expanding inventory.",
            Icons.trending_up,
            successColor,
          ),
          _buildRecommendationItem(
            "Optimize Electronics Marketing",
            "Electronics declining (-2.1%). Review pricing strategy and promotional campaigns.",
            Icons.campaign,
            warningColor,
          ),
          _buildRecommendationItem(
            "Revitalize Books & Media",
            "Books & Media showing -5.3% decline. Consider digital alternatives or bundle offers.",
            Icons.refresh,
            infoColor,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: color,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
