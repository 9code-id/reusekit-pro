import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaClaimsView extends StatefulWidget {
  const BfaClaimsView({super.key});

  @override
  State<BfaClaimsView> createState() => _BfaClaimsViewState();
}

class _BfaClaimsViewState extends State<BfaClaimsView> {
  int currentTab = 0;
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> claims = [
    {
      "id": "CLM-2024-001",
      "type": "Auto Insurance",
      "description": "Minor collision damage to rear bumper",
      "dateSubmitted": "2024-01-15",
      "status": "approved",
      "claimAmount": 2500.0,
      "approvedAmount": 2200.0,
      "deductible": 500.0,
      "payoutAmount": 1700.0,
      "estimatedCompletion": "2024-01-25",
      "adjuster": "Sarah Johnson",
      "adjusterPhone": "(555) 123-4567",
      "icon": Icons.directions_car,
      "color": Colors.blue,
      "documents": [
        {"name": "Accident Report", "status": "submitted"},
        {"name": "Repair Estimate", "status": "approved"},
        {"name": "Photos", "status": "submitted"}
      ]
    },
    {
      "id": "CLM-2024-002",
      "type": "Health Insurance",
      "description": "Emergency room visit for chest pain",
      "dateSubmitted": "2024-02-03",
      "status": "processing",
      "claimAmount": 4200.0,
      "approvedAmount": 0.0,
      "deductible": 1000.0,
      "payoutAmount": 0.0,
      "estimatedCompletion": "2024-02-20",
      "adjuster": "Michael Chen",
      "adjusterPhone": "(555) 234-5678",
      "icon": Icons.local_hospital,
      "color": Colors.red,
      "documents": [
        {"name": "Medical Records", "status": "submitted"},
        {"name": "Hospital Bills", "status": "submitted"},
        {"name": "Insurance Card", "status": "approved"}
      ]
    },
    {
      "id": "CLM-2024-003",
      "type": "Travel Insurance",
      "description": "Trip cancellation due to illness",
      "dateSubmitted": "2024-01-28",
      "status": "denied",
      "claimAmount": 3500.0,
      "approvedAmount": 0.0,
      "deductible": 250.0,
      "payoutAmount": 0.0,
      "estimatedCompletion": "N/A",
      "adjuster": "Emma Rodriguez",
      "adjusterPhone": "(555) 345-6789",
      "icon": Icons.flight,
      "color": Colors.orange,
      "documents": [
        {"name": "Medical Certificate", "status": "insufficient"},
        {"name": "Trip Receipts", "status": "submitted"},
        {"name": "Cancellation Notice", "status": "submitted"}
      ],
      "denialReason": "Pre-existing condition not covered under policy terms"
    },
    {
      "id": "CLM-2023-089",
      "type": "Home Insurance",
      "description": "Water damage from burst pipe",
      "dateSubmitted": "2023-12-10",
      "status": "settled",
      "claimAmount": 8500.0,
      "approvedAmount": 7800.0,
      "deductible": 1000.0,
      "payoutAmount": 6800.0,
      "estimatedCompletion": "2023-12-28",
      "adjuster": "David Kim",
      "adjusterPhone": "(555) 456-7890",
      "icon": Icons.home,
      "color": Colors.green,
      "documents": [
        {"name": "Damage Photos", "status": "approved"},
        {"name": "Plumber Report", "status": "approved"},
        {"name": "Repair Invoices", "status": "approved"}
      ]
    }
  ];

  List<String> statusFilters = ["all", "processing", "approved", "denied", "settled"];

