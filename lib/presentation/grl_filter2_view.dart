import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter2View extends StatefulWidget {
  @override
  State<GrlFilter2View> createState() => _GrlFilter2ViewState();
}

class _GrlFilter2ViewState extends State<GrlFilter2View> {
  String selectedLocation = "";
  String selectedPropertyType = "";
  String selectedPriceRange = "";
  String selectedBedrooms = "";
  String selectedBathrooms = "";
  List<String> selectedAmenities = [];
  String selectedListingType = "all";
  DateTime? startDate;
  DateTime? endDate;

  List<Map<String, dynamic>> locationItems = [
    {"label": "Select Location", "value": ""},
    {"label": "New York", "value": "new_york"},
    {"label": "Los Angeles", "value": "los_angeles"},
    {"label": "Chicago", "value": "chicago"},
    {"label": "Miami", "value": "miami"},
    {"label": "San Francisco", "value": "san_francisco"},
  ];

  List<Map<String, dynamic>> propertyTypeItems = [
    {"label": "Select Property Type", "value": ""},
    {"label": "Apartment", "value": "apartment"},
    {"label": "House", "value": "house"},
    {"label": "Condo", "value": "condo"},
    {"label": "Townhouse", "value": "townhouse"},
    {"label": "Studio", "value": "studio"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "Select Price Range", "value": ""},
    {"label": "Under \$1,000", "value": "under_1000"},
    {"label": "\$1,000 - \$2,000", "value": "1000_2000"},
    {"label": "\$2,000 - \$3,000", "value": "2000_3000"},
    {"label": "\$3,000 - \$5,000", "value": "3000_5000"},
    {"label": "Over \$5,000", "value": "over_5000"},
  ];

  List<Map<String, dynamic>> bedroomItems = [
    {"label": "Any Bedrooms", "value": ""},
    {"label": "1 Bedroom", "value": "1"},
    {"label": "2 Bedrooms", "value": "2"},
    {"label": "3 Bedrooms", "value": "3"},
    {"label": "4+ Bedrooms", "value": "4+"},
  ];

  List<Map<String, dynamic>> bathroomItems = [
    {"label": "Any Bathrooms", "value": ""},
    {"label": "1 Bathroom", "value": "1"},
    {"label": "2 Bathrooms", "value": "2"},
    {"label": "3+ Bathrooms", "value": "3+"},
  ];

  List<String> amenitiesList = [
    "Parking",
    "Pet Friendly",
    "Gym",
    "Swimming Pool",
    "Laundry",
    "Balcony",
    "Air Conditioning",
    "Dishwasher",
    "Elevator",
    "Furnished",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Filters"),
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
            // Location Filter
            Text(
              "Location",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Location",
              items: locationItems,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            // Property Type
            Text(
              "Property Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Property Type",
              items: propertyTypeItems,
              value: selectedPropertyType,
              onChanged: (value, label) {
                selectedPropertyType = value;
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

            // Bedrooms and Bathrooms
            Text(
              "Rooms",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Bedrooms",
                    items: bedroomItems,
                    value: selectedBedrooms,
                    onChanged: (value, label) {
                      selectedBedrooms = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Bathrooms",
                    items: bathroomItems,
                    value: selectedBathrooms,
                    onChanged: (value, label) {
                      selectedBathrooms = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Availability Dates
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
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Available From",
                          value: startDate ?? DateTime.now(),
                          onChanged: (value) {
                            startDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDatePicker(
                          label: "Available To",
                          value: endDate ?? DateTime.now().add(Duration(days: 30)),
                          onChanged: (value) {
                            endDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Amenities
            Text(
              "Amenities",
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
                children: amenitiesList.map((amenity) {
                  bool isSelected = selectedAmenities.contains(amenity);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedAmenities.remove(amenity);
                      } else {
                        selectedAmenities.add(amenity);
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
                        amenity,
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

            // Listing Type
            Text(
              "Listing Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: [
                {"label": "All", "value": "all"},
                {"label": "For Rent", "value": "rent"},
                {"label": "For Sale", "value": "sale"},
                {"label": "Short Term", "value": "short_term"},
              ],
              value: selectedListingType,
              onChanged: (index, label, value, item) {
                selectedListingType = value;
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
      'location': selectedLocation,
      'propertyType': selectedPropertyType,
      'priceRange': selectedPriceRange,
      'bedrooms': selectedBedrooms,
      'bathrooms': selectedBathrooms,
      'amenities': selectedAmenities,
      'listingType': selectedListingType,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };

    ss("Property filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedLocation = "";
    selectedPropertyType = "";
    selectedPriceRange = "";
    selectedBedrooms = "";
    selectedBathrooms = "";
    selectedAmenities.clear();
    selectedListingType = "all";
    startDate = null;
    endDate = null;
    setState(() {});
  }
}
