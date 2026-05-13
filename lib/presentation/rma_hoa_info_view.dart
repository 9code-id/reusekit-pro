import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaHoaInfoView extends StatefulWidget {
  const RmaHoaInfoView({super.key});

  @override
  State<RmaHoaInfoView> createState() => _RmaHoaInfoViewState();
}

class _RmaHoaInfoViewState extends State<RmaHoaInfoView> {
  String selectedTab = "overview";
  
  List<Map<String, dynamic>> tabOptions = [
    {"label": "Overview", "value": "overview"},
    {"label": "Fees", "value": "fees"},
    {"label": "Rules", "value": "rules"},
    {"label": "Amenities", "value": "amenities"},
    {"label": "Documents", "value": "documents"},
  ];
  
  Map<String, dynamic> hoaData = {
    "name": "Oakwood Hills Homeowners Association",
    "established": "1985",
    "total_units": 245,
    "monthly_fee": 285.00,
    "reserve_fund": 125000.00,
    "management_company": "Premier Property Management",
    "board_members": 7,
    "next_meeting": "2024-07-15",
    "fiscal_year_end": "December 31",
  };
  
  List<Map<String, dynamic>> feeStructure = [
    {
      "type": "Monthly HOA Fee",
      "amount": 285.00,
      "frequency": "Monthly",
      "due_date": "1st of each month",
      "includes": "Common area maintenance, landscaping, insurance",
    },
    {
      "type": "Special Assessment",
      "amount": 1500.00,
      "frequency": "One-time",
      "due_date": "August 1, 2024",
      "includes": "Roof replacement project",
    },
    {
      "type": "Transfer Fee",
      "amount": 250.00,
      "frequency": "Per sale",
      "due_date": "At closing",
      "includes": "Document preparation and review",
    },
    {
      "type": "Violation Fine",
      "amount": 50.00,
      "frequency": "Per violation",
      "due_date": "Within 30 days",
      "includes": "CC&R violations, architectural violations",
    },
  ];
  
  List<Map<String, dynamic>> rules = [
    {
      "category": "Architectural Guidelines",
      "rules": [
        "All exterior modifications require approval",
        "Paint colors must be from approved palette",
        "Fencing height limited to 6 feet",
        "No storage sheds without permit",
      ],
    },
    {
      "category": "Landscaping Requirements",
      "rules": [
        "Front yard must be maintained",
        "No artificial grass in front yards",
        "Tree removal requires approval",
        "Irrigation system maintenance required",
      ],
    },
    {
      "category": "Parking Regulations",
      "rules": [
        "Maximum 2 vehicles per driveway",
        "No commercial vehicles overnight",
        "Guest parking 72-hour limit",
        "No RV or boat parking on street",
      ],
    },
    {
      "category": "Pet Policy",
      "rules": [
        "Maximum 2 pets per household",
        "Dogs must be leashed in common areas",
        "Pet waste must be cleaned immediately",
        "No aggressive breed restrictions",
      ],
    },
  ];
  
  List<Map<String, dynamic>> amenities = [
    {
      "name": "Community Pool",
      "description": "Heated outdoor pool with spa",
      "hours": "6:00 AM - 10:00 PM",
      "icon": Icons.pool,
      "maintenance": "Regular cleaning and chemical treatment",
    },
    {
      "name": "Fitness Center",
      "description": "24/7 access with modern equipment",
      "hours": "24/7 (keycard access)",
      "icon": Icons.fitness_center,
      "maintenance": "Equipment serviced monthly",
    },
    {
      "name": "Tennis Court",
      "description": "Professional grade court with lighting",
      "hours": "6:00 AM - 11:00 PM",
      "icon": Icons.sports_tennis,
      "maintenance": "Surface resurfaced annually",
    },
    {
      "name": "Clubhouse",
      "description": "Event space for community gatherings",
      "hours": "Reservation required",
      "icon": Icons.home,
      "maintenance": "Cleaned weekly, renovated as needed",
    },
    {
      "name": "Playground",
      "description": "Children's play area with safety equipment",
      "hours": "Dawn to dusk",
      "icon": Icons.child_friendly,
      "maintenance": "Safety inspected monthly",
    },
  ];
  
