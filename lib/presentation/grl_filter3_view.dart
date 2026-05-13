import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter3View extends StatefulWidget {
  @override
  State<GrlFilter3View> createState() => _GrlFilter3ViewState();
}

class _GrlFilter3ViewState extends State<GrlFilter3View> {
  String selectedCuisine = "";
  String selectedPriceRange = "";
  String selectedDistance = "";
  String selectedRating = "";
  List<String> selectedFeatures = [];
  List<String> selectedDietaryOptions = [];
  TimeOfDay? openTime;
  TimeOfDay? closeTime;
  bool openNow = false;
  bool takeout = false;
  bool delivery = false;
  bool reservations = false;

  List<Map<String, dynamic>> cuisineItems = [
    {"label": "All Cuisines", "value": ""},
    {"label": "Italian", "value": "italian"},
    {"label": "Chinese", "value": "chinese"},
    {"label": "Mexican", "value": "mexican"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "American", "value": "american"},
    {"label": "Indian", "value": "indian"},
    {"label": "Thai", "value": "thai"},
    {"label": "French", "value": "french"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "Any Price", "value": ""},
    {"label": "\$ (Under \$15)", "value": "1"},
    {"label": "\$\$ (\$15-\$30)", "value": "2"},
    {"label": "\$\$\$ (\$30-\$60)", "value": "3"},
    {"label": "\$\$\$\$ (Over \$60)", "value": "4"},
  ];

  List<Map<String, dynamic>> distanceItems = [
    {"label": "Any Distance", "value": ""},
    {"label": "Within 1 mile", "value": "1"},
    {"label": "Within 5 miles", "value": "5"},
    {"label": "Within 10 miles", "value": "10"},
    {"label": "Within 25 miles", "value": "25"},
  ];

  List<Map<String, dynamic>> ratingItems = [
    {"label": "Any Rating", "value": ""},
    {"label": "4+ Stars", "value": "4"},
    {"label": "3+ Stars", "value": "3"},
    {"label": "2+ Stars", "value": "2"},
  ];

  List<String> featuresList = [
    "Outdoor Seating",
    "WiFi",
    "Parking Available",
    "Live Music",
    "Happy Hour",
    "Kid Friendly",
    "Pet Friendly",
    "Group Friendly",
    "Romantic",
    "Business Dining",
  ];

  List<String> dietaryOptionsList = [
    "Vegetarian",
    "Vegan",
    "Gluten Free",
    "Halal",
    "Kosher",
    "Dairy Free",
    "Nut Free",
    "Keto Friendly",
    "Low Carb",
    "Organic",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Filters"),
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
            // Cuisine Type
            Text(
              "Cuisine Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Cuisine",
              items: cuisineItems,
              value: selectedCuisine,
              onChanged: (value, label) {
                selectedCuisine = value;
                setState(() {});
              },
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

            // Distance and Rating
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Distance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Distance",
                        items: distanceItems,
                        value: selectedDistance,
                        onChanged: (value, label) {
                          selectedDistance = value;
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
                        "Rating",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Rating",
                        items: ratingItems,
                        value: selectedRating,
                        onChanged: (value, label) {
                          selectedRating = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Hours
            Text(
              "Hours",
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
                        "label": "Open Now",
                        "value": true,
                        "checked": openNow,
                      }
                    ],
                    value: [
                      if (openNow)
                        {"label": "Open Now", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      openNow = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  if (!openNow) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Open Time",
                            value: openTime ?? TimeOfDay(hour: 9, minute: 0),
                            onChanged: (value) {
                              openTime = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Close Time",
                            value: closeTime ?? TimeOfDay(hour: 22, minute: 0),
                            onChanged: (value) {
                              closeTime = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Service Options
            Text(
              "Service Options",
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
                        "label": "Takeout Available",
                        "value": true,
                        "checked": takeout,
                      }
                    ],
                    value: [
                      if (takeout)
                        {"label": "Takeout Available", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      takeout = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Delivery Available",
                        "value": true,
                        "checked": delivery,
                      }
                    ],
                    value: [
                      if (delivery)
                        {"label": "Delivery Available", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      delivery = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Accepts Reservations",
                        "value": true,
                        "checked": reservations,
                      }
                    ],
                    value: [
                      if (reservations)
                        {"label": "Accepts Reservations", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      reservations = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Features
            Text(
              "Features",
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
              child: Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: featuresList.map((feature) {
                  bool isSelected = selectedFeatures.contains(feature);
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
                        feature,
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
            ),

            // Dietary Options
            Text(
              "Dietary Options",
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
              child: Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: dietaryOptionsList.map((option) {
                  bool isSelected = selectedDietaryOptions.contains(option);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedDietaryOptions.remove(option);
                      } else {
                        selectedDietaryOptions.add(option);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? successColor : Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? successColor : Colors.grey.withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        option,
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
      'cuisine': selectedCuisine,
      'priceRange': selectedPriceRange,
      'distance': selectedDistance,
      'rating': selectedRating,
      'features': selectedFeatures,
      'dietaryOptions': selectedDietaryOptions,
      'openNow': openNow,
      'takeout': takeout,
      'delivery': delivery,
      'reservations': reservations,
      'openTime': openTime?.kkmm,
      'closeTime': closeTime?.kkmm,
    };

    ss("Restaurant filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedCuisine = "";
    selectedPriceRange = "";
    selectedDistance = "";
    selectedRating = "";
    selectedFeatures.clear();
    selectedDietaryOptions.clear();
    openTime = null;
    closeTime = null;
    openNow = false;
    takeout = false;
    delivery = false;
    reservations = false;
    setState(() {});
  }
}
