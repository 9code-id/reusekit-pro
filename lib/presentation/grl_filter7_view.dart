import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter7View extends StatefulWidget {
  @override
  State<GrlFilter7View> createState() => _GrlFilter7ViewState();
}

class _GrlFilter7ViewState extends State<GrlFilter7View> {
  String selectedCategory = "";
  String selectedBrand = "";
  String selectedSize = "";
  String selectedColor = "";
  String selectedPriceRange = "";
  String selectedCondition = "";
  List<String> selectedMaterials = [];
  String selectedGender = "";
  String selectedSeason = "";
  bool onSale = false;
  bool freeShipping = false;
  bool sustainableBrand = false;
  bool newArrivals = false;
  double minPrice = 0;
  double maxPrice = 500;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": ""},
    {"label": "Tops", "value": "tops"},
    {"label": "Bottoms", "value": "bottoms"},
    {"label": "Dresses", "value": "dresses"},
    {"label": "Outerwear", "value": "outerwear"},
    {"label": "Shoes", "value": "shoes"},
    {"label": "Accessories", "value": "accessories"},
    {"label": "Bags", "value": "bags"},
    {"label": "Jewelry", "value": "jewelry"},
  ];

  List<Map<String, dynamic>> brandItems = [
    {"label": "All Brands", "value": ""},
    {"label": "Nike", "value": "nike"},
    {"label": "Adidas", "value": "adidas"},
    {"label": "Zara", "value": "zara"},
    {"label": "H&M", "value": "hm"},
    {"label": "Uniqlo", "value": "uniqlo"},
    {"label": "Levi's", "value": "levis"},
    {"label": "Calvin Klein", "value": "calvin_klein"},
    {"label": "Tommy Hilfiger", "value": "tommy_hilfiger"},
  ];

  List<Map<String, dynamic>> sizeItems = [
    {"label": "All Sizes", "value": ""},
    {"label": "XS", "value": "xs"},
    {"label": "S", "value": "s"},
    {"label": "M", "value": "m"},
    {"label": "L", "value": "l"},
    {"label": "XL", "value": "xl"},
    {"label": "XXL", "value": "xxl"},
    {"label": "One Size", "value": "one_size"},
  ];

  List<Map<String, dynamic>> colorItems = [
    {"label": "All Colors", "value": ""},
    {"label": "Black", "value": "black"},
    {"label": "White", "value": "white"},
    {"label": "Navy", "value": "navy"},
    {"label": "Gray", "value": "gray"},
    {"label": "Blue", "value": "blue"},
    {"label": "Red", "value": "red"},
    {"label": "Green", "value": "green"},
    {"label": "Pink", "value": "pink"},
    {"label": "Brown", "value": "brown"},
    {"label": "Beige", "value": "beige"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All Prices", "value": ""},
    {"label": "Under \$25", "value": "under_25"},
    {"label": "\$25 - \$50", "value": "25_50"},
    {"label": "\$50 - \$100", "value": "50_100"},
    {"label": "\$100 - \$200", "value": "100_200"},
    {"label": "Over \$200", "value": "over_200"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "All Conditions", "value": ""},
    {"label": "New with Tags", "value": "new_tags"},
    {"label": "New without Tags", "value": "new_no_tags"},
    {"label": "Excellent", "value": "excellent"},
    {"label": "Very Good", "value": "very_good"},
    {"label": "Good", "value": "good"},
    {"label": "Fair", "value": "fair"},
  ];

  List<Map<String, dynamic>> genderItems = [
    {"label": "All Genders", "value": ""},
    {"label": "Women", "value": "women"},
    {"label": "Men", "value": "men"},
    {"label": "Unisex", "value": "unisex"},
    {"label": "Kids", "value": "kids"},
  ];

  List<Map<String, dynamic>> seasonItems = [
    {"label": "All Seasons", "value": ""},
    {"label": "Spring", "value": "spring"},
    {"label": "Summer", "value": "summer"},
    {"label": "Fall", "value": "fall"},
    {"label": "Winter", "value": "winter"},
    {"label": "All Season", "value": "all_season"},
  ];

  List<String> materialsList = [
    "Cotton",
    "Polyester",
    "Wool",
    "Silk",
    "Denim",
    "Leather",
    "Linen",
    "Cashmere",
    "Viscose",
    "Nylon",
    "Acrylic",
    "Spandex",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fashion Filters"),
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
            // Category and Brand
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Category",
                        items: categoryItems,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brand",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Brand",
                        items: brandItems,
                        value: selectedBrand,
                        onChanged: (value, label) {
                          selectedBrand = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Size and Color
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Size",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Size",
                        items: sizeItems,
                        value: selectedSize,
                        onChanged: (value, label) {
                          selectedSize = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Color",
                        items: colorItems,
                        value: selectedColor,
                        onChanged: (value, label) {
                          selectedColor = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Price Range
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
              value: selectedPriceRange,
              onChanged: (value, label) {
                selectedPriceRange = value;
                setState(() {});
              },
            ),

            // Custom Price Range
            if (selectedPriceRange == "") ...[
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
                        Text(
                          "Custom Range: \$${minPrice.toInt()} - \$${maxPrice.toInt()}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: RangeValues(minPrice, maxPrice),
                      min: 0,
                      max: 1000,
                      divisions: 100,
                      activeColor: primaryColor,
                      labels: RangeLabels(
                        "\$${minPrice.toInt()}",
                        "\$${maxPrice.toInt()}",
                      ),
                      onChanged: (values) {
                        minPrice = values.start;
                        maxPrice = values.end;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Condition and Gender
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Condition",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Condition",
                        items: conditionItems,
                        value: selectedCondition,
                        onChanged: (value, label) {
                          selectedCondition = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Gender",
                        items: genderItems,
                        value: selectedGender,
                        onChanged: (value, label) {
                          selectedGender = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Season
            Text(
              "Season",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Season",
              items: seasonItems,
              value: selectedSeason,
              onChanged: (value, label) {
                selectedSeason = value;
                setState(() {});
              },
            ),

            // Materials
            Text(
              "Materials",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select preferred materials:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: materialsList.map((material) {
                      bool isSelected = selectedMaterials.contains(material);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedMaterials.remove(material);
                          } else {
                            selectedMaterials.add(material);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            material,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Special Features
            Text(
              "Special Features",
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
                        "label": "On Sale",
                        "value": true,
                        "checked": onSale,
                      }
                    ],
                    value: [
                      if (onSale)
                        {"label": "On Sale", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      onSale = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Free Shipping",
                        "value": true,
                        "checked": freeShipping,
                      }
                    ],
                    value: [
                      if (freeShipping)
                        {"label": "Free Shipping", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      freeShipping = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Sustainable Brand",
                        "value": true,
                        "checked": sustainableBrand,
                      }
                    ],
                    value: [
                      if (sustainableBrand)
                        {"label": "Sustainable Brand", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      sustainableBrand = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "New Arrivals",
                        "value": true,
                        "checked": newArrivals,
                      }
                    ],
                    value: [
                      if (newArrivals)
                        {"label": "New Arrivals", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      newArrivals = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
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

            // Clear Filters Button
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
      'size': selectedSize,
      'color': selectedColor,
      'priceRange': selectedPriceRange,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'condition': selectedCondition,
      'gender': selectedGender,
      'season': selectedSeason,
      'materials': selectedMaterials,
      'onSale': onSale,
      'freeShipping': freeShipping,
      'sustainableBrand': sustainableBrand,
      'newArrivals': newArrivals,
    };

    ss("Fashion filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedCategory = "";
    selectedBrand = "";
    selectedSize = "";
    selectedColor = "";
    selectedPriceRange = "";
    selectedCondition = "";
    selectedGender = "";
    selectedSeason = "";
    selectedMaterials.clear();
    onSale = false;
    freeShipping = false;
    sustainableBrand = false;
    newArrivals = false;
    minPrice = 0;
    maxPrice = 500;
    setState(() {});
  }
}
