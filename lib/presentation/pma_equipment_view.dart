import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaEquipmentView extends StatefulWidget {
  const PmaEquipmentView({super.key});

  @override
  State<PmaEquipmentView> createState() => _PmaEquipmentViewState();
}

class _PmaEquipmentViewState extends State<PmaEquipmentView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedLocation = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> equipment = [
    {
      "id": 1,
      "name": "MacBook Pro 16\"",
      "category": "laptop",
      "model": "MacBook Pro M3 Max",
      "serialNumber": "MBP-2024-001",
      "status": "assigned",
      "assignedTo": "John Smith",
      "location": "Development Floor",
      "purchaseDate": "2024-01-15",
      "purchasePrice": 3500,
      "warrantyExpiry": "2026-01-15",
      "specifications": {
        "processor": "M3 Max",
        "memory": "32GB",
        "storage": "1TB SSD",
        "display": "16-inch Liquid Retina XDR"
      },
      "maintenanceSchedule": "2025-07-15",
      "condition": "excellent",
      "image": "https://picsum.photos/300/200?random=1&keyword=laptop"
    },
    {
      "id": 2,
      "name": "Dell Ultrasharp 4K Monitor",
      "category": "monitor",
      "model": "U2723QE",
      "serialNumber": "DLM-2024-002",
      "status": "available",
      "assignedTo": null,
      "location": "Equipment Room A",
      "purchaseDate": "2024-02-20",
      "purchasePrice": 650,
      "warrantyExpiry": "2027-02-20",
      "specifications": {
        "size": "27 inches",
        "resolution": "3840 x 2160",
        "connectivity": "USB-C, HDMI, DisplayPort",
        "colorGamut": "99% sRGB"
      },
      "maintenanceSchedule": "2025-08-20",
      "condition": "excellent",
      "image": "https://picsum.photos/300/200?random=2&keyword=monitor"
    },
    {
      "id": 3,
      "name": "iPhone 15 Pro",
      "category": "mobile",
      "model": "iPhone 15 Pro",
      "serialNumber": "IPH-2024-003",
      "status": "assigned",
      "assignedTo": "Sarah Wilson",
      "location": "Design Studio",
      "purchaseDate": "2024-03-10",
      "purchasePrice": 1200,
      "warrantyExpiry": "2025-03-10",
      "specifications": {
        "storage": "256GB",
        "color": "Natural Titanium",
        "camera": "48MP Main, 12MP Ultra Wide",
        "processor": "A17 Pro"
      },
      "maintenanceSchedule": "2025-09-10",
      "condition": "good",
      "image": "https://picsum.photos/300/200?random=3&keyword=iphone"
    },
    {
      "id": 4,
      "name": "Logitech MX Master 3S",
      "category": "accessory",
      "model": "MX Master 3S",
      "serialNumber": "LGT-2024-004",
      "status": "maintenance",
      "assignedTo": null,
      "location": "IT Department",
      "purchaseDate": "2024-04-05",
      "purchasePrice": 100,
      "warrantyExpiry": "2026-04-05",
      "specifications": {
        "connectivity": "Bluetooth, USB-C",
        "battery": "Up to 70 days",
        "sensors": "Darkfield laser tracking",
        "buttons": "7 programmable buttons"
      },
      "maintenanceSchedule": "2025-10-05",
      "condition": "fair",
      "image": "https://picsum.photos/300/200?random=4&keyword=mouse"
    },
    {
      "id": 5,
      "name": "Surface Studio 2+",
      "category": "workstation",
      "model": "Surface Studio 2+",
      "serialNumber": "SFS-2024-005",
      "status": "assigned",
      "assignedTo": "Lisa Davis",
      "location": "Creative Suite",
      "purchaseDate": "2024-05-15",
      "purchasePrice": 4500,
      "warrantyExpiry": "2026-05-15",
      "specifications": {
        "processor": "Intel Core i7-11370H",
        "memory": "32GB",
        "storage": "1TB SSD",
        "display": "28-inch PixelSense touchscreen"
      },
      "maintenanceSchedule": "2025-11-15",
      "condition": "excellent",
      "image": "https://picsum.photos/300/200?random=5&keyword=workstation"
    },
    {
      "id": 6,
      "name": "Canon EOS R5",
      "category": "camera",
      "model": "EOS R5",
      "serialNumber": "CAN-2024-006",
      "status": "available",
      "assignedTo": null,
      "location": "Media Room",
      "purchaseDate": "2024-06-01",
      "purchasePrice": 3800,
      "warrantyExpiry": "2026-06-01",
      "specifications": {
        "sensor": "45MP Full Frame CMOS",
        "video": "8K RAW recording",
        "stabilization": "5-axis In-body",
        "connectivity": "Wi-Fi, Bluetooth"
      },
      "maintenanceSchedule": "2025-12-01",
      "condition": "excellent",
      "image": "https://picsum.photos/300/200?random=6&keyword=camera"
    }
  ];

  List<String> locations = ["Development Floor", "Equipment Room A", "Design Studio", "IT Department", "Creative Suite", "Media Room"];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Laptops", "value": "laptop"},
    {"label": "Monitors", "value": "monitor"},
    {"label": "Mobile Devices", "value": "mobile"},
    {"label": "Accessories", "value": "accessory"},
    {"label": "Workstations", "value": "workstation"},
    {"label": "Cameras", "value": "camera"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Retired", "value": "retired"}
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "all"},
  ];

  @override
  void initState() {
    super.initState();
    locationOptions.addAll(locations.map((location) => {"label": location, "value": location}).toList());
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "assigned":
        return infoColor;
      case "maintenance":
        return warningColor;
      case "retired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "excellent":
        return successColor;
      case "good":
        return infoColor;
      case "fair":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredEquipment() {
    List<Map<String, dynamic>> filtered = equipment;

    if (selectedCategory != "all") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    if (selectedLocation != "all") {
      filtered = filtered.where((item) => item["location"] == selectedLocation).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               item["model"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               item["serialNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
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
                  "Equipment Management",
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
            label: "Search equipment...",
            value: searchQuery,
            hint: "Search by name, model, or serial number",
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
          SizedBox(height: spSm),
          QDropdownField(
            label: "Location",
            items: locationOptions,
            value: selectedLocation,
            onChanged: (value, label) {
              selectedLocation = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentStats() {
    int totalEquipment = equipment.length;
    int availableEquipment = equipment.where((e) => e["status"] == "available").length;
    int assignedEquipment = equipment.where((e) => e["status"] == "assigned").length;
    int maintenanceEquipment = equipment.where((e) => e["status"] == "maintenance").length;

    return Container(
      margin: EdgeInsets.all(spSm),
      child: Row(
        children: [
          _buildStatCard("Total", totalEquipment, primaryColor, Icons.inventory),
          _buildStatCard("Available", availableEquipment, successColor, Icons.check_circle),
          _buildStatCard("Assigned", assignedEquipment, infoColor, Icons.assignment_ind),
          _buildStatCard("Maintenance", maintenanceEquipment, warningColor, Icons.build),
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

  Widget _buildEquipmentGrid() {
    List<Map<String, dynamic>> filtered = _getFilteredEquipment();

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
              "No equipment found",
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

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: filtered.map((item) => _buildEquipmentCard(item)).toList(),
    );
  }

  Widget _buildEquipmentCard(Map<String, dynamic> item) {
    Map<String, dynamic> specs = item["specifications"];
    DateTime purchaseDate = DateTime.parse(item["purchaseDate"]);
    DateTime warrantyExpiry = DateTime.parse(item["warrantyExpiry"]);
    bool isWarrantyExpiring = warrantyExpiry.difference(DateTime.now()).inDays <= 30;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(color: _getStatusColor(item["status"]), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusMd),
              topRight: Radius.circular(radiusMd),
            ),
            child: Container(
              height: 120,
              width: double.infinity,
              child: Image.network(
                "${item["image"]}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: disabledColor,
                    child: Icon(
                      _getCategoryIcon(item["category"]),
                      size: 48,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(item["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(item["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["model"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.tag, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["serialNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (item["assignedTo"] != null) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${item["assignedTo"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "Condition:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: _getConditionColor(item["condition"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["condition"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getConditionColor(item["condition"]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Value:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "\$${item["purchasePrice"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (isWarrantyExpiring) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Warranty expires ${warrantyExpiry.day}/${warrantyExpiry.month}/${warrantyExpiry.year}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "laptop":
        return Icons.laptop_mac;
      case "monitor":
        return Icons.monitor;
      case "mobile":
        return Icons.phone_iphone;
      case "accessory":
        return Icons.mouse;
      case "workstation":
        return Icons.desktop_windows;
      case "camera":
        return Icons.camera_alt;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildEquipmentStats(),
            _buildEquipmentGrid(),
          ],
        ),
      ),
    );
  }
}
