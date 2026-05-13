import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaInsuranceClaimsView extends StatefulWidget {
  const MhaInsuranceClaimsView({super.key});

  @override
  State<MhaInsuranceClaimsView> createState() => _MhaInsuranceClaimsViewState();
}

class _MhaInsuranceClaimsViewState extends State<MhaInsuranceClaimsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  
  List<Map<String, dynamic>> claims = [
    {
      "claimId": "CLM-2024-0345",
      "date": "2024-06-25",
      "provider": "Downtown Medical Center",
      "service": "MRI Scan",
      "type": "Diagnostic",
      "amount": 2850.00,
      "covered": 2565.00,
      "yourCost": 285.00,
      "status": "Paid",
      "dateSubmitted": "2024-06-26",
      "datePaid": "2024-06-30",
      "diagnosisCode": "R50.9",
      "description": "Brain MRI with contrast for headache evaluation",
    },
    {
      "claimId": "CLM-2024-0289",
      "date": "2024-06-18",
      "provider": "Dr. Jennifer Smith",
      "service": "Annual Physical",
      "type": "Preventive",
      "amount": 250.00,
      "covered": 250.00,
      "yourCost": 0.00,
      "status": "Paid",
      "dateSubmitted": "2024-06-19",
      "datePaid": "2024-06-22",
      "diagnosisCode": "Z00.00",
      "description": "Annual comprehensive wellness exam",
    },
    {
      "claimId": "CLM-2024-0267",
      "date": "2024-06-15",
      "provider": "Express Care Pharmacy",
      "service": "Prescription Medication",
      "type": "Pharmacy",
      "amount": 125.50,
      "covered": 106.68,
      "yourCost": 18.82,
      "status": "Processing",
      "dateSubmitted": "2024-06-16",
      "datePaid": null,
      "diagnosisCode": "I10",
      "description": "90-day supply of blood pressure medication",
    },
    {
      "claimId": "CLM-2024-0234",
      "date": "2024-06-10",
      "provider": "City Emergency Hospital",
      "service": "Emergency Room Visit",
      "type": "Emergency",
      "amount": 4250.00,
      "covered": 3825.00,
      "yourCost": 425.00,
      "status": "Under Review",
      "dateSubmitted": "2024-06-12",
      "datePaid": null,
      "diagnosisCode": "S72.001A",
      "description": "Emergency treatment for suspected fracture",
    },
    {
      "claimId": "CLM-2024-0198",
      "date": "2024-06-05",
      "provider": "Family Dental Practice",
      "service": "Dental Cleaning",
      "type": "Dental",
      "amount": 180.00,
      "covered": 144.00,
      "yourCost": 36.00,
      "status": "Paid",
      "dateSubmitted": "2024-06-06",
      "datePaid": "2024-06-08",
      "diagnosisCode": "Z01.20",
      "description": "Routine dental prophylaxis and examination",
    },
    {
      "claimId": "CLM-2024-0156",
      "date": "2024-05-28",
      "provider": "Orthopedic Specialists",
      "service": "Physical Therapy",
      "type": "Therapy",
      "amount": 320.00,
      "covered": 256.00,
      "yourCost": 64.00,
      "status": "Denied",
      "dateSubmitted": "2024-05-30",
      "datePaid": null,
      "diagnosisCode": "M25.561",
      "description": "Physical therapy for knee rehabilitation",
      "denialReason": "Service not pre-authorized",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredClaims = claims.where((claim) {
      bool matchesSearch = claim["provider"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          claim["service"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          claim["claimId"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || claim["status"].toString().toLowerCase() == selectedStatus.toLowerCase();
      bool matchesType = selectedType == "all" || claim["type"].toString().toLowerCase() == selectedType.toLowerCase();
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    // Sort by date (newest first)
    filteredClaims.sort((a, b) => b["date"].compareTo(a["date"]));

    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'paid': return successColor;
        case 'processing': return warningColor;
        case 'under review': return infoColor;
        case 'denied': return dangerColor;
        default: return disabledBoldColor;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Claims"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Navigate to file new claim");
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
            // Search Bar
            QTextField(
              label: "Search claims...",
              value: searchQuery,
              hint: "Search by provider, service, or claim ID",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Paid", "value": "paid"},
                      {"label": "Processing", "value": "processing"},
                      {"label": "Under Review", "value": "under review"},
                      {"label": "Denied", "value": "denied"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: [
                      {"label": "All Types", "value": "all"},
                      {"label": "Emergency", "value": "emergency"},
                      {"label": "Preventive", "value": "preventive"},
                      {"label": "Diagnostic", "value": "diagnostic"},
                      {"label": "Pharmacy", "value": "pharmacy"},
                      {"label": "Dental", "value": "dental"},
                      {"label": "Therapy", "value": "therapy"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Claims Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Text(
                    "Claims Summary",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${filteredClaims.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Claims",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${(filteredClaims.fold(0.0, (sum, claim) => sum + (claim["amount"] as double))).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${(filteredClaims.fold(0.0, (sum, claim) => sum + (claim["covered"] as double))).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Covered",
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
                ],
              ),
            ),
            
            // Claims List
            Text(
              "Claims History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            if (filteredClaims.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No claims found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredClaims.map((claim) {
                Color statusColor = getStatusColor(claim["status"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${claim["service"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${claim["provider"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                                  "${claim["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${claim["type"]}",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Claim Details
                      Row(
                        spacing: spMd,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Claim ID",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${claim["claimId"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
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
                                  "Service Date",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${claim["date"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
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
                                  "Diagnosis",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${claim["diagnosisCode"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // Financial Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "\$${(claim["amount"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
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
                                    "Covered",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "\$${(claim["covered"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: successColor,
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
                                    "Your Cost",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "\$${(claim["yourCost"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: claim["yourCost"] == 0 ? successColor : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Description
                      Text(
                        "${claim["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      
                      // Denial Reason (if applicable)
                      if (claim["status"] == "Denied" && claim.containsKey("denialReason"))
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(50)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Denial Reason",
                                    style: TextStyle(
                                      color: dangerColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${claim["denialReason"]}",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 13,
                                ),
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
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                ss("Viewing details for ${claim["claimId"]}");
                              },
                            ),
                          ),
                          if (claim["status"] == "Denied")
                            Expanded(
                              child: QButton(
                                label: "Appeal",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Starting appeal for ${claim["claimId"]}");
                                },
                              ),
                            ),
                          if (claim["status"] == "Processing" || claim["status"] == "Under Review")
                            Expanded(
                              child: QButton(
                                label: "Track Status",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Tracking ${claim["claimId"]}");
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Navigate to file new claim");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
