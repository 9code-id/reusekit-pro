import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaEditVehicleView extends StatefulWidget {
  const CmaEditVehicleView({super.key});

  @override
  State<CmaEditVehicleView> createState() => _CmaEditVehicleViewState();
}

class _CmaEditVehicleViewState extends State<CmaEditVehicleView> {
  final formKey = GlobalKey<FormState>();
  
  // Sample vehicle data - in real app this would come from arguments
  String vehicleName = "Honda Civic 2024";
  String licensePlate = "ABC-1234";
  String vehicleType = "Sedan";
  String year = "2024";
  String color = "Silver";
  String fuelType = "Gasoline";
  String engineCapacity = "2.0L";
  String transmission = "Automatic";
  String purchaseDate = "2024-01-15";
  String purchasePrice = "25000";
  String mileage = "15000";
  String vinNumber = "1HGBH41JXMN109186";
  String insuranceExpiry = "2025-12-31";
  String registrationExpiry = "2025-11-30";
  String status = "Active";
  List<String> vehicleImages = [
    "https://picsum.photos/400/300?random=1&keyword=car",
    "https://picsum.photos/400/300?random=2&keyword=car"
  ];
  
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

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "Active"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Out of Service", "value": "Out of Service"},
    {"label": "Retired", "value": "Retired"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Vehicle"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _updateVehicle();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showVehicleActions();
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
              // Vehicle Status Alert
              if (status != "Active")
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: status == "Maintenance" 
                        ? warningColor.withAlpha(10) 
                        : dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: status == "Maintenance" 
                          ? warningColor.withAlpha(50) 
                          : dangerColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        status == "Maintenance" ? Icons.build : Icons.warning,
                        color: status == "Maintenance" ? warningColor : dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Vehicle Status: $status",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: status == "Maintenance" ? warningColor : dangerColor,
                              ),
                            ),
                            Text(
                              status == "Maintenance" 
                                  ? "This vehicle is currently under maintenance."
                                  : "This vehicle is out of service.",
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
                      label: "Update Vehicle Photos",
                      value: vehicleImages,
                      maxImages: 10,
                      hint: "Add or update vehicle photos",
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
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Current Mileage",
                            value: mileage,
                            hint: "Current mileage in miles",
                            validator: Validator.required,
                            onChanged: (value) {
                              mileage = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Status",
                            items: statusOptions,
                            value: status,
                            onChanged: (value, label) {
                              status = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
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
                            value: DateTime.parse(purchaseDate),
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
                            value: DateTime.parse(insuranceExpiry),
                            onChanged: (value) {
                              insuranceExpiry = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDatePicker(
                            label: "Registration Expiry",
                            value: DateTime.parse(registrationExpiry),
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
                      label: "Save Changes",
                      onPressed: () {
                        _updateVehicle();
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      onPressed: () {
                        back();
                      },
                    ),
                  ),
                ],
              ),

              // Danger Zone
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: dangerColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Danger Zone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "These actions cannot be undone. Please proceed with caution.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Archive Vehicle",
                            onPressed: () async {
                              bool isConfirmed = await confirm("Are you sure you want to archive this vehicle? It will be moved to archived vehicles list.");
                              if (isConfirmed) {
                                ss("Vehicle has been archived");
                                back();
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Delete Vehicle",
                            onPressed: () async {
                              bool isConfirmed = await confirm("Are you sure you want to permanently delete this vehicle? This action cannot be undone.");
                              if (isConfirmed) {
                                ss("Vehicle has been deleted");
                                back();
                              }
                            },
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

  void _updateVehicle() {
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
      
      // Simulate updating vehicle
      showLoading();
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Vehicle information has been successfully updated");
        back();
      });
    }
  }

  void _showVehicleActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Vehicle Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Details",
                  onPressed: () {
                    back();
                    // navigateTo('CmaVehicleDetailsView')
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Schedule Maintenance",
                  onPressed: () {
                    back();
                    ss("Maintenance scheduled");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Documents",
                  onPressed: () {
                    back();
                    // navigateTo('CmaVehicleDocumentsView')
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Duplicate Vehicle",
                  onPressed: () {
                    back();
                    ss("Vehicle information copied for new entry");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
