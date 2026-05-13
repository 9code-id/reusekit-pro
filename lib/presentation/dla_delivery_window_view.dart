import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDeliveryWindowView extends StatefulWidget {
  const DlaDeliveryWindowView({super.key});

  @override
  State<DlaDeliveryWindowView> createState() => _DlaDeliveryWindowViewState();
}

class _DlaDeliveryWindowViewState extends State<DlaDeliveryWindowView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  String windowName = "";
  TimeOfDay startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 17, minute: 0);
  String windowType = "standard";
  String description = "";
  String maxDeliveries = "10";
  String priceModifier = "1.0";
  bool isActive = true;
  bool isPeakHour = false;
  List<String> selectedDays = [];

  List<Map<String, dynamic>> windowTypeOptions = [
    {"label": "Standard Window", "value": "standard"},
    {"label": "Express Window", "value": "express"},
    {"label": "Economy Window", "value": "economy"},
    {"label": "Premium Window", "value": "premium"},
  ];

  List<Map<String, dynamic>> dayOptions = [
    {"label": "Monday", "value": "monday", "checked": false},
    {"label": "Tuesday", "value": "tuesday", "checked": false},
    {"label": "Wednesday", "value": "wednesday", "checked": false},
    {"label": "Thursday", "value": "thursday", "checked": false},
    {"label": "Friday", "value": "friday", "checked": false},
    {"label": "Saturday", "value": "saturday", "checked": false},
    {"label": "Sunday", "value": "sunday", "checked": false},
  ];

  List<Map<String, dynamic>> existingWindows = [
    {
      "id": "window_001",
      "name": "Morning Express",
      "type": "express",
      "start_time": "06:00",
      "end_time": "09:00",
      "max_deliveries": 15,
      "price_modifier": 1.5,
      "is_active": true,
      "is_peak": false,
      "days": ["monday", "tuesday", "wednesday", "thursday", "friday"],
      "current_bookings": 8,
      "description": "Early morning express deliveries",
    },
    {
      "id": "window_002",
      "name": "Standard Morning",
      "type": "standard",
      "start_time": "09:00",
      "end_time": "12:00",
      "max_deliveries": 20,
      "price_modifier": 1.0,
      "is_active": true,
      "is_peak": true,
      "days": ["monday", "tuesday", "wednesday", "thursday", "friday"],
      "current_bookings": 18,
      "description": "Regular morning delivery window",
    },
    {
      "id": "window_003",
      "name": "Lunch Time",
      "type": "economy",
      "start_time": "12:00",
      "end_time": "14:00",
      "max_deliveries": 8,
      "price_modifier": 0.8,
      "is_active": true,
      "is_peak": false,
      "days": ["monday", "tuesday", "wednesday", "thursday", "friday"],
      "current_bookings": 3,
      "description": "Budget-friendly lunch time deliveries",
    },
    {
      "id": "window_004",
      "name": "Afternoon Peak",
      "type": "premium",
      "start_time": "14:00",
      "end_time": "18:00",
      "max_deliveries": 25,
      "price_modifier": 1.3,
      "is_active": true,
      "is_peak": true,
      "days": ["monday", "tuesday", "wednesday", "thursday", "friday"],
      "current_bookings": 22,
      "description": "High-volume afternoon deliveries",
    },
    {
      "id": "window_005",
      "name": "Evening Service",
      "type": "standard",
      "start_time": "18:00",
      "end_time": "21:00",
      "max_deliveries": 12,
      "price_modifier": 0.9,
      "is_active": false,
      "is_peak": false,
      "days": ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday"],
      "current_bookings": 0,
      "description": "After-hours delivery service",
    },
  ];

  Color _getWindowTypeColor(String type) {
    switch (type) {
      case "express":
        return dangerColor;
      case "premium":
        return primaryColor;
      case "standard":
        return successColor;
      case "economy":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  void _createWindow() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (selectedDays.isEmpty) {
      se("Please select at least one day");
      return;
    }

    bool isConfirmed = await confirm("Create this delivery window?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Delivery window created successfully");
    _resetForm();
  }

  void _resetForm() {
    windowName = "";
    startTime = TimeOfDay(hour: 9, minute: 0);
    endTime = TimeOfDay(hour: 17, minute: 0);
    windowType = "standard";
    description = "";
    maxDeliveries = "10";
    priceModifier = "1.0";
    isActive = true;
    isPeakHour = false;
    selectedDays = [];
    
    for (var day in dayOptions) {
      day["checked"] = false;
    }
    
    setState(() {});
  }

  void _toggleWindowStatus(Map<String, dynamic> window) async {
    bool newStatus = !(window["is_active"] as bool);
    String action = newStatus ? "activate" : "deactivate";
    
    bool isConfirmed = await confirm("Are you sure you want to $action this delivery window?");
    if (!isConfirmed) return;

    window["is_active"] = newStatus;
    setState(() {});
    
    ss("Window ${newStatus ? 'activated' : 'deactivated'} successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Windows"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Statistics Overview
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Total Windows",
                        "${existingWindows.length}",
                        Icons.schedule,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Active Windows",
                        "${existingWindows.where((w) => w["is_active"] as bool).length}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildStatCard(
                        "Peak Hours",
                        "${existingWindows.where((w) => w["is_peak"] as bool).length}",
                        Icons.trending_up,
                        dangerColor,
                      ),
                      _buildStatCard(
                        "Total Capacity",
                        "${existingWindows.fold(0, (sum, w) => sum + (w["max_deliveries"] as int))}",
                        Icons.inventory,
                        warningColor,
                      ),
                    ],
                  ),

                  // Create New Window Form
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Create New Delivery Window",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              spacing: spSm,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: QTextField(
                                        label: "Window Name",
                                        value: windowName,
                                        validator: Validator.required,
                                        hint: "e.g., Morning Express",
                                        onChanged: (value) {
                                          windowName = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: QDropdownField(
                                        label: "Window Type",
                                        items: windowTypeOptions,
                                        value: windowType,
                                        onChanged: (value, label) {
                                          windowType = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: QTimePicker(
                                        label: "Start Time",
                                        value: startTime,
                                        onChanged: (value) {
                                          startTime = value!;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: QTimePicker(
                                        label: "End Time",
                                        value: endTime,
                                        onChanged: (value) {
                                          endTime = value!;
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
                                        label: "Max Deliveries",
                                        value: maxDeliveries,
                                        validator: Validator.required,
                                        onChanged: (value) {
                                          maxDeliveries = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: QNumberField(
                                        label: "Price Modifier",
                                        value: priceModifier,
                                        validator: Validator.required,
                                        hint: "1.0 = standard, 1.5 = 50% more",
                                        onChanged: (value) {
                                          priceModifier = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                QMemoField(
                                  label: "Description",
                                  value: description,
                                  hint: "Describe this delivery window",
                                  onChanged: (value) {
                                    description = value;
                                    setState(() {});
                                  },
                                ),
                                
                                // Days Selection
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: primaryColor.withAlpha(50),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Available Days",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spSm),
                                      QSwitch(
                                        items: dayOptions,
                                        value: selectedDays.map((day) => {
                                          "label": dayOptions.firstWhere((d) => d["value"] == day)["label"],
                                          "value": day,
                                          "checked": true,
                                        }).toList(),
                                        onChanged: (values, ids) {
                                          selectedDays = values.map((v) => v["value"] as String).toList();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                // Settings Switches
                                Row(
                                  children: [
                                    Expanded(
                                      child: QSwitch(
                                        label: "Active",
                                        items: [
                                          {
                                            "label": "Window Active",
                                            "value": true,
                                            "checked": isActive,
                                          }
                                        ],
                                        value: [if (isActive) {"label": "Window Active", "value": true, "checked": true}],
                                        onChanged: (values, ids) {
                                          isActive = values.isNotEmpty;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: QSwitch(
                                        label: "Peak Hour",
                                        items: [
                                          {
                                            "label": "Is Peak Hour",
                                            "value": true,
                                            "checked": isPeakHour,
                                          }
                                        ],
                                        value: [if (isPeakHour) {"label": "Is Peak Hour", "value": true, "checked": true}],
                                        onChanged: (values, ids) {
                                          isPeakHour = values.isNotEmpty;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                // Action Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: QButton(
                                        label: "Reset Form",
                                        onPressed: _resetForm,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [primaryColor, primaryColor.withAlpha(200)],
                                          ),
                                          borderRadius: BorderRadius.circular(radiusMd),
                                        ),
                                        child: QButton(
                                          label: "Create Window",
                                          onPressed: _createWindow,
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

                  // Existing Windows
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.list, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Existing Delivery Windows",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...existingWindows.map((window) => _buildWindowCard(window)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowCard(Map<String, dynamic> window) {
    bool isActive = window["is_active"] as bool;
    bool isPeak = window["is_peak"] as bool;
    Color typeColor = _getWindowTypeColor(window["type"]);
    int currentBookings = window["current_bookings"] as int;
    int maxDeliveries = window["max_deliveries"] as int;
    double utilizationRate = currentBookings / maxDeliveries;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : disabledColor.withAlpha(20),
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${window["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.black87 : disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${window["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: typeColor,
                            ),
                          ),
                        ),
                        if (isPeak)
                          Container(
                            margin: EdgeInsets.only(left: spXs),
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "PEAK",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${window["start_time"]} - ${window["end_time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive ? disabledBoldColor : disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: isActive ? Icons.pause : Icons.play_arrow,
                size: bs.sm,
                onPressed: () => _toggleWindowStatus(window),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${window["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: isActive ? disabledBoldColor : disabledColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Capacity: $currentBookings/$maxDeliveries",
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? disabledBoldColor : disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Modifier: ${((window["price_modifier"] as double) * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? disabledBoldColor : disabledColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: utilizationRate,
              child: Container(
                decoration: BoxDecoration(
                  color: utilizationRate > 0.8 ? dangerColor : 
                         utilizationRate > 0.6 ? warningColor : successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Days: ${(window["days"] as List).map((d) => d.toString().substring(0, 3).toUpperCase()).join(', ')}",
            style: TextStyle(
              fontSize: 11,
              color: isActive ? disabledBoldColor : disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
