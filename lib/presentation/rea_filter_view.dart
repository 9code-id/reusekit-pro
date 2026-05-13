import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaFilterView extends StatefulWidget {
  const ReaFilterView({super.key});

  @override
  State<ReaFilterView> createState() => _ReaFilterViewState();
}

class _ReaFilterViewState extends State<ReaFilterView> {
  // Price range
  double minPrice = 100000;
  double maxPrice = 1000000;
  RangeValues priceRange = RangeValues(100000, 1000000);

  // Property type
  String selectedPropertyType = "All";
  final List<String> propertyTypes = [
    "All", "Apartment", "House", "Villa", "Townhouse", 
    "Studio", "Penthouse", "Commercial", "Land"
  ];

  // Bedrooms & Bathrooms
  int selectedBedrooms = 0; // 0 means any
  int selectedBathrooms = 0; // 0 means any

  // Area range
  RangeValues areaRange = RangeValues(500, 5000);

  // Amenities
  Map<String, bool> amenities = {
    "Parking": false,
    "Swimming Pool": false,
    "Gym/Fitness Center": false,
    "Garden": false,
    "Balcony": false,
    "Elevator": false,
    "Security": false,
    "Air Conditioning": false,
    "Furnished": false,
    "Pet Friendly": false,
    "Internet/WiFi": false,
    "Laundry": false,
  };

  // Property features
  Map<String, bool> features = {
    "New Construction": false,
    "Recently Renovated": false,
    "Move-in Ready": false,
    "Under Construction": false,
    "Resale Property": false,
    "Investment Property": false,
    "Luxury Property": false,
    "Eco-Friendly": false,
  };

  // Location filters
  String selectedCity = "";
  String selectedNeighborhood = "";
  double maxDistance = 50; // km
  bool nearSchools = false;
  bool nearHospitals = false;
  bool nearPublicTransport = false;
  bool nearShopping = false;

  // Additional filters
  String propertyAge = "Any"; // Any, Under 5 years, 5-10 years, 10+ years
  String furnishingStatus = "Any"; // Any, Furnished, Semi-furnished, Unfurnished
  String availability = "Any"; // Any, Immediate, Within 1 month, Within 3 months
  bool virtualTourAvailable = false;
  bool hasPhotos = false;

  int totalFiltersApplied = 0;

  @override
  void initState() {
    super.initState();
    _updateFilterCount();
  }

