import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter10View extends StatefulWidget {
  @override
  State<GrlFilter10View> createState() => _GrlFilter10ViewState();
}

class _GrlFilter10ViewState extends State<GrlFilter10View> {
  String selectedMake = "";
  String selectedModel = "";
  String selectedYear = "";
  String selectedPriceRange = "";
  String selectedMileage = "";
  String selectedTransmission = "";
  String selectedFuelType = "";
  String selectedBodyType = "";
  String selectedColor = "";
  List<String> selectedFeatures = [];
  String selectedCondition = "";
  bool certified = false;
  bool oneOwner = false;
  bool noAccidents = false;
  bool serviceRecords = false;
  double maxPrice = 50000;
  double maxMileage = 100000;

  List<Map<String, dynamic>> makeItems = [
    {"label": "Any Make", "value": ""},
    {"label": "Toyota", "value": "toyota"},
    {"label": "Honda", "value": "honda"},
    {"label": "Ford", "value": "ford"},
    {"label": "Chevrolet", "value": "chevrolet"},
    {"label": "BMW", "value": "bmw"},
    {"label": "Mercedes-Benz", "value": "mercedes"},
    {"label": "Audi", "value": "audi"},
    {"label": "Nissan", "value": "nissan"},
    {"label": "Hyundai", "value": "hyundai"},
    {"label": "Volkswagen", "value": "volkswagen"},
  ];

  List<Map<String, dynamic>> modelItems = [
    {"label": "Any Model", "value": ""},
    {"label": "Camry", "value": "camry"},
    {"label": "Accord", "value": "accord"},
    {"label": "F-150", "value": "f150"},
    {"label": "Civic", "value": "civic"},
    {"label": "Corolla", "value": "corolla"},
    {"label": "Silverado", "value": "silverado"},
    {"label": "RAV4", "value": "rav4"},
    {"label": "CR-V", "value": "crv"},
  ];

  List<Map<String, dynamic>> yearItems = [
    {"label": "Any Year", "value": ""},
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
    {"label": "2020", "value": "2020"},
    {"label": "2015-2019", "value": "2015_2019"},
    {"label": "2010-2014", "value": "2010_2014"},
    {"label": "Before 2010", "value": "before_2010"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "Any Price", "value": ""},
    {"label": "Under \$10,000", "value": "under_10k"},
    {"label": "\$10,000 - \$20,000", "value": "10k_20k"},
    {"label": "\$20,000 - \$30,000", "value": "20k_30k"},
    {"label": "\$30,000 - \$50,000", "value": "30k_50k"},
    {"label": "Over \$50,000", "value": "over_50k"},
  ];

  List<Map<String, dynamic>> mileageItems = [
    {"label": "Any Mileage", "value": ""},
    {"label": "Under 25,000", "value": "under_25k"},
    {"label": "25,000 - 50,000", "value": "25k_50k"},
    {"label": "50,000 - 75,000", "value": "50k_75k"},
    {"label": "75,000 - 100,000", "value": "75k_100k"},
    {"label": "Over 100,000", "value": "over_100k"},
  ];

  List<Map<String, dynamic>> transmissionItems = [
    {"label": "Any Transmission", "value": ""},
    {"label": "Automatic", "value": "automatic"},
    {"label": "Manual", "value": "manual"},
    {"label": "CVT", "value": "cvt"},
  ];

  List<Map<String, dynamic>> fuelTypeItems = [
    {"label": "Any Fuel Type", "value": ""},
    {"label": "Gasoline", "value": "gasoline"},
    {"label": "Hybrid", "value": "hybrid"},
    {"label": "Electric", "value": "electric"},
    {"label": "Diesel", "value": "diesel"},
    {"label": "Plug-in Hybrid", "value": "plugin_hybrid"},
  ];

  List<Map<String, dynamic>> bodyTypeItems = [
    {"label": "Any Body Type", "value": ""},
    {"label": "Sedan", "value": "sedan"},
    {"label": "SUV", "value": "suv"},
    {"label": "Truck", "value": "truck"},
    {"label": "Coupe", "value": "coupe"},
    {"label": "Hatchback", "value": "hatchback"},
    {"label": "Convertible", "value": "convertible"},
    {"label": "Wagon", "value": "wagon"},
    {"label": "Minivan", "value": "minivan"},
  ];

  List<Map<String, dynamic>> colorItems = [
    {"label": "Any Color", "value": ""},
    {"label": "Black", "value": "black"},
    {"label": "White", "value": "white"},
    {"label": "Silver", "value": "silver"},
    {"label": "Gray", "value": "gray"},
    {"label": "Red", "value": "red"},
    {"label": "Blue", "value": "blue"},
    {"label": "Green", "value": "green"},
    {"label": "Brown", "value": "brown"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "Any Condition", "value": ""},
    {"label": "New", "value": "new"},
    {"label": "Certified Pre-Owned", "value": "certified"},
    {"label": "Used - Excellent", "value": "excellent"},
    {"label": "Used - Good", "value": "good"},
    {"label": "Used - Fair", "value": "fair"},
  ];

