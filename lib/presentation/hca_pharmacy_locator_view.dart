import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPharmacyLocatorView extends StatefulWidget {
  const HcaPharmacyLocatorView({super.key});

  @override
  State<HcaPharmacyLocatorView> createState() => _HcaPharmacyLocatorViewState();
}

class _HcaPharmacyLocatorViewState extends State<HcaPharmacyLocatorView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedRadius = "5 miles";
  String selectedSort = "Distance";
  bool openNowOnly = false;
  bool accepts24h = false;

  List<Map<String, dynamic>> radiusItems = [
    {"label": "1 mile", "value": "1 mile"},
    {"label": "3 miles", "value": "3 miles"},
    {"label": "5 miles", "value": "5 miles"},
    {"label": "10 miles", "value": "10 miles"},
    {"label": "25 miles", "value": "25 miles"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Distance", "value": "Distance"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Price", "value": "Price"},
    {"label": "Name", "value": "Name"},
  ];

  List<Map<String, dynamic>> nearbyPharmacies = [
    {
      "id": "1",
      "name": "CVS Pharmacy",
      "address": "123 Main St, City, ST 12345",
      "phone": "+1234567890",
      "distance": 0.8,
      "rating": 4.2,
      "isOpen": true,
      "is24h": false,
      "openHours": "8:00 AM - 10:00 PM",
      "services": ["Prescription Pickup", "Vaccination", "Health Screening"],
      "accepts": ["Insurance A", "Insurance B", "Cash"],
      "waitTime": "15-20 minutes",
      "image": "https://picsum.photos/100/100?random=1&keyword=pharmacy",
    },
    {
      "id": "2",
      "name": "Walgreens",
      "address": "456 Oak Ave, City, ST 12345",
      "phone": "+1987654321",
      "distance": 1.2,
      "rating": 4.5,
      "isOpen": true,
      "is24h": true,
      "openHours": "24 Hours",
      "services": ["Prescription Pickup", "Vaccination", "Photo Services"],
      "accepts": ["Insurance A", "Insurance C", "Cash"],
      "waitTime": "10-15 minutes",
      "image": "https://picsum.photos/100/100?random=2&keyword=pharmacy",
    },
    {
      "id": "3",
      "name": "Rite Aid",
      "address": "789 Pine St, City, ST 12345",
      "phone": "+1122334455",
      "distance": 2.1,
      "rating": 4.0,
      "isOpen": false,
      "is24h": false,
      "openHours": "9:00 AM - 9:00 PM",
      "services": ["Prescription Pickup", "Health Products"],
      "accepts": ["Insurance B", "Insurance D", "Cash"],
      "waitTime": "20-25 minutes",
      "image": "https://picsum.photos/100/100?random=3&keyword=pharmacy",
    },
  ];

  List<Map<String, dynamic>> prescriptionHistory = [
    {
      "id": "1",
      "medicationName": "Lisinopril 10mg",
      "prescribedBy": "Dr. Sarah Wilson",
      "pharmacy": "CVS Pharmacy",
      "dateFilled": "2024-06-15",
      "quantity": "30 tablets",
      "refillsLeft": 2,
      "nextRefillDate": "2024-07-15",
      "status": "Active",
      "cost": 15.99,
    },
    {
      "id": "2",
      "medicationName": "Metformin 500mg",
      "prescribedBy": "Dr. Michael Chen",
      "pharmacy": "Walgreens",
      "dateFilled": "2024-06-10",
      "quantity": "60 tablets",
      "refillsLeft": 1,
      "nextRefillDate": "2024-07-10",
      "status": "Active",
      "cost": 8.50,
    },
  ];

  List<Map<String, dynamic>> savedPharmacies = [
    {
      "id": "1",
      "name": "CVS Pharmacy",
      "address": "123 Main St, City, ST 12345",
      "phone": "+1234567890",
      "isFavorite": true,
      "notes": "Usually has my medications in stock",
    },
    {
      "id": "2",
      "name": "Walgreens",
      "address": "456 Oak Ave, City, ST 12345",
      "phone": "+1987654321",
      "isFavorite": false,
      "notes": "Good for urgent prescriptions",
    },
  ];

  Widget _buildSearchTab() {
    List<Map<String, dynamic>> filteredPharmacies = nearbyPharmacies.where((pharmacy) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${pharmacy["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${pharmacy["address"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesOpenNow = !openNowOnly || pharmacy["isOpen"] == true;
      bool matches24h = !accepts24h || pharmacy["is24h"] == true;
      return matchesSearch && matchesOpenNow && matches24h;
    }).toList();

    // Sort pharmacies
    filteredPharmacies.sort((a, b) {
      switch (selectedSort) {
        case "Distance":
          return (a["distance"] as double).compareTo(b["distance"] as double);
        case "Rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "Name":
          return "${a["name"]}".compareTo("${b["name"]}");
        default:
          return 0;
      }
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
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
                QTextField(
                  label: "Search pharmacies...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Radius",
                        items: radiusItems,
                        value: selectedRadius,
                        onChanged: (value, label) {
                          selectedRadius = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortItems,
                        value: selectedSort,
                        onChanged: (value, label) {
                          selectedSort = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Open Now",
                      "value": "open",
                      "checked": openNowOnly,
                    },
                    {
                      "label": "24/7 Only",
                      "value": "24h",
                      "checked": accepts24h,
                    },
                  ],
                  value: [
                    if (openNowOnly) {"label": "Open Now", "value": "open", "checked": true},
                    if (accepts24h) {"label": "24/7 Only", "value": "24h", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    openNowOnly = values.any((v) => v["value"] == "open");
                    accepts24h = values.any((v) => v["value"] == "24h");
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Pharmacies List
          ...filteredPharmacies.map((pharmacy) {
            return _buildPharmacyCard(pharmacy);
          }).toList(),

          if (filteredPharmacies.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spLg),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.local_pharmacy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No pharmacies found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPrescriptionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Prescription Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Prescription",
              icon: Icons.add,
              onPressed: () {
                // Add prescription
              },
            ),
          ),

          // Active Prescriptions
          Container(
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
                  "Active Prescriptions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...prescriptionHistory.map((prescription) {
                  return _buildPrescriptionCard(prescription);
                }).toList(),
              ],
            ),
          ),

          // Refill Reminders
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Refill Reminders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...prescriptionHistory.where((p) {
                  DateTime nextRefill = DateTime.parse("${p["nextRefillDate"]}");
                  return nextRefill.difference(DateTime.now()).inDays <= 7;
                }).map((prescription) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${prescription["medicationName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Due: ${prescription["nextRefillDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Refill",
                          size: bs.sm,
                          onPressed: () {
                            // Request refill
                            ss("Refill request sent");
                          },
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
    );
  }

  Widget _buildSavedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Favorite Pharmacies
          Container(
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
                  "Favorite Pharmacies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...savedPharmacies.where((p) => p["isFavorite"] == true).map((pharmacy) {
                  return _buildSavedPharmacyCard(pharmacy);
                }).toList(),
              ],
            ),
          ),

          // Other Saved Pharmacies
          Container(
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
                  "Saved Pharmacies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...savedPharmacies.where((p) => p["isFavorite"] != true).map((pharmacy) {
                  return _buildSavedPharmacyCard(pharmacy);
                }).toList(),
              ],
            ),
          ),

          // Prescription History Summary
          Container(
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
                  "Quick Stats",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        Icons.medication,
                        "Active\nPrescriptions",
                        "${prescriptionHistory.length}",
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        Icons.schedule,
                        "Due for\nRefill",
                        "1",
                        warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        Icons.local_pharmacy,
                        "Saved\nPharmacies",
                        "${savedPharmacies.length}",
                        successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        Icons.attach_money,
                        "Monthly\nSpending",
                        "\$${((prescriptionHistory.map((p) => p["cost"] as double).reduce((a, b) => a + b))).toStringAsFixed(0)}",
                        infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacyCard(Map<String, dynamic> pharmacy) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${pharmacy["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${pharmacy["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (pharmacy["isOpen"] == true) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Open",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ] else ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Closed",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${pharmacy["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          "${pharmacy["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${pharmacy["distance"]} mi",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (pharmacy["is24h"] == true) ...[
                          SizedBox(width: spSm),
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
                              "24H",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hours: ${pharmacy["openHours"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Wait Time: ${pharmacy["waitTime"]}",
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
          SizedBox(height: spSm),
          Text(
            "Services: ${(pharmacy["services"] as List).join(", ")}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call",
                  icon: Icons.call,
                  onPressed: () {
                    // Make call
                    ss("Calling ${pharmacy["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Directions",
                  icon: Icons.directions,
                  onPressed: () {
                    // Get directions
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.favorite_border,
                size: bs.sm,
                onPressed: () {
                  // Save pharmacy
                  ss("Pharmacy saved to favorites");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionCard(Map<String, dynamic> prescription) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${prescription["medicationName"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${prescription["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Prescribed by: ${prescription["prescribedBy"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Pharmacy: ${prescription["pharmacy"]}",
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
                      "Quantity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${prescription["quantity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Refills Left",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${prescription["refillsLeft"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${prescription["cost"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                  label: "Request Refill",
                  onPressed: () {
                    // Request refill
                    ss("Refill request sent");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  // View details
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavedPharmacyCard(Map<String, dynamic> pharmacy) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${pharmacy["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (pharmacy["isFavorite"] == true) ...[
                      Icon(Icons.favorite, color: dangerColor, size: 16),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${pharmacy["address"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (pharmacy["notes"] != null && "${pharmacy["notes"]}".isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${pharmacy["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          QButton(
            icon: Icons.call,
            size: bs.sm,
            onPressed: () {
              // Call pharmacy
              ss("Calling ${pharmacy["name"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pharmacy Locator",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Search", icon: Icon(Icons.search)),
        Tab(text: "Prescriptions", icon: Icon(Icons.medication)),
        Tab(text: "Saved", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildSearchTab(),
        _buildPrescriptionsTab(),
        _buildSavedTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
