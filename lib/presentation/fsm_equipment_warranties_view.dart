import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEquipmentWarrantiesView extends StatefulWidget {
  const FsmEquipmentWarrantiesView({super.key});

  @override
  State<FsmEquipmentWarrantiesView> createState() => _FsmEquipmentWarrantiesViewState();
}

class _FsmEquipmentWarrantiesViewState extends State<FsmEquipmentWarrantiesView> {
  List<Map<String, dynamic>> warranties = [
    {
      "id": "WR001",
      "equipmentId": "EQ001",
      "equipmentName": "Industrial Generator Model X200",
      "warrantyType": "Full Coverage",
      "startDate": "2024-01-15",
      "endDate": "2026-01-15",
      "daysRemaining": 574,
      "status": "Active",
      "provider": "PowerTech Industries",
      "contactPerson": "James Wilson",
      "contactPhone": "+1-555-0123",
      "contactEmail": "warranty@powertech.com",
      "terms": "Full parts and labor coverage including emergency service",
      "coverage": ["Parts", "Labor", "Emergency Service", "Remote Diagnostics"],
      "value": 2500.0,
      "claimsUsed": 1,
      "claimsLimit": 5,
      "image": "https://picsum.photos/80/80?random=1&keyword=generator"
    },
    {
      "id": "WR002",
      "equipmentId": "EQ002",
      "equipmentName": "HVAC System Pro Series 500",
      "warrantyType": "Extended Warranty",
      "startDate": "2024-02-10",
      "endDate": "2027-02-10",
      "daysRemaining": 970,
      "status": "Active",
      "provider": "Climate Solutions Corp",
      "contactPerson": "Maria Rodriguez",
      "contactPhone": "+1-555-0456",
      "contactEmail": "support@climatesolutions.com",
      "terms": "Extended coverage with priority service response",
      "coverage": ["Parts", "Labor", "Annual Maintenance", "Priority Service"],
      "value": 3200.0,
      "claimsUsed": 2,
      "claimsLimit": 8,
      "image": "https://picsum.photos/80/80?random=2&keyword=hvac"
    },
    {
      "id": "WR003",
      "equipmentId": "EQ003",
      "warrantyName": "Fire Safety System v3.1",
      "warrantyType": "Manufacturer Warranty",
      "startDate": "2024-03-05",
      "endDate": "2029-03-05",
      "daysRemaining": 1728,
      "status": "Active",
      "provider": "SafeTech Systems",
      "contactPerson": "Robert Kim",
      "contactPhone": "+1-555-0789",
      "contactEmail": "warranty@safetech.com",
      "terms": "5-year comprehensive warranty with annual inspections",
      "coverage": ["Parts", "Labor", "Annual Inspections", "Software Updates"],
      "value": 1800.0,
      "claimsUsed": 0,
      "claimsLimit": 3,
      "image": "https://picsum.photos/80/80?random=3&keyword=safety"
    },
    {
      "id": "WR004",
      "equipmentId": "EQ004",
      "equipmentName": "Conveyor Belt System MK4",
      "warrantyType": "Limited Warranty",
      "startDate": "2023-11-20",
      "endDate": "2025-11-20",
      "daysRemaining": 519,
      "status": "Expiring Soon",
      "provider": "Industrial Motion Ltd",
      "contactPerson": "David Chen",
      "contactPhone": "+1-555-0321",
      "contactEmail": "service@industrialmotion.com",
      "terms": "Parts only warranty excluding wear items",
      "coverage": ["Parts", "Technical Support"],
      "value": 1200.0,
      "claimsUsed": 3,
      "claimsLimit": 4,
      "image": "https://picsum.photos/80/80?random=4&keyword=conveyor"
    },
    {
      "id": "WR005",
      "equipmentId": "EQ005",
      "equipmentName": "Security Camera Network HD",
      "warrantyType": "Full Coverage",
      "startDate": "2024-04-12",
      "endDate": "2026-04-12",
      "daysRemaining": 661,
      "status": "Active",
      "provider": "SecureVision Technologies",
      "contactPerson": "Lisa Wang",
      "contactPhone": "+1-555-0654",
      "contactEmail": "warranty@securevision.com",
      "terms": "Complete system warranty with remote monitoring",
      "coverage": ["Hardware", "Software", "Remote Monitoring", "Replacement Units"],
      "value": 1500.0,
      "claimsUsed": 1,
      "claimsLimit": 6,
      "image": "https://picsum.photos/80/80?random=5&keyword=camera"
    }
  ];