  List<String> featuresList = [
    "Leather Seats",
    "Sunroof",
    "Navigation System",
    "Backup Camera",
    "Bluetooth",
    "Heated Seats",
    "Remote Start",
    "Cruise Control",
    "Parking Sensors",
    "Lane Departure Warning",
    "Blind Spot Monitoring",
    "Apple CarPlay",
    "Android Auto",
    "Premium Sound System",
    "All-Wheel Drive",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Filters"),
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
            // Make and Model
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Make",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Make",
                        items: makeItems,
                        value: selectedMake,
                        onChanged: (value, label) {
                          selectedMake = value;
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
                        "Model",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Model",
                        items: modelItems,
                        value: selectedModel,
                        onChanged: (value, label) {
                          selectedModel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Year and Price Range
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Year",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Year",
                        items: yearItems,
                        value: selectedYear,
                        onChanged: (value, label) {
                          selectedYear = value;
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
                        "Price Range",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Price Range",
                        items: priceRangeItems,
                        value: selectedPriceRange,
                        onChanged: (value, label) {
                          selectedPriceRange = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Custom Price Range
            if (selectedPriceRange == "") ...[
              Text(
                "Max Price",
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
                        Text(
                          "Max Price: \$${maxPrice.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: maxPrice,
                      min: 5000,
                      max: 100000,
                      divisions: 95,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        maxPrice = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Mileage and Transmission
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mileage",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Mileage",
                        items: mileageItems,
                        value: selectedMileage,
                        onChanged: (value, label) {
                          selectedMileage = value;
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
                        "Transmission",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Transmission",
                        items: transmissionItems,
                        value: selectedTransmission,
                        onChanged: (value, label) {
                          selectedTransmission = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Custom Mileage Range
            if (selectedMileage == "") ...[
              Text(
                "Max Mileage",
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
                        Text(
                          "Max Mileage: ${maxMileage.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} miles",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: maxMileage,
                      min: 0,
                      max: 200000,
                      divisions: 200,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        maxMileage = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Fuel Type and Body Type
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fuel Type",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Fuel Type",
                        items: fuelTypeItems,
                        value: selectedFuelType,
                        onChanged: (value, label) {
                          selectedFuelType = value;
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
                        "Body Type",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Body Type",
                        items: bodyTypeItems,
                        value: selectedBodyType,
                        onChanged: (value, label) {
                          selectedBodyType = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Color and Condition
            Row(
              children: [
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
                SizedBox(width: spSm),
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
              ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select desired features:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
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
                ],
              ),
            ),

            // Vehicle History
            Text(
              "Vehicle History",
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
                        "label": "Certified Pre-Owned",
                        "value": true,
                        "checked": certified,
                      }
                    ],
                    value: [
                      if (certified)
                        {"label": "Certified Pre-Owned", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      certified = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "One Owner",
                        "value": true,
                        "checked": oneOwner,
                      }
                    ],
                    value: [
                      if (oneOwner)
                        {"label": "One Owner", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      oneOwner = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "No Accidents",
                        "value": true,
                        "checked": noAccidents,
                      }
                    ],
                    value: [
                      if (noAccidents)
                        {"label": "No Accidents", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      noAccidents = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Service Records Available",
                        "value": true,
                        "checked": serviceRecords,
                      }
                    ],
                    value: [
                      if (serviceRecords)
                        {"label": "Service Records Available", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      serviceRecords = values.isNotEmpty;
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
      'make': selectedMake,
      'model': selectedModel,
      'year': selectedYear,
      'priceRange': selectedPriceRange,
      'maxPrice': maxPrice,
      'mileage': selectedMileage,
      'maxMileage': maxMileage,
      'transmission': selectedTransmission,
      'fuelType': selectedFuelType,
      'bodyType': selectedBodyType,
      'color': selectedColor,
      'condition': selectedCondition,
      'features': selectedFeatures,
      'certified': certified,
      'oneOwner': oneOwner,
      'noAccidents': noAccidents,
      'serviceRecords': serviceRecords,
    };

    ss("Car filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedMake = "";
    selectedModel = "";
    selectedYear = "";
    selectedPriceRange = "";
    selectedMileage = "";
    selectedTransmission = "";
    selectedFuelType = "";
    selectedBodyType = "";
    selectedColor = "";
    selectedCondition = "";
    selectedFeatures.clear();
    certified = false;
    oneOwner = false;
    noAccidents = false;
    serviceRecords = false;
    maxPrice = 50000;
    maxMileage = 100000;
    setState(() {});
  }
}
