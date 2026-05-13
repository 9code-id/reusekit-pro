import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCropInsuranceView extends StatefulWidget {
  const AmaCropInsuranceView({super.key});

  @override
  State<AmaCropInsuranceView> createState() => _AmaCropInsuranceViewState();
}

class _AmaCropInsuranceViewState extends State<AmaCropInsuranceView> {
  int selectedTab = 0;
  String selectedPolicy = "";
  String selectedStatus = "all";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Policies", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Expired", "value": "expired"},
    {"label": "Claimed", "value": "claimed"},
  ];

  List<Map<String, dynamic>> insurancePolicies = [
    {
      "id": "POL001",
      "cropType": "Corn",
      "policyType": "Multi-Peril Crop Insurance",
      "coverage": 75000.0,
      "premium": 3500.0,
      "status": "active",
      "startDate": "2024-03-01",
      "endDate": "2024-11-30",
      "acres": 50,
      "riskLevel": "Medium",
      "provider": "AgriSure Insurance",
      "deductible": 5000.0,
    },
    {
      "id": "POL002",
      "cropType": "Wheat",
      "policyType": "Crop Revenue Coverage",
      "coverage": 45000.0,
      "premium": 2100.0,
      "status": "active",
      "startDate": "2024-04-15",
      "endDate": "2024-09-30",
      "acres": 30,
      "riskLevel": "Low",
      "provider": "FarmGuard Insurance",
      "deductible": 3000.0,
    },
    {
      "id": "POL003",
      "cropType": "Soybeans",
      "policyType": "Actual Production History",
      "coverage": 35000.0,
      "premium": 1800.0,
      "status": "pending",
      "startDate": "2024-05-01",
      "endDate": "2024-10-31",
      "acres": 25,
      "riskLevel": "High",
      "provider": "CropSafe Solutions",
      "deductible": 2500.0,
    },
    {
      "id": "POL004",
      "cropType": "Rice",
      "policyType": "Whole Farm Revenue Protection",
      "coverage": 60000.0,
      "premium": 2800.0,
      "status": "expired",
      "startDate": "2023-06-01",
      "endDate": "2023-12-31",
      "acres": 40,
      "riskLevel": "Medium",
      "provider": "AgriSure Insurance",
      "deductible": 4000.0,
    },
  ];

  List<Map<String, dynamic>> availablePlans = [
    {
      "name": "Basic Crop Protection",
      "coverage": "50% of production value",
      "premium": "2.5% of coverage",
      "features": ["Weather protection", "Basic crop loss", "Fire coverage"],
      "riskTypes": ["Drought", "Flood", "Fire"],
      "deductible": "5% of coverage",
    },
    {
      "name": "Comprehensive Coverage",
      "coverage": "75% of production value",
      "premium": "4.2% of coverage",
      "features": ["Full weather protection", "Disease coverage", "Pest damage", "Market price protection"],
      "riskTypes": ["All weather risks", "Plant diseases", "Pest damage", "Market fluctuations"],
      "deductible": "3% of coverage",
    },
    {
      "name": "Premium Protection Plus",
      "coverage": "90% of production value",
      "premium": "6.8% of coverage",
      "features": ["Maximum protection", "Quality loss coverage", "Replanting coverage", "Prevented planting"],
      "riskTypes": ["All covered risks", "Quality degradation", "Replanting costs"],
      "deductible": "2% of coverage",
    },
  ];

  List<Map<String, dynamic>> claimsHistory = [
    {
      "claimId": "CLM001",
      "policyId": "POL001",
      "cropType": "Corn",
      "claimType": "Drought Damage",
      "claimDate": "2024-07-15",
      "claimAmount": 12000.0,
      "status": "approved",
      "payoutAmount": 10800.0,
      "assessmentDate": "2024-07-20",
    },
    {
      "claimId": "CLM002",
      "policyId": "POL002",
      "claimType": "Hail Damage",
      "claimDate": "2024-06-10",
      "claimAmount": 8500.0,
      "status": "processing",
      "payoutAmount": 0.0,
      "assessmentDate": "2024-06-15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Crop Insurance",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "My Policies", icon: Icon(Icons.shield)),
        Tab(text: "Available Plans", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Claims", icon: Icon(Icons.assignment)),
        Tab(text: "Coverage Calculator", icon: Icon(Icons.calculate)),
      ],
      tabChildren: [
        _buildMyPoliciesTab(),
        _buildAvailablePlansTab(),
        _buildClaimsTab(),
        _buildCalculatorTab(),
      ],
    );
  }

  Widget _buildMyPoliciesTab() {
    List<Map<String, dynamic>> filteredPolicies = insurancePolicies.where((policy) {
      if (selectedStatus == "all") return true;
      return policy["status"] == selectedStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QDropdownField(
                  label: "Filter by Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Active Policies",
                  "${insurancePolicies.where((p) => p["status"] == "active").length}",
                  successColor,
                  Icons.shield_outlined,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Total Coverage",
                  "\$${insurancePolicies.where((p) => p["status"] == "active").fold(0.0, (sum, p) => sum + (p["coverage"] as double)).toStringAsFixed(0)}",
                  primaryColor,
                  Icons.security,
                ),
              ),
            ],
          ),

          // Policies List
          ...filteredPolicies.map((policy) {
            Color statusColor = _getStatusColor(policy["status"]);
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
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${policy["cropType"]} Insurance",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Policy #${policy["id"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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
                          "${policy["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${policy["policyType"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Coverage Amount:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(policy["coverage"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Annual Premium:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(policy["premium"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Covered Acres:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${policy["acres"]} acres",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Deductible:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(policy["deductible"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
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
                            // Navigate to policy details
                          },
                        ),
                      ),
                      if (policy["status"] == "active") ...[
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "File Claim",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to claim filing
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAvailablePlansTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Choose the right insurance plan to protect your crops and secure your farming investment.",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),

          // Available Plans
          ...availablePlans.map((plan) {
            return Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${plan["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${plan["coverage"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Premium Rate:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${plan["premium"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Deductible:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${plan["deductible"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Covered Risks:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (plan["riskTypes"] as List<String>).map((risk) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          risk,
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text(
                    "Key Features:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  ...(plan["features"] as List<String>).map((feature) {
                    return Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  QButton(
                    label: "Get Quote",
                    onPressed: () {
                      si("Generating insurance quote...");
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildClaimsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "File New Claim",
                  icon: Icons.add,
                  onPressed: () {
                    // Navigate to claim filing
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Track Claims",
                  icon: Icons.track_changes,
                  onPressed: () {
                    // Navigate to claim tracking
                  },
                ),
              ),
            ],
          ),

          // Claims Summary
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Total Claims",
                  "${claimsHistory.length}",
                  primaryColor,
                  Icons.assignment,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Approved Amount",
                  "\$${claimsHistory.where((c) => c["status"] == "approved").fold(0.0, (sum, c) => sum + (c["payoutAmount"] as double)).toStringAsFixed(0)}",
                  successColor,
                  Icons.payment,
                ),
              ),
            ],
          ),

          // Claims History
          ...claimsHistory.map((claim) {
            Color statusColor = _getClaimStatusColor(claim["status"]);
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
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Claim #${claim["claimId"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${claim["claimType"]} - ${claim["cropType"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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
                          "${claim["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Claim Date:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "${claim["claimDate"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Claim Amount:", style: TextStyle(color: disabledBoldColor)),
                            Text(
                              "\$${(claim["claimAmount"] as double).toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        if (claim["status"] == "approved")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payout Amount:", style: TextStyle(color: disabledBoldColor)),
                              Text(
                                "\$${(claim["payoutAmount"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to claim details
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                Text(
                  "Coverage Calculator",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Calculate the optimal insurance coverage for your crops",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                // Calculator form would go here
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Coverage calculator functionality will be implemented based on crop type, farm size, historical yields, and market prices.",
                    style: TextStyle(color: infoColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "expired":
        return dangerColor;
      case "claimed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getClaimStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "processing":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
