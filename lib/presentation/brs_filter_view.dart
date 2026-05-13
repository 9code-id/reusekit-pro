import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsFilterView extends StatefulWidget {
  const BrsFilterView({super.key});

  @override
  State<BrsFilterView> createState() => _BrsFilterViewState();
}

class _BrsFilterViewState extends State<BrsFilterView> {
  String selectedCategory = "All";
  String selectedBarber = "All";
  String selectedLocation = "All";
  double minPrice = 0;
  double maxPrice = 100;
  String selectedRating = "All";
  String selectedDuration = "All";
  bool onlyAvailable = false;
  bool onlyPopular = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "Hair Cut", "value": "Hair Cut"},
    {"label": "Beard Care", "value": "Beard Care"},
    {"label": "Hair Wash", "value": "Hair Wash"},
    {"label": "Styling", "value": "Styling"},
    {"label": "Coloring", "value": "Coloring"},
    {"label": "Treatments", "value": "Treatments"},
  ];

  List<Map<String, dynamic>> barbers = [
    {"label": "All Barbers", "value": "All"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Mike Johnson", "value": "mike_johnson"},
    {"label": "David Brown", "value": "david_brown"},
    {"label": "Alex Wilson", "value": "alex_wilson"},
    {"label": "Chris Taylor", "value": "chris_taylor"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "All"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Midtown", "value": "midtown"},
    {"label": "Uptown", "value": "uptown"},
    {"label": "Westside", "value": "westside"},
    {"label": "Eastside", "value": "eastside"},
  ];

  List<Map<String, dynamic>> ratings = [
    {"label": "All Ratings", "value": "All"},
    {"label": "4.5+ Stars", "value": "4.5"},
    {"label": "4.0+ Stars", "value": "4.0"},
    {"label": "3.5+ Stars", "value": "3.5"},
    {"label": "3.0+ Stars", "value": "3.0"},
  ];

  List<Map<String, dynamic>> durations = [
    {"label": "Any Duration", "value": "All"},
    {"label": "15-30 minutes", "value": "15-30"},
    {"label": "30-45 minutes", "value": "30-45"},
    {"label": "45-60 minutes", "value": "45-60"},
    {"label": "60+ minutes", "value": "60+"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Services"),
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              "Reset",
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            _buildFilterSection(
              title: "Category",
              child: QDropdownField(
                label: "Select Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),

            // Barber Filter
            _buildFilterSection(
              title: "Barber",
              child: QDropdownField(
                label: "Select Barber",
                items: barbers,
                value: selectedBarber,
                onChanged: (value, label) {
                  selectedBarber = value;
                  setState(() {});
                },
              ),
            ),

            // Location Filter
            _buildFilterSection(
              title: "Location",
              child: QDropdownField(
                label: "Select Location",
                items: locations,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
            ),

            // Price Range
            _buildFilterSection(
              title: "Price Range",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "\$${minPrice.toInt()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${maxPrice.toInt()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  RangeSlider(
                    values: RangeValues(minPrice, maxPrice),
                    min: 0,
                    max: 100,
                    divisions: 20,
                    activeColor: primaryColor,
                    inactiveColor: disabledColor,
                    onChanged: (values) {
                      minPrice = values.start;
                      maxPrice = values.end;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        "Min: \$${minPrice.toInt()}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Max: \$${maxPrice.toInt()}",
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

            // Rating Filter
            _buildFilterSection(
              title: "Minimum Rating",
              child: QDropdownField(
                label: "Select Rating",
                items: ratings,
                value: selectedRating,
                onChanged: (value, label) {
                  selectedRating = value;
                  setState(() {});
                },
              ),
            ),

            // Duration Filter
            _buildFilterSection(
              title: "Service Duration",
              child: QDropdownField(
                label: "Select Duration",
                items: durations,
                value: selectedDuration,
                onChanged: (value, label) {
                  selectedDuration = value;
                  setState(() {});
                },
              ),
            ),

            // Quick Filters
            _buildFilterSection(
              title: "Quick Filters",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Only Available Now",
                              "value": true,
                              "checked": onlyAvailable,
                            }
                          ],
                          value: [
                            if (onlyAvailable)
                              {
                                "label": "Only Available Now",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            onlyAvailable = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Popular Services Only",
                              "value": true,
                              "checked": onlyPopular,
                            }
                          ],
                          value: [
                            if (onlyPopular)
                              {
                                "label": "Popular Services Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            onlyPopular = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Current Filters Summary
            if (_hasActiveFilters()) ...[
              _buildFilterSection(
                title: "Active Filters",
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: _buildActiveFilterChips(),
                ),
              ),
            ],
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Estimated Results",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${_getEstimatedResults()} services",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Apply Filters",
              size: bs.md,
              onPressed: () {
                _applyFilters();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          child,
        ],
      ),
    );
  }

  List<Widget> _buildActiveFilterChips() {
    List<Widget> chips = [];
    
    if (selectedCategory != "All") {
      chips.add(_buildFilterChip("Category: $selectedCategory", () {
        selectedCategory = "All";
        setState(() {});
      }));
    }
    
    if (selectedBarber != "All") {
      chips.add(_buildFilterChip("Barber: $selectedBarber", () {
        selectedBarber = "All";
        setState(() {});
      }));
    }
    
    if (selectedLocation != "All") {
      chips.add(_buildFilterChip("Location: $selectedLocation", () {
        selectedLocation = "All";
        setState(() {});
      }));
    }
    
    if (minPrice > 0 || maxPrice < 100) {
      chips.add(_buildFilterChip("Price: \$${minPrice.toInt()}-\$${maxPrice.toInt()}", () {
        minPrice = 0;
        maxPrice = 100;
        setState(() {});
      }));
    }
    
    if (selectedRating != "All") {
      chips.add(_buildFilterChip("Rating: ${selectedRating}+ Stars", () {
        selectedRating = "All";
        setState(() {});
      }));
    }
    
    if (selectedDuration != "All") {
      chips.add(_buildFilterChip("Duration: $selectedDuration", () {
        selectedDuration = "All";
        setState(() {});
      }));
    }
    
    if (onlyAvailable) {
      chips.add(_buildFilterChip("Available Now", () {
        onlyAvailable = false;
        setState(() {});
      }));
    }
    
    if (onlyPopular) {
      chips.add(_buildFilterChip("Popular Only", () {
        onlyPopular = false;
        setState(() {});
      }));
    }
    
    return chips;
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: primaryColor.withAlpha(51),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasActiveFilters() {
    return selectedCategory != "All" ||
        selectedBarber != "All" ||
        selectedLocation != "All" ||
        minPrice > 0 ||
        maxPrice < 100 ||
        selectedRating != "All" ||
        selectedDuration != "All" ||
        onlyAvailable ||
        onlyPopular;
  }

  int _getEstimatedResults() {
    // Simulate estimation based on filters
    int baseResults = 25;
    
    if (selectedCategory != "All") baseResults = (baseResults * 0.6).round();
    if (selectedBarber != "All") baseResults = (baseResults * 0.4).round();
    if (selectedLocation != "All") baseResults = (baseResults * 0.7).round();
    if (selectedRating != "All") baseResults = (baseResults * 0.8).round();
    if (selectedDuration != "All") baseResults = (baseResults * 0.9).round();
    if (onlyAvailable) baseResults = (baseResults * 0.5).round();
    if (onlyPopular) baseResults = (baseResults * 0.3).round();
    
    return baseResults.clamp(0, 25);
  }

  void _resetFilters() {
    selectedCategory = "All";
    selectedBarber = "All";
    selectedLocation = "All";
    minPrice = 0;
    maxPrice = 100;
    selectedRating = "All";
    selectedDuration = "All";
    onlyAvailable = false;
    onlyPopular = false;
    setState(() {});
    si("All filters have been reset");
  }

  void _applyFilters() {
    // Build filter parameters
    Map<String, dynamic> filters = {
      'category': selectedCategory,
      'barber': selectedBarber,
      'location': selectedLocation,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'rating': selectedRating,
      'duration': selectedDuration,
      'onlyAvailable': onlyAvailable,
      'onlyPopular': onlyPopular,
    };
    
    // Apply filters and go back
    ss("Filters applied successfully");
    back();
  }
}
