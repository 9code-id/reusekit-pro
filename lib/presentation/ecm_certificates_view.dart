import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCertificatesView extends StatefulWidget {
  const EcmCertificatesView({super.key});

  @override
  State<EcmCertificatesView> createState() => _EcmCertificatesViewState();
}

class _EcmCertificatesViewState extends State<EcmCertificatesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Medical", "value": "Medical"},
    {"label": "Nursing", "value": "Nursing"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Surgical", "value": "Surgical"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Expiring Soon", "value": "Expiring"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> certificates = [
    {
      "id": "CERT001",
      "title": "Basic Life Support (BLS)",
      "category": "Emergency",
      "issuer": "American Heart Association",
      "issueDate": "2024-01-15",
      "expiryDate": "2026-01-15",
      "status": "Active",
      "hours": 4.0,
      "image": "https://picsum.photos/150/100?random=1&keyword=certificate",
      "description": "Basic life support skills for healthcare providers"
    },
    {
      "id": "CERT002", 
      "title": "Advanced Cardiac Life Support",
      "category": "Emergency",
      "issuer": "American Heart Association",
      "issueDate": "2024-03-20",
      "expiryDate": "2025-03-20",
      "status": "Expiring",
      "hours": 12.5,
      "image": "https://picsum.photos/150/100?random=2&keyword=medical",
      "description": "Advanced cardiac emergency management protocols"
    },
    {
      "id": "CERT003",
      "title": "Infection Control Certification",
      "category": "Medical",
      "issuer": "CDC Healthcare Infection Control",
      "issueDate": "2023-08-10",
      "expiryDate": "2024-08-10",
      "status": "Expired",
      "hours": 8.0,
      "image": "https://picsum.photos/150/100?random=3&keyword=safety",
      "description": "Healthcare infection prevention and control measures"
    },
    {
      "id": "CERT004",
      "title": "Wound Care Specialist",
      "category": "Nursing",
      "issuer": "Wound Care Education Institute",
      "issueDate": "2024-05-12",
      "expiryDate": "2027-05-12",
      "status": "Active",
      "hours": 20.0,
      "image": "https://picsum.photos/150/100?random=4&keyword=healthcare",
      "description": "Specialized wound assessment and treatment protocols"
    },
    {
      "id": "CERT005",
      "title": "Surgical Technician Certification",
      "category": "Surgical",
      "issuer": "National Board of Surgical Technology",
      "issueDate": "2024-02-28",
      "expiryDate": "2026-02-28",
      "status": "Active",
      "hours": 40.0,
      "image": "https://picsum.photos/150/100?random=5&keyword=surgery",
      "description": "Sterile processing and surgical assistance certification"
    },
    {
      "id": "CERT006",
      "title": "Medication Administration",
      "category": "Nursing",
      "issuer": "State Nursing Board",
      "issueDate": "2024-01-05",
      "expiryDate": "2025-01-05",
      "status": "Expiring",
      "hours": 6.0,
      "image": "https://picsum.photos/150/100?random=6&keyword=medicine",
      "description": "Safe medication administration practices and protocols"
    }
  ];

  List<Map<String, dynamic>> get filteredCertificates {
    return certificates.where((cert) {
      bool matchesSearch = (cert["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (cert["issuer"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || cert["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || cert["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expiring":
        return warningColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildCertificateCard(Map<String, dynamic> certificate) {
    DateTime expiryDate = DateTime.parse(certificate["expiryDate"]);
    DateTime now = DateTime.now();
    int daysRemaining = expiryDate.difference(now).inDays;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Certificate Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getStatusColor(certificate["status"]).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${certificate["image"]}"),
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
                        "${certificate["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${certificate["issuer"]}",
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
                    color: _getStatusColor(certificate["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${certificate["status"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Certificate Details
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${certificate["description"]}",
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
                            "Certificate ID",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${certificate["id"]}",
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
                            "CE Hours",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${(certificate["hours"] as double).toStringAsFixed(1)} hrs",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Issue Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(certificate["issueDate"]).dMMMy}",
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
                            "Expiry Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(certificate["expiryDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(certificate["status"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                if (certificate["status"] == "Expiring" || certificate["status"] == "Expired") ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: certificate["status"] == "Expired" 
                          ? dangerColor.withAlpha(20) 
                          : warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: certificate["status"] == "Expired" 
                            ? dangerColor 
                            : warningColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          certificate["status"] == "Expired" 
                              ? Icons.error 
                              : Icons.warning,
                          size: 16,
                          color: certificate["status"] == "Expired" 
                              ? dangerColor 
                              : warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          certificate["status"] == "Expired"
                              ? "Certificate has expired"
                              : "Expires in $daysRemaining days",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: certificate["status"] == "Expired" 
                                ? dangerColor 
                                : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to certificate details
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Certificate downloaded successfully");
                      },
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

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int activeCerts = certificates.where((c) => c["status"] == "Active").length;
    int expiringCerts = certificates.where((c) => c["status"] == "Expiring").length;
    int expiredCerts = certificates.where((c) => c["status"] == "Expired").length;
    double totalHours = certificates.fold(0.0, (sum, cert) => sum + (cert["hours"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Certificates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add certificate
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Overview
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Active Certificates", "$activeCerts", successColor, Icons.verified),
                _buildStatCard("Expiring Soon", "$expiringCerts", warningColor, Icons.schedule),
                _buildStatCard("Expired", "$expiredCerts", dangerColor, Icons.error),
                _buildStatCard("Total CE Hours", "${totalHours.toStringAsFixed(1)}", primaryColor, Icons.school),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search certificates...",
                    value: searchQuery,
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
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
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
            
            SizedBox(height: spLg),
            
            // Certificates List Header
            Row(
              children: [
                Text(
                  "My Certificates",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredCertificates.length} certificates",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Certificates List
            if (filteredCertificates.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No certificates found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or search criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredCertificates.map((certificate) => _buildCertificateCard(certificate)),
          ],
        ),
      ),
    );
  }
}
