import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaInsuranceView extends StatefulWidget {
  const CmaInsuranceView({super.key});

  @override
  State<CmaInsuranceView> createState() => _CmaInsuranceViewState();
}

class _CmaInsuranceViewState extends State<CmaInsuranceView> {
  List<Map<String, dynamic>> insurancePolicies = [
    {
      "id": 1,
      "provider": "State Farm",
      "policy_number": "SF-987654321",
      "coverage_type": "Full Coverage",
      "premium": 1250.00,
      "deductible": 500.00,
      "start_date": "2024-01-15",
      "end_date": "2025-01-15",
      "status": "Active",
      "vehicle": "2022 Toyota Camry",
      "coverage_details": {
        "liability": 100000,
        "collision": 50000,
        "comprehensive": 50000,
        "uninsured_motorist": 25000
      }
    },
    {
      "id": 2,
      "provider": "Geico",
      "policy_number": "GC-123456789",
      "coverage_type": "Liability Only",
      "premium": 680.00,
      "deductible": 1000.00,
      "start_date": "2024-03-01",
      "end_date": "2025-03-01",
      "status": "Active",
      "vehicle": "2019 Honda Civic",
      "coverage_details": {
        "liability": 75000,
        "collision": 0,
        "comprehensive": 0,
        "uninsured_motorist": 15000
      }
    },
    {
      "id": 3,
      "provider": "Allstate",
      "policy_number": "AS-456789123",
      "coverage_type": "Full Coverage",
      "premium": 1450.00,
      "deductible": 250.00,
      "start_date": "2024-06-01",
      "end_date": "2025-06-01",
      "status": "Pending Renewal",
      "vehicle": "2023 Ford F-150",
      "coverage_details": {
        "liability": 150000,
        "collision": 75000,
        "comprehensive": 75000,
        "uninsured_motorist": 50000
      }
    }
  ];

  List<Map<String, dynamic>> insuranceClaims = [
    {
      "id": 1,
      "claim_number": "CLM-001-2024",
      "date": "2024-04-15",
      "type": "Collision",
      "status": "Approved",
      "amount": 3500.00,
      "description": "Rear-end collision at intersection",
      "policy_id": 1
    },
    {
      "id": 2,
      "claim_number": "CLM-002-2024",
      "date": "2024-08-22",
      "type": "Vandalism",
      "status": "Under Review",
      "amount": 1200.00,
      "description": "Scratched paint and broken mirror",
      "policy_id": 3
    }
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Insurance Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Policies", icon: Icon(Icons.policy)),
        Tab(text: "Claims", icon: Icon(Icons.assignment)),
        Tab(text: "Coverage", icon: Icon(Icons.shield)),
      ],
      tabChildren: [
        _buildPoliciesTab(),
        _buildClaimsTab(),
        _buildCoverageTab(),
      ],
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Active Policies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Policy",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showAddPolicyDialog();
                },
              ),
            ],
          ),

          ...insurancePolicies.map((policy) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: policy["status"] == "Active" ? successColor : warningColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${policy["provider"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: policy["status"] == "Active" ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${policy["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "Policy: ${policy["policy_number"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                Text(
                  "${policy["vehicle"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Annual Premium",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(policy["premium"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
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
                            "\$${(policy["deductible"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
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
                            "Expires",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(policy["end_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
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
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _showPolicyDetails(policy);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        _editPolicy(policy);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Insurance Claims",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "File Claim",
                icon: Icons.add_circle,
                size: bs.sm,
                onPressed: () {
                  _showFileClaimDialog();
                },
              ),
            ],
          ),

          ...insuranceClaims.map((claim) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getClaimStatusColor(claim["status"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${claim["claim_number"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getClaimStatusColor(claim["status"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${claim["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${claim["type"]} - ${DateTime.parse(claim["date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${claim["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
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
                            "\$${(claim["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Track Status",
                      size: bs.sm,
                      onPressed: () {
                        _trackClaimStatus(claim);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCoverageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Coverage Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...insurancePolicies.map((policy) => Container(
            margin: EdgeInsets.only(bottom: spMd),
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
                  "${policy["provider"]} - ${policy["vehicle"]}",
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
                      child: _buildCoverageItem(
                        "Liability",
                        "\$${((policy["coverage_details"]["liability"] as int).toDouble()).currency}",
                        Icons.security,
                      ),
                    ),
                    Expanded(
                      child: _buildCoverageItem(
                        "Collision",
                        policy["coverage_details"]["collision"] == 0 
                            ? "Not Covered" 
                            : "\$${((policy["coverage_details"]["collision"] as int).toDouble()).currency}",
                        Icons.car_crash,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildCoverageItem(
                        "Comprehensive",
                        policy["coverage_details"]["comprehensive"] == 0 
                            ? "Not Covered" 
                            : "\$${((policy["coverage_details"]["comprehensive"] as int).toDouble()).currency}",
                        Icons.shield,
                      ),
                    ),
                    Expanded(
                      child: _buildCoverageItem(
                        "Uninsured Motorist",
                        "\$${((policy["coverage_details"]["uninsured_motorist"] as int).toDouble()).currency}",
                        Icons.no_accounts,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCoverageItem(String title, String amount, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
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
          SizedBox(height: spXs),
          Text(
            amount,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: amount.contains("Not") ? dangerColor : primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getClaimStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Denied":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  void _showAddPolicyDialog() {
    si("Add new insurance policy feature coming soon");
  }

  void _showPolicyDetails(Map<String, dynamic> policy) {
    si("Viewing policy details for ${policy["provider"]}");
  }

  void _editPolicy(Map<String, dynamic> policy) {
    si("Editing policy ${policy["policy_number"]}");
  }

  void _showFileClaimDialog() {
    si("File new insurance claim feature coming soon");
  }

  void _trackClaimStatus(Map<String, dynamic> claim) {
    si("Tracking status for claim ${claim["claim_number"]}");
  }
}
