import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaQualityCheckView extends StatefulWidget {
  const LtaQualityCheckView({super.key});

  @override
  State<LtaQualityCheckView> createState() => _LtaQualityCheckViewState();
}

class _LtaQualityCheckViewState extends State<LtaQualityCheckView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedResult = "All Results";
  String selectedInspector = "All Inspectors";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Re-inspection", "value": "Re-inspection"},
  ];

  List<Map<String, dynamic>> resultOptions = [
    {"label": "All Results", "value": "All Results"},
    {"label": "Passed", "value": "Passed"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Conditional Pass", "value": "Conditional Pass"},
    {"label": "Rejected", "value": "Rejected"},
  ];

  List<Map<String, dynamic>> inspectorOptions = [
    {"label": "All Inspectors", "value": "All Inspectors"},
    {"label": "Quality Manager", "value": "Quality Manager"},
    {"label": "Senior Inspector", "value": "Senior Inspector"},
    {"label": "QC Specialist A", "value": "QC Specialist A"},
    {"label": "QC Specialist B", "value": "QC Specialist B"},
    {"label": "Lead Auditor", "value": "Lead Auditor"},
  ];

  List<Map<String, dynamic>> qualityChecks = [
    {
      "id": "qc_001",
      "orderNumber": "ORD-2024-001",
      "packageId": "pkg_001_1",
      "customerName": "TechCorp Solutions",
      "status": "Completed",
      "result": "Passed",
      "inspector": "QC Specialist A",
      "startTime": "2024-03-15T13:00:00Z",
      "completionTime": "2024-03-15T13:45:00Z",
      "packageType": "Fragile Package",
      "totalItems": 3,
      "checkedItems": 3,
      "passedItems": 3,
      "failedItems": 0,
      "weight": 1.5,
      "dimensions": "40x30x20 cm",
      "trackingNumber": "TRK001234567",
      "checklistItems": [
        {
          "category": "Packaging",
          "item": "Box integrity",
          "status": "Passed",
          "notes": "No damage observed",
          "critical": true,
        },
        {
          "category": "Packaging",
          "item": "Protective materials",
          "status": "Passed",
          "notes": "Adequate bubble wrap and foam padding",
          "critical": true,
        },
        {
          "category": "Labeling",
          "item": "Shipping labels",
          "status": "Passed",
          "notes": "All labels clearly visible and correct",
          "critical": true,
        },
        {
          "category": "Labeling",
          "item": "Fragile stickers",
          "status": "Passed",
          "notes": "Fragile handling stickers properly placed",
          "critical": false,
        },
        {
          "category": "Content",
          "item": "Item count verification",
          "status": "Passed",
          "notes": "All 3 items present and accounted for",
          "critical": true,
        },
        {
          "category": "Content",
          "item": "Item condition",
          "status": "Passed",
          "notes": "No visible damage to electronics",
          "critical": true,
        },
      ],
      "defects": [],
      "photos": ["qc_001_photo1.jpg", "qc_001_photo2.jpg"],
      "overallScore": 100,
      "notes": "Package meets all quality standards. Ready for shipment.",
      "recommendations": [],
    },
    {
      "id": "qc_002",
      "orderNumber": "ORD-2024-003",
      "packageId": "pkg_003_1",
      "customerName": "MedSupply Inc",
      "status": "In Progress",
      "result": "",
      "inspector": "QC Specialist B",
      "startTime": "2024-03-15T14:30:00Z",
      "completionTime": "",
      "packageType": "Cold Package",
      "totalItems": 3,
      "checkedItems": 2,
      "passedItems": 2,
      "failedItems": 0,
      "weight": 0.8,
      "dimensions": "35x25x25 cm",
      "trackingNumber": "",
      "checklistItems": [
        {
          "category": "Temperature Control",
          "item": "Insulation integrity",
          "status": "Passed",
          "notes": "Insulated box properly sealed",
          "critical": true,
        },
        {
          "category": "Temperature Control",
          "item": "Gel pack placement",
          "status": "Passed",
          "notes": "Gel packs correctly positioned around products",
          "critical": true,
        },
        {
          "category": "Temperature Control",
          "item": "Temperature monitoring",
          "status": "In Progress",
          "notes": "Digital temperature monitor activated",
          "critical": true,
        },
        {
          "category": "Documentation",
          "item": "Cold chain certificate",
          "status": "Pending",
          "notes": "Awaiting documentation",
          "critical": true,
        },
        {
          "category": "Content",
          "item": "Pharmaceutical verification",
          "status": "Pending",
          "notes": "Batch numbers and expiry dates to be verified",
          "critical": true,
        },
      ],
      "defects": [],
      "photos": ["qc_002_photo1.jpg"],
      "overallScore": 0,
      "notes": "Temperature-sensitive pharmaceutical inspection in progress",
      "recommendations": [],
    },
    {
      "id": "qc_003",
      "orderNumber": "ORD-2024-005",
      "packageId": "pkg_005_1",
      "customerName": "Office Solutions Pro",
      "status": "Failed",
      "result": "Failed",
      "inspector": "Senior Inspector",
      "startTime": "2024-03-15T11:30:00Z",
      "completionTime": "2024-03-15T12:15:00Z",
      "packageType": "Standard Box",
      "totalItems": 8,
      "checkedItems": 8,
      "passedItems": 6,
      "failedItems": 2,
      "weight": 2.1,
      "dimensions": "45x35x30 cm",
      "trackingNumber": "TRK005678901",
      "checklistItems": [
        {
          "category": "Packaging",
          "item": "Box integrity",
          "status": "Failed",
          "notes": "Bottom corner showing stress damage",
          "critical": true,
        },
        {
          "category": "Packaging",
          "item": "Seal quality",
          "status": "Passed",
          "notes": "Tape application adequate",
          "critical": false,
        },
        {
          "category": "Content",
          "item": "Item count verification",
          "status": "Passed",
          "notes": "All items present",
          "critical": true,
        },
        {
          "category": "Content",
          "item": "Item condition",
          "status": "Failed",
          "notes": "2 items show minor damage",
          "critical": true,
        },
        {
          "category": "Labeling",
          "item": "Shipping labels",
          "status": "Passed",
          "notes": "Labels correctly applied",
          "critical": true,
        },
      ],
      "defects": [
        {
          "type": "Packaging",
          "description": "Box corner damage",
          "severity": "Critical",
          "action": "Replace box",
        },
        {
          "type": "Product",
          "description": "Minor item damage",
          "severity": "Major",
          "action": "Replace damaged items",
        },
      ],
      "photos": ["qc_003_photo1.jpg", "qc_003_photo2.jpg", "qc_003_photo3.jpg"],
      "overallScore": 65,
      "notes": "Package failed quality inspection due to packaging and product damage",
      "recommendations": ["Replace damaged box", "Replace damaged items", "Re-pack with additional protection"],
    },
    {
      "id": "qc_004",
      "orderNumber": "ORD-2024-004",
      "packageId": "pkg_004_1",
      "customerName": "ChemLab Solutions",
      "status": "Pending",
      "result": "",
      "inspector": "Lead Auditor",
      "startTime": "",
      "completionTime": "",
      "packageType": "Hazmat Package",
      "totalItems": 2,
      "checkedItems": 0,
      "passedItems": 0,
      "failedItems": 0,
      "weight": 2.9,
      "dimensions": "30x30x30 cm",
      "trackingNumber": "",
      "checklistItems": [
        {
          "category": "Safety",
          "item": "Hazmat container integrity",
          "status": "Pending",
          "notes": "",
          "critical": true,
        },
        {
          "category": "Safety",
          "item": "Leak containment",
          "status": "Pending",
          "notes": "",
          "critical": true,
        },
        {
          "category": "Safety",
          "item": "Warning labels placement",
          "status": "Pending",
          "notes": "",
          "critical": true,
        },
        {
          "category": "Documentation",
          "item": "Hazmat shipping papers",
          "status": "Pending",
          "notes": "",
          "critical": true,
        },
        {
          "category": "Documentation",
          "item": "Safety data sheets",
          "status": "Pending",
          "notes": "",
          "critical": true,
        },
      ],
      "defects": [],
      "photos": [],
      "overallScore": 0,
      "notes": "Awaiting specialized hazmat inspection protocols",
      "recommendations": [],
    },
    {
      "id": "qc_005",
      "orderNumber": "ORD-2024-006",
      "packageId": "pkg_006_1",
      "customerName": "Global Electronics",
      "status": "Completed",
      "result": "Conditional Pass",
      "inspector": "Quality Manager",
      "startTime": "2024-03-15T10:00:00Z",
      "completionTime": "2024-03-15T11:30:00Z",
      "packageType": "Express Box",
      "totalItems": 5,
      "checkedItems": 5,
      "passedItems": 4,
      "failedItems": 1,
      "weight": 3.2,
      "dimensions": "50x35x25 cm",
      "trackingNumber": "TRK006789012",
      "checklistItems": [
        {
          "category": "Packaging",
          "item": "Express packaging standards",
          "status": "Passed",
          "notes": "Meets express delivery requirements",
          "critical": true,
        },
        {
          "category": "Labeling",
          "item": "Express shipping labels",
          "status": "Passed",
          "notes": "Priority labels correctly applied",
          "critical": true,
        },
        {
          "category": "Content",
          "item": "Item verification",
          "status": "Conditional",
          "notes": "1 item substituted with customer approval",
          "critical": false,
        },
        {
          "category": "Documentation",
          "item": "Shipping documentation",
          "status": "Passed",
          "notes": "All paperwork complete",
          "critical": true,
        },
      ],
      "defects": [
        {
          "type": "Substitution",
          "description": "Item substitution made",
          "severity": "Minor",
          "action": "Customer notification sent",
        },
      ],
      "photos": ["qc_005_photo1.jpg"],
      "overallScore": 85,
      "notes": "Package approved with conditional pass due to item substitution",
      "recommendations": ["Confirm customer acceptance of substitution before shipping"],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadQualityData();
  }

  void _loadQualityData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredQualityChecks {
    return qualityChecks.where((check) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${check["orderNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${check["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${check["inspector"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${check["packageType"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${check["trackingNumber"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All Status" || 
          check["status"] == selectedStatus;
      
      bool matchesResult = selectedResult == "All Results" || 
          check["result"] == selectedResult;
      
      bool matchesInspector = selectedInspector == "All Inspectors" || 
          check["inspector"] == selectedInspector;
      
      return matchesSearch && matchesStatus && matchesResult && matchesInspector;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Completed":
        return successColor;
      case "Failed":
        return dangerColor;
      case "Re-inspection":
        return Colors.orange;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Pending":
        return Icons.schedule;
      case "In Progress":
        return Icons.search;
      case "Completed":
        return Icons.check_circle;
      case "Failed":
        return Icons.error;
      case "Re-inspection":
        return Icons.refresh;
      default:
        return Icons.help;
    }
  }

  Color _getResultColor(String result) {
    switch (result) {
      case "Passed":
        return successColor;
      case "Failed":
        return dangerColor;
      case "Conditional Pass":
        return warningColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCheckItemStatusColor(String status) {
    switch (status) {
      case "Passed":
        return successColor;
      case "Failed":
        return dangerColor;
      case "Conditional":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Pending":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDefectSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "Major":
        return Colors.orange;
      case "Minor":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSummaryCards() {
    List<Map<String, dynamic>> displayChecks = filteredQualityChecks;
    int pendingChecks = displayChecks.where((c) => c["status"] == "Pending").length;
    int inProgressChecks = displayChecks.where((c) => c["status"] == "In Progress").length;
    int completedChecks = displayChecks.where((c) => c["status"] == "Completed").length;
    int failedChecks = displayChecks.where((c) => c["status"] == "Failed").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Pending", pendingChecks, warningColor, Icons.schedule),
        _buildSummaryCard("In Progress", inProgressChecks, primaryColor, Icons.search),
        _buildSummaryCard("Completed", completedChecks, successColor, Icons.check_circle),
        _buildSummaryCard("Failed", failedChecks, dangerColor, Icons.error),
      ],
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, IconData icon) {
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$count",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityCheckCard(Map<String, dynamic> check) {
    String status = "${check["status"]}";
    String result = "${check["result"]}";
    bool isCompleted = status == "Completed";
    bool hasFailed = status == "Failed" || result == "Failed";
    bool hasDefects = (check["defects"] as List).isNotEmpty;
    double itemProgress = check["totalItems"] > 0 ? (check["checkedItems"] as num) / (check["totalItems"] as num) : 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: _getStatusColor(status),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${check["orderNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (result.isNotEmpty) ...[
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getResultColor(result).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 10,
                      color: _getResultColor(result),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              Spacer(),
              if (hasDefects)
                Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 16,
                ),
              if (isCompleted && (check["overallScore"] as num) >= 90)
                Icon(
                  Icons.verified,
                  color: successColor,
                  size: 16,
                ),
            ],
          ),
          SizedBox(height: spSm),

          // Package and Inspector Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${check["customerName"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${check["inspector"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${check["packageType"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.scale, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${(check["weight"] as num).toStringAsFixed(1)}kg",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Inspection Progress
          if (check["totalItems"] > 0) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Inspection Progress: ${check["checkedItems"]}/${check["totalItems"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: itemProgress,
                        backgroundColor: Colors.grey.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCompleted ? successColor : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Column(
                  children: [
                    Text(
                      "${(itemProgress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? successColor : primaryColor,
                      ),
                    ),
                    if (isCompleted && (check["overallScore"] as num) > 0)
                      Text(
                        "Score: ${check["overallScore"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: (check["overallScore"] as num) >= 80 ? successColor : 
                                 (check["overallScore"] as num) >= 60 ? warningColor : dangerColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Sample Checklist Items (first 4)
          if ((check["checklistItems"] as List).isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checklist Items (${(check["checklistItems"] as List).length} total):",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: (check["checklistItems"] as List).take(4).map((item) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getCheckItemStatusColor("${item["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            if (item["critical"] == true)
                              Icon(
                                Icons.priority_high,
                                size: 10,
                                color: dangerColor,
                              ),
                            SizedBox(width: 2),
                            Text(
                              "${item["category"]}:",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${item["item"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "${item["status"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: _getCheckItemStatusColor("${item["status"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if ((check["checklistItems"] as List).length > 4)
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "... and ${(check["checklistItems"] as List).length - 4} more items",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Defects (if any)
          if (hasDefects) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Defects Found:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: (check["defects"] as List).map((defect) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: _getDefectSeverityColor("${defect["severity"]}").withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${defect["severity"]}",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: _getDefectSeverityColor("${defect["severity"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${defect["description"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Notes
          if ("${check["notes"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 12, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${check["notes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "Pending" ? "Start Inspection" : 
                         status == "In Progress" ? "Continue Inspection" :
                         status == "Completed" ? "View Details" :
                         status == "Failed" ? "Re-inspect" : "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.photo_camera,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
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

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Quality Check"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayChecks = filteredQualityChecks;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Check"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.checklist),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search quality checks...",
              value: searchQuery,
              hint: "Search by order, customer, inspector, or tracking number",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Result",
                    items: resultOptions,
                    value: selectedResult,
                    onChanged: (value, label) {
                      selectedResult = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Inspector",
              items: inspectorOptions,
              value: selectedInspector,
              onChanged: (value, label) {
                selectedInspector = value;
                setState(() {});
              },
            ),

            // Summary Cards
            _buildSummaryCards(),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${displayChecks.length} quality checks found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Quality Checks
            if (displayChecks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No quality checks found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or check back later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayChecks.map((check) => _buildQualityCheckCard(check)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
