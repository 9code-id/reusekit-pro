import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPresentationUploadsView extends StatefulWidget {
  const EcmPresentationUploadsView({super.key});

  @override
  State<EcmPresentationUploadsView> createState() => _EcmPresentationUploadsViewState();
}

class _EcmPresentationUploadsViewState extends State<EcmPresentationUploadsView> {
  List<Map<String, dynamic>> presentations = [
    {
      "id": 1,
      "title": "Digital Transformation in Healthcare",
      "presenter": "Dr. Sarah Johnson",
      "file_name": "healthcare_digital_transform.pdf",
      "file_size": "12.5 MB",
      "upload_date": DateTime.now().subtract(Duration(days: 2)),
      "status": "Approved",
      "category": "Healthcare",
      "duration": "45 min",
      "views": 1250,
      "downloads": 89,
      "type": "PDF"
    },
    {
      "id": 2,
      "title": "AI in Modern Education Systems",
      "presenter": "Prof. Michael Chen",
      "file_name": "ai_education_presentation.pptx",
      "file_size": "28.7 MB",
      "upload_date": DateTime.now().subtract(Duration(days: 1)),
      "status": "Pending Review",
      "category": "Education",
      "duration": "60 min",
      "views": 892,
      "downloads": 45,
      "type": "PowerPoint"
    },
    {
      "id": 3,
      "title": "Sustainable Energy Solutions",
      "presenter": "Dr. Emily Rodriguez",
      "file_name": "sustainable_energy.pdf",
      "file_size": "15.2 MB",
      "upload_date": DateTime.now().subtract(Duration(hours: 8)),
      "status": "Under Review",
      "category": "Environment",
      "duration": "50 min",
      "views": 634,
      "downloads": 32,
      "type": "PDF"
    },
    {
      "id": 4,
      "title": "Blockchain in Finance",
      "presenter": "James Wilson",
      "file_name": "blockchain_finance.pptx",
      "file_size": "22.1 MB",
      "upload_date": DateTime.now().subtract(Duration(hours: 3)),
      "status": "Rejected",
      "category": "Finance",
      "duration": "40 min",
      "views": 445,
      "downloads": 12,
      "type": "PowerPoint"
    },
    {
      "id": 5,
      "title": "IoT and Smart Cities",
      "presenter": "Lisa Park",
      "file_name": "iot_smart_cities.pdf",
      "file_size": "18.9 MB",
      "upload_date": DateTime.now().subtract(Duration(minutes: 45)),
      "status": "Approved",
      "category": "Technology",
      "duration": "55 min",
      "views": 789,
      "downloads": 67,
      "type": "PDF"
    }
  ];

  String selectedCategory = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  bool isUploading = false;
  List<String> uploadFiles = [];

  final List<String> categories = ["All", "Healthcare", "Education", "Environment", "Finance", "Technology"];
  final List<String> statuses = ["All", "Approved", "Pending Review", "Under Review", "Rejected"];

  List<Map<String, dynamic>> get filteredPresentations {
    return presentations.where((presentation) {
      final matchesCategory = selectedCategory == "All" || presentation["category"] == selectedCategory;
      final matchesStatus = selectedStatus == "All" || presentation["status"] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty || 
          "${presentation["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${presentation["presenter"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending Review":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFileTypeIcon(String type) {
    switch (type) {
      case "PDF":
        return Icons.picture_as_pdf;
      case "PowerPoint":
        return Icons.slideshow;
      default:
        return Icons.description;
    }
  }

  void _uploadPresentation() async {
    // Navigate to upload form
    // navigateTo(EcmUploadPresentationView());
  }

  void _viewPresentation(Map<String, dynamic> presentation) async {
    // Navigate to presentation viewer
    // navigateTo(EcmPresentationViewerView(presentation: presentation));
  }

  void _downloadPresentation(Map<String, dynamic> presentation) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("${presentation["title"]} downloaded successfully");
  }

  void _deletePresentation(Map<String, dynamic> presentation) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this presentation?");
    if (isConfirmed) {
      presentations.removeWhere((p) => p["id"] == presentation["id"]);
      setState(() {});
      ss("Presentation deleted successfully");
    }
  }

  Widget _buildStatsCard() {
    final totalPresentations = presentations.length;
    final approvedCount = presentations.where((p) => p["status"] == "Approved").length;
    final pendingCount = presentations.where((p) => p["status"] == "Pending Review").length;
    final totalViews = presentations.fold(0, (sum, p) => sum + (p["views"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Statistics",
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
                child: _buildStatItem("Total", totalPresentations.toString(), Icons.folder, primaryColor),
              ),
              Expanded(
                child: _buildStatItem("Approved", approvedCount.toString(), Icons.check_circle, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Pending", pendingCount.toString(), Icons.pending, warningColor),
              ),
              Expanded(
                child: _buildStatItem("Views", "${(totalViews / 1000).toStringAsFixed(1)}K", Icons.visibility, infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPresentationCard(Map<String, dynamic> presentation) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getFileTypeIcon("${presentation["type"]}"),
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${presentation["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "by ${presentation["presenter"]}",
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
                        color: _getStatusColor("${presentation["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${presentation["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${presentation["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.folder, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${presentation["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${presentation["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.file_present, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${presentation["file_size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.visibility, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${presentation["views"]} views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.download, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${presentation["downloads"]} downloads",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(presentation["upload_date"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                QButton(
                  label: "View",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () => _viewPresentation(presentation),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Download",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () => _downloadPresentation(presentation),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _deletePresentation(presentation),
                  child: Icon(
                    Icons.delete,
                    color: dangerColor,
                    size: 20,
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
        title: Text("Presentation Uploads"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: _uploadPresentation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search presentations...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
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
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
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
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (filteredPresentations.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.folder_open,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No presentations found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or upload a new presentation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredPresentations.map((presentation) {
                  return _buildPresentationCard(presentation);
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadPresentation,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