  List<Map<String, dynamic>> filteredWarranties = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Full Coverage", "value": "Full Coverage"},
    {"label": "Extended Warranty", "value": "Extended Warranty"},
    {"label": "Manufacturer Warranty", "value": "Manufacturer Warranty"},
    {"label": "Limited Warranty", "value": "Limited Warranty"},
  ];

  @override
  void initState() {
    super.initState();
    filteredWarranties = warranties;
  }

  void _filterWarranties() {
    filteredWarranties = warranties.where((warranty) {
      bool matchesSearch = warranty["equipmentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          warranty["provider"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          warranty["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || warranty["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || warranty["warrantyType"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expiring Soon":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "Suspended":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case "Active":
        return "✓";
      case "Expiring Soon":
        return "⚠";
      case "Expired":
        return "✗";
      case "Suspended":
        return "⏸";
      default:
        return "?";
    }
  }

  Widget _buildWarrantyCard(Map<String, dynamic> warranty) {
    int daysRemaining = warranty["daysRemaining"] as int;
    int claimsUsed = warranty["claimsUsed"] as int;
    int claimsLimit = warranty["claimsLimit"] as int;
    double claimsPercentage = (claimsUsed / claimsLimit) * 100;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(warranty["status"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${warranty["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${warranty["equipmentName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${warranty["id"]} • ${warranty["warrantyType"]}",
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
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(warranty["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getStatusIcon(warranty["status"]),
                          style: TextStyle(
                            fontSize: 10,
                            color: _getStatusColor(warranty["status"]),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${warranty["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: _getStatusColor(warranty["status"]),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "$daysRemaining days left",
                    style: TextStyle(
                      fontSize: 10,
                      color: daysRemaining < 90 ? dangerColor : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Provider: ${warranty["provider"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${warranty["terms"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Start Date", "${warranty["startDate"]}", Icons.play_arrow),
              ),
              Expanded(
                child: _buildInfoItem("End Date", "${warranty["endDate"]}", Icons.stop),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Contact", "${warranty["contactPerson"]}", Icons.person),
              ),
              Expanded(
                child: _buildInfoItem("Value", "\$${(warranty["value"] as double).currency}", Icons.attach_money),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: claimsPercentage > 75 ? dangerColor.withAlpha(10) : successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Claims Used",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: claimsPercentage > 75 ? dangerColor : successColor,
                      ),
                    ),
                    Text(
                      "$claimsUsed / $claimsLimit",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: claimsPercentage > 75 ? dangerColor : successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: claimsPercentage / 100,
                  backgroundColor: disabledColor.withAlpha(50),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    claimsPercentage > 75 ? dangerColor : successColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Coverage:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: 4),
          Wrap(
            spacing: spXs,
            runSpacing: 4,
            children: (warranty["coverage"] as List).map((coverage) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$coverage",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to warranty details
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Contact Provider",
                  size: bs.sm,
                  onPressed: () {
                    // Contact warranty provider
                  },
                ),
              ),
            ],
          ),
          if (warranty["status"] == "Expiring Soon") ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Renew Warranty",
                size: bs.sm,
                onPressed: () {
                  // Renew warranty
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    int totalWarranties = warranties.length;
    int activeWarranties = warranties.where((w) => w["status"] == "Active").length;
    int expiringSoon = warranties.where((w) => w["status"] == "Expiring Soon").length;
    double totalValue = warranties.fold(0.0, (sum, w) => sum + (w["value"] as double));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Warranties", "$totalWarranties", Icons.shield, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Active", "$activeWarranties", Icons.check_circle, successColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Expiring Soon", "$expiringSoon", Icons.warning, warningColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Total Value", "\$${totalValue.currency}", Icons.attach_money, infoColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
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
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment Warranties"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add warranty
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to warranty calendar
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Warranties",
                    value: searchQuery,
                    hint: "Search by equipment, provider, or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterWarranties();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      _filterWarranties();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Warranty Type",
                    items: typeItems,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      _filterWarranties();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Equipment Warranties (${filteredWarranties.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...filteredWarranties.map((warranty) => _buildWarrantyCard(warranty)).toList(),
          ],
        ),
      ),
    );
  }
}
