import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaVehicleSetupView extends StatefulWidget {
  const DlaVehicleSetupView({super.key});

  @override
  State<DlaVehicleSetupView> createState() => _DlaVehicleSetupViewState();
}

class _DlaVehicleSetupViewState extends State<DlaVehicleSetupView> {
  final formKey = GlobalKey<FormState>();
  
  String vehicleType = "";
  String vehicleMake = "";
  String vehicleModel = "";
  String vehicleYear = "";
  String vehicleColor = "";
  String licensePlate = "";
  String driverLicense = "";
  String vehicleRegistration = "";
  String insurance = "";
  List<String> vehicleImages = [];
  
  List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Car", "value": "car"},
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Bicycle", "value": "bicycle"},
    {"label": "Scooter", "value": "scooter"},
    {"label": "Van", "value": "van"},
    {"label": "Truck", "value": "truck"},
  ];
  
  List<Map<String, dynamic>> vehicleColors = [
    {"label": "White", "value": "white"},
    {"label": "Black", "value": "black"},
    {"label": "Silver", "value": "silver"},
    {"label": "Red", "value": "red"},
    {"label": "Blue", "value": "blue"},
    {"label": "Gray", "value": "gray"},
    {"label": "Green", "value": "green"},
    {"label": "Yellow", "value": "yellow"},
    {"label": "Other", "value": "other"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Setup"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Step 2 of 2",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Vehicle Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Vehicle Details Section
              Text(
                "Vehicle Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QDropdownField(
                label: "Vehicle Type",
                items: vehicleTypes,
                value: vehicleType,
                validator: Validator.required,
                onChanged: (value, label) {
                  vehicleType = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Make",
                      value: vehicleMake,
                      hint: "Toyota, Honda, etc.",
                      validator: Validator.required,
                      onChanged: (value) {
                        vehicleMake = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Model",
                      value: vehicleModel,
                      hint: "Civic, Camry, etc.",
                      validator: Validator.required,
                      onChanged: (value) {
                        vehicleModel = value;
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
                      label: "Year",
                      value: vehicleYear,
                      hint: "2020",
                      validator: Validator.required,
                      onChanged: (value) {
                        vehicleYear = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Color",
                      items: vehicleColors,
                      value: vehicleColor,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        vehicleColor = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "License Plate Number",
                value: licensePlate,
                hint: "ABC-1234",
                validator: Validator.required,
                onChanged: (value) {
                  licensePlate = value;
                  setState(() {});
                },
              ),
              
              // Vehicle Images
              Text(
                "Vehicle Photos",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QMultiImagePicker(
                label: "Vehicle Images",
                value: vehicleImages,
                maxImages: 5,
                hint: "Add clear photos of your vehicle",
                validator: (images) {
                  if (images == null || images.isEmpty) {
                    return "At least one vehicle photo is required";
                  }
                  return null;
                },
                onChanged: (value) {
                  vehicleImages = value;
                  setState(() {});
                },
              ),
              
              // Required Documents Section
              Text(
                "Required Documents",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QImagePicker(
                label: "Driver's License",
                value: driverLicense,
                hint: "Upload your driver's license",
                validator: Validator.required,
                onChanged: (value) {
                  driverLicense = value;
                  setState(() {});
                },
              ),
              
              QImagePicker(
                label: "Vehicle Registration",
                value: vehicleRegistration,
                hint: "Upload vehicle registration document",
                validator: Validator.required,
                onChanged: (value) {
                  vehicleRegistration = value;
                  setState(() {});
                },
              ),
              
              QImagePicker(
                label: "Insurance Certificate",
                value: insurance,
                hint: "Upload current insurance certificate",
                validator: Validator.required,
                onChanged: (value) {
                  insurance = value;
                  setState(() {});
                },
              ),
              
              // Document Requirements
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.document_scanner,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Document Requirements",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "• All documents must be current and valid\n• Photos should be clear and readable\n• Documents must match the vehicle information provided\n• Processing may take 24-48 hours for verification",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit for Verification",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Handle vehicle setup submission
                      ss("Vehicle information submitted for verification!");
                      // Navigate to home or dashboard
                    }
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Save as Draft
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Save as draft
                    ss("Vehicle information saved as draft");
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: spMd),
                    side: BorderSide(color: primaryColor),
                  ),
                  child: Text(
                    "Save as Draft",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Help Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "If you need assistance with document upload or have questions about vehicle requirements, contact our support team.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Contact support
                            },
                            icon: Icon(Icons.support_agent, size: 16),
                            label: Text("Contact Support"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: infoColor,
                              side: BorderSide(color: infoColor),
                              padding: EdgeInsets.symmetric(vertical: spSm),
                            ),
                          ),
                        ),
                      ],
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
