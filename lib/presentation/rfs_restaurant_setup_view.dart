import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsRestaurantSetupView extends StatefulWidget {
  const RfsRestaurantSetupView({super.key});

  @override
  State<RfsRestaurantSetupView> createState() => _RfsRestaurantSetupViewState();
}

class _RfsRestaurantSetupViewState extends State<RfsRestaurantSetupView> {
  final formKey = GlobalKey<FormState>();
  String restaurantName = "";
  String selectedCuisineType = "";
  String selectedRestaurantType = "";
  String description = "";
  String website = "";
  String socialMedia = "";
  List<String> restaurantImages = [];
  String restaurantLogo = "";
  bool loading = false;

  List<Map<String, dynamic>> cuisineTypes = [
    {"label": "American", "value": "American"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Mexican", "value": "Mexican"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Japanese", "value": "Japanese"},
    {"label": "Indian", "value": "Indian"},
    {"label": "Mediterranean", "value": "Mediterranean"},
    {"label": "French", "value": "French"},
    {"label": "Thai", "value": "Thai"},
    {"label": "Korean", "value": "Korean"},
    {"label": "Vietnamese", "value": "Vietnamese"},
    {"label": "Lebanese", "value": "Lebanese"},
    {"label": "Greek", "value": "Greek"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "Fusion", "value": "Fusion"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> restaurantTypes = [
    {"label": "Fine Dining", "value": "Fine Dining"},
    {"label": "Casual Dining", "value": "Casual Dining"},
    {"label": "Fast Food", "value": "Fast Food"},
    {"label": "Fast Casual", "value": "Fast Casual"},
    {"label": "Cafe/Bistro", "value": "Cafe/Bistro"},
    {"label": "Bar/Pub", "value": "Bar/Pub"},
    {"label": "Food Truck", "value": "Food Truck"},
    {"label": "Catering", "value": "Catering"},
    {"label": "Bakery", "value": "Bakery"},
    {"label": "Coffee Shop", "value": "Coffee Shop"},
  ];

  void _handleNext() async {
    if (formKey.currentState!.validate()) {
      if (selectedCuisineType.isEmpty) {
        se("Please select a cuisine type");
        return;
      }
      if (selectedRestaurantType.isEmpty) {
        se("Please select a restaurant type");
        return;
      }
      
      loading = true;
      setState(() {});
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Restaurant information saved successfully!");
      // Navigate to location setup
      //navigateTo(RfsLocationSetupView());
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStepItem("1", "Restaurant", true, true),
          Expanded(child: Container(height: 2, color: disabledColor)),
          _buildStepItem("2", "Location", false, false),
          Expanded(child: Container(height: 2, color: disabledColor)),
          _buildStepItem("3", "Business", false, false),
          Expanded(child: Container(height: 2, color: disabledColor)),
          _buildStepItem("4", "Hours", false, false),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : (isCompleted ? successColor : disabledColor),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? primaryColor : disabledBoldColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Setup"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Indicator
              _buildStepIndicator(),
              
              SizedBox(height: spLg),
              
              // Header
              Text(
                "Tell us about your restaurant",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "We'll use this information to customize your experience",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Basic Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Restaurant Name",
                          value: restaurantName,
                          validator: Validator.required,
                          onChanged: (value) {
                            restaurantName = value;
                            setState(() {});
                          },
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Cuisine Type",
                                items: cuisineTypes,
                                value: selectedCuisineType,
                                onChanged: (value, label) {
                                  selectedCuisineType = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Restaurant Type",
                                items: restaurantTypes,
                                value: selectedRestaurantType,
                                onChanged: (value, label) {
                                  selectedRestaurantType = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        QMemoField(
                          label: "Description",
                          value: description,
                          hint: "Describe your restaurant, specialties, and what makes it unique...",
                          onChanged: (value) {
                            description = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Branding Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Branding & Images",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QImagePicker(
                          label: "Restaurant Logo",
                          value: restaurantLogo,
                          hint: "Upload your restaurant logo",
                          onChanged: (value) {
                            restaurantLogo = value;
                            setState(() {});
                          },
                        ),
                        
                        QMultiImagePicker(
                          label: "Restaurant Photos",
                          value: restaurantImages,
                          maxImages: 5,
                          hint: "Add photos of your restaurant, food, and ambiance",
                          onChanged: (value) {
                            restaurantImages = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Online Presence Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Online Presence",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Optional",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Website URL",
                          value: website,
                          hint: "https://yourrestaurant.com",
                          onChanged: (value) {
                            website = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Social Media",
                          value: socialMedia,
                          hint: "@yourrestaurant or Facebook page URL",
                          onChanged: (value) {
                            socialMedia = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Next Button
              Container(
                width: double.infinity,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : QButton(
                        label: "Continue to Location Setup",
                        size: bs.md,
                        onPressed: _handleNext,
                      ),
              ),
              
              SizedBox(height: spMd),
              
              // Skip Option
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Skip this step
                    //navigateTo(RfsLocationSetupView());
                  },
                  child: Text(
                    "Skip for now",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Progress Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "You can always update this information later in your restaurant settings.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
