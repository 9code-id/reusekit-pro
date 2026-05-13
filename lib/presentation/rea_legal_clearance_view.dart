import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLegalClearanceView extends StatefulWidget {
  const ReaLegalClearanceView({super.key});

  @override
  State<ReaLegalClearanceView> createState() => _ReaLegalClearanceViewState();
}

class _ReaLegalClearanceViewState extends State<ReaLegalClearanceView> {
  String selectedPropertyType = "Residential";
  String selectedState = "";
  String propertyAddress = "";
  bool isLoading = false;

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "Residential", "value": "Residential"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Industrial", "value": "Industrial"},
    {"label": "Agricultural", "value": "Agricultural"},
  ];

  List<Map<String, dynamic>> states = [
    {"label": "California", "value": "CA"},
    {"label": "New York", "value": "NY"},
    {"label": "Texas", "value": "TX"},
    {"label": "Florida", "value": "FL"},
    {"label": "Illinois", "value": "IL"},
  ];

  List<Map<String, dynamic>> clearanceDocuments = [
    {
      "id": 1,
      "name": "Title Deed Verification",
      "description": "Verification of property ownership and clear title",
      "status": "Completed",
      "issuedDate": "2024-01-15",
      "validUntil": "2024-12-31",
      "authority": "County Recorder's Office",
      "documentNumber": "TD-2024-001234",
      "icon": Icons.description,
      "color": successColor,
      "fee": "\$150"
    },
    {
      "id": 2,
      "name": "Zoning Compliance Certificate",
      "description": "Confirms property complies with local zoning laws",
      "status": "In Progress",
      "issuedDate": "2024-02-01",
      "validUntil": "2024-12-31",
      "authority": "City Planning Department",
      "documentNumber": "ZC-2024-005678",
      "icon": Icons.location_city,
      "color": warningColor,
      "fee": "\$75"
    },
    {
      "id": 3,
      "name": "Environmental Clearance",
      "description": "Environmental impact assessment and clearance",
      "status": "Pending",
      "issuedDate": "",
      "validUntil": "",
      "authority": "Environmental Protection Agency",
      "documentNumber": "EC-2024-009876",
      "icon": Icons.nature,
      "color": infoColor,
      "fee": "\$200"
    },
    {
      "id": 4,
      "name": "Fire Safety Certificate",
      "description": "Fire safety compliance and clearance certificate",
      "status": "Completed",
      "issuedDate": "2024-01-20",
      "validUntil": "2025-01-20",
      "authority": "Fire Department",
      "documentNumber": "FS-2024-002468",
      "icon": Icons.local_fire_department,
      "color": successColor,
      "fee": "\$100"
    },
    {
      "id": 5,
      "name": "Building Code Compliance",
      "description": "Compliance with local building codes and regulations",
      "status": "Expired",
      "issuedDate": "2023-06-15",
      "validUntil": "2024-01-15",
      "authority": "Building Department",
      "documentNumber": "BC-2023-013579",
      "icon": Icons.architecture,
      "color": dangerColor,
      "fee": "\$125"
    }
  ];

  List<Map<String, dynamic>> legalServices = [
    {
      "id": 1,
      "name": "Property Law Associates",
      "type": "Law Firm",
      "specialties": ["Title Search", "Property Disputes", "Real Estate Law"],
      "rating": 4.8,
      "reviews": 156,
      "experience": "15+ years",
      "contact": "(555) 123-4567",
      "email": "info@propertylaw.com",
      "address": "123 Legal Ave, Suite 100",
      "hourlyRate": "\$350-450",
      "image": "https://picsum.photos/300/200?random=1&keyword=lawyer"
    },
    {
      "id": 2,
      "name": "Real Estate Legal Group",
      "type": "Legal Consultancy",
      "specialties": ["Due Diligence", "Contract Review", "Clearance Services"],
      "rating": 4.6,
      "reviews": 89,
      "experience": "10+ years",
      "contact": "(555) 234-5678",
      "email": "contact@relegalgroup.com",
      "address": "456 Justice St, Floor 3",
      "hourlyRate": "\$300-400",
      "image": "https://picsum.photos/300/200?random=2&keyword=legal"
    },
    {
      "id": 3,
      "name": "Title & Clearance Services",
      "type": "Title Company",
      "specialties": ["Title Insurance", "Document Verification", "Clearance"],
      "rating": 4.7,
      "reviews": 234,
      "experience": "20+ years",
      "contact": "(555) 345-6789",
      "email": "services@titleclearance.com",
      "address": "789 Document Dr",
      "hourlyRate": "\$250-350",
      "image": "https://picsum.photos/300/200?random=3&keyword=title"
    }
  ];

  Widget _buildPropertyInfoForm() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
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
            "Property Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Property Address",
            value: propertyAddress,
            hint: "Enter complete property address",
            onChanged: (value) {
              propertyAddress = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Property Type",
                  items: propertyTypes,
                  value: selectedPropertyType,
                  onChanged: (value, label) {
                    selectedPropertyType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "State",
                  items: states,
                  value: selectedState,
                  onChanged: (value, label) {
                    selectedState = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Check Clearance Status",
              icon: Icons.search,
              size: bs.md,
              onPressed: () {
                _checkClearanceStatus();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearanceDocuments() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Legal Clearance Documents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...clearanceDocuments.map((document) => _buildDocumentCard(document)),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: document["color"],
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (document["color"] as Color).withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    document["icon"],
                    color: document["color"],
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
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${document["description"]}",
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
                    color: document["color"],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${document["status"]}",
                    style: TextStyle(
                      color: Colors.white,
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
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  _buildDocumentInfo("Document Number", "${document["documentNumber"]}"),
                  _buildDocumentInfo("Issuing Authority", "${document["authority"]}"),
                  _buildDocumentInfo("Fee", "${document["fee"]}"),
                  if (document["issuedDate"].toString().isNotEmpty)
                    _buildDocumentInfo("Issued Date", "${document["issuedDate"]}"),
                  if (document["validUntil"].toString().isNotEmpty)
                    _buildDocumentInfo("Valid Until", "${document["validUntil"]}"),
                ],
              ),
            ),

            Row(
              children: [
                if (document["status"] == "Completed") ...[
                  Expanded(
                    child: QButton(
                      label: "Download",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        // Download document
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                ] else if (document["status"] == "Expired") ...[
                  Expanded(
                    child: QButton(
                      label: "Renew",
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {
                        // Renew document
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                ] else if (document["status"] == "Pending") ...[
                  Expanded(
                    child: QButton(
                      label: "Apply",
                      icon: Icons.assignment,
                      size: bs.sm,
                      onPressed: () {
                        // Apply for document
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                Expanded(
                  child: QButton(
                    label: "Track Status",
                    icon: Icons.track_changes,
                    size: bs.sm,
                    onPressed: () {
                      // Track status
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Details",
                    icon: Icons.info,
                    size: bs.sm,
                    onPressed: () {
                      // View details
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegalServices() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Legal Service Providers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    // View all services
                  },
                ),
              ],
            ),
          ),
          ...legalServices.map((service) => _buildServiceCard(service)),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
              image: DecorationImage(
                image: NetworkImage("${service["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(127),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${service["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${service["type"]}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${service["rating"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildServiceInfo(Icons.work, "Experience", "${service["experience"]}"),
                    ),
                    Expanded(
                      child: _buildServiceInfo(Icons.attach_money, "Rate", "${service["hourlyRate"]}"),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: _buildServiceInfo(Icons.reviews, "Reviews", "${service["reviews"]}"),
                    ),
                    Expanded(
                      child: _buildServiceInfo(Icons.phone, "Contact", "${service["contact"]}"),
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Specialties:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (service["specialties"] as List).map((specialty) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${specialty}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Contact",
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          // Contact service provider
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Consult",
                        icon: Icons.chat,
                        size: bs.sm,
                        onPressed: () {
                          // Schedule consultation
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Profile",
                        icon: Icons.person,
                        size: bs.sm,
                        onPressed: () {
                          // View profile
                        },
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

  Widget _buildServiceInfo(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: disabledBoldColor, size: 14),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _checkClearanceStatus() async {
    if (propertyAddress.isEmpty || selectedState.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    isLoading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});

    ss("Clearance status updated successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Clearance"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Show help
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildPropertyInfoForm(),
                  SizedBox(height: spMd),
                  _buildClearanceDocuments(),
                  SizedBox(height: spMd),
                  _buildLegalServices(),
                  SizedBox(height: spMd),
                ],
              ),
            ),
    );
  }
}
