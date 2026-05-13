import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsLocationSetupView extends StatefulWidget {
  const RfsLocationSetupView({super.key});

  @override
  State<RfsLocationSetupView> createState() => _RfsLocationSetupViewState();
}

class _RfsLocationSetupViewState extends State<RfsLocationSetupView> {
  final formKey = GlobalKey<FormState>();
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String phone = "";
  String email = "";
  bool enableDelivery = false;
  bool enableTakeout = true;
  bool enableDineIn = true;
  String deliveryRadius = "5";
  String deliveryFee = "2.99";
  String minimumOrder = "15.00";
  bool loading = false;

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> radiusOptions = [
    {"label": "1 mile", "value": "1"},
    {"label": "3 miles", "value": "3"},
    {"label": "5 miles", "value": "5"},
    {"label": "10 miles", "value": "10"},
    {"label": "15 miles", "value": "15"},
    {"label": "20 miles", "value": "20"},
  ];

  void _handleNext() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Location information saved successfully!");
      // Navigate to business info setup
      //navigateTo(RfsBusinessInfoView());
    }
  }

  void _getCurrentLocation() {
    ss("Getting current location...");
    // Implement location services
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
          _buildStepItem("1", "Restaurant", false, true),
          Expanded(child: Container(height: 2, color: successColor)),
          _buildStepItem("2", "Location", true, false),
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
        title: Text("Location Setup"),
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
                "Where is your restaurant located?",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "This helps customers find you and enables location-based services",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Address Section
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
                          "Restaurant Address",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: _getCurrentLocation,
                          child: Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Use Current",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Street Address",
                          value: address,
                          validator: Validator.required,
                          onChanged: (value) {
                            address = value;
                            setState(() {});
                          },
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: QTextField(
                                label: "City",
                                value: city,
                                validator: Validator.required,
                                onChanged: (value) {
                                  city = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "State",
                                value: state,
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
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "ZIP Code",
                                value: zipCode,
                                validator: Validator.required,
                                onChanged: (value) {
                                  zipCode = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Country",
                                items: countryOptions,
                                value: country,
                                onChanged: (value, label) {
                                  country = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Contact Information Section
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
                      "Contact Information",
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
                          label: "Phone Number",
                          value: phone,
                          validator: Validator.required,
                          onChanged: (value) {
                            phone = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Email Address",
                          value: email,
                          validator: Validator.email,
                          onChanged: (value) {
                            email = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Service Options Section
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
                      "Service Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spSm,
                      children: [
                        QSwitch(
                          items: [
                            {
                              "label": "Dine-in available",
                              "value": "dine_in",
                              "checked": enableDineIn,
                            }
                          ],
                          value: [
                            if (enableDineIn)
                              {
                                "label": "Dine-in available",
                                "value": "dine_in",
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableDineIn = values.any((v) => v["value"] == "dine_in");
                            setState(() {});
                          },
                        ),
                        
                        QSwitch(
                          items: [
                            {
                              "label": "Takeout available",
                              "value": "takeout",
                              "checked": enableTakeout,
                            }
                          ],
                          value: [
                            if (enableTakeout)
                              {
                                "label": "Takeout available",
                                "value": "takeout",
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableTakeout = values.any((v) => v["value"] == "takeout");
                            setState(() {});
                          },
                        ),
                        
                        QSwitch(
                          items: [
                            {
                              "label": "Delivery available",
                              "value": "delivery",
                              "checked": enableDelivery,
                            }
                          ],
                          value: [
                            if (enableDelivery)
                              {
                                "label": "Delivery available",
                                "value": "delivery",
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableDelivery = values.any((v) => v["value"] == "delivery");
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Delivery Settings (conditionally shown)
              if (enableDelivery) ...[
                SizedBox(height: spMd),
                
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
                        "Delivery Settings",
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
                          QDropdownField(
                            label: "Delivery Radius",
                            items: radiusOptions,
                            value: deliveryRadius,
                            onChanged: (value, label) {
                              deliveryRadius = value;
                              setState(() {});
                            },
                          ),
                          
                          Row(
                            children: [
                              Expanded(
                                child: QNumberField(
                                  label: "Delivery Fee (\$)",
                                  value: deliveryFee,
                                  onChanged: (value) {
                                    deliveryFee = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QNumberField(
                                  label: "Minimum Order (\$)",
                                  value: minimumOrder,
                                  onChanged: (value) {
                                    minimumOrder = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              
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
                        label: "Continue to Business Info",
                        size: bs.md,
                        onPressed: _handleNext,
                      ),
              ),
              
              SizedBox(height: spMd),
              
              // Back Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    back();
                  },
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
