import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMobileSignaturesView extends StatefulWidget {
  const FsmMobileSignaturesView({super.key});

  @override
  State<FsmMobileSignaturesView> createState() => _FsmMobileSignaturesViewState();
}

class _FsmMobileSignaturesViewState extends State<FsmMobileSignaturesView> {
  String searchQuery = "";
  String selectedType = "";
  String selectedStatus = "";

  List<Map<String, dynamic>> signatures = [
    {
      "id": "SIG-001",
      "title": "Work Order Completion - Metro Office",
      "type": "Customer Approval",
      "signedBy": "John Mitchell",
      "signedByRole": "Building Manager",
      "signedDate": "2024-12-20 11:45:00",
      "workOrder": "WO-2024-001",
      "customer": "Metro Office Complex",
      "technician": "Alex Johnson",
      "status": "Completed",
      "signatureImage": "https://picsum.photos/200/100?random=1&keyword=signature",
      "documentType": "Work Completion Form",
      "notes": "Customer satisfied with HVAC maintenance work",
      "location": "Downtown Service Center",
      "deviceInfo": "iPad - Field App v2.1",
      "witnessName": "Sarah Johnson",
      "witnessRole": "Facility Coordinator",
    },
    {
      "id": "SIG-002",
      "title": "Safety Inspection Acknowledgment",
      "type": "Safety Compliance",
      "signedBy": "Maria Rodriguez",
      "signedByRole": "Field Supervisor",
      "signedDate": "2024-12-20 09:30:00",
      "workOrder": "",
      "customer": "Construction Site Alpha",
      "technician": "Maria Rodriguez",
      "status": "Completed",
      "signatureImage": "https://picsum.photos/200/100?random=2&keyword=signature",
      "documentType": "Safety Checklist",
      "notes": "All safety protocols verified and documented",
      "location": "Construction Site Alpha",
      "deviceInfo": "Samsung Tablet - Field App v2.1",
      "witnessName": "David Chen",
      "witnessRole": "Site Manager",
    },
    {
      "id": "SIG-003",
      "title": "Material Delivery Confirmation",
      "type": "Delivery Receipt",
      "signedBy": "Jennifer Park",
      "signedByRole": "Warehouse Manager",
      "signedDate": "2024-12-20 14:15:00",
      "workOrder": "WO-2024-003",
      "customer": "Creative Design Studio",
      "technician": "David Kim",
      "status": "Pending",
      "signatureImage": "",
      "documentType": "Material Receipt",
      "notes": "Electrical materials delivered for installation project",
      "location": "Creative District",
      "deviceInfo": "iPhone - Field App v2.1",
      "witnessName": "",
      "witnessRole": "",
    },
    {
      "id": "SIG-004",
      "title": "Emergency Response Authorization",
      "type": "Emergency Authorization",
      "signedBy": "Robert Williams",
      "signedByRole": "Property Owner",
      "signedDate": "2024-12-19 20:30:00",
      "workOrder": "WO-2024-002",
      "customer": "Riverside Apartments",
      "technician": "Maria Rodriguez",
      "status": "Completed",
      "signatureImage": "https://picsum.photos/200/100?random=3&keyword=signature",
      "documentType": "Emergency Work Authorization",
      "notes": "Emergency plumbing repair authorized due to water leak",
      "location": "Riverside District",
      "deviceInfo": "iPhone - Field App v2.1",
      "witnessName": "Lisa Brown",
      "witnessRole": "Building Superintendent",
    },
    {
      "id": "SIG-005",
      "title": "Equipment Maintenance Sign-off",
      "type": "Maintenance Approval",
      "signedBy": "Thomas Anderson",
      "signedByRole": "Equipment Owner",
      "signedDate": "2024-12-20 16:00:00",
      "workOrder": "",
      "customer": "TechMart Electronics",
      "technician": "Sarah Wilson",
      "status": "In Progress",
      "signatureImage": "",
      "documentType": "Equipment Maintenance Log",
      "notes": "Monthly security system maintenance in progress",
      "location": "Tech Avenue",
      "deviceInfo": "iPad - Field App v2.1",
      "witnessName": "Michelle Lee",
      "witnessRole": "Store Manager",
    },
    {
      "id": "SIG-006",
      "title": "Training Completion Certificate",
      "type": "Training Completion",
      "signedBy": "James Chen",
      "signedByRole": "Team Lead",
      "signedDate": "2024-12-20 17:30:00",
      "workOrder": "",
      "customer": "",
      "technician": "David Kim",
      "status": "Completed",
      "signatureImage": "https://picsum.photos/200/100?random=4&keyword=signature",
      "documentType": "Training Certificate",
      "notes": "Safety training and equipment certification completed",
      "location": "Main Office",
      "deviceInfo": "iPad - Field App v2.1",
      "witnessName": "Patricia Davis",
      "witnessRole": "HR Manager",
    },
  ];

