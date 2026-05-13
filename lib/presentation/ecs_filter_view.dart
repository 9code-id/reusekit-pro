import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsFilterView extends StatefulWidget {
  const EcsFilterView({super.key});

  @override
  State<EcsFilterView> createState() => _EcsFilterViewState();
}

class _EcsFilterViewState extends State<EcsFilterView> {
  // Price Range
  double minPrice = 0;
  double maxPrice = 1000;
  RangeValues priceRange = RangeValues(50, 500);
  
  // Category
  String selectedCategory = "";
  List<String> categories = [
    "Electronics",
    "Fashion",
    "Home & Garden",
    "Sports & Outdoors",
    "Beauty & Personal Care",
    "Books",
    "Automotive",
    "Toys & Games",
  ];
  
  // Brand
  List<String> selectedBrands = [];
  List<String> brands = [
    "Apple",
    "Samsung",
    "Sony",
    "Bose",
    "Nike",
    "Adidas",
    "Zara",
    "H&M",
  ];
  
  // Rating
  double minRating = 0;
  
  // Features
  List<String> selectedFeatures = [];
  List<String> features = [
    "Free Shipping",
    "Prime Eligible",
    "On Sale",
    "New Arrivals",
    "Best Seller",
    "Customer Choice",
  ];
  
  // Color
  String selectedColor = "";
  List<Map<String, dynamic>> colors = [
    {"name": "Black", "color": Colors.black},
    {"name": "White", "color": Colors.white},
    {"name": "Red", "color": Colors.red},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Green", "color": Colors.green},
    {"name": "Yellow", "color": Colors.yellow},
    {"name": "Purple", "color": Colors.purple},
    {"name": "Orange", "color": Colors.orange},
  ];
  
  // Size
  String selectedSize = "";
  List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL"];
  
  // Availability
  bool inStockOnly = false;
  bool freeShippingOnly = false;
  bool onSaleOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Products"),
        actions: [
          GestureDetector(
            onTap: () => _clearAllFilters(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    color: dangerColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range
            _buildSectionTitle("Price Range"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${priceRange.start.round()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${priceRange.end.round()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: minPrice,
                    max: maxPrice,
                    divisions: 20,
                    activeColor: primaryColor,
                    onChanged: (values) {
                      priceRange = values;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Category
            _buildSectionTitle("Category"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      selectedCategory = selectedCategory == category ? "" : category;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(category),
                          ),
                          if (selectedCategory == category)
                            Icon(
                              Icons.check,
                              color: primaryColor,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Brand
            _buildSectionTitle("Brand"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: brands.map((brand) {
                  final isSelected = selectedBrands.contains(brand);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedBrands.remove(brand);
                      } else {
                        selectedBrands.add(brand);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(brand),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Rating
            _buildSectionTitle("Minimum Rating"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(5, (index) {
                  final rating = 5 - index;
                  final isSelected = minRating >= rating;
                  
                  return GestureDetector(
                    onTap: () {
                      minRating = isSelected && minRating == rating ? 0 : rating.toDouble();
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < rating ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 20,
                              );
                            }),
                          ),
                          Text(" & Up"),
                          Spacer(),
                          if (isSelected)
                            Icon(
                              Icons.check,
                              color: primaryColor,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Color
            _buildSectionTitle("Color"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: colors.map((colorData) {
                  final colorName = colorData["name"] as String;
                  final color = colorData["color"] as Color;
                  final isSelected = selectedColor == colorName;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedColor = isSelected ? "" : colorName;
                      setState(() {});
                    },
                    child: Container(
                      width: 60,
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                width: isSelected ? 3 : 1,
                              ),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: color == Colors.white || color == Colors.yellow
                                        ? Colors.black
                                        : Colors.white,
                                    size: 20,
                                  )
                                : null,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            colorName,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Size
            _buildSectionTitle("Size"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: sizes.map((size) {
                  final isSelected = selectedSize == size;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedSize = isSelected ? "" : size;
                      setState(() {});
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Features
            _buildSectionTitle("Features"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: features.map((feature) {
                  final isSelected = selectedFeatures.contains(feature);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedFeatures.remove(feature);
                      } else {
                        selectedFeatures.add(feature);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(feature),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Availability Options
            _buildSectionTitle("Availability"),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildSwitchOption(
                    "In Stock Only",
                    inStockOnly,
                    (value) {
                      inStockOnly = value;
                      setState(() {});
                    },
                  ),
                  _buildSwitchOption(
                    "Free Shipping Only",
                    freeShippingOnly,
                    (value) {
                      freeShippingOnly = value;
                      setState(() {});
                    },
                  ),
                  _buildSwitchOption(
                    "On Sale Only",
                    onSaleOnly,
                    (value) {
                      onSaleOnly = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Clear Filters",
                size: bs.md,
                onPressed: () => _clearAllFilters(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () => _applyFilters(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fsH6,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchOption(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(
            value: value,
            activeColor: primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _clearAllFilters() {
    priceRange = RangeValues(minPrice, maxPrice);
    selectedCategory = "";
    selectedBrands.clear();
    minRating = 0;
    selectedFeatures.clear();
    selectedColor = "";
    selectedSize = "";
    inStockOnly = false;
    freeShippingOnly = false;
    onSaleOnly = false;
    setState(() {});
    ss("All filters cleared");
  }

  void _applyFilters() {
    // Apply filters and navigate back
    back();
    ss("Filters applied successfully");
  }
}
