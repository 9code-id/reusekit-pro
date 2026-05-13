import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaTestResultsView extends StatefulWidget {
  const MhaTestResultsView({super.key});

  @override
  State<MhaTestResultsView> createState() => _MhaTestResultsViewState();
}

class _MhaTestResultsViewState extends State<MhaTestResultsView> {
  bool loading = false;
  
  Map<String, dynamic> testResult = {
    "id": "LAB001",
    "testName": "Complete Blood Count (CBC)",
    "patientName": "John Doe",
    "age": 35,
    "gender": "Male",
    "date": "2024-01-15",
    "time": "10:30 AM",
    "collectionDate": "2024-01-14",
    "reportDate": "2024-01-15",
    "status": "Completed",
    "overallResult": "Normal",
    "doctorName": "Dr. Sarah Wilson",
    "labName": "City Diagnostic Center",
    "labAddress": "123 Health Street, Medical District",
    "labPhone": "+1-555-0123",
    "technician": "Michael Smith",
    "criticalValues": 0,
    "abnormalValues": 1,
    "totalTests": 12,
    "downloadUrl": "cbc_report_001.pdf",
    "comments": "Patient was fasting for 12 hours. All major parameters are within normal range. Slight elevation in WBC count may indicate minor infection.",
    "parameters": [
      {
        "name": "Hemoglobin",
        "value": "14.2",
        "unit": "g/dL",
        "normalRange": "12.0-15.5",
        "status": "Normal",
        "flag": "",
        "description": "Protein in red blood cells that carries oxygen",
      },
      {
        "name": "RBC Count",
        "value": "4.8",
        "unit": "million/uL",
        "normalRange": "4.5-5.9",
        "status": "Normal",
        "flag": "",
        "description": "Number of red blood cells per microliter",
      },
      {
        "name": "WBC Count",
        "value": "11500",
        "unit": "/uL",
        "normalRange": "4000-11000",
        "status": "High",
        "flag": "H",
        "description": "Number of white blood cells per microliter",
      },
      {
        "name": "Platelet Count",
        "value": "285",
        "unit": "thousand/uL",
        "normalRange": "150-450",
        "status": "Normal",
        "flag": "",
        "description": "Number of platelets per microliter",
      },
      {
        "name": "Hematocrit",
        "value": "42.5",
        "unit": "%",
        "normalRange": "38.0-46.0",
        "status": "Normal",
        "flag": "",
        "description": "Percentage of blood volume occupied by red blood cells",
      },
      {
        "name": "MCV",
        "value": "88",
        "unit": "fL",
        "normalRange": "80-100",
        "status": "Normal",
        "flag": "",
        "description": "Mean corpuscular volume - average size of red blood cells",
      },
      {
        "name": "MCH",
        "value": "30",
        "unit": "pg",
        "normalRange": "27-33",
        "status": "Normal",
        "flag": "",
        "description": "Mean corpuscular hemoglobin - average amount of hemoglobin per red blood cell",
      },
      {
        "name": "MCHC",
        "value": "34",
        "unit": "g/dL",
        "normalRange": "32-36",
        "status": "Normal",
        "flag": "",
        "description": "Mean corpuscular hemoglobin concentration",
      },
    ],
  };
  
