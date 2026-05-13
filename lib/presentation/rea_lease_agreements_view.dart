import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLeaseAgreementsView extends StatefulWidget {
  const ReaLeaseAgreementsView({super.key});

  @override
  State<ReaLeaseAgreementsView> createState() => _ReaLeaseAgreementsViewState();
}

class _ReaLeaseAgreementsViewState extends State<ReaLeaseAgreementsView> {
  String searchQuery = "";
  String filterStatus = "all";
  String filterType = "all";
  
  List<Map<String, dynamic>> leaseAgreements = [
    {
      "id": "LA001",
      "tenantName": "John Smith",
      "tenantEmail": "john.smith@email.com",
      "tenantPhone": "+1 234-567-8901",
      "propertyName": "Downtown Apartment 2A",
      "propertyAddress": "123 Main St, Downtown",
      "propertyImage": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "leaseType": "Residential",
      "status": "active",
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "monthlyRent": 1200.0,
      "securityDeposit": 2400.0,
      "leaseTerm": 12,
      "renewalOption": true,
      "furnished": false,
      "petsAllowed": false,
      "smokingAllowed": false,
      "documentUrl": "https://example.com/lease-la001.pdf",
      "signedDate": "2023-12-15",
      "clauses": [
        "Rent due on 1st of each month",
        "24-hour notice required for entry",
        "No subletting without written consent"
      ]
    },
    {
      "id": "LA002",
      "tenantName": "Sarah Johnson",
      "tenantEmail": "sarah.johnson@email.com",
      "tenantPhone": "+1 234-567-8902",
      "propertyName": "Sunset Villa Unit B",
      "propertyAddress": "456 Oak Ave, Sunset District",
      "propertyImage": "https://picsum.photos/300/200?random=2&keyword=villa",
      "leaseType": "Residential",
      "status": "expiring",
      "startDate": "2023-02-01",
      "endDate": "2024-01-31",
      "monthlyRent": 1800.0,
      "securityDeposit": 3600.0,
      "leaseTerm": 12,
      "renewalOption": true,
      "furnished": true,
      "petsAllowed": true,
      "smokingAllowed": false,
      "documentUrl": "https://example.com/lease-la002.pdf",
      "signedDate": "2023-01-15",
      "clauses": [
        "Pet deposit of \$500 required",
        "Furnished items inventory attached",
        "Utilities included in rent"
      ]
    },
    {
      "id": "LA003",
      "tenantName": "Mike Wilson",
      "tenantEmail": "mike.wilson@email.com",
      "tenantPhone": "+1 234-567-8903",
      "propertyName": "City Center Studio",
      "propertyAddress": "789 Center St, City Center",
      "propertyImage": "https://picsum.photos/300/200?random=3&keyword=studio",
      "leaseType": "Residential",
      "status": "draft",
      "startDate": "2024-02-01",
      "endDate": "2025-01-31",
      "monthlyRent": 900.0,
      "securityDeposit": 1800.0,
      "leaseTerm": 12,
      "renewalOption": false,
      "furnished": false,
      "petsAllowed": false,
      "smokingAllowed": false,
      "documentUrl": null,
      "signedDate": null,
      "clauses": [
        "Studio apartment with kitchenette",
        "Shared laundry facilities",
        "Parking space not included"
      ]
    },
    {
      "id": "LA004",
      "tenantName": "Global Tech Solutions",
      "tenantEmail": "admin@globaltech.com",
      "tenantPhone": "+1 234-567-8904",
      "propertyName": "Business Plaza Office 301",
      "propertyAddress": "321 Business Blvd, Financial District",
      "propertyImage": "https://picsum.photos/300/200?random=4&keyword=office",
      "leaseType": "Commercial",
      "status": "active",
      "startDate": "2023-06-01",
      "endDate": "2026-05-31",
      "monthlyRent": 3500.0,
      "securityDeposit": 10500.0,
      "leaseTerm": 36,
      "renewalOption": true,
      "furnished": false,
      "petsAllowed": false,
      "smokingAllowed": false,
      "documentUrl": "https://example.com/lease-la004.pdf",
      "signedDate": "2023-05-15",
      "clauses": [
        "Commercial use only",
        "Tenant responsible for utilities",
        "Business hours: 6 AM - 10 PM"
      ]
    },
    {
      "id": "LA005",
      "tenantName": "Emma Davis",
      "tenantEmail": "emma.davis@email.com",
      "tenantPhone": "+1 234-567-8905",
      "propertyName": "Garden View Condo",
      "propertyAddress": "654 Garden Way, Westside",
      "propertyImage": "https://picsum.photos/300/200?random=5&keyword=condo",
      "leaseType": "Residential",
      "status": "terminated",
      "startDate": "2022-03-01",
      "endDate": "2023-02-28",
      "monthlyRent": 1500.0,
      "securityDeposit": 3000.0,
      "leaseTerm": 12,
      "renewalOption": false,
      "furnished": true,
      "petsAllowed": true,
      "smokingAllowed": false,
      "documentUrl": "https://example.com/lease-la005.pdf",
      "signedDate": "2022-02-15",
      "clauses": [
        "Early termination by mutual consent",
        "Security deposit fully refunded",
        "Property condition excellent"
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredAgreements {
    List<Map<String, dynamic>> filtered = leaseAgreements;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((agreement) {
        return (agreement["tenantName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (agreement["propertyName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (agreement["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (filterStatus != "all") {
      filtered = filtered.where((agreement) => agreement["status"] == filterStatus).toList();
    }
    
    if (filterType != "all") {
      filtered = filtered.where((agreement) => agreement["leaseType"].toString().toLowerCase() == filterType).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "expiring":
        return warningColor;
      case "draft":
        return infoColor;
      case "terminated":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "expiring":
        return "Expiring Soon";
      case "draft":
        return "Draft";
      case "terminated":
        return "Terminated";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lease Agreements"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search lease agreements...",
                    value: searchQuery,
                    hint: "Search by tenant, property, or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Active Leases",
                  "${leaseAgreements.where((l) => l["status"] == "active").length}",
                  Icons.assignment_turned_in,
                  successColor,
                ),
                _buildSummaryCard(
                  "Expiring Soon",
                  "${leaseAgreements.where((l) => l["status"] == "expiring").length}",
                  Icons.warning,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Draft Leases",
                  "${leaseAgreements.where((l) => l["status"] == "draft").length}",
                  Icons.drafts,
                  infoColor,
                ),
                _buildSummaryCard(
                  "Monthly Revenue",
                  "\$${leaseAgreements.where((l) => l["status"] == "active").fold(0.0, (sum, l) => sum + (l["monthlyRent"] as double)).toStringAsFixed(0)}",
                  Icons.attach_money,
                  primaryColor,
                ),
              ],
            ),

            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    label: "Status",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Expiring", "value": "expiring"},
                      {"label": "Draft", "value": "draft"},
                      {"label": "Terminated", "value": "terminated"},
                    ],
                    value: filterStatus,
                    onChanged: (index, label, value, item) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    label: "Type",
                    items: const [
                      {"label": "All", "value": "all"},
                      {"label": "Residential", "value": "residential"},
                      {"label": "Commercial", "value": "commercial"},
                    ],
                    value: filterType,
                    onChanged: (index, label, value, item) {
                      filterType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Lease Agreements List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(Icons.assignment, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Lease Agreements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredAgreements.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final agreement = filteredAgreements[index];
                      return _buildLeaseAgreementItem(agreement);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateLeaseDialog();
        },
        child: Icon(Icons.add),
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
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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

  Widget _buildLeaseAgreementItem(Map<String, dynamic> agreement) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Property Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${agreement["propertyImage"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              
              // Agreement Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${agreement["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(agreement["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getStatusLabel(agreement["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(agreement["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${agreement["tenantName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${agreement["propertyName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Lease Type Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${agreement["leaseType"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Lease Terms
          Row(
            children: [
              Icon(Icons.attach_money, size: 16, color: successColor),
              SizedBox(width: spXs),
              Text(
                "\$${(agreement["monthlyRent"] as double).toStringAsFixed(0)}/month",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.calendar_today, size: 16, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "${agreement["leaseTerm"]} months",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.date_range, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(agreement["startDate"]).dMMMy} - ${DateTime.parse(agreement["endDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Features
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: [
              if (agreement["furnished"] as bool)
                _buildFeatureChip("Furnished", Icons.chair),
              if (agreement["petsAllowed"] as bool)
                _buildFeatureChip("Pets Allowed", Icons.pets),
              if (agreement["renewalOption"] as bool)
                _buildFeatureChip("Renewable", Icons.refresh),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showLeaseDetailDialog(agreement);
                },
              ),
              SizedBox(width: spSm),
              if (agreement["documentUrl"] != null) ...[
                QButton(
                  label: "Download",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Document download started");
                  },
                ),
                SizedBox(width: spSm),
              ],
              if (agreement["status"] == "draft") ...[
                QButton(
                  label: "Send for Signing",
                  size: bs.sm,
                  onPressed: () {
                    _showSendForSigningDialog(agreement);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, IconData icon) {
    return Container(
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
          Icon(icon, size: 14, color: infoColor),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Apply Filters",
              onPressed: () {
                back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateLeaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Lease Agreement"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Create a new lease agreement"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => back(),
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showLeaseDetailDialog(Map<String, dynamic> agreement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Lease Agreement Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tenant: ${agreement["tenantName"]}"),
            Text("Property: ${agreement["propertyName"]}"),
            Text("Monthly Rent: \$${(agreement["monthlyRent"] as double).toStringAsFixed(0)}"),
            Text("Security Deposit: \$${(agreement["securityDeposit"] as double).toStringAsFixed(0)}"),
            Text("Lease Term: ${agreement["leaseTerm"]} months"),
            if (agreement["signedDate"] != null) ...[
              SizedBox(height: spSm),
              Text("Signed: ${DateTime.parse(agreement["signedDate"]).dMMMy}"),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showSendForSigningDialog(Map<String, dynamic> agreement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Send for Signing"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Send lease agreement to ${agreement["tenantName"]} for digital signing?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Lease agreement sent for signing");
            },
            child: Text("Send"),
          ),
        ],
      ),
    );
  }
}
