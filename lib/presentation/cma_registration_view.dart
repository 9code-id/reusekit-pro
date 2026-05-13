import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRegistrationView extends StatefulWidget {
  const CmaRegistrationView({super.key});

  @override
  State<CmaRegistrationView> createState() => _CmaRegistrationViewState();
}

class _CmaRegistrationViewState extends State<CmaRegistrationView> {
  final formKey = GlobalKey<FormState>();
  String vehicleMake = "";
  String vehicleModel = "";
  String vehicleYear = "";
  String licensePlate = "";
  String vin = "";
  String engineType = "";
  String transmissionType = "";
  String fuelType = "";
  String ownerName = "";
  String ownerPhone = "";
  String ownerEmail = "";
  String registrationDate = "";
  String purchaseDate = "";
  String insuranceProvider = "";
  String policyNumber = "";
  String profileImage = "";

  List<Map<String, dynamic>> vehicleYears = List.generate(30, (index) {
    int year = DateTime.now().year - index;
    return {
      "label": year.toString(),
      "value": year.toString(),
    };
  });

  List<Map<String, dynamic>> engineTypes = [
    {"label": "Gasoline", "value": "gasoline"},
    {"label": "Diesel", "value": "diesel"},
    {"label": "Hybrid", "value": "hybrid"},
    {"label": "Electric", "value": "electric"},
    {"label": "Turbo", "value": "turbo"},
  ];

  List<Map<String, dynamic>> transmissionTypes = [
    {"label": "Manual", "value": "manual"},
    {"label": "Automatic", "value": "automatic"},
    {"label": "CVT", "value": "cvt"},
    {"label": "Semi-Automatic", "value": "semi_automatic"},
  ];

  List<Map<String, dynamic>> fuelTypes = [
    {"label": "Regular Gasoline", "value": "regular"},
    {"label": "Premium Gasoline", "value": "premium"},
    {"label": "Diesel", "value": "diesel"},
    {"label": "Electric", "value": "electric"},
    {"label": "Hybrid", "value": "hybrid"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Registration"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _saveVehicleRegistration();
              }
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
              Text(
                "Vehicle Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QImagePicker(
                      label: "Vehicle Photo",
                      value: profileImage,
                      hint: "Upload a photo of your vehicle",
                      onChanged: (value) {
                        profileImage = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Make",
                            value: vehicleMake,
                            hint: "Toyota, Honda, Ford...",
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
                            hint: "Camry, Civic, Focus...",
                            validator: Validator.required,
                            onChanged: (value) {
                              vehicleModel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QDropdownField(
                      label: "Year",
                      items: vehicleYears,
                      value: vehicleYear,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        vehicleYear = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "License Plate",
                      value: licensePlate,
                      hint: "ABC-1234",
                      validator: Validator.required,
                      onChanged: (value) {
                        licensePlate = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "VIN Number",
                      value: vin,
                      hint: "Vehicle Identification Number",
                      validator: Validator.required,
                      onChanged: (value) {
                        vin = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Text(
                "Engine & Transmission",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QDropdownField(
                      label: "Engine Type",
                      items: engineTypes,
                      value: engineType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        engineType = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Transmission",
                      items: transmissionTypes,
                      value: transmissionType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        transmissionType = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Fuel Type",
                      items: fuelTypes,
                      value: fuelType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        fuelType = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Text(
                "Owner Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Owner Name",
                      value: ownerName,
                      hint: "Full name of vehicle owner",
                      validator: Validator.required,
                      onChanged: (value) {
                        ownerName = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: ownerPhone,
                            hint: "+1 234 567 8900",
                            validator: Validator.required,
                            onChanged: (value) {
                              ownerPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Email",
                            value: ownerEmail,
                            hint: "owner@email.com",
                            validator: Validator.email,
                            onChanged: (value) {
                              ownerEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Text(
                "Registration & Insurance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Registration Date",
                            value: registrationDate.isNotEmpty 
                                ? DateTime.parse(registrationDate) 
                                : DateTime.now(),
                            onChanged: (value) {
                              registrationDate = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Purchase Date",
                            value: purchaseDate.isNotEmpty 
                                ? DateTime.parse(purchaseDate) 
                                : DateTime.now(),
                            onChanged: (value) {
                              purchaseDate = value.toString();
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
                            label: "Insurance Provider",
                            value: insuranceProvider,
                            hint: "State Farm, Geico, Allstate...",
                            onChanged: (value) {
                              insuranceProvider = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Policy Number",
                            value: policyNumber,
                            hint: "Insurance policy number",
                            onChanged: (value) {
                              policyNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Register Vehicle",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _saveVehicleRegistration();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveVehicleRegistration() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Vehicle registered successfully!");
    
    // navigateTo(VehicleDashboardView());
  }
}
