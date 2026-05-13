import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaWarehouseView extends StatefulWidget {
  const DlaWarehouseView({super.key});

  @override
  State<DlaWarehouseView> createState() => _DlaWarehouseViewState();
}

class _DlaWarehouseViewState extends State<DlaWarehouseView> {
  final formKey = GlobalKey<FormState>();
  String warehouseName = "";
  String warehouseCode = "";
  String address = "";
  String city = "";
  String state = "";
  String postalCode = "";
  String country = "Indonesia";
  String contactPerson = "";
  String phoneNumber = "";
  String email = "";
  String warehouseType = "distribution";
  String status = "active";
  double totalArea = 0.0;
  double storageCapacity = 0.0;
  int loadingDocks = 0;
  String operatingHours = "";
  String securityLevel = "medium";
  bool hasClimateControl = false;
  bool hasSecurityCamera = true;
  bool hasFireSafety = true;
  List<String> warehouseImages = [];
  String notes = "";

  List<Map<String, dynamic>> warehouseTypes = [
    {"label": "Distribution Center", "value": "distribution"},
    {"label": "Storage Facility", "value": "storage"},
    {"label": "Cross-Dock Terminal", "value": "cross_dock"},
    {"label": "Cold Storage", "value": "cold_storage"},
    {"label": "Fulfillment Center", "value": "fulfillment"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Under Maintenance", "value": "maintenance"},
    {"label": "Temporarily Closed", "value": "temp_closed"},
  ];

  List<Map<String, dynamic>> securityLevels = [
    {"label": "Basic", "value": "basic"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Maximum", "value": "maximum"},
  ];

  List<Map<String, dynamic>> operatingHourOptions = [
    {"label": "24/7 Operations", "value": "24_7"},
    {"label": "Regular Hours (8AM-6PM)", "value": "regular"},
    {"label": "Extended Hours (6AM-10PM)", "value": "extended"},
    {"label": "Custom Schedule", "value": "custom"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledColor;
      case "maintenance":
        return warningColor;
      case "temp_closed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildInfoCard(String title, String value, IconData icon, {Color? color}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (color ?? primaryColor).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color ?? primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, bool isEnabled, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (isEnabled ? successColor : disabledColor).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              isEnabled ? Icons.check_circle : Icons.cancel,
              color: isEnabled ? successColor : disabledColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: successColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warehouse Management"),
        actions: [
          QButton(
            icon: Icons.list,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Warehouse Information",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Add or manage warehouse facility details",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      "Warehouse Status",
                      status.replaceAll('_', ' ').toUpperCase(),
                      Icons.info,
                      color: _getStatusColor(status),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildInfoCard(
                      "Storage Capacity",
                      "${storageCapacity.toStringAsFixed(0)} m³",
                      Icons.inventory,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Warehouse Name",
                            value: warehouseName,
                            hint: "Enter warehouse name",
                            validator: Validator.required,
                            onChanged: (value) {
                              warehouseName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Warehouse Code",
                            value: warehouseCode,
                            hint: "e.g., WH001",
                            validator: Validator.required,
                            onChanged: (value) {
                              warehouseCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Warehouse Type",
                            items: warehouseTypes,
                            value: warehouseType,
                            onChanged: (value, label) {
                              warehouseType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
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
              
              SizedBox(height: spLg),
              
              Text(
                "Address Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    QMemoField(
                      label: "Street Address",
                      value: address,
                      hint: "Enter complete street address",
                      validator: Validator.required,
                      onChanged: (value) {
                        address = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
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
                            label: "State/Province",
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
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Postal Code",
                            value: postalCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              postalCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Country",
                            value: country,
                            validator: Validator.required,
                            onChanged: (value) {
                              country = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    QTextField(
                      label: "Contact Person",
                      value: contactPerson,
                      hint: "Warehouse manager name",
                      validator: Validator.required,
                      onChanged: (value) {
                        contactPerson = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: phoneNumber,
                            hint: "+62 xxx xxx xxxx",
                            validator: Validator.required,
                            onChanged: (value) {
                              phoneNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: email,
                            hint: "warehouse@company.com",
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
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Facility Specifications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Total Area (m²)",
                            value: totalArea.toString(),
                            onChanged: (value) {
                              totalArea = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Storage Capacity (m³)",
                            value: storageCapacity.toString(),
                            onChanged: (value) {
                              storageCapacity = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Loading Docks",
                            value: loadingDocks.toString(),
                            onChanged: (value) {
                              loadingDocks = int.tryParse(value) ?? 0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Security Level",
                            items: securityLevels,
                            value: securityLevel,
                            onChanged: (value, label) {
                              securityLevel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    QDropdownField(
                      label: "Operating Hours",
                      items: operatingHourOptions,
                      value: operatingHours.isNotEmpty ? operatingHours : "regular",
                      onChanged: (value, label) {
                        operatingHours = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Features & Amenities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              _buildFeatureCard("Climate Control System", hasClimateControl, (value) {
                hasClimateControl = value;
                setState(() {});
              }),
              
              SizedBox(height: spSm),
              
              _buildFeatureCard("Security Camera System", hasSecurityCamera, (value) {
                hasSecurityCamera = value;
                setState(() {});
              }),
              
              SizedBox(height: spSm),
              
              _buildFeatureCard("Fire Safety System", hasFireSafety, (value) {
                hasFireSafety = value;
                setState(() {});
              }),
              
              SizedBox(height: spLg),
              
              Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    QMultiImagePicker(
                      label: "Warehouse Images",
                      value: warehouseImages,
                      maxImages: 10,
                      hint: "Add photos of the warehouse facility",
                      onChanged: (value) {
                        warehouseImages = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spSm),
                    
                    QMemoField(
                      label: "Additional Notes",
                      value: notes,
                      hint: "Any additional information about the warehouse...",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Warehouse",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Warehouse information saved successfully!");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.location_on,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