  List<Map<String, dynamic>> recommendations = [
    {
      "type": "Follow-up",
      "title": "Repeat WBC Count",
      "description": "Consider repeating WBC count in 1-2 weeks to monitor if elevation persists",
      "icon": Icons.refresh,
      "color": warningColor,
    },
    {
      "type": "Lifestyle",
      "title": "Maintain Hydration",
      "description": "Continue adequate water intake to support healthy blood parameters",
      "icon": Icons.water_drop,
      "color": infoColor,
    },
    {
      "type": "Diet",
      "title": "Iron-Rich Foods",
      "description": "Include iron-rich foods like spinach, lean meat, and legumes in your diet",
      "icon": Icons.restaurant,
      "color": successColor,
    },
    {
      "type": "Consultation",
      "title": "Doctor Follow-up",
      "description": "Schedule a follow-up consultation to discuss the slightly elevated WBC count",
      "icon": Icons.medical_services,
      "color": primaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Results"),
        actions: [
          IconButton(
            onPressed: () {
              _shareReport();
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              _downloadReport();
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: loading 
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Test header
                  _buildTestHeader(),
                  
                  SizedBox(height: spMd),
                  
                  // Overall result
                  _buildOverallResult(),
                  
                  SizedBox(height: spMd),
                  
                  // Test parameters
                  _buildParametersSection(),
                  
                  SizedBox(height: spMd),
                  
                  // Recommendations
                  _buildRecommendationsSection(),
                  
                  SizedBox(height: spMd),
                  
                  // Lab information
                  _buildLabInformation(),
                  
                  SizedBox(height: spMd),
                  
                  // Action buttons
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildTestHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(100)),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.science,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${testResult["testName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Report ID: ${testResult["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${testResult["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Patient info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Patient: ${testResult["patientName"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "Age: ${testResult["age"]} | ${testResult["gender"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Collection Date: ${testResult["collectionDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "Report Date: ${testResult["reportDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallResult() {
    Color resultColor = testResult["overallResult"] == "Normal" 
        ? successColor 
        : testResult["overallResult"] == "Abnormal" 
            ? warningColor 
            : dangerColor;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: resultColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: resultColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                testResult["overallResult"] == "Normal" 
                    ? Icons.check_circle
                    : Icons.warning,
                color: resultColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Overall Result: ${testResult["overallResult"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Summary stats
          Row(
            children: [
              Expanded(
                child: _buildResultStat("Total Tests", "${testResult["totalTests"]}", Icons.list, primaryColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildResultStat("Abnormal", "${testResult["abnormalValues"]}", Icons.warning, warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildResultStat("Critical", "${testResult["criticalValues"]}", Icons.error, dangerColor),
              ),
            ],
          ),
          
          if (testResult["comments"] != null && (testResult["comments"] as String).isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Clinical Comments:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${testResult["comments"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildParametersSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Test Parameters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Parameters list
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (testResult["parameters"] as List).length,
            itemBuilder: (context, index) {
              final parameter = (testResult["parameters"] as List<Map<String, dynamic>>)[index];
              return _buildParameterCard(parameter);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildParameterCard(Map<String, dynamic> parameter) {
    Color statusColor = parameter["status"] == "Normal" 
        ? successColor 
        : parameter["status"] == "High" || parameter["status"] == "Low"
            ? warningColor
            : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(100)),
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
                          "${parameter["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (parameter["flag"] != null && (parameter["flag"] as String).isNotEmpty) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${parameter["flag"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${parameter["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${parameter["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Parameter values
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${parameter["value"]} ${parameter["unit"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Normal Range",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${parameter["normalRange"]} ${parameter["unit"]}",
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
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              final recommendation = recommendations[index];
              return _buildRecommendationCard(recommendation);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> recommendation) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (recommendation["color"] as Color).withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (recommendation["color"] as Color).withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: recommendation["color"] as Color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              recommendation["icon"] as IconData,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${recommendation["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: recommendation["color"] as Color,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${recommendation["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: recommendation["color"] as Color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabInformation() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Laboratory Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildInfoRow("Laboratory", "${testResult["labName"]}"),
                _buildInfoRow("Address", "${testResult["labAddress"]}"),
                _buildInfoRow("Phone", "${testResult["labPhone"]}"),
                _buildInfoRow("Technician", "${testResult["technician"]}"),
                _buildInfoRow("Ordered by", "Dr. ${testResult["doctorName"]}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Book Follow-up",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('BookAppointmentView', arguments: {"doctor": testResult["doctorName"]});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Schedule Retest",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('BookLabTestView', arguments: testResult);
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //navigateTo('AddToHealthRecordsView', arguments: testResult);
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_to_photos,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Add to Records",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _printReport();
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.print,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Print Report",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _shareReport() {
    ss("Report shared successfully");
  }

  void _downloadReport() {
    loading = true;
    setState(() {});
    
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      hideLoading();
      ss("Report downloaded successfully");
    });
  }

  void _printReport() {
    ss("Report sent to printer");
  }
}