  void _updateFilterCount() {
    int count = 0;
    
    // Price range
    if (priceRange.start > 100000 || priceRange.end < 1000000) count++;
    
    // Property type
    if (selectedPropertyType != "All") count++;
    
    // Bedrooms/Bathrooms
    if (selectedBedrooms > 0) count++;
    if (selectedBathrooms > 0) count++;
    
    // Area
    if (areaRange.start > 500 || areaRange.end < 5000) count++;
    
    // Amenities
    count += amenities.values.where((value) => value).length;
    
    // Features
    count += features.values.where((value) => value).length;
    
    // Location
    if (selectedCity.isNotEmpty) count++;
    if (selectedNeighborhood.isNotEmpty) count++;
    if (maxDistance < 50) count++;
    if (nearSchools || nearHospitals || nearPublicTransport || nearShopping) count++;
    
    // Additional
    if (propertyAge != "Any") count++;
    if (furnishingStatus != "Any") count++;
    if (availability != "Any") count++;
    if (virtualTourAvailable || hasPhotos) count++;
    
    setState(() {
      totalFiltersApplied = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          if (totalFiltersApplied > 0)
            TextButton(
              onPressed: _clearAllFilters,
              child: Text(
                "Clear All",
                style: TextStyle(
                  color: dangerColor,
                  fontWeight: FontWeight.w600,
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
            // Filter summary
            if (totalFiltersApplied > 0)
              Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "$totalFiltersApplied ${totalFiltersApplied == 1 ? 'filter' : 'filters'} applied",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Price Range
            _buildSectionTitle("Price Range"),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Min Price",
                          value: "\$${priceRange.start.toInt()}",
                          onChanged: (value) {
                            // Handle min price change
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text("to", style: TextStyle(color: disabledBoldColor)),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Max Price",
                          value: "\$${priceRange.end.toInt()}",
                          onChanged: (value) {
                            // Handle max price change
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  RangeSlider(
                    values: priceRange,
                    min: 50000,
                    max: 2000000,
                    divisions: 100,
                    labels: RangeLabels(
                      "\$${priceRange.start.toInt()}",
                      "\$${priceRange.end.toInt()}",
                    ),
                    onChanged: (values) {
                      setState(() {
                        priceRange = values;
                      });
                      _updateFilterCount();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Property Type
            _buildSectionTitle("Property Type"),
            _buildOptionGrid(
              propertyTypes,
              selectedPropertyType,
              (value) {
                setState(() {
                  selectedPropertyType = value;
                });
                _updateFilterCount();
              },
            ),

            SizedBox(height: spMd),

            // Bedrooms & Bathrooms
            _buildSectionTitle("Bedrooms & Bathrooms"),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Bedrooms
                  Row(
                    children: [
                      Text(
                        "Bedrooms:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      ...List.generate(6, (index) {
                        final value = index; // 0 = Any, 1-5 = specific count
                        final label = index == 0 ? "Any" : "$index";
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBedrooms = value;
                            });
                            _updateFilterCount();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: spXs),
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: selectedBedrooms == value
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: selectedBedrooms == value
                                    ? primaryColor
                                    : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: selectedBedrooms == value
                                    ? Colors.white
                                    : disabledBoldColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: spSm),
                  // Bathrooms
                  Row(
                    children: [
                      Text(
                        "Bathrooms:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      ...List.generate(6, (index) {
                        final value = index; // 0 = Any, 1-5 = specific count
                        final label = index == 0 ? "Any" : "$index";
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBathrooms = value;
                            });
                            _updateFilterCount();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: spXs),
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: selectedBathrooms == value
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: selectedBathrooms == value
                                    ? primaryColor
                                    : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: selectedBathrooms == value
                                    ? Colors.white
                                    : disabledBoldColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Area Range
            _buildSectionTitle("Area (sq ft)"),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("${areaRange.start.toInt()} sq ft"),
                      Spacer(),
                      Text("${areaRange.end.toInt()} sq ft"),
                    ],
                  ),
                  RangeSlider(
                    values: areaRange,
                    min: 200,
                    max: 10000,
                    divisions: 100,
                    onChanged: (values) {
                      setState(() {
                        areaRange = values;
                      });
                      _updateFilterCount();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Amenities
            _buildSectionTitle("Amenities"),
            _buildCheckboxGrid(amenities),

            SizedBox(height: spMd),

            // Property Features
            _buildSectionTitle("Property Features"),
            _buildCheckboxGrid(features),

            SizedBox(height: spMd),

            // Location Preferences
            _buildSectionTitle("Location Preferences"),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "City",
                    value: selectedCity,
                    onChanged: (value) {
                      selectedCity = value;
                      _updateFilterCount();
                    },
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Neighborhood",
                    value: selectedNeighborhood,
                    onChanged: (value) {
                      selectedNeighborhood = value;
                      _updateFilterCount();
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text("Max Distance: ${maxDistance.toInt()} km"),
                      Spacer(),
                    ],
                  ),
                  Slider(
                    value: maxDistance,
                    min: 1,
                    max: 100,
                    divisions: 99,
                    onChanged: (value) {
                      setState(() {
                        maxDistance = value;
                      });
                      _updateFilterCount();
                    },
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      _buildSwitchTile("Near Schools", nearSchools, (value) {
                        setState(() {
                          nearSchools = value;
                        });
                        _updateFilterCount();
                      }),
                      _buildSwitchTile("Near Hospitals", nearHospitals, (value) {
                        setState(() {
                          nearHospitals = value;
                        });
                        _updateFilterCount();
                      }),
                      _buildSwitchTile("Near Public Transport", nearPublicTransport, (value) {
                        setState(() {
                          nearPublicTransport = value;
                        });
                        _updateFilterCount();
                      }),
                      _buildSwitchTile("Near Shopping Centers", nearShopping, (value) {
                        setState(() {
                          nearShopping = value;
                        });
                        _updateFilterCount();
                      }),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Additional Filters
            _buildSectionTitle("Additional Filters"),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QDropdownField(
                    label: "Property Age",
                    items: [
                      {"label": "Any", "value": "Any"},
                      {"label": "Under 5 years", "value": "Under 5 years"},
                      {"label": "5-10 years", "value": "5-10 years"},
                      {"label": "10+ years", "value": "10+ years"},
                    ],
                    value: propertyAge,
                    onChanged: (value, label) {
                      setState(() {
                        propertyAge = value;
                      });
                      _updateFilterCount();
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Furnishing Status",
                    items: [
                      {"label": "Any", "value": "Any"},
                      {"label": "Furnished", "value": "Furnished"},
                      {"label": "Semi-furnished", "value": "Semi-furnished"},
                      {"label": "Unfurnished", "value": "Unfurnished"},
                    ],
                    value: furnishingStatus,
                    onChanged: (value, label) {
                      setState(() {
                        furnishingStatus = value;
                      });
                      _updateFilterCount();
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Availability",
                    items: [
                      {"label": "Any", "value": "Any"},
                      {"label": "Immediate", "value": "Immediate"},
                      {"label": "Within 1 month", "value": "Within 1 month"},
                      {"label": "Within 3 months", "value": "Within 3 months"},
                    ],
                    value: availability,
                    onChanged: (value, label) {
                      setState(() {
                        availability = value;
                      });
                      _updateFilterCount();
                    },
                  ),
                  SizedBox(height: spSm),
                  _buildSwitchTile("Has Virtual Tour", virtualTourAvailable, (value) {
                    setState(() {
                      virtualTourAvailable = value;
                    });
                    _updateFilterCount();
                  }),
                  _buildSwitchTile("Has Photos", hasPhotos, (value) {
                    setState(() {
                      hasPhotos = value;
                    });
                    _updateFilterCount();
                  }),
                ],
              ),
            ),

            SizedBox(height: spMd * 2),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Reset Filters",
                onPressed: _clearAllFilters,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Apply Filters",
                onPressed: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fsH6,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _buildOptionGrid(List<String> options, String selectedValue, Function(String) onSelect) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Wrap(
        spacing: spXs,
        runSpacing: spXs,
        children: options.map((option) {
          final isSelected = option == selectedValue;
          return GestureDetector(
            onTap: () => onSelect(option),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : disabledBoldColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCheckboxGrid(Map<String, bool> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: items.keys.map((key) {
          return _buildSwitchTile(key, items[key]!, (value) {
            setState(() {
              items[key] = value;
            });
            _updateFilterCount();
          });
        }).toList(),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: primaryColor,
        ),
      ],
    );
  }

  void _clearAllFilters() {
    setState(() {
      // Reset all filters to default values
      priceRange = RangeValues(100000, 1000000);
      selectedPropertyType = "All";
      selectedBedrooms = 0;
      selectedBathrooms = 0;
      areaRange = RangeValues(500, 5000);
      
      amenities.updateAll((key, value) => false);
      features.updateAll((key, value) => false);
      
      selectedCity = "";
      selectedNeighborhood = "";
      maxDistance = 50;
      nearSchools = false;
      nearHospitals = false;
      nearPublicTransport = false;
      nearShopping = false;
      
      propertyAge = "Any";
      furnishingStatus = "Any";
      availability = "Any";
      virtualTourAvailable = false;
      hasPhotos = false;
      
      totalFiltersApplied = 0;
    });
    ss("All filters cleared");
  }

  void _applyFilters() {
    _updateFilterCount();
    ss("Filters applied successfully!");
    back();
  }
}
