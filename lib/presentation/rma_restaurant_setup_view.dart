import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRestaurantSetupView extends StatefulWidget {
  const RmaRestaurantSetupView({super.key});

  @override
  State<RmaRestaurantSetupView> createState() => _RmaRestaurantSetupViewState();
}

class _RmaRestaurantSetupViewState extends State<RmaRestaurantSetupView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool loading = false;

  // Restaurant Basic Info
  String restaurantName = "";
  String restaurantType = "fine_dining";
  String description = "";
  String cuisine = "american";
  String website = "";
  String logoImage = "";

  // Location Info
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "USA";
  String phone = "";
  String email = "";

  // Operating Hours
  Map<String, Map<String, String>> operatingHours = {
    "monday": {"open": "09:00", "close": "22:00", "closed": "false"},
    "tuesday": {"open": "09:00", "close": "22:00", "closed": "false"},
    "wednesday": {"open": "09:00", "close": "22:00", "closed": "false"},
    "thursday": {"open": "09:00", "close": "22:00", "closed": "false"},
    "friday": {"open": "09:00", "close": "23:00", "closed": "false"},
    "saturday": {"open": "10:00", "close": "23:00", "closed": "false"},
    "sunday": {"open": "10:00", "close": "21:00", "closed": "false"},
  };

  // Features & Services
  List<String> selectedFeatures = [];
  int seatingCapacity = 50;
  bool hasDelivery = true;
  bool hasTakeaway = true;
  bool hasReservations = true;
  bool hasWifi = true;
  bool hasParking = true;

  final List<Map<String, dynamic>> restaurantTypes = [
    {"label": "Fine Dining", "value": "fine_dining"},
    {"label": "Casual Dining", "value": "casual_dining"},
    {"label": "Fast Food", "value": "fast_food"},
    {"label": "Fast Casual", "value": "fast_casual"},
    {"label": "Coffee Shop", "value": "coffee_shop"},
    {"label": "Bar & Grill", "value": "bar_grill"},
    {"label": "Bakery", "value": "bakery"},
    {"label": "Food Truck", "value": "food_truck"},
  ];

  final List<Map<String, dynamic>> cuisineTypes = [
    {"label": "American", "value": "american"},
    {"label": "Italian", "value": "italian"},
    {"label": "Mexican", "value": "mexican"},
    {"label": "Chinese", "value": "chinese"},
    {"label": "Indian", "value": "indian"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "Thai", "value": "thai"},
    {"label": "Mediterranean", "value": "mediterranean"},
    {"label": "French", "value": "french"},
    {"label": "Korean", "value": "korean"},
  ];

  final List<Map<String, dynamic>> availableFeatures = [
    {"label": "Online Ordering", "value": "online_ordering", "icon": Icons.shopping_cart},
    {"label": "Table Reservations", "value": "reservations", "icon": Icons.event_seat},
    {"label": "Delivery Service", "value": "delivery", "icon": Icons.delivery_dining},
    {"label": "Catering", "value": "catering", "icon": Icons.restaurant_menu},
    {"label": "Private Events", "value": "private_events", "icon": Icons.event},
    {"label": "Bar Service", "value": "bar", "icon": Icons.local_bar},
    {"label": "Live Music", "value": "live_music", "icon": Icons.music_note},
    {"label": "Outdoor Seating", "value": "outdoor_seating", "icon": Icons.deck},
  ];

  Future<void> _completeSetup() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate setup completion
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    loading = false;
    setState(() {});
    
    ss("Restaurant setup completed successfully!");
    //navigateTo('RmaHomeView')
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Setup Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: List.generate(4, (index) {
              final isActive = index == currentStep;
              final isCompleted = index < currentStep;
              
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  child: Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isActive || isCompleted 
                              ? primaryColor 
                              : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? Icon(Icons.check, color: Colors.white, size: 16)
                              : Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        ["Basic Info", "Location", "Hours", "Features"][index],
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive || isCompleted 
                              ? primaryColor 
                              : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Basic Restaurant Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QImagePicker(
            label: "Restaurant Logo",
            value: logoImage,
            hint: "Upload your restaurant logo",
            onChanged: (value) {
              logoImage = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Restaurant Name",
            value: restaurantName,
            hint: "Enter your restaurant name",
            validator: Validator.required,
            onChanged: (value) {
              restaurantName = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Restaurant Type",
                  items: restaurantTypes,
                  value: restaurantType,
                  onChanged: (value, label) {
                    restaurantType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Cuisine Type",
                  items: cuisineTypes,
                  value: cuisine,
                  onChanged: (value, label) {
                    cuisine = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe your restaurant and what makes it special",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website (Optional)",
            value: website,
            hint: "Enter your restaurant website URL",
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Restaurant Location & Contact",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Street Address",
            value: address,
            hint: "Enter street address",
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: city,
                  hint: "Enter city",
                  validator: Validator.required,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "State",
                  value: state,
                  hint: "State",
                  validator: Validator.required,
                  onChanged: (value) {
                    state = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: zipCode,
                  hint: "ZIP",
                  validator: Validator.required,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Country",
                  value: country,
                  hint: "Country",
                  validator: Validator.required,
                  onChanged: (value) {
                    country = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: phone,
                  hint: "Restaurant phone",
                  validator: Validator.required,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Email",
                  value: email,
                  hint: "Restaurant email",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
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

  Widget _buildOperatingHoursStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Operating Hours",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...operatingHours.keys.map((day) {
            final dayData = operatingHours[day]!;
            final isClosed = dayData["closed"] == "true";
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isClosed 
                    ? disabledColor.withAlpha(10) 
                    : primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          day.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QSwitch(
                        items: [
                          {
                            "label": "Closed",
                            "value": "closed",
                            "checked": isClosed,
                          }
                        ],
                        value: [
                          if (isClosed)
                            {
                              "label": "Closed",
                              "value": "closed",
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          operatingHours[day]!["closed"] = values.isNotEmpty ? "true" : "false";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  if (!isClosed) ...[
                    SizedBox(height: spSm),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Open Time",
                            value: TimeOfDay.fromDateTime(
                              DateTime.parse("2024-01-01 ${dayData["open"]}:00")
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                operatingHours[day]!["open"] = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: QTimePicker(
                            label: "Close Time",
                            value: TimeOfDay.fromDateTime(
                              DateTime.parse("2024-01-01 ${dayData["close"]}:00")
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                operatingHours[day]!["close"] = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeaturesStep() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Features & Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Seating Capacity",
            value: seatingCapacity.toString(),
            validator: Validator.required,
            onChanged: (value) {
              seatingCapacity = int.tryParse(value) ?? 0;
              setState(() {});
            },
          ),
          Text(
            "Available Services:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: availableFeatures.map((feature) {
              final isSelected = selectedFeatures.contains(feature["value"]);
              
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedFeatures.remove(feature["value"]);
                  } else {
                    selectedFeatures.add(feature["value"] as String);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primaryColor.withAlpha(10) 
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected 
                          ? primaryColor 
                          : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        feature["icon"] as IconData,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${feature["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 16,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        spacing: spSm,
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  setState(() {
                    currentStep--;
                  });
                },
              ),
            ),
          Expanded(
            flex: currentStep > 0 ? 1 : 2,
            child: QButton(
              label: currentStep == 3 ? "Complete Setup" : "Next",
              size: bs.sm,
              onPressed: () {
                if (currentStep == 3) {
                  _completeSetup();
                } else {
                  setState(() {
                    currentStep++;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Setup"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    if (currentStep == 0) _buildBasicInfoStep(),
                    if (currentStep == 1) _buildLocationStep(),
                    if (currentStep == 2) _buildOperatingHoursStep(),
                    if (currentStep == 3) _buildFeaturesStep(),
                  ],
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }
}