  List<Map<String, dynamic>> get filteredSignatures {
    return signatures.where((signature) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${signature["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${signature["signedBy"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${signature["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType.isEmpty || signature["type"] == selectedType;
      bool matchesStatus = selectedStatus.isEmpty || signature["status"] == selectedStatus;
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Pending":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "Customer Approval":
        return primaryColor;
      case "Safety Compliance":
        return successColor;
      case "Delivery Receipt":
        return infoColor;
      case "Emergency Authorization":
        return dangerColor;
      case "Maintenance Approval":
        return warningColor;
      case "Training Completion":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case "Customer Approval":
        return Icons.approval;
      case "Safety Compliance":
        return Icons.security;
      case "Delivery Receipt":
        return Icons.local_shipping;
      case "Emergency Authorization":
        return Icons.emergency;
      case "Maintenance Approval":
        return Icons.build;
      case "Training Completion":
        return Icons.school;
      default:
        return Icons.edit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Signatures"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // navigateTo('NewSignatureView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    label: "Search signatures...",
                    value: searchQuery,
                    hint: "Search by title, signer, or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: [
                            {"label": "All Types", "value": ""},
                            {"label": "Customer Approval", "value": "Customer Approval"},
                            {"label": "Safety Compliance", "value": "Safety Compliance"},
                            {"label": "Delivery Receipt", "value": "Delivery Receipt"},
                            {"label": "Emergency Authorization", "value": "Emergency Authorization"},
                            {"label": "Maintenance Approval", "value": "Maintenance Approval"},
                            {"label": "Training Completion", "value": "Training Completion"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": ""},
                            {"label": "Completed", "value": "Completed"},
                            {"label": "Pending", "value": "Pending"},
                            {"label": "In Progress", "value": "In Progress"},
                            {"label": "Expired", "value": "Expired"},
                          ],
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
            ),

            // Signature Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.draw, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${signatures.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${signatures.where((s) => s["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${signatures.where((s) => s["status"] == "Pending" || s["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flash_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "New Signature",
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('CreateSignatureView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Customer Approval",
                          icon: Icons.approval,
                          color: primaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('CustomerApprovalView')
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Safety Sign-off",
                          icon: Icons.security,
                          color: successColor,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('SafetySignoffView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Signatures",
                          icon: Icons.download,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            ss("Signatures exported successfully");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Signatures List
            Container(
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
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Signatures (${filteredSignatures.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredSignatures.map((signature) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: getTypeColor("${signature["type"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  getTypeIcon("${signature["type"]}"),
                                  color: getTypeColor("${signature["type"]}"),
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${signature["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${signature["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getStatusColor("${signature["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${signature["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${signature["signedBy"]} (${signature["signedByRole"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ("${signature["customer"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.business, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "${signature["customer"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          if ("${signature["workOrder"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.work, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "Work Order: ${signature["workOrder"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${DateTime.parse("${signature["signedDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${signature["location"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if ("${signature["witnessName"]}".isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "Witness: ${signature["witnessName"]} (${signature["witnessRole"]})",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          if ("${signature["notes"]}".isNotEmpty)
                            Text(
                              "${signature["notes"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: disabledBoldColor,
                              ),
                            ),
                          if ("${signature["signatureImage"]}".isNotEmpty)
                            Container(
                              width: double.infinity,
                              height: 80,
                              margin: EdgeInsets.symmetric(vertical: spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledOutlineBorderColor),
                                image: DecorationImage(
                                  image: NetworkImage("${signature["signatureImage"]}"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('SignatureDetailView')
                                },
                              ),
                              SizedBox(width: spSm),
                              if ("${signature["status"]}" == "Completed")
                                QButton(
                                  label: "Download",
                                  icon: Icons.download,
                                  size: bs.sm,
                                  color: successColor,
                                  onPressed: () {
                                    ss("Signature downloaded");
                                  },
                                ),
                              if ("${signature["status"]}" == "Pending")
                                QButton(
                                  label: "Complete",
                                  size: bs.sm,
                                  color: primaryColor,
                                  onPressed: () {
                                    // navigateTo('CompleteSignatureView')
                                  },
                                ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Share",
                                icon: Icons.share,
                                size: bs.sm,
                                color: infoColor,
                                onPressed: () {
                                  ss("Signature shared");
                                },
                              ),
                            ],
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
      ),
    );
  }
}
