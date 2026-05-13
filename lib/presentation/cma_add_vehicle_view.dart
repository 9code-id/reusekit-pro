import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAddVehicleView extends StatefulWidget {
  const CmaAddVehicleView({super.key});

  @override
  State<CmaAddVehicleView> createState() => _CmaAddVehicleViewState();
}

class _CmaAddVehicleViewState extends State<CmaAddVehicleView> {
  final formKey = GlobalKey<FormState>();
  
  String vehicleName = "";
  String licensePlate = "";
  String vehicleType = "";
  String year = "";
  String color = "";
  String fuelType = "";
  String engineCapacity = "";
  String transmission = "";
  String purchaseDate = "";
  String purchasePrice = "";
  String mileage = "";
  String vinNumber = "";
  String insuranceExpiry = "";
  String registrationExpiry = "";
  List<String> vehicleImages = [];
  
  List<Map<String, dynamic>> vehicleTypeOptions = [
    {"label": "Sedan", "value": "Sedan"},
    {"label": "SUV", "value": "SUV"},
    {"label": "Hatchback", "value": "Hatchback"},
    {"label": "Truck", "value": "Truck"},
    {"label": "Van", "value": "Van"},
    {"label": "Coupe", "value": "Coupe"},
    {"label": "Convertible", "value": "Convertible"}
  ];

  List<Map<String, dynamic>> fuelTypeOptions = [
    {"label": "Gasoline", "value": "Gasoline"},
    {"label": "Diesel", "value": "Diesel"},
    {"label": "Hybrid", "value": "Hybrid"},
    {"label": "Electric", "value": "Electric"},
    {"label": "CNG", "value": "CNG"},
    {"label": "LPG", "value": "LPG"}
  ];

  List<Map<String, dynamic>> transmissionOptions = [
    {"label": "Manual", "value": "Manual"},
    {"label": "Automatic", "value": "Automatic"},
    {"label": "CVT", "value": "CVT"},
    {"label": "Semi-Automatic", "value": "Semi-Automatic"}
  ];

  List<Map<String, dynamic>> colorOptions = [
    {"label": "White", "value": "White"},
    {"label": "Black", "value": "Black"},
    {"label": "Silver", "value": "Silver"},
    {"label": "Gray", "value": "Gray"},
    {"label": "Red", "value": "Red"},
    {"label": "Blue", "value": "Blue"},
    {"label": "Green", "value": "Green"},
    {"label": "Yellow", "value": "Yellow"},
    {"label": "Orange", "value": "Orange"},
    {"label": "Brown", "value": "Brown"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Vehicle"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _saveVehicle();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Images
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vehicle Images",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMultiImagePicker(
                      label: "Upload Vehicle Photos",
                      value: vehicleImages,
                      maxImages: 10,
                      hint: "Add multiple photos of the vehicle",
                      helper: "You can upload up to 10 high-quality images",
                      onChanged: (value) {
                        vehicleImages = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Basic Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
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
                    QTextField(
                      label: "Vehicle Name",
                      value: vehicleName,
                      hint: "e.g., Honda Civic 2024",
                      validator: Validator.required,
                      onChanged: (value) {
                        vehicleName = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "License Plate",
                            value: licensePlate,
                            hint: "e.g., ABC-1234",
                            validator: Validator.required,
                            onChanged: (value) {
                              licensePlate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Vehicle Type",
                            items: vehicleTypeOptions,
                            value: vehicleType,
                            onChanged: (value, label) {
                              vehicleType = value;
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
                          child: QNumberField(
                            label: "Year",
                            value: year,
                            hint: "e.g., 2024",
                            validator: Validator.required,
                            onChanged: (value) {
                              year = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Color",
                            items: colorOptions,
                            value: color,
                            onChanged: (value, label) {
                              color = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QNumberField(
                      label: "Current Mileage",
                      value: mileage,
                      hint: "Current mileage in miles",
                      validator: Validator.required,
                      onChanged: (value) {
                        mileage = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Technical Specifications
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Technical Specifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Fuel Type",
                            items: fuelTypeOptions,
                            value: fuelType,
                            onChanged: (value, label) {
                              fuelType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Engine Capacity",
                            value: engineCapacity,
                            hint: "e.g., 2.0L",
                            onChanged: (value) {
                              engineCapacity = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Transmission",
                      items: transmissionOptions,
                      value: transmission,
                      onChanged: (value, label) {
                        transmission = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "VIN Number",
                      value: vinNumber,
                      hint: "Vehicle Identification Number",
                      validator: Validator.required,
                      onChanged: (value) {
                        vinNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Purchase Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Purchase Date",
                            value: purchaseDate.isNotEmpty ? DateTime.parse(purchaseDate) : DateTime.now(),
                            onChanged: (value) {
                              purchaseDate = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Purchase Price (\$)",
                            value: purchasePrice,
                            hint: "Purchase price in USD",
                            validator: Validator.required,
                            onChanged: (value) {
                              purchasePrice = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Legal Documents
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Legal Documents & Expiry Dates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Insurance Expiry",
                            value: insuranceExpiry.isNotEmpty ? DateTime.parse(insuranceExpiry) : DateTime.now().add(Duration(days: 365)),
                            onChanged: (value) {
                              insuranceExpiry = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDatePicker(
                            label: "Registration Expiry",
                            value: registrationExpiry.isNotEmpty ? DateTime.parse(registrationExpiry) : DateTime.now().add(Duration(days: 365)),
                            onChanged: (value) {
                              registrationExpiry = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Draft",
                      onPressed: () {
                        _saveDraft();
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Add Vehicle",
                      onPressed: () {
                        _saveVehicle();
                      },
                    ),
                  ),
                ],
              ),

              // Additional Information Note
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "After adding the vehicle, you can upload additional documents like registration papers, insurance policies, and maintenance records from the vehicle details page.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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

  void _saveVehicle() {
    if (formKey.currentState!.validate()) {
      if (vehicleName.isEmpty) {
        se("Please enter vehicle name");
        return;
      }
      if (licensePlate.isEmpty) {
        se("Please enter license plate");
        return;
      }
      if (vinNumber.isEmpty) {
        se("Please enter VIN number");
        return;
      }
      
      // Simulate saving vehicle
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Vehicle ${vehicleName} has been successfully added to the fleet");
        back();
      });
    }
  }

  void _saveDraft() {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Vehicle information saved as draft");
    });
  }
}
