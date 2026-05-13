import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAddLocationView extends StatefulWidget {
  const WcaAddLocationView({super.key});

  @override
  State<WcaAddLocationView> createState() => _WcaAddLocationViewState();
}

class _WcaAddLocationViewState extends State<WcaAddLocationView> {
  final formKey = GlobalKey<FormState>();
  
  String locationName = "";
  String country = "";
  String state = "";
  String city = "";
  String latitude = "";
  String longitude = "";
  String timezone = "";
  String description = "";
  bool isDefault = false;
  bool enableAlerts = true;
  String alertRadius = "10";
  
  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "US"},
    {"label": "Canada", "value": "CA"},
    {"label": "United Kingdom", "value": "GB"},
    {"label": "Australia", "value": "AU"},
    {"label": "Germany", "value": "DE"},
    {"label": "France", "value": "FR"},
    {"label": "Japan", "value": "JP"},
    {"label": "Brazil", "value": "BR"},
    {"label": "India", "value": "IN"},
    {"label": "China", "value": "CN"},
  ];

  List<Map<String, dynamic>> timezones = [
    {"label": "UTC-12:00", "value": "UTC-12"},
    {"label": "UTC-11:00", "value": "UTC-11"},
    {"label": "UTC-10:00", "value": "UTC-10"},
    {"label": "UTC-09:00", "value": "UTC-9"},
    {"label": "UTC-08:00", "value": "UTC-8"},
    {"label": "UTC-07:00", "value": "UTC-7"},
    {"label": "UTC-06:00", "value": "UTC-6"},
    {"label": "UTC-05:00", "value": "UTC-5"},
    {"label": "UTC-04:00", "value": "UTC-4"},
    {"label": "UTC-03:00", "value": "UTC-3"},
    {"label": "UTC-02:00", "value": "UTC-2"},
    {"label": "UTC-01:00", "value": "UTC-1"},
    {"label": "UTC+00:00", "value": "UTC+0"},
    {"label": "UTC+01:00", "value": "UTC+1"},
    {"label": "UTC+02:00", "value": "UTC+2"},
    {"label": "UTC+03:00", "value": "UTC+3"},
    {"label": "UTC+04:00", "value": "UTC+4"},
    {"label": "UTC+05:00", "value": "UTC+5"},
    {"label": "UTC+06:00", "value": "UTC+6"},
    {"label": "UTC+07:00", "value": "UTC+7"},
    {"label": "UTC+08:00", "value": "UTC+8"},
    {"label": "UTC+09:00", "value": "UTC+9"},
    {"label": "UTC+10:00", "value": "UTC+10"},
    {"label": "UTC+11:00", "value": "UTC+11"},
    {"label": "UTC+12:00", "value": "UTC+12"},
  ];

  List<Map<String, dynamic>> alertRadiusOptions = [
    {"label": "5 km", "value": "5"},
    {"label": "10 km", "value": "10"},
    {"label": "25 km", "value": "25"},
    {"label": "50 km", "value": "50"},
    {"label": "100 km", "value": "100"},
  ];

  void _getCurrentLocation() {
    // Simulate getting current location
    latitude = "40.7128";
    longitude = "-74.0060";
    city = "New York";
    state = "New York";
    country = "US";
    timezone = "UTC-5";
    locationName = "My Current Location";
    setState(() {});
    ss("Current location detected");
  }

  void _searchLocation() {
    //navigateTo ('WcaSearchLocationView')
  }

  void _saveLocation() {
    if (formKey.currentState!.validate()) {
      ss("Location '${locationName}' added successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Location"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchLocation,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Quick Actions
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Use Current Location",
                            icon: Icons.my_location,
                            size: bs.sm,
                            onPressed: _getCurrentLocation,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Search Location",
                            icon: Icons.search,
                            size: bs.sm,
                            onPressed: _searchLocation,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Location Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Location Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Location Name",
                      value: locationName,
                      hint: "Enter a custom name for this location",
                      validator: Validator.required,
                      onChanged: (value) {
                        locationName = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Country",
                      items: countries,
                      value: country,
                      onChanged: (value, label) {
                        country = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "State/Province",
                            value: state,
                            hint: "Enter state or province",
                            onChanged: (value) {
                              state = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "City",
                            value: city,
                            hint: "Enter city name",
                            validator: Validator.required,
                            onChanged: (value) {
                              city = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Coordinates
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gps_fixed, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Coordinates",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Latitude",
                            value: latitude,
                            hint: "e.g., 40.7128",
                            validator: Validator.required,
                            onChanged: (value) {
                              latitude = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Longitude",
                            value: longitude,
                            hint: "e.g., -74.0060",
                            validator: Validator.required,
                            onChanged: (value) {
                              longitude = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Timezone",
                      items: timezones,
                      value: timezone,
                      onChanged: (value, label) {
                        timezone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Settings
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Location Settings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Set as Default Location",
                          "value": true,
                          "checked": isDefault,
                        }
                      ],
                      value: [
                        if (isDefault)
                          {
                            "label": "Set as Default Location",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isDefault = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Weather Alerts",
                          "value": true,
                          "checked": enableAlerts,
                        }
                      ],
                      value: [
                        if (enableAlerts)
                          {
                            "label": "Enable Weather Alerts",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        enableAlerts = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (enableAlerts)
                      QDropdownField(
                        label: "Alert Radius",
                        items: alertRadiusOptions,
                        value: alertRadius,
                        onChanged: (value, label) {
                          alertRadius = value;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Description
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Add notes about this location (optional)",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Location Preview
              if (latitude.isNotEmpty && longitude.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(Icons.preview, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "Location Preview",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map, size: 48, color: primaryColor),
                            SizedBox(height: spSm),
                            Text(
                              "Map Preview",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${latitude}, ${longitude}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // Save Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Location",
                  size: bs.md,
                  onPressed: _saveLocation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
