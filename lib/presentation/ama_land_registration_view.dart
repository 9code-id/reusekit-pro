import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaLandRegistrationView extends StatefulWidget {
  const AmaLandRegistrationView({super.key});

  @override
  State<AmaLandRegistrationView> createState() => _AmaLandRegistrationViewState();
}

class _AmaLandRegistrationViewState extends State<AmaLandRegistrationView> {
  final formKey = GlobalKey<FormState>();
  
  String parcelName = "";
  String address = "";
  String area = "";
  String landType = "Agricultural";
  String soilType = "Loamy";
  String waterSource = "Rainfall";
  String ownershipType = "Owned";
  String coordinates = "";
  bool isIrrigated = false;
  String description = "";

  List<Map<String, dynamic>> landTypeItems = [
    {"label": "Agricultural Land", "value": "Agricultural"},
    {"label": "Pasture Land", "value": "Pasture"},
    {"label": "Orchard", "value": "Orchard"},
    {"label": "Greenhouse", "value": "Greenhouse"},
    {"label": "Mixed Use", "value": "Mixed"},
  ];

  List<Map<String, dynamic>> soilTypeItems = [
    {"label": "Loamy Soil", "value": "Loamy"},
    {"label": "Clay Soil", "value": "Clay"},
    {"label": "Sandy Soil", "value": "Sandy"},
    {"label": "Silty Soil", "value": "Silty"},
    {"label": "Peaty Soil", "value": "Peaty"},
    {"label": "Chalky Soil", "value": "Chalky"},
  ];

  List<Map<String, dynamic>> waterSourceItems = [
    {"label": "Rainfall", "value": "Rainfall"},
    {"label": "Well Water", "value": "Well"},
    {"label": "River/Stream", "value": "River"},
    {"label": "Irrigation System", "value": "Irrigation"},
    {"label": "Borehole", "value": "Borehole"},
    {"label": "Municipal Water", "value": "Municipal"},
  ];

  List<Map<String, dynamic>> ownershipItems = [
    {"label": "Owned", "value": "Owned"},
    {"label": "Leased", "value": "Leased"},
    {"label": "Rented", "value": "Rented"},
    {"label": "Sharecropping", "value": "Sharecropping"},
  ];

  List<Map<String, dynamic>> registeredParcels = [
    {
      "name": "Main Field A",
      "area": "15.5",
      "type": "Agricultural",
      "status": "Active"
    },
    {
      "name": "South Pasture",
      "area": "8.2",
      "type": "Pasture",
      "status": "Active"
    },
    {
      "name": "Apple Orchard",
      "area": "3.7",
      "type": "Orchard",
      "status": "Active"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Land Registration"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              si("Open map view for location selection");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.landscape,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register Land Parcels",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Add your land parcels to enable precise farm management and monitoring",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (registeredParcels.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Registered Parcels (${registeredParcels.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "View All",
                    size: bs.sm,
                    onPressed: () {
                      si("Navigate to parcels list view");
                    },
                  ),
                ],
              ),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: List.generate(registeredParcels.length.clamp(0, 3), (index) {
                    final parcel = registeredParcels[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: index > 0 ? Border(
                          top: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ) : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.agriculture,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${parcel["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${parcel["area"]} hectares • ${parcel["type"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${parcel["status"]}",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
            
            Text(
              "Add New Land Parcel",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Parcel Name",
                    value: parcelName,
                    validator: Validator.required,
                    hint: "e.g., North Field, Main Pasture",
                    onChanged: (value) {
                      parcelName = value;
                      setState(() {});
                    },
                  ),
                  
                  QTextField(
                    label: "Address/Location",
                    value: address,
                    validator: Validator.required,
                    hint: "Street address or description",
                    onChanged: (value) {
                      address = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Area (Hectares)",
                          value: area,
                          validator: Validator.required,
                          onChanged: (value) {
                            area = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Land Type",
                          items: landTypeItems,
                          value: landType,
                          onChanged: (value, label) {
                            landType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Soil Type",
                          items: soilTypeItems,
                          value: soilType,
                          onChanged: (value, label) {
                            soilType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Water Source",
                          items: waterSourceItems,
                          value: waterSource,
                          onChanged: (value, label) {
                            waterSource = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Ownership Type",
                    items: ownershipItems,
                    value: ownershipType,
                    onChanged: (value, label) {
                      ownershipType = value;
                      setState(() {});
                    },
                  ),
                  
                  QTextField(
                    label: "GPS Coordinates (Optional)",
                    value: coordinates,
                    hint: "Latitude, Longitude",
                    onChanged: (value) {
                      coordinates = value;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Irrigation System",
                    items: [
                      {
                        "label": "This land has irrigation infrastructure",
                        "value": true,
                        "checked": isIrrigated,
                      }
                    ],
                    value: [
                      if (isIrrigated)
                        {
                          "label": "This land has irrigation infrastructure",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      isIrrigated = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QMemoField(
                    label: "Additional Notes",
                    value: description,
                    hint: "Any additional information about this land parcel",
                    onChanged: (value) {
                      description = value;
                      setState(() {});
                    },
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Accurate land registration helps with crop planning, yield estimation, and compliance with agricultural regulations.",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  QButton(
                    label: "Register Land Parcel",
                    size: bs.md,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showLoading();
                        Future.delayed(Duration(seconds: 2), () {
                          hideLoading();
                          ss("Land parcel registered successfully!");
                          // Clear form
                          parcelName = "";
                          address = "";
                          area = "";
                          coordinates = "";
                          description = "";
                          setState(() {});
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
