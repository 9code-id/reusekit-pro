import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaQualityCheckView extends StatefulWidget {
  const ImaQualityCheckView({super.key});

  @override
  State<ImaQualityCheckView> createState() => _ImaQualityCheckViewState();
}

class _ImaQualityCheckViewState extends State<ImaQualityCheckView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedResult = "all";
  String sortBy = "inspection_date";
  
  List<Map<String, dynamic>> qualityChecks = [
    {
      "id": "QC-2024-001",
      "receipt_id": "GRN-2024-001",
      "po_number": "PO-2024-045",
      "supplier": "Tech Solutions Inc",
      "inspection_date": "2024-01-15",
      "inspector": "Mike Johnson",
      "status": "completed",
      "result": "passed",
      "priority": "high",
      "total_items": 25,
      "checked_items": 25,
      "defect_rate": 0.0,
      "warehouse": "Main Warehouse",
      "items": [
        {
          "item_code": "TH001",
          "name": "Wireless Headphones",
          "quantity": 10,
          "checked": 10,
          "passed": 10,
          "failed": 0,
          "defects": [],
          "result": "passed",
          "notes": "All units working properly",
        },
        {
          "item_code": "BS002",
          "name": "Bluetooth Speakers",
          "quantity": 15,
          "checked": 15,
          "passed": 15,
          "failed": 0,
          "defects": [],
          "result": "passed",
          "notes": "Sound quality excellent",
        },
      ],
      "checklist": [
        {"item": "Physical Damage Check", "status": "passed", "notes": "No damage found"},
        {"item": "Functional Test", "status": "passed", "notes": "All functions working"},
        {"item": "Packaging Integrity", "status": "passed", "notes": "Packaging intact"},
        {"item": "Documentation", "status": "passed", "notes": "All docs present"},
      ],
      "overall_notes": "All items meet quality standards",
      "approval_status": "approved",
      "approved_by": "Quality Manager",
      "approval_date": "2024-01-15",
    },
    {
      "id": "QC-2024-002",
      "receipt_id": "GRN-2024-002",
      "po_number": "PO-2024-042",
      "supplier": "Office Supplies Co",
      "inspection_date": "2024-01-14",
      "inspector": "Lisa Brown",
      "status": "completed",
      "result": "failed",
      "priority": "medium",
      "total_items": 50,
      "checked_items": 50,
      "defect_rate": 30.0,
      "warehouse": "Main Warehouse",
      "items": [
        {
          "item_code": "OC003",
          "name": "Office Chairs",
          "quantity": 20,
          "checked": 20,
          "passed": 20,
          "failed": 0,
          "defects": [],
          "result": "passed",
          "notes": "Good quality chairs",
        },
        {
          "item_code": "DL004",
          "name": "Desk Lamps",
          "quantity": 30,
          "checked": 30,
          "passed": 15,
          "failed": 15,
          "defects": ["Broken switch", "Loose connections", "Scratched surface"],
          "result": "failed",
          "notes": "Multiple defects found",
        },
      ],
      "checklist": [
        {"item": "Physical Damage Check", "status": "failed", "notes": "15 lamps damaged"},
        {"item": "Functional Test", "status": "failed", "notes": "Switch issues"},
        {"item": "Packaging Integrity", "status": "passed", "notes": "Packaging OK"},
        {"item": "Documentation", "status": "passed", "notes": "Docs present"},
      ],
      "overall_notes": "Significant defects in desk lamps, supplier notification required",
      "approval_status": "rejected",
      "approved_by": "Quality Manager",
      "approval_date": "2024-01-14",
    },
    {
      "id": "QC-2024-003",
      "receipt_id": "GRN-2024-003",
      "po_number": "PO-2024-040",
      "supplier": "Electronics World",
      "inspection_date": "2024-01-13",
      "inspector": "Tom Wilson",
      "status": "completed",
      "result": "passed",
      "priority": "high",
      "total_items": 100,
      "checked_items": 100,
      "defect_rate": 2.0,
      "warehouse": "Tech Warehouse",
      "items": [
        {
          "item_code": "LP005",
          "name": "Laptops",
          "quantity": 30,
          "checked": 30,
          "passed": 29,
          "failed": 1,
          "defects": ["Dead pixel"],
          "result": "conditional",
          "notes": "1 laptop with minor screen issue",
        },
        {
          "item_code": "MN006",
          "name": "Monitors",
          "quantity": 40,
          "checked": 40,
          "passed": 39,
          "failed": 1,
          "defects": ["Back panel crack"],
          "result": "conditional",
          "notes": "1 monitor with cosmetic damage",
        },
      ],
      "checklist": [
        {"item": "Physical Damage Check", "status": "conditional", "notes": "Minor issues found"},
        {"item": "Functional Test", "status": "passed", "notes": "All functions working"},
        {"item": "Packaging Integrity", "status": "passed", "notes": "Packaging intact"},
        {"item": "Documentation", "status": "passed", "notes": "All docs present"},
      ],
      "overall_notes": "Minor defects acceptable for business use",
      "approval_status": "conditional",
      "approved_by": "Quality Manager",
      "approval_date": "2024-01-13",
    },
    {
      "id": "QC-2024-004",
      "receipt_id": "GRN-2024-004",
      "po_number": "PO-2024-038",
      "supplier": "Medical Supplies Ltd",
      "inspection_date": null,
      "inspector": "Dr. Smith",
      "status": "pending",
      "result": "pending",
      "priority": "high",
      "total_items": 75,
      "checked_items": 0,
      "defect_rate": 0.0,
      "warehouse": "Medical Warehouse",
      "items": [
        {
          "item_code": "FK007",
          "name": "First Aid Kits",
          "quantity": 25,
          "checked": 0,
          "passed": 0,
          "failed": 0,
          "defects": [],
          "result": "pending",
          "notes": "Awaiting inspection",
        },
        {
          "item_code": "SE008",
          "name": "Safety Equipment",
          "quantity": 50,
          "checked": 0,
          "passed": 0,
          "failed": 0,
          "defects": [],
          "result": "pending",
          "notes": "Awaiting inspection",
        },
      ],
      "checklist": [
        {"item": "Physical Damage Check", "status": "pending", "notes": ""},
        {"item": "Functional Test", "status": "pending", "notes": ""},
        {"item": "Expiry Date Check", "status": "pending", "notes": ""},
        {"item": "Certification Validation", "status": "pending", "notes": ""},
      ],
      "overall_notes": "Medical supplies requiring specialized inspection",
      "approval_status": "pending",
      "approved_by": null,
      "approval_date": null,
    },
    {
      "id": "QC-2024-005",
      "receipt_id": "GRN-2024-005",
      "po_number": "PO-2024-050",
      "supplier": "Furniture Plus",
      "inspection_date": "2024-01-16",
      "inspector": "Robert Jones",
      "status": "in_progress",
      "result": "pending",
      "priority": "medium",
      "total_items": 40,
      "checked_items": 20,
      "defect_rate": 0.0,
      "warehouse": "Furniture Warehouse",
      "items": [
        {
          "item_code": "CT009",
          "name": "Conference Tables",
          "quantity": 5,
          "checked": 5,
          "passed": 5,
          "failed": 0,
          "defects": [],
          "result": "passed",
          "notes": "Excellent build quality",
        },
        {
          "item_code": "EC010",
          "name": "Executive Chairs",
          "quantity": 15,
          "checked": 15,
          "passed": 15,
          "failed": 0,
          "defects": [],
          "result": "passed",
          "notes": "Good upholstery and comfort",
        },
      ],
      "checklist": [
        {"item": "Physical Damage Check", "status": "passed", "notes": "No damage found"},
        {"item": "Assembly Quality", "status": "passed", "notes": "Well assembled"},
        {"item": "Material Quality", "status": "in_progress", "notes": "Checking wood quality"},
        {"item": "Finish Quality", "status": "pending", "notes": ""},
      ],
      "overall_notes": "Inspection in progress, looks promising so far",
      "approval_status": "pending",
      "approved_by": null,
      "approval_date": null,
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> resultItems = [
    {"label": "All Results", "value": "all"},
    {"label": "Passed", "value": "passed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Conditional", "value": "conditional"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Inspection Date", "value": "inspection_date"},
    {"label": "QC Number", "value": "id"},
    {"label": "Supplier", "value": "supplier"},
    {"label": "Priority", "value": "priority"},
    {"label": "Defect Rate", "value": "defect_rate"},
  ];

  List<Map<String, dynamic>> get filteredQualityChecks {
    var items = qualityChecks.where((item) {
      bool matchesSearch = item["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["po_number"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["inspector"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "all" || item["priority"] == selectedPriority;
      bool matchesResult = selectedResult == "all" || item["result"] == selectedResult;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesResult;
    }).toList();

    items.sort((a, b) {
      switch (sortBy) {
        case "inspection_date":
          if (a["inspection_date"] == null && b["inspection_date"] == null) return 0;
          if (a["inspection_date"] == null) return 1;
          if (b["inspection_date"] == null) return -1;
          return b["inspection_date"].compareTo(a["inspection_date"]);
        case "id":
          return a["id"].compareTo(b["id"]);
        case "supplier":
          return a["supplier"].compareTo(b["supplier"]);
        case "priority":
          var priorityOrder = {"high": 0, "medium": 1, "low": 2};
          return (priorityOrder[a["priority"]] ?? 3).compareTo(priorityOrder[b["priority"]] ?? 3);
        case "defect_rate":
          return (b["defect_rate"] as double).compareTo(a["defect_rate"] as double);
        default:
          return 0;
      }
    });

    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "pending":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getResultColor(String result) {
    switch (result) {
      case "passed":
        return successColor;
      case "failed":
        return dangerColor;
      case "conditional":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getApprovalColor(String? approval) {
    switch (approval) {
      case "approved":
        return successColor;
      case "rejected":
        return dangerColor;
      case "conditional":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _showQualityCheckDetails(Map<String, dynamic> qc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${qc["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Receipt: ${qc["receipt_id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getResultColor(qc["result"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getResultColor(qc["result"]),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "${qc["result"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getResultColor(qc["result"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Information
                    Text(
                      "Inspection Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildInfoRow("PO Number", "${qc["po_number"]}"),
                    _buildInfoRow("Supplier", "${qc["supplier"]}"),
                    _buildInfoRow("Inspector", "${qc["inspector"]}"),
                    if (qc["inspection_date"] != null)
                      _buildInfoRow("Inspection Date", "${qc["inspection_date"]}"),
                    _buildInfoRow("Warehouse", "${qc["warehouse"]}"),
                    _buildInfoRow("Total Items", "${qc["total_items"]}"),
                    _buildInfoRow("Checked Items", "${qc["checked_items"]}"),
                    _buildInfoRow("Defect Rate", "${(qc["defect_rate"] as double).toStringAsFixed(1)}%"),
                    
                    // Approval Information
                    SizedBox(height: spMd),
                    Text(
                      "Approval Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildInfoRow("Approval Status", "${qc["approval_status"]}".toUpperCase()),
                    if (qc["approved_by"] != null)
                      _buildInfoRow("Approved By", "${qc["approved_by"]}"),
                    if (qc["approval_date"] != null)
                      _buildInfoRow("Approval Date", "${qc["approval_date"]}"),
                    
                    // Quality Checklist
                    SizedBox(height: spMd),
                    Text(
                      "Quality Checklist",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ...(qc["checklist"] as List).map((check) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _getResultColor(check["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: _getResultColor(check["status"]),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                check["status"] == "passed" ? Icons.check :
                                check["status"] == "failed" ? Icons.close :
                                check["status"] == "in_progress" ? Icons.more_horiz :
                                Icons.schedule,
                                size: 12,
                                color: _getResultColor(check["status"]),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${check["item"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (check["notes"] != null && check["notes"].toString().isNotEmpty)
                                    Text(
                                      "${check["notes"]}",
                                      style: TextStyle(
                                        fontSize: 12,
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
                    }).toList(),
                    
                    // Items Details
                    SizedBox(height: spMd),
                    Text(
                      "Items Inspection",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ...(qc["items"] as List).map((item) {
                      double passRate = (item["quantity"] as int) > 0 
                          ? (item["passed"] as int) / (item["quantity"] as int) 
                          : 0.0;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Code: ${item["item_code"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getResultColor(item["result"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["result"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getResultColor(item["result"]),
                                    ),
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
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["quantity"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
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
                                        "Checked",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["checked"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
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
                                        "Passed",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["passed"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
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
                                        "Failed",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["failed"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
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
                                Text(
                                  "Pass Rate: ${(passRate * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Quality: ${item["result"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _getResultColor(item["result"]),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            LinearProgressIndicator(
                              value: passRate,
                              backgroundColor: disabledColor.withAlpha(30),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                passRate >= 0.9 ? successColor : 
                                passRate >= 0.7 ? warningColor : dangerColor,
                              ),
                            ),
                            
                            if ((item["defects"] as List).isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Text(
                                "Defects Found:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...((item["defects"] as List).map((defect) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: spXs),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: dangerColor.withAlpha(100),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    "• $defect",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: dangerColor,
                                    ),
                                  ),
                                );
                              }).toList()),
                            ],
                            
                            if (item["notes"] != null && item["notes"].toString().isNotEmpty) ...[
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                    
                    // Overall Notes
                    if (qc["overall_notes"] != null && qc["overall_notes"].toString().isNotEmpty) ...[
                      SizedBox(height: spMd),
                      Text(
                        "Overall Notes",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${qc["overall_notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (qc["status"] == "pending" || qc["status"] == "in_progress")
                    Expanded(
                      child: QButton(
                        label: qc["status"] == "pending" ? "Start Inspection" : "Continue",
                        size: bs.md,
                        onPressed: () {
                          back();
                          _startInspection(qc);
                        },
                      ),
                    ),
                  if (qc["status"] == "pending" || qc["status"] == "in_progress")
                    SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Export Report",
                      size: bs.md,
                      onPressed: () {
                        back();
                        _exportReport(qc);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startInspection(Map<String, dynamic> qc) {
    si("Starting inspection for ${qc["id"]}");
  }

  void _exportReport(Map<String, dynamic> qc) {
    si("Exporting quality report for ${qc["id"]}");
  }

  void _generateAnalytics() {
    si("Generating quality analytics");
  }

  void _bulkApproval() {
    si("Bulk approval selected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Check"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: _generateAnalytics,
          ),
          IconButton(
            icon: Icon(Icons.approval),
            onPressed: _bulkApproval,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.verified,
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
                                  "Total Inspections",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${qualityChecks.length}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Passed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${qualityChecks.where((item) => item["result"] == "passed").length}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.error,
                              color: dangerColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Failed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${qualityChecks.where((item) => item["result"] == "failed").length}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.trending_down,
                              color: infoColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg Defect Rate",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${((qualityChecks.fold(0.0, (sum, item) => sum + (item["defect_rate"] as double))) / qualityChecks.length).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search quality checks...",
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
                    label: "Status",
                    items: statusItems,
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
                    label: "Priority",
                    items: priorityItems,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
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
                    label: "Result",
                    items: resultItems,
                    value: selectedResult,
                    onChanged: (value, label) {
                      selectedResult = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Quality Checks List
            Text(
              "Quality Checks (${filteredQualityChecks.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...filteredQualityChecks.map((qc) {
              double progress = (qc["total_items"] as int) > 0 
                  ? (qc["checked_items"] as int) / (qc["total_items"] as int) 
                  : 0.0;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radiusMd),
                    onTap: () => _showQualityCheckDetails(qc),
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${qc["id"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Receipt: ${qc["receipt_id"]}",
                                      style: TextStyle(
                                        fontSize: 14,
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getResultColor(qc["result"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(
                                        color: _getResultColor(qc["result"]),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "${qc["result"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getResultColor(qc["result"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(qc["priority"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${qc["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getPriorityColor(qc["priority"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${qc["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(qc["defect_rate"] as double).toStringAsFixed(1)}% defects",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (qc["defect_rate"] as double) == 0 ? successColor :
                                         (qc["defect_rate"] as double) < 10 ? warningColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${qc["inspector"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (qc["inspection_date"] != null) ...[
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${qc["inspection_date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Text(
                                "Progress: ${qc["checked_items"]}/${qc["total_items"]} items",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(progress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: progress >= 1.0 ? successColor : progress > 0 ? infoColor : warningColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: disabledColor.withAlpha(30),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progress >= 1.0 ? successColor : progress > 0 ? infoColor : warningColor,
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(qc["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        qc["status"] == "completed" ? Icons.check_circle :
                                        qc["status"] == "in_progress" ? Icons.pending :
                                        Icons.schedule,
                                        size: 14,
                                        color: _getStatusColor(qc["status"]),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${qc["status"]}".replaceAll("_", " ").toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor(qc["status"]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getApprovalColor(qc["approval_status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      qc["approval_status"] == "approved" ? Icons.verified :
                                      qc["approval_status"] == "rejected" ? Icons.cancel :
                                      qc["approval_status"] == "conditional" ? Icons.warning :
                                      Icons.pending,
                                      size: 14,
                                      color: _getApprovalColor(qc["approval_status"]),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${qc["approval_status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getApprovalColor(qc["approval_status"]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            
            if (filteredQualityChecks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No quality checks found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
