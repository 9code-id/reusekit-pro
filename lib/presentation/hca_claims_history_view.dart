import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaClaimsHistoryView extends StatefulWidget {
  const HcaClaimsHistoryView({super.key});

  @override
  State<HcaClaimsHistoryView> createState() => _HcaClaimsHistoryViewState();
}

class _HcaClaimsHistoryViewState extends State<HcaClaimsHistoryView> {
  String selectedStatus = "All";
  String selectedYear = "2024";
  
  List<Map<String, dynamic>> claims = [
    {
      "id": "CLM-2024-001",
      "date": "2024-03-15",
      "provider": "City Medical Center",
      "service": "Annual Physical Exam",
      "amount": 350.00,
      "covered": 280.00,
      "copay": 25.00,
      "deductible": 45.00,
      "status": "Paid",
      "processedDate": "2024-03-20",
      "diagnosis": "Z00.00 - Routine health examination"
    },
    {
      "id": "CLM-2024-002", 
      "date": "2024-03-22",
      "provider": "Downtown Pharmacy",
      "service": "Prescription Medication",
      "amount": 125.00,
      "covered": 87.50,
      "copay": 15.00,
      "deductible": 22.50,
      "status": "Paid",
      "processedDate": "2024-03-25",
      "diagnosis": "E11.9 - Type 2 diabetes mellitus"
    },
    {
      "id": "CLM-2024-003",
      "date": "2024-04-10",
      "provider": "Heart Specialists Clinic",
      "service": "Cardiology Consultation",
      "amount": 450.00,
      "covered": 360.00,
      "copay": 50.00,
      "deductible": 40.00,
      "status": "Processing",
      "processedDate": null,
      "diagnosis": "I25.9 - Chronic ischemic heart disease"
    },
    {
      "id": "CLM-2024-004",
      "date": "2024-04-18",
      "provider": "Radiology Associates",
      "service": "Chest X-Ray",
      "amount": 280.00,
      "covered": 224.00,
      "copay": 0.00,
      "deductible": 56.00,
      "status": "Denied",
      "processedDate": "2024-04-22",
      "diagnosis": "Z87.891 - Personal history of nicotine dependence"
    },
    {
      "id": "CLM-2024-005",
      "date": "2024-05-02",
      "provider": "Wellness Lab",
      "service": "Blood Work Panel",
      "amount": 180.00,
      "covered": 180.00,
      "copay": 0.00,
      "deductible": 0.00,
      "status": "Paid",
      "processedDate": "2024-05-05",
      "diagnosis": "Z00.00 - Routine health examination"
    },
    {
      "id": "CLM-2024-006",
      "date": "2024-05-15",
      "provider": "Urgent Care Plus",
      "service": "Urgent Care Visit",
      "amount": 320.00,
      "covered": 240.00,
      "copay": 35.00,
      "deductible": 45.00,
      "status": "Pending",
      "processedDate": null,
      "diagnosis": "J06.9 - Acute upper respiratory infection"
    }
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Denied", "value": "Denied"},
  ];

  List<Map<String, dynamic>> yearItems = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
  ];

  List<Map<String, dynamic>> get filteredClaims {
    return claims.where((claim) {
      bool statusMatch = selectedStatus == "All" || claim["status"] == selectedStatus;
      bool yearMatch = claim["date"].toString().startsWith(selectedYear);
      return statusMatch && yearMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double totalClaimed = filteredClaims.fold(0.0, (sum, claim) => sum + (claim["amount"] as double));
    double totalCovered = filteredClaims.fold(0.0, (sum, claim) => sum + (claim["covered"] as double));
    double totalPaid = filteredClaims.where((c) => c["status"] == "Paid").fold(0.0, (sum, claim) => sum + (claim["covered"] as double));
    int pendingCount = filteredClaims.where((c) => c["status"] == "Pending" || c["status"] == "Processing").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Claims History"),
        actions: [
          QButton(
            icon: Icons.file_download,
            size: bs.sm,
            onPressed: () {
              ss("Downloading claims report...");
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard("Total Claimed", "\$${totalClaimed.toStringAsFixed(0)}", primaryColor, Icons.receipt),
                _buildSummaryCard("Total Covered", "\$${totalCovered.toStringAsFixed(0)}", successColor, Icons.check_circle),
                _buildSummaryCard("Total Paid", "\$${totalPaid.toStringAsFixed(0)}", infoColor, Icons.payment),
                _buildSummaryCard("Pending Claims", "$pendingCount", warningColor, Icons.pending),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Year",
                    items: yearItems,
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Claims List Header
            Row(
              children: [
                Text(
                  "Claims (${filteredClaims.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "New Claim",
                  size: bs.sm,
                  onPressed: () {
                    ss("Filing new claim...");
                  },
                ),
              ],
            ),

            // Claims List
            Column(
              spacing: spSm,
              children: filteredClaims.map((claim) {
                Color statusColor = claim["status"] == "Paid" ? successColor :
                                  claim["status"] == "Processing" ? infoColor :
                                  claim["status"] == "Pending" ? warningColor : dangerColor;

                return Container(
                  padding: EdgeInsets.all(spSm),
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
                    children: [
                      // Claim Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${claim["id"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${claim["provider"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${claim["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Service and Date
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.medical_services, size: 16, color: primaryColor),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${claim["service"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: primaryColor),
                                SizedBox(width: spSm),
                                Text(
                                  "Service Date: ${claim["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            if (claim["processedDate"] != null) ...[
                              Row(
                                children: [
                                  Icon(Icons.check, size: 16, color: primaryColor),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Processed: ${claim["processedDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Financial Breakdown
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAmountItem("Billed Amount", (claim["amount"] as double), primaryColor),
                                ),
                                Expanded(
                                  child: _buildAmountItem("Covered", (claim["covered"] as double), successColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAmountItem("Copay", (claim["copay"] as double), warningColor),
                                ),
                                Expanded(
                                  child: _buildAmountItem("Deductible", (claim["deductible"] as double), infoColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Diagnosis
                      if (claim["diagnosis"] != null) ...[
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Diagnosis: ${claim["diagnosis"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: spSm),

                      // Actions
                      Row(
                        children: [
                          Spacer(),
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              ss("Viewing claim details for ${claim["id"]}");
                            },
                          ),
                          SizedBox(width: spSm),
                          if (claim["status"] == "Denied") ...[
                            QButton(
                              label: "Appeal",
                              size: bs.sm,
                              onPressed: () {
                                ss("Starting appeal process...");
                              },
                            ),
                            SizedBox(width: spSm),
                          ],
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more options
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Load More Button (if needed)
            if (filteredClaims.length >= 10) ...[
              Center(
                child: QButton(
                  label: "Load More Claims",
                  size: bs.sm,
                  onPressed: () {
                    ss("Loading more claims...");
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAmountItem(String label, double amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