  List<Map<String, dynamic>> documents = [
    {
      "name": "CC&Rs (Covenants, Conditions & Restrictions)",
      "type": "Legal Document",
      "last_updated": "2023-03-15",
      "icon": Icons.gavel,
      "description": "Governing rules and restrictions for the community",
    },
    {
      "name": "Bylaws",
      "type": "Governance",
      "last_updated": "2022-11-08",
      "icon": Icons.rule,
      "description": "HOA board operations and procedures",
    },
    {
      "name": "Financial Statements",
      "type": "Financial",
      "last_updated": "2024-05-31",
      "icon": Icons.assessment,
      "description": "Monthly and annual financial reports",
    },
    {
      "name": "Meeting Minutes",
      "type": "Records",
      "last_updated": "2024-06-10",
      "icon": Icons.notes,
      "description": "Board meeting minutes and decisions",
    },
    {
      "name": "Architectural Guidelines",
      "type": "Guidelines",
      "last_updated": "2023-08-22",
      "icon": Icons.architecture,
      "description": "Design standards and approval process",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOA Information"),
        actions: [
          IconButton(
            icon: Icon(Icons.contact_phone),
            onPressed: () {
              // Contact HOA management
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHoaOverview(),
            _buildTabSelector(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHoaOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${hoaData["name"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Established ${hoaData["established"]} • ${hoaData["total_units"]} Units",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewStat(
                  "Monthly Fee",
                  "\$${(hoaData["monthly_fee"] as double).currency}",
                  Icons.attach_money,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat(
                  "Reserve Fund",
                  "\$${((hoaData["reserve_fund"] as double) / 1000).toStringAsFixed(0)}K",
                  Icons.savings,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Information Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: tabOptions,
            value: selectedTab,
            onChanged: (index, label, value, item) {
              selectedTab = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "overview":
        return _buildOverviewContent();
      case "fees":
        return _buildFeesContent();
      case "rules":
        return _buildRulesContent();
      case "amenities":
        return _buildAmenitiesContent();
      case "documents":
        return _buildDocumentsContent();
      default:
        return _buildOverviewContent();
    }
  }

  Widget _buildOverviewContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "HOA Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoItem("Management Company", "${hoaData["management_company"]}", Icons.business),
          _buildInfoItem("Board Members", "${hoaData["board_members"]} elected members", Icons.people),
          _buildInfoItem("Next Meeting", "${hoaData["next_meeting"]}", Icons.event),
          _buildInfoItem("Fiscal Year End", "${hoaData["fiscal_year_end"]}", Icons.calendar_today),
          
          SizedBox(height: spMd),
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          _buildContactItem("Management Office", "(555) 123-4567", Icons.phone),
          _buildContactItem("Emergency Line", "(555) 987-6543", Icons.emergency),
          _buildContactItem("Email", "info@oakwoodhills.org", Icons.email),
          _buildContactItem("Website", "www.oakwoodhills.org", Icons.web),
        ],
      ),
    );
  }

  Widget _buildFeesContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fee Structure",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...feeStructure.map((fee) => _buildFeeCard(fee)),
        ],
      ),
    );
  }

  Widget _buildFeeCard(Map<String, dynamic> fee) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${fee["type"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${(fee["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Frequency: ${fee["frequency"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Due: ${fee["due_date"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Includes: ${fee["includes"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Community Rules & Regulations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...rules.map((category) => _buildRuleCategory(category)),
        ],
      ),
    );
  }

  Widget _buildRuleCategory(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${category["category"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          ...(category["rules"] as List).map((rule) => 
            Padding(
              padding: EdgeInsets.only(left: spSm, top: spXs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ", style: TextStyle(color: disabledBoldColor)),
                  Expanded(
                    child: Text(
                      rule,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Community Amenities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...amenities.map((amenity) => _buildAmenityCard(amenity)),
        ],
      ),
    );
  }

  Widget _buildAmenityCard(Map<String, dynamic> amenity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              amenity["icon"] as IconData,
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
                  "${amenity["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${amenity["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Hours: ${amenity["hours"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "HOA Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...documents.map((document) => _buildDocumentCard(document)),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              document["icon"] as IconData,
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
                  "${document["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${document["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Updated: ${document["last_updated"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Download or view document
            },
            child: Icon(
              Icons.download,
              color: primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Row(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(width: spSm),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
