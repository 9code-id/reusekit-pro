import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaInsuranceClaimsView extends StatefulWidget {
  const CmaInsuranceClaimsView({super.key});

  @override
  State<CmaInsuranceClaimsView> createState() => _CmaInsuranceClaimsViewState();
}

class _CmaInsuranceClaimsViewState extends State<CmaInsuranceClaimsView> {
  String claimType = "Auto Collision";
  String incidentDate = "";
  String claimDescription = "";
  String damageAmount = "";
  List<String> claimDocuments = [];
  List<String> damagePhotos = [];
  
  List<Map<String, dynamic>> claimTypes = [
    {"label": "Auto Collision", "value": "Auto Collision"},
    {"label": "Comprehensive", "value": "Comprehensive"},
    {"label": "Liability", "value": "Liability"},
    {"label": "Uninsured Motorist", "value": "Uninsured Motorist"},
    {"label": "Personal Injury", "value": "Personal Injury"},
    {"label": "Property Damage", "value": "Property Damage"},
  ];

  List<Map<String, dynamic>> insuranceClaims = [
    {
      "claimNumber": "CLM-2024-001234",
      "type": "Auto Collision",
      "status": "Under Review",
      "dateReported": DateTime.now().subtract(Duration(days: 3)),
      "estimatedPayout": 4500.00,
      "deductible": 500.00,
      "adjusterName": "Sarah Johnson",
      "adjusterPhone": "(555) 123-4567",
      "incidentDate": DateTime.now().subtract(Duration(days: 5)),
      "description": "Rear-end collision at traffic light",
      "repairShop": "Mike's Auto Body",
      "rentalCar": true,
    },
    {
      "claimNumber": "CLM-2024-001189",
      "type": "Comprehensive",
      "status": "Approved",
      "dateReported": DateTime.now().subtract(Duration(days: 15)),
      "estimatedPayout": 2800.00,
      "deductible": 250.00,
      "adjusterName": "Mike Rodriguez",
      "adjusterPhone": "(555) 987-6543",
      "incidentDate": DateTime.now().subtract(Duration(days: 17)),
      "description": "Hail damage to vehicle roof and hood",
      "repairShop": "Auto Excellence",
      "rentalCar": false,
    },
    {
      "claimNumber": "CLM-2023-009876",
      "type": "Liability",
      "status": "Closed",
      "dateReported": DateTime.now().subtract(Duration(days: 45)),
      "estimatedPayout": 3200.00,
      "deductible": 0.00,
      "adjusterName": "Lisa Chen",
      "adjusterPhone": "(555) 555-0123",
      "incidentDate": DateTime.now().subtract(Duration(days: 47)),
      "description": "Property damage to other vehicle",
      "repairShop": "N/A",
      "rentalCar": false,
    },
  ];

  List<Map<String, dynamic>> claimSteps = [
    {
      "step": 1,
      "title": "Report Incident",
      "description": "Report the incident to police and insurance",
      "completed": true,
    },
    {
      "step": 2,
      "title": "File Claim",
      "description": "Submit claim with documentation",
      "completed": true,
    },
    {
      "step": 3,
      "title": "Adjuster Review",
      "description": "Insurance adjuster reviews your claim",
      "completed": false,
    },
    {
      "step": 4,
      "title": "Damage Assessment",
      "description": "Vehicle inspection and damage estimate",
      "completed": false,
    },
    {
      "step": 5,
      "title": "Claim Approval",
      "description": "Insurance company approves payout",
      "completed": false,
    },
    {
      "step": 6,
      "title": "Repair/Settlement",
      "description": "Vehicle repair or settlement payment",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Claims"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showNewClaimDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
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
                        child: QButton(
                          label: "File New Claim",
                          icon: Icons.add_circle,
                          onPressed: () {
                            _showNewClaimDialog();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Call Insurance",
                          icon: Icons.phone,
                          onPressed: () {
                            si("Calling insurance company...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Active Claims Summary
            Text(
              "Active Claims Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildSummaryCard(
                  "Total Claims",
                  "${insuranceClaims.length}",
                  Icons.description,
                  primaryColor,
                ),
                _buildSummaryCard(
                  "Under Review",
                  "${insuranceClaims.where((c) => c["status"] == "Under Review").length}",
                  Icons.hourglass_empty,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Approved",
                  "${insuranceClaims.where((c) => c["status"] == "Approved").length}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildSummaryCard(
                  "Total Payout",
                  "\$${insuranceClaims.map((c) => c["estimatedPayout"] as double).reduce((a, b) => a + b).toStringAsFixed(0)}",
                  Icons.attach_money,
                  infoColor,
                ),
              ],
            ),

            // Claim Process Tracker
            Text(
              "Claim Process Tracker",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
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
                    "Current Claim: CLM-2024-001234",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: claimSteps.map((step) {
                      bool isCompleted = step["completed"] as bool;
                      Color stepColor = isCompleted ? successColor : disabledBoldColor;
                      
                      return Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isCompleted ? successColor : disabledColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCompleted ? Icons.check : Icons.radio_button_unchecked,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${step["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: stepColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${step["description"]}",
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Claims List
            Text(
              "Your Insurance Claims",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: insuranceClaims.map((claim) {
                Color statusColor = (claim["status"] as String) == "Approved" 
                    ? successColor 
                    : (claim["status"] as String) == "Under Review" 
                        ? warningColor 
                        : (claim["status"] as String) == "Closed"
                            ? infoColor
                            : dangerColor;
                
                return Container(
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
                          Expanded(
                            child: Text(
                              "${claim["claimNumber"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${claim["status"]}",
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${claim["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      Text(
                        "${claim["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Incident: ${(claim["incidentDate"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Reported: ${(claim["dateReported"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (claim["adjusterName"] != null)
                                  Text(
                                    "Adjuster: ${claim["adjusterName"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: spXs,
                            children: [
                              Text(
                                "Estimated Payout",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(claim["estimatedPayout"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              if ((claim["deductible"] as double) > 0)
                                Text(
                                  "Deductible: \$${(claim["deductible"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      
                      if (claim["rentalCar"] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.car_rental, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "Rental Car Covered",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                _showClaimDetails(claim);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Call Adjuster",
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {
                              si("Calling ${claim["adjusterName"]}...");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Insurance Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor),
                      SizedBox(width: spSm),
                      Text(
                        "Insurance Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Policy Number: POL-123456789\n"
                    "Provider: State Farm Insurance\n"
                    "Coverage: Full Coverage\n"
                    "Next Premium: March 15, 2024",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Policy Details",
                      size: bs.sm,
                      color: infoColor,
                      onPressed: () {
                        si("Viewing policy details");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showNewClaimDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("File New Claim"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Claim Type",
              items: claimTypes,
              value: claimType,
              onChanged: (value, label) {
                claimType = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Incident Date",
              value: incidentDate,
              hint: "MM/DD/YYYY",
              onChanged: (value) {
                incidentDate = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Description",
              value: claimDescription,
              hint: "Describe what happened...",
              onChanged: (value) {
                claimDescription = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("New claim filed successfully");
            },
            child: Text("File Claim"),
          ),
        ],
      ),
    );
  }

  void _showClaimDetails(Map<String, dynamic> claim) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Claim Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Claim Number: ${claim["claimNumber"]}"),
            Text("Type: ${claim["type"]}"),
            Text("Status: ${claim["status"]}"),
            Text("Estimated Payout: \$${(claim["estimatedPayout"] as double).toStringAsFixed(2)}"),
            if (claim["repairShop"] != "N/A")
              Text("Repair Shop: ${claim["repairShop"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
