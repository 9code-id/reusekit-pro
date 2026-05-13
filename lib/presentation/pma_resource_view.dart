import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaResourceView extends StatefulWidget {
  const PmaResourceView({super.key});

  @override
  State<PmaResourceView> createState() => _PmaResourceViewState();
}

class _PmaResourceViewState extends State<PmaResourceView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> resources = [
    {
      "id": 1,
      "name": "John Smith",
      "role": "Senior Developer",
      "department": "Engineering",
      "email": "john.smith@company.com",
      "phone": "+1 (555) 123-4567",
      "status": "available",
      "skills": ["Flutter", "React", "Node.js", "Python"],
      "currentProject": "Mobile Banking App",
      "utilization": 85,
      "hourlyRate": 75,
      "location": "New York",
      "experience": "5+ years",
      "avatar": "https://picsum.photos/100/100?random=1",
      "category": "human"
    },
    {
      "id": 2,
      "name": "Sarah Wilson",
      "role": "UI/UX Designer",
      "department": "Design",
      "email": "sarah.wilson@company.com",
      "phone": "+1 (555) 234-5678",
      "status": "busy",
      "skills": ["Figma", "Sketch", "Adobe XD", "Prototyping"],
      "currentProject": "E-commerce Platform",
      "utilization": 95,
      "hourlyRate": 65,
      "location": "San Francisco",
      "experience": "4+ years",
      "avatar": "https://picsum.photos/100/100?random=2",
      "category": "human"
    },
    {
      "id": 3,
      "name": "MacBook Pro 16\"",
      "role": "Development Laptop",
      "department": "IT Equipment",
      "serialNumber": "MBP-2024-001",
      "model": "MacBook Pro M3 Max",
      "status": "available",
      "specifications": ["M3 Max Chip", "32GB RAM", "1TB SSD", "macOS Sonoma"],
      "currentProject": null,
      "assignedTo": null,
      "cost": 3500,
      "location": "Equipment Room A",
      "purchaseDate": "2024-01-15",
      "warranty": "2 years",
      "category": "equipment"
    },
    {
      "id": 4,
      "name": "AWS Cloud Server",
      "role": "Production Server",
      "department": "Infrastructure",
      "instanceId": "i-0123456789abcdef0",
      "instanceType": "t3.large",
      "status": "in_use",
      "specifications": ["2 vCPUs", "8GB RAM", "100GB Storage", "Ubuntu 22.04"],
      "currentProject": "CRM System",
      "monthlyCost": 250,
      "region": "us-east-1",
      "uptime": "99.9%",
      "category": "infrastructure"
    },
    {
      "id": 5,
      "name": "Conference Room Alpha",
      "role": "Meeting Room",
      "department": "Facilities",
      "capacity": 12,
      "status": "available",
      "equipment": ["75\" Smart TV", "Wireless Projector", "Video Conferencing", "Whiteboard"],
      "currentBooking": null,
      "location": "Floor 3, East Wing",
      "features": ["Natural Light", "Air Conditioning", "WiFi"],
      "category": "facility"
    },
    {
      "id": 6,
      "name": "Design Software License",
      "role": "Adobe Creative Suite",
      "department": "Software",
      "licenseKey": "CC-2024-DESIGN-001",
      "status": "in_use",
      "applications": ["Photoshop", "Illustrator", "InDesign", "After Effects"],
      "assignedTo": "Sarah Wilson",
      "expiryDate": "2025-12-31",
      "monthlyCost": 80,
      "category": "license"
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Human Resources", "value": "human"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Infrastructure", "value": "infrastructure"},
    {"label": "Facilities", "value": "facility"},
    {"label": "Software Licenses", "value": "license"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "In Use", "value": "in_use"},
    {"label": "Busy", "value": "busy"},
    {"label": "Maintenance", "value": "maintenance"}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "in_use":
      case "busy":
        return warningColor;
      case "maintenance":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredResources() {
    List<Map<String, dynamic>> filtered = resources;

    if (selectedCategory != "all") {
      filtered = filtered.where((resource) => resource["category"] == selectedCategory).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((resource) => resource["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((resource) {
        return resource["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               resource["role"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               resource["department"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Resource Directory",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Search resources...",
            value: searchQuery,
            hint: "Search by name, role, or department",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResourceStats() {
    int totalResources = resources.length;
    int availableResources = resources.where((r) => r["status"] == "available").length;
    int inUseResources = resources.where((r) => r["status"] == "in_use" || r["status"] == "busy").length;
    int humanResources = resources.where((r) => r["category"] == "human").length;

    return Container(
      margin: EdgeInsets.all(spSm),
      child: Row(
        children: [
          _buildStatCard("Total", totalResources, primaryColor, Icons.inventory),
          _buildStatCard("Available", availableResources, successColor, Icons.check_circle),
          _buildStatCard("In Use", inUseResources, warningColor, Icons.hourglass_empty),
          _buildStatCard("People", humanResources, infoColor, Icons.people),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: spSm),
            Text(
              "$value",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourcesList() {
    List<Map<String, dynamic>> filtered = _getFilteredResources();

    if (filtered.isEmpty) {
      return Container(
        margin: EdgeInsets.all(spSm),
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No resources found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Try adjusting your search criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: filtered.map((resource) => _buildResourceItem(resource)).toList(),
      ),
    );
  }

  Widget _buildResourceItem(Map<String, dynamic> resource) {
    String category = resource["category"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
          left: BorderSide(color: _getCategoryColor(category), width: 4),
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
                  color: _getCategoryColor(category).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  color: _getCategoryColor(category),
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${resource["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${resource["role"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(resource["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${resource["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(resource["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildResourceDetails(resource),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResourceDetails(Map<String, dynamic> resource) {
    String category = resource["category"];
    
    switch (category) {
      case "human":
        return _buildHumanResourceDetails(resource);
      case "equipment":
        return _buildEquipmentDetails(resource);
      case "infrastructure":
        return _buildInfrastructureDetails(resource);
      case "facility":
        return _buildFacilityDetails(resource);
      case "license":
        return _buildLicenseDetails(resource);
      default:
        return Container();
    }
  }

  Widget _buildHumanResourceDetails(Map<String, dynamic> resource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.business, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["department"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            Spacer(),
            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["location"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Icon(Icons.email, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Expanded(
              child: Text(
                "${resource["email"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ),
          ],
        ),
        if (resource["currentProject"] != null) ...[
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.work, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Project: ${resource["currentProject"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              Text(
                "${resource["utilization"]}% utilized",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: spSm),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: (resource["skills"] as List).map((skill) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "$skill",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildEquipmentDetails(Map<String, dynamic> resource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tag, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["model"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            Spacer(),
            Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "\$${resource["cost"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["location"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            Spacer(),
            Icon(Icons.security, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["warranty"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: (resource["specifications"] as List).map((spec) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "$spec",
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildInfrastructureDetails(Map<String, dynamic> resource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.cloud, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["instanceType"]} (${resource["region"]})",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            Spacer(),
            Text(
              "\$${resource["monthlyCost"]}/month",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Icon(Icons.trending_up, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "Uptime: ${resource["uptime"]}",
              style: TextStyle(fontSize: 14, color: successColor),
            ),
            Spacer(),
            if (resource["currentProject"] != null) ...[
              Icon(Icons.work, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${resource["currentProject"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFacilityDetails(Map<String, dynamic> resource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "Capacity: ${resource["capacity"]} people",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            Spacer(),
            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["location"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: (resource["equipment"] as List).map((equipment) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "$equipment",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildLicenseDetails(Map<String, dynamic> resource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.key, size: 16, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              "${resource["licenseKey"]}",
              style: TextStyle(fontSize: 14, color: disabledBoldColor),
            ),
            Spacer(),
            Text(
              "\$${resource["monthlyCost"]}/month",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        if (resource["assignedTo"] != null) ...[
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Assigned to: ${resource["assignedTo"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Expires: ${resource["expiryDate"]}",
                style: TextStyle(fontSize: 14, color: warningColor),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "human":
        return primaryColor;
      case "equipment":
        return infoColor;
      case "infrastructure":
        return warningColor;
      case "facility":
        return successColor;
      case "license":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "human":
        return Icons.person;
      case "equipment":
        return Icons.laptop_mac;
      case "infrastructure":
        return Icons.cloud;
      case "facility":
        return Icons.meeting_room;
      case "license":
        return Icons.key;
      default:
        return Icons.inventory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildResourceStats(),
            _buildResourcesList(),
          ],
        ),
      ),
    );
  }
}