  List<Map<String, dynamic>> get filteredClaims {
    if (selectedStatus == "all") {
      return claims;
    }
    return claims.where((claim) => claim["status"] == selectedStatus).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "processing":
        return warningColor;
      case "denied":
        return dangerColor;
      case "settled":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "approved":
        return "Approved";
      case "processing":
        return "Processing";
      case "denied":
        return "Denied";
      case "settled":
        return "Settled";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Insurance Claims",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Claims", icon: Icon(Icons.assignment)),
        Tab(text: "File New", icon: Icon(Icons.add_circle)),
        Tab(text: "Help", icon: Icon(Icons.help)),
      ],
      tabChildren: [
        // My Claims Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${claims.where((c) => c["status"] == "approved" || c["status"] == "settled").length}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Approved",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: warningColor.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${claims.where((c) => c["status"] == "processing").length}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Processing",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Filter Section
              Row(
                children: [
                  Text(
                    "Filter by Status:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QHorizontalScroll(
                      children: statusFilters.map((status) {
                        final isSelected = selectedStatus == status;
                        return GestureDetector(
                          onTap: () {
                            selectedStatus = status;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.grey[100],
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              status == "all" ? "All" : getStatusText(status),
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Claims List
              Text(
                "Claims (${filteredClaims.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              if (filteredClaims.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 48,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Claims Found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "No claims match the selected filter criteria",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...filteredClaims.map((claim) {
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
                          color: getStatusColor(claim["status"] as String),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (claim["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                claim["icon"] as IconData,
                                color: claim["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${claim["id"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: getStatusColor(claim["status"] as String),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          getStatusText(claim["status"] as String),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
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
                                      color: claim["color"] as Color,
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
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Claim Details
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Claim Amount",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${((claim["claimAmount"] as double).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
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
                                          "Deductible",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${((claim["deductible"] as double).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((claim["payoutAmount"] as double) > 0)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Payout",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${((claim["payoutAmount"] as double).toDouble()).currency}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Submitted: ${DateTime.parse(claim["dateSubmitted"] as String).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (claim["estimatedCompletion"] != "N/A") ...[
                                    SizedBox(width: spMd),
                                    Icon(
                                      Icons.schedule,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Est. completion: ${DateTime.parse(claim["estimatedCompletion"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: spMd),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // Show claim details
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.phone,
                                  color: primaryColor,
                                  size: 18,
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.all(spXs),
                                constraints: BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.email,
                                  color: primaryColor,
                                  size: 18,
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.all(spXs),
                                constraints: BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Denial Reason (if applicable)
                        if (claim["status"] == "denied" && claim.containsKey("denialReason")) ...[
                          SizedBox(height: spMd),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: dangerColor.withAlpha(100)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "Denial Reason: ${claim["denialReason"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),

        // File New Claim Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "File a New Claim",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Start your claim process quickly and easily",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Claim Types
              Text(
                "Select Claim Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  {
                    "title": "Auto Insurance",
                    "description": "Vehicle accidents, theft, damage",
                    "icon": Icons.directions_car,
                    "color": Colors.blue,
                    "avgTime": "3-5 days"
                  },
                  {
                    "title": "Health Insurance",
                    "description": "Medical expenses, hospital bills",
                    "icon": Icons.local_hospital,
                    "color": Colors.red,
                    "avgTime": "7-10 days"
                  },
                  {
                    "title": "Home Insurance",
                    "description": "Property damage, theft, disasters",
                    "icon": Icons.home,
                    "color": Colors.green,
                    "avgTime": "5-7 days"
                  },
                  {
                    "title": "Travel Insurance",
                    "description": "Trip cancellation, medical abroad",
                    "icon": Icons.flight,
                    "color": Colors.orange,
                    "avgTime": "2-3 days"
                  },
                  {
                    "title": "Life Insurance",
                    "description": "Beneficiary claims, payouts",
                    "icon": Icons.favorite,
                    "color": Colors.purple,
                    "avgTime": "10-14 days"
                  },
                  {
                    "title": "Business Insurance",
                    "description": "Commercial property, liability",
                    "icon": Icons.business,
                    "color": Colors.teal,
                    "avgTime": "7-14 days"
                  },
                ].map((claimType) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to specific claim form
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: (claimType["color"] as Color).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  claimType["icon"] as IconData,
                                  color: claimType["color"] as Color,
                                  size: 28,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: (claimType["color"] as Color).withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Avg ${claimType["avgTime"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: claimType["color"] as Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "${claimType["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${claimType["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Start Claim",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: spLg),

              // Quick Tips
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Quick Tips for Filing Claims",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    ...["Have your policy number ready", 
                        "Take photos of any damage", 
                        "Keep all receipts and documentation",
                        "Report incidents as soon as possible",
                        "Be honest and accurate in your description"].map((tip) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                tip,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Help Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Claims Help & Support",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Get assistance with your insurance claims",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Contact Options
              Text(
                "Contact Support",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.phone,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "24/7 Claims Hotline",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "1-800-CLAIMS-1 (1-800-252-4671)",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Call Now",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    
                    Divider(height: spLg),
                    
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.chat,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Live Chat Support",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Available Mon-Fri 8AM-8PM EST",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Start Chat",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // FAQ
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...[
                {
                  "question": "How long does claim processing take?",
                  "answer": "Most claims are processed within 3-14 business days depending on the type and complexity."
                },
                {
                  "question": "What documents do I need to file a claim?",
                  "answer": "Policy number, incident details, photos of damage, receipts, and any relevant reports."
                },
                {
                  "question": "Can I track my claim status?",
                  "answer": "Yes, you can track your claim status in real-time through this app or our website."
                },
                {
                  "question": "What if my claim is denied?",
                  "answer": "You can appeal the decision by providing additional documentation or contacting our appeals department."
                }
              ].map((faq) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${faq["question"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${faq["answer"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
