import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaVehicleRegistrationView extends StatefulWidget {
  const LtaVehicleRegistrationView({super.key});

  @override
  State<LtaVehicleRegistrationView> createState() => _LtaVehicleRegistrationViewState();
}

class _LtaVehicleRegistrationViewState extends State<LtaVehicleRegistrationView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Vehicle Basic Information
  String vehicleMake = "";
  String vehicleModel = "";
  String vehicleYear = "";
  String vehicleColor = "";
  String licensePlate = "";
  String vinNumber = "";
  
  // Vehicle Specifications
  String vehicleType = "";
  String fuelType = "";
  String transmission = "";
  String engineSize = "";
  String loadCapacity = "";
  String vehicleLength = "";
  String vehicleWidth = "";
  String vehicleHeight = "";
  
  // Insurance & Documents
  String insuranceProvider = "";
  String policyNumber = "";
  String insuranceExpiry = "";
  String registrationExpiry = "";
  
  // Vehicle Photos & Documents
  String frontPhoto = "";
  String backPhoto = "";
  String sidePhoto = "";
  String interiorPhoto = "";
  List<String> documents = [];

  List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Pickup Truck", "value": "pickup"},
    {"label": "Van", "value": "van"},
    {"label": "Box Truck", "value": "box_truck"},
    {"label": "Semi Truck", "value": "semi"},
    {"label": "Flatbed", "value": "flatbed"},
    {"label": "Refrigerated Truck", "value": "refrigerated"},
  ];

  List<Map<String, dynamic>> fuelTypes = [
    {"label": "Gasoline", "value": "gasoline"},
    {"label": "Diesel", "value": "diesel"},
    {"label": "Electric", "value": "electric"},
    {"label": "Hybrid", "value": "hybrid"},
  ];

  List<Map<String, dynamic>> transmissionTypes = [
    {"label": "Manual", "value": "manual"},
    {"label": "Automatic", "value": "automatic"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, warningColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 50,
                    color: Colors.white,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Register Your Vehicle",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "Add your delivery vehicle to the fleet",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Progress Indicator
                  Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          height: 4,
                          decoration: BoxDecoration(
                            color: index <= currentStep 
                                ? Colors.white 
                                : Colors.white.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      );
                    }),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Step ${currentStep + 1} of 4",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Form Content
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Form(
                key: formKey,
                child: _buildCurrentStep(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                ],
                Expanded(
                  flex: currentStep > 0 ? 1 : 2,
                  child: QButton(
                    label: currentStep == 3 ? "Register Vehicle" : "Next",
                    size: bs.md,
                    icon: currentStep == 3 ? Icons.check : Icons.arrow_forward,
                    onPressed: () {
                      if (currentStep == 3) {
                        // Register vehicle
                        if (formKey.currentState!.validate()) {
                          showLoading();
                          Future.delayed(Duration(seconds: 2), () {
                            hideLoading();
                            ss("Vehicle registered successfully!");
                            back();
                          });
                        }
                      } else {
                        if (formKey.currentState!.validate()) {
                          currentStep++;
                          setState(() {});
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildBasicInformation();
      case 1:
        return _buildSpecifications();
      case 2:
        return _buildInsuranceDocuments();
      case 3:
        return _buildPhotosDocuments();
      default:
        return Container();
    }
  }

  Widget _buildBasicInformation() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Basic Vehicle Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Make",
                value: vehicleMake,
                hint: "e.g., Ford, Toyota",
                validator: Validator.required,
                onChanged: (value) {
                  vehicleMake = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Model",
                value: vehicleModel,
                hint: "e.g., F-150, Hiace",
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
              child: QNumberField(
                label: "Year",
                value: vehicleYear,
                validator: Validator.required,
                onChanged: (value) {
                  vehicleYear = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Color",
                value: vehicleColor,
                hint: "e.g., White, Blue",
                validator: Validator.required,
                onChanged: (value) {
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
          hint: "Enter license plate number",
          validator: Validator.required,
          onChanged: (value) {
            licensePlate = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "VIN Number",
          value: vinNumber,
          hint: "17-character Vehicle Identification Number",
          validator: Validator.required,
          onChanged: (value) {
            vinNumber = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Text(
                  "Make sure all information matches your vehicle registration documents exactly.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecifications() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Vehicle Specifications",
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
          onChanged: (value, label) {
            vehicleType = value;
            setState(() {});
          },
        ),
        
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Fuel Type",
                items: fuelTypes,
                value: fuelType,
                onChanged: (value, label) {
                  fuelType = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QDropdownField(
                label: "Transmission",
                items: transmissionTypes,
                value: transmission,
                onChanged: (value, label) {
                  transmission = value;
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
                label: "Engine Size (L)",
                value: engineSize,
                hint: "e.g., 2.5, 3.0",
                onChanged: (value) {
                  engineSize = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Load Capacity (kg)",
                value: loadCapacity,
                hint: "Maximum load weight",
                validator: Validator.required,
                onChanged: (value) {
                  loadCapacity = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Text(
          "Vehicle Dimensions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Length (m)",
                value: vehicleLength,
                hint: "e.g., 4.5",
                onChanged: (value) {
                  vehicleLength = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Width (m)",
                value: vehicleWidth,
                hint: "e.g., 2.0",
                onChanged: (value) {
                  vehicleWidth = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Height (m)",
                value: vehicleHeight,
                hint: "e.g., 2.5",
                onChanged: (value) {
                  vehicleHeight = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsuranceDocuments() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Insurance & Registration",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QTextField(
          label: "Insurance Provider",
          value: insuranceProvider,
          hint: "Name of insurance company",
          validator: Validator.required,
          onChanged: (value) {
            insuranceProvider = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Policy Number",
          value: policyNumber,
          hint: "Insurance policy number",
          validator: Validator.required,
          onChanged: (value) {
            policyNumber = value;
            setState(() {});
          },
        ),
        
        QDatePicker(
          label: "Insurance Expiry Date",
          value: insuranceExpiry.isNotEmpty ? DateTime.parse(insuranceExpiry) : DateTime.now(),
          onChanged: (value) {
            insuranceExpiry = value.toString();
            setState(() {});
          },
        ),
        
        QDatePicker(
          label: "Registration Expiry Date",
          value: registrationExpiry.isNotEmpty ? DateTime.parse(registrationExpiry) : DateTime.now(),
          onChanged: (value) {
            registrationExpiry = value.toString();
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Insurance Requirements",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Your vehicle must have comprehensive insurance coverage including commercial use and liability protection.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosDocuments() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Vehicle Photos & Documents",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Vehicle Photos",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          children: [
            Expanded(
              child: QImagePicker(
                label: "Front Photo",
                value: frontPhoto,
                hint: "Front view of vehicle",
                validator: Validator.required,
                onChanged: (value) {
                  frontPhoto = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QImagePicker(
                label: "Back Photo",
                value: backPhoto,
                hint: "Rear view of vehicle",
                validator: Validator.required,
                onChanged: (value) {
                  backPhoto = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Row(
          children: [
            Expanded(
              child: QImagePicker(
                label: "Side Photo",
                value: sidePhoto,
                hint: "Side view of vehicle",
                validator: Validator.required,
                onChanged: (value) {
                  sidePhoto = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QImagePicker(
                label: "Interior Photo",
                value: interiorPhoto,
                hint: "Interior/cargo area",
                onChanged: (value) {
                  interiorPhoto = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        QAttachmentPicker(
          label: "Required Documents",
          value: documents,
          hint: "Upload registration, insurance certificates",
          validator: (files) {
            if (files == null || files.isEmpty) {
              return "Please upload required documents";
            }
            return null;
          },
          onChanged: (value) {
            documents = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verification Process",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Your vehicle will be reviewed and verified within 24-48 hours. You'll receive confirmation via email once approved.",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
