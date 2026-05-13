import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaFilterView extends StatefulWidget {
  const FdaFilterView({super.key});

  @override
  State<FdaFilterView> createState() => _FdaFilterViewState();
}

class _FdaFilterViewState extends State<FdaFilterView> {
  // Price Range
  double minPrice = 0;
  double maxPrice = 50;
  RangeValues priceRange = const RangeValues(5, 30);

  // Delivery Time
  String selectedDeliveryTime = "Any Time";
  List<String> deliveryTimeOptions = [
    "Any Time",
    "Under 20 min",
    "20-30 min",
    "30-45 min",
    "45+ min",
  ];

  // Rating
  double minimumRating = 0;
  List<double> ratingOptions = [0, 3.0, 3.5, 4.0, 4.5];

  // Distance
  double maxDistance = 10;
  List<double> distanceOptions = [1, 2, 5, 10, 15];

  // Categories
  List<Map<String, dynamic>> categories = [
    {"name": "Fast Food", "selected": false, "icon": Icons.fastfood},
    {"name": "Pizza", "selected": true, "icon": Icons.local_pizza},
    {"name": "Burger", "selected": false, "icon": Icons.lunch_dining},
    {"name": "Asian", "selected": false, "icon": Icons.ramen_dining},
    {"name": "Italian", "selected": true, "icon": Icons.restaurant_menu},
    {"name": "Mexican", "selected": false, "icon": Icons.local_dining},
    {"name": "Dessert", "selected": false, "icon": Icons.cake},
    {"name": "Coffee", "selected": false, "icon": Icons.local_cafe},
    {"name": "Healthy", "selected": false, "icon": Icons.eco},
    {"name": "Vegan", "selected": false, "icon": Icons.grass},
  ];

  // Features
  List<Map<String, dynamic>> features = [
    {"name": "Free Delivery", "selected": true, "icon": Icons.delivery_dining},
    {"name": "Accepts Coupons", "selected": false, "icon": Icons.local_offer},
    {"name": "Open Now", "selected": true, "icon": Icons.access_time},
    {"name": "Featured", "selected": false, "icon": Icons.star},
    {"name": "New Restaurant", "selected": false, "icon": Icons.new_releases},
    {"name": "Fast Delivery", "selected": false, "icon": Icons.speed},
  ];

  // Dietary Preferences
  List<Map<String, dynamic>> dietaryPreferences = [
    {"name": "Vegetarian", "selected": false, "icon": Icons.eco},
    {"name": "Vegan", "selected": false, "icon": Icons.grass},
    {"name": "Gluten-Free", "selected": false, "icon": Icons.no_meals},
    {"name": "Halal", "selected": false, "icon": Icons.mosque},
    {"name": "Kosher", "selected": false, "icon": Icons.star},
    {"name": "Dairy-Free", "selected": false, "icon": Icons.block},
  ];

  void _clearAllFilters() {
    setState(() {
      priceRange = const RangeValues(0, 50);
      selectedDeliveryTime = "Any Time";
      minimumRating = 0;
      maxDistance = 10;
      
      for (var category in categories) {
        category["selected"] = false;
      }
      
      for (var feature in features) {
        feature["selected"] = false;
      }
      
      for (var diet in dietaryPreferences) {
        diet["selected"] = false;
      }
    });
    ss("All filters cleared");
  }

  void _applyFilters() {
    int selectedCategoriesCount = categories.where((c) => c["selected"]).length;
    int selectedFeaturesCount = features.where((f) => f["selected"]).length;
    int selectedDietCount = dietaryPreferences.where((d) => d["selected"]).length;
    
    ss("Filters applied: $selectedCategoriesCount categories, $selectedFeaturesCount features, $selectedDietCount dietary preferences");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          GestureDetector(
            onTap: _clearAllFilters,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Center(
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  Text(
                    "Price Range",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${priceRange.start.round()}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$${priceRange.end.round()}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: 50,
                          divisions: 10,
                          activeColor: primaryColor,
                          inactiveColor: disabledColor,
                          onChanged: (RangeValues values) {
                            setState(() {
                              priceRange = values;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spLg),

                  // Delivery Time
                  Text(
                    "Delivery Time",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: deliveryTimeOptions.map((time) {
                      bool isSelected = selectedDeliveryTime == time;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDeliveryTime = time;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spLg),

                  // Minimum Rating
                  Text(
                    "Minimum Rating",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: ratingOptions.map((rating) {
                      bool isSelected = minimumRating == rating;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            minimumRating = rating;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (rating > 0) ...[
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: isSelected ? Colors.white : warningColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${rating.toString()}+",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                  ),
                                ),
                              ] else
                                Text(
                                  "Any Rating",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spLg),

                  // Distance
                  Text(
                    "Maximum Distance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: distanceOptions.map((distance) {
                      bool isSelected = maxDistance == distance;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            maxDistance = distance;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            "${distance.toInt()} km",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spLg),

                  // Categories
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: categories.map((category) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            category["selected"] = !category["selected"];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: category["selected"] ? primaryColor.withAlpha(20) : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: category["selected"] ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                category["icon"],
                                size: 20,
                                color: category["selected"] ? primaryColor : disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: category["selected"] ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              if (category["selected"])
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: primaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spLg),

                  // Features
                  Text(
                    "Features",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...features.map((feature) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            child: QSwitch(
                              items: [
                                {
                                  "label": "${feature["name"]}",
                                  "value": feature["name"],
                                  "checked": feature["selected"],
                                }
                              ],
                              value: feature["selected"] ? [{"label": "${feature["name"]}", "value": feature["name"], "checked": true}] : [],
                              onChanged: (values, ids) {
                                setState(() {
                                  feature["selected"] = values.isNotEmpty;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: spLg),

                  // Dietary Preferences
                  Text(
                    "Dietary Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: dietaryPreferences.map((diet) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            diet["selected"] = !diet["selected"];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: diet["selected"] ? successColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: diet["selected"] ? successColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                diet["icon"],
                                size: 14,
                                color: diet["selected"] ? Colors.white : disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${diet["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: diet["selected"] ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spXl),
                ],
              ),
            ),
          ),

          // Apply Button
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    onPressed: _applyFilters,
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
