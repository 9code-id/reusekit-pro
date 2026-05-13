import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter1View extends StatefulWidget {
  @override
  State<GrlFilter1View> createState() => _GrlFilter1ViewState();
}

class _GrlFilter1ViewState extends State<GrlFilter1View> {
  String selectedCategory = "all";
  String selectedBrand = "";
  String priceRange = "all";
  bool inStock = false;
  bool onSale = false;
  String sortBy = "newest";
  double minPrice = 0;
  double maxPrice = 1000;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
    {"label": "Books", "value": "books"},
  ];

  List<Map<String, dynamic>> brandItems = [
    {"label": "Select Brand", "value": ""},
    {"label": "Apple", "value": "apple"},
    {"label": "Samsung", "value": "samsung"},
    {"label": "Nike", "value": "nike"},
    {"label": "Adidas", "value": "adidas"},
    {"label": "Sony", "value": "sony"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$50", "value": "under_50"},
    {"label": "\$50 - \$100", "value": "50_100"},
    {"label": "\$100 - \$500", "value": "100_500"},
    {"label": "Over \$500", "value": "over_500"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Best Rating", "value": "rating"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Filters"),
        actions: [
          GestureDetector(
            onTap: () {
              _resetFilters();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            Text(
              "Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Category",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Brand Filter
            Text(
              "Brand",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Brand",
              items: brandItems,
              value: selectedBrand,
              onChanged: (value, label) {
                selectedBrand = value;
                setState(() {});
              },
            ),

            // Price Range Filter
            Text(
              "Price Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Price Range",
              items: priceRangeItems,
              value: priceRange,
              onChanged: (value, label) {
                priceRange = value;
                setState(() {});
              },
            ),

            // Custom Price Range
            if (priceRange == "all") ...[
              Text(
                "Custom Price Range",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Min Price (\$)",
                            value: minPrice.toString(),
                            onChanged: (value) {
                              minPrice = double.tryParse(value) ?? 0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Max Price (\$)",
                            value: maxPrice.toString(),
                            onChanged: (value) {
                              maxPrice = double.tryParse(value) ?? 1000;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Price range: \$${minPrice.toInt()} - \$${maxPrice.toInt()}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Availability Filters
            Text(
              "Availability",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "In Stock Only",
                        "value": true,
                        "checked": inStock,
                      }
                    ],
                    value: [
                      if (inStock)
                        {"label": "In Stock Only", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      inStock = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "On Sale Only",
                        "value": true,
                        "checked": onSale,
                      }
                    ],
                    value: [
                      if (onSale)
                        {"label": "On Sale Only", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      onSale = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Sort Options
            Text(
              "Sort By",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Sort Options",
              items: sortItems,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Apply Filter Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  _applyFilters();
                },
              ),
            ),

            SizedBox(height: spSm),

            // Clear All Filters
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _resetFilters();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "Clear All Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {
      'category': selectedCategory,
      'brand': selectedBrand,
      'priceRange': priceRange,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'inStock': inStock,
      'onSale': onSale,
      'sortBy': sortBy,
    };

    ss("Filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedCategory = "all";
    selectedBrand = "";
    priceRange = "all";
    inStock = false;
    onSale = false;
    sortBy = "newest";
    minPrice = 0;
    maxPrice = 1000;
    setState(() {});
  }
}
