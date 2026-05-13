import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFertilizerScheduleView extends StatefulWidget {
  const AmaFertilizerScheduleView({super.key});

  @override
  State<AmaFertilizerScheduleView> createState() => _AmaFertilizerScheduleViewState();
}

class _AmaFertilizerScheduleViewState extends State<AmaFertilizerScheduleView> {
  String selectedField = "";
  String selectedCrop = "";
  String selectedFertilizer = "";
  String applicationDate = "";
  String notes = "";
  double amount = 0.0;
  String selectedWeek = "current";
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "Field A - North Plot", "value": "field_a"},
    {"label": "Field B - South Plot", "value": "field_b"},
    {"label": "Field C - East Plot", "value": "field_c"},
    {"label": "Field D - West Plot", "value": "field_d"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "Rice", "value": "rice"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Corn", "value": "corn"},
    {"label": "Tomato", "value": "tomato"},
    {"label": "Soybean", "value": "soybean"},
  ];

  List<Map<String, dynamic>> fertilizerOptions = [
    {"label": "NPK 16-16-16", "value": "npk_16_16_16"},
    {"label": "Urea", "value": "urea"},
    {"label": "DAP", "value": "dap"},
    {"label": "Compost", "value": "compost"},
    {"label": "Bone Meal", "value": "bone_meal"},
  ];

  List<Map<String, dynamic>> weekOptions = [
    {"label": "This Week", "value": "current"},
    {"label": "Next Week", "value": "next"},
    {"label": "Week After", "value": "week_after"},
    {"label": "All Upcoming", "value": "all"},
  ];

  List<Map<String, dynamic>> scheduledApplications = [
    {
      "id": "1",
      "field": "Field A - North Plot",
      "crop": "Rice",
      "fertilizer": "NPK 16-16-16",
      "scheduledDate": "2025-06-16",
      "growthStage": "Vegetative",
      "amount": 50.0,
      "unit": "kg/ha",
      "priority": "High",
      "status": "Scheduled",
      "weather": "Sunny",
      "notes": "Apply during morning hours",
      "estimatedCost": 1200.0,
      "applicationMethod": "Broadcasting"
    },
    {
      "id": "2",
      "field": "Field B - South Plot",
      "crop": "Wheat",
      "fertilizer": "Urea",
      "scheduledDate": "2025-06-17",
      "growthStage": "Tillering",
      "amount": 40.0,
      "unit": "kg/ha",
      "priority": "Medium",
      "status": "Scheduled",
      "weather": "Cloudy",
      "notes": "Split application in two parts",
      "estimatedCost": 800.0,
      "applicationMethod": "Side Dressing"
    },
    {
      "id": "3",
      "field": "Field C - East Plot",
      "crop": "Tomato",
      "fertilizer": "Compost",
      "scheduledDate": "2025-06-18",
      "growthStage": "Flowering",
      "amount": 2.0,
      "unit": "ton/ha",
      "priority": "Low",
      "status": "Delayed",
      "weather": "Rainy",
      "notes": "Wait for dry conditions",
      "estimatedCost": 600.0,
      "applicationMethod": "Manual Spreading"
    },
    {
      "id": "4",
      "field": "Field D - West Plot",
      "crop": "Corn",
      "fertilizer": "DAP",
      "scheduledDate": "2025-06-19",
      "growthStage": "Booting",
      "amount": 35.0,
      "unit": "kg/ha",
      "priority": "High",
      "status": "Ready",
      "weather": "Sunny",
      "notes": "Apply before irrigation",
      "estimatedCost": 900.0,
      "applicationMethod": "Broadcasting"
    },
    {
      "id": "5",
      "field": "Field A - North Plot",
      "fertilizer": "Bone Meal",
      "scheduledDate": "2025-06-20",
      "growthStage": "Reproductive",
      "amount": 25.0,
      "unit": "kg/ha",
      "priority": "Medium",
      "status": "Scheduled",
      "weather": "Partly Cloudy",
      "notes": "Organic supplement application",
      "estimatedCost": 875.0,
      "applicationMethod": "Incorporation"
    },
    {
      "id": "6",
      "field": "Field B - South Plot",
      "crop": "Wheat",
      "fertilizer": "NPK 16-16-16",
      "scheduledDate": "2025-06-22",
      "growthStage": "Grain Filling",
      "amount": 30.0,
      "unit": "kg/ha",
      "priority": "Medium",
      "status": "Scheduled",
      "weather": "Sunny",
      "notes": "Final application before harvest",
      "estimatedCost": 720.0,
      "applicationMethod": "Foliar Spray"
    },
  ];

  List<Map<String, dynamic>> cropScheduleTemplates = [
    {
      "crop": "Rice",
      "stages": [
        {
          "stage": "Pre-planting",
          "days": "0-7",
          "fertilizer": "Compost",
          "amount": "2-3 ton/ha",
          "nutrients": "Organic matter, slow-release nutrients"
        },
        {
          "stage": "Tillering",
          "days": "15-25",
          "fertilizer": "Urea",
          "amount": "40-50 kg/ha",
          "nutrients": "High nitrogen for vegetative growth"
        },
        {
          "stage": "Panicle Initiation",
          "days": "45-55",
          "fertilizer": "NPK 16-16-16",
          "amount": "50-60 kg/ha",
          "nutrients": "Balanced nutrients for flowering"
        },
        {
          "stage": "Grain Filling",
          "days": "70-80",
          "fertilizer": "Potash",
          "amount": "25-30 kg/ha",
          "nutrients": "Potassium for grain development"
        },
      ]
    },
    {
      "crop": "Wheat",
      "stages": [
        {
          "stage": "Sowing",
          "days": "0-5",
          "fertilizer": "DAP",
          "amount": "100-120 kg/ha",
          "nutrients": "Phosphorus for root development"
        },
        {
          "stage": "Tillering",
          "days": "30-40",
          "fertilizer": "Urea",
          "amount": "40-50 kg/ha",
          "nutrients": "Nitrogen for tiller development"
        },
        {
          "stage": "Booting",
          "days": "65-75",
          "fertilizer": "NPK 12-32-16",
          "amount": "50-60 kg/ha",
          "nutrients": "Balanced nutrients for head formation"
        },
      ]
    },
    {
      "crop": "Tomato",
      "stages": [
        {
          "stage": "Transplanting",
          "days": "0-7",
          "fertilizer": "Compost",
          "amount": "3-4 ton/ha",
          "nutrients": "Organic matter and starter nutrients"
        },
        {
          "stage": "Vegetative",
          "days": "14-21",
          "fertilizer": "NPK 20-10-10",
          "amount": "30-40 kg/ha",
          "nutrients": "High nitrogen for leaf development"
        },
        {
          "stage": "Flowering",
          "days": "35-45",
          "fertilizer": "NPK 10-20-20",
          "amount": "40-50 kg/ha",
          "nutrients": "Phosphorus and potassium for fruit set"
        },
        {
          "stage": "Fruiting",
          "days": "55-65",
          "fertilizer": "Potash",
          "amount": "30-40 kg/ha",
          "nutrients": "Potassium for fruit development"
        },
      ]
    },
  ];

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ready':
        return successColor;
      case 'scheduled':
        return primaryColor;
      case 'delayed':
        return warningColor;
      case 'completed':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _scheduleApplication() async {
    if (selectedField.isEmpty || selectedFertilizer.isEmpty || applicationDate.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    // Add to schedule
    ss("Fertilizer application scheduled successfully");
    
    // Reset form
    selectedField = "";
    selectedCrop = "";
    selectedFertilizer = "";
    applicationDate = "";
    notes = "";
    amount = 0.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fertilizer Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_view_week),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Schedule New Application
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.add_circle,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Schedule New Application",
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
                        child: QDropdownField(
                          label: "Select Field",
                          items: fieldOptions,
                          value: selectedField,
                          onChanged: (value, label) {
                            selectedField = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Select Crop",
                          items: cropOptions,
                          value: selectedCrop,
                          onChanged: (value, label) {
                            selectedCrop = value;
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
                          label: "Select Fertilizer",
                          items: fertilizerOptions,
                          value: selectedFertilizer,
                          onChanged: (value, label) {
                            selectedFertilizer = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Amount (kg/ha)",
                          value: amount.toString(),
                          onChanged: (value) {
                            amount = double.tryParse(value) ?? 0.0;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QDatePicker(
                    label: "Application Date",
                    value: applicationDate.isEmpty ? DateTime.now() : DateTime.parse(applicationDate),
                    onChanged: (value) {
                      applicationDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),

                  QMemoField(
                    label: "Notes",
                    value: notes,
                    hint: "Application instructions or special notes",
                    onChanged: (value) {
                      notes = value;
                      setState(() {});
                    },
                  ),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Schedule Application",
                      size: bs.md,
                      onPressed: _scheduleApplication,
                    ),
                  ),
                ],
              ),
            ),

            // Filter Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Filter Schedule",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QCategoryPicker(
                    items: weekOptions,
                    value: selectedWeek,
                    onChanged: (index, label, value, item) {
                      selectedWeek = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Upcoming Applications
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.schedule,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upcoming Applications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${scheduledApplications.where((app) => app["status"] != "Completed").length} Pending",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  ...scheduledApplications.where((app) => 
                    selectedWeek == "all" || app["status"] != "Completed"
                  ).map((application) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${application["field"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(application["priority"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${application["priority"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(application["status"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${application["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: disabledBoldColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${application["scheduledDate"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.wb_sunny,
                                color: disabledBoldColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${application["weather"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          if (application["crop"] != null)
                            Row(
                              children: [
                                Text(
                                  "${application["crop"]} • ${application["growthStage"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${((application["estimatedCost"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${application["fertilizer"]} - ${(application["amount"] as double).toStringAsFixed(1)} ${application["unit"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Method: ${application["applicationMethod"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),

                          if (application["notes"] != null && application["notes"].isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.blue.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${application["notes"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: application["status"] == "Ready" ? "Apply Now" : "Reschedule",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Crop Schedule Templates
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.timeline,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Fertilizer Schedule Templates",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Recommended fertilizer application schedules by crop growth stages",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  ...cropScheduleTemplates.map((template) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(40)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${template["crop"]} Schedule",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                          
                          ...(template["stages"] as List).map((stage) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${stage["stage"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${stage["days"]} days",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Fertilizer: ${stage["fertilizer"]} (${stage["amount"]})",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    "${stage["nutrients"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Use This Template",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Weekly Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.summarize,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "This Week Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scheduled Applications",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${scheduledApplications.where((app) => app["status"] == "Scheduled").length}",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Estimated Cost",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${((scheduledApplications.where((app) => app["status"] == "Scheduled").map((app) => app["estimatedCost"] as double).fold(0.0, (sum, cost) => sum + cost)).toDouble()).currency}",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    );
  }
}
