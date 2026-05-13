import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaReturnAuthorizationView extends StatefulWidget {
  const ImaReturnAuthorizationView({super.key});

  @override
  State<ImaReturnAuthorizationView> createState() => _ImaReturnAuthorizationViewState();
}

class _ImaReturnAuthorizationViewState extends State<ImaReturnAuthorizationView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Pending Review", "value": "Pending Review"},
    {"label": "Under Investigation", "value": "Under Investigation"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All"},
    {"label": "Standard Return", "value": "Standard Return"},
    {"label": "Warranty Claim", "value": "Warranty Claim"},
    {"label": "Damage Claim", "value": "Damage Claim"},
    {"label": "Quality Issue", "value": "Quality Issue"},
    {"label": "Wrong Item", "value": "Wrong Item"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> authorizations = [
    {
      "id": "RMA-2024-001",
      "returnId": "RET-2024-001",
      "orderNumber": "ORD-45892",
      "customer": "John Doe",
      "email": "john.doe@email.com",
      "phone": "+1 555-0123",
      "status": "Pending Review",
      "type": "Warranty Claim",
      "priority": "High",
      "submittedDate": "2024-06-19",
      "reviewDeadline": "2024-06-26",
      "assignedTo": null,
      "reviewedBy": null,
      "reviewedDate": null,
      "approvalCode": null,
      "expiryDate": null,
      "estimatedValue": 599.99,
      "restockingFee": 0.00,
      "shippingLabel": false,
      "reason": "Product stopped working after 2 weeks",
      "description": "Smartphone randomly shuts down and won't turn back on. Already tried factory reset and different chargers.",
      "warrantyStatus": "Active",
      "purchaseDate": "2024-06-05",
      "warrantyExpiry": "2025-06-05",
      "supportingDocs": [
        "https://picsum.photos/300/400?random=1",
        "https://picsum.photos/300/400?random=2"
      ],
      "items": [
        {
          "sku": "ELEC-001",
          "name": "Smartphone Pro Max",
          "quantity": 1,
          "originalPrice": 599.99,
          "currentValue": 599.99,
          "condition": "Defective",
          "serialNumber": "SN123456789"
        }
      ],
      "returnInstructions": null,
      "reviewNotes": []
    },
    {
      "id": "RMA-2024-002",
      "returnId": "RET-2024-002",
      "orderNumber": "ORD-45893",
      "customer": "Sarah Smith",
      "email": "sarah.smith@email.com",
      "phone": "+1 555-0124",
      "status": "Under Investigation",
      "type": "Damage Claim",
      "priority": "Medium",
      "submittedDate": "2024-06-18",
      "reviewDeadline": "2024-06-25",
      "assignedTo": "Investigation Team",
      "reviewedBy": null,
      "reviewedDate": null,
      "approvalCode": null,
      "expiryDate": null,
      "estimatedValue": 899.99,
      "restockingFee": 45.00,
      "shippingLabel": false,
      "reason": "Damaged during shipping",
      "description": "Laptop arrived with cracked screen and dents on the case. Packaging was also damaged.",
      "warrantyStatus": "N/A",
      "purchaseDate": "2024-06-16",
      "warrantyExpiry": null,
      "supportingDocs": [
        "https://picsum.photos/300/400?random=3",
        "https://picsum.photos/300/400?random=4",
        "https://picsum.photos/300/400?random=5"
      ],
      "items": [
        {
          "sku": "COMP-001",
          "name": "Gaming Laptop",
          "quantity": 1,
          "originalPrice": 899.99,
          "currentValue": 854.99,
          "condition": "Damaged",
          "serialNumber": "LT987654321"
        }
      ],
      "returnInstructions": null,
      "reviewNotes": [
        {
          "date": "2024-06-18",
          "reviewer": "Mike Johnson",
          "note": "Initial review started. Photos show significant damage to packaging and product."
        }
      ]
    },
    {
      "id": "RMA-2024-003",
      "returnId": "RET-2024-003",
      "orderNumber": "ORD-45894",
      "customer": "Tech Solutions Ltd",
      "email": "orders@techsolutions.com",
      "phone": "+1 555-0125",
      "status": "Approved",
      "type": "Quality Issue",
      "priority": "High",
      "submittedDate": "2024-06-17",
      "reviewDeadline": "2024-06-24",
      "assignedTo": "Quality Team",
      "reviewedBy": "Lisa Davis",
      "reviewedDate": "2024-06-18",
      "approvalCode": "RMA-APPR-789123",
      "expiryDate": "2024-07-02",
      "estimatedValue": 2400.00,
      "restockingFee": 0.00,
      "shippingLabel": true,
      "reason": "Multiple units with same defect",
      "description": "Ordered 4 monitors, all have flickering issue and color distortion. Clearly a batch quality problem.",
      "warrantyStatus": "Active",
      "purchaseDate": "2024-06-15",
      "warrantyExpiry": "2027-06-15",
      "supportingDocs": [
        "https://picsum.photos/300/400?random=6",
        "https://picsum.photos/300/400?random=7"
      ],
      "items": [
        {
          "sku": "MON-001",
          "name": "4K Monitor",
          "quantity": 4,
          "originalPrice": 600.00,
          "currentValue": 600.00,
          "condition": "Defective",
          "serialNumber": "MON001-004"
        }
      ],
      "returnInstructions": "Pack all items in original boxes. Use provided shipping label. Include all accessories.",
      "reviewNotes": [
        {
          "date": "2024-06-17",
          "reviewer": "Quality Team",
          "note": "Received batch quality complaint. Similar issues reported by other customers."
        },
        {
          "date": "2024-06-18",
          "reviewer": "Lisa Davis",
          "note": "Approved for full refund. Known batch issue confirmed. No restocking fee."
        }
      ]
    },
    {
      "id": "RMA-2024-004",
      "returnId": "RET-2024-004",
      "orderNumber": "ORD-45895",
      "customer": "Emma Wilson",
      "email": "emma.wilson@email.com",
      "phone": "+1 555-0126",
      "status": "Rejected",
      "type": "Standard Return",
      "priority": "Low",
      "submittedDate": "2024-06-15",
      "reviewDeadline": "2024-06-22",
      "assignedTo": "Return Team",
      "reviewedBy": "David Brown",
      "reviewedDate": "2024-06-16",
      "approvalCode": null,
      "expiryDate": null,
      "estimatedValue": 0.00,
      "restockingFee": 0.00,
      "shippingLabel": false,
      "reason": "Changed mind",
      "description": "Product works fine but customer no longer needs it. Return requested after 60 days.",
      "warrantyStatus": "Active",
      "purchaseDate": "2024-04-10",
      "warrantyExpiry": "2025-04-10",
      "rejectionReason": "Return window expired. Our policy allows returns within 30 days of purchase.",
      "supportingDocs": [],
      "items": [
        {
          "sku": "HOME-001",
          "name": "Smart Thermostat",
          "quantity": 1,
          "originalPrice": 199.99,
          "currentValue": 199.99,
          "condition": "Like New",
          "serialNumber": "THM192837465"
        }
      ],
      "returnInstructions": null,
      "reviewNotes": [
        {
          "date": "2024-06-16",
          "reviewer": "David Brown",
          "note": "Return request submitted beyond 30-day policy window. Customer notified of rejection."
        }
      ]
    },
    {
      "id": "RMA-2024-005",
      "returnId": "RET-2024-005",
      "orderNumber": "ORD-45896",
      "customer": "Business Corp",
      "email": "procurement@businesscorp.com",
      "phone": "+1 555-0127",
      "status": "Expired",
      "type": "Wrong Item",
      "priority": "Medium",
      "submittedDate": "2024-06-10",
      "reviewDeadline": "2024-06-17",
      "assignedTo": "Return Team",
      "reviewedBy": null,
      "reviewedDate": null,
      "approvalCode": "RMA-APPR-456789",
      "expiryDate": "2024-06-17",
      "estimatedValue": 1299.99,
      "restockingFee": 0.00,
      "shippingLabel": true,
      "reason": "Wrong item shipped",
      "description": "Ordered desktop computers but received tablets instead. Completely wrong products.",
      "warrantyStatus": "N/A",
      "purchaseDate": "2024-06-08",
      "warrantyExpiry": null,
      "supportingDocs": [
        "https://picsum.photos/300/400?random=8"
      ],
      "items": [
        {
          "sku": "TAB-001",
          "name": "Tablet (Wrong Item)",
          "quantity": 3,
          "originalPrice": 433.33,
          "currentValue": 433.33,
          "condition": "New",
          "serialNumber": "TAB001-003"
        }
      ],
      "returnInstructions": "Return all items in original packaging. Customer will receive correct items after return processed.",
      "reviewNotes": [
        {
          "date": "2024-06-10",
          "reviewer": "System",
          "note": "Auto-approved due to wrong item shipped. Customer has 7 days to return."
        }
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredAuthorizations {
    return authorizations.where((auth) {
      final matchesSearch = auth["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          auth["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          auth["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          auth["returnId"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || auth["status"] == selectedStatus;
      final matchesType = selectedType == "All" || auth["type"] == selectedType;
      final matchesPriority = selectedPriority == "All" || auth["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesType && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Under Investigation":
        return primaryColor;
      case "Pending Review":
        return warningColor;
      case "Rejected":
        return dangerColor;
      case "Expired":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _approveAuthorization(Map<String, dynamic> auth) {
    showDialog(
      context: context,
      builder: (context) {
        String approvalCode = "RMA-APPR-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
        DateTime expiryDate = DateTime.now().add(Duration(days: 14));
        bool includeShippingLabel = true;
        String returnInstructions = "Package items securely in original packaging. Include all accessories and documentation.";
        
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text("Approve Return Authorization"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QTextField(
                    label: "Approval Code",
                    value: approvalCode,
                    onChanged: (value) {
                      approvalCode = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDatePicker(
                    label: "Expiry Date",
                    value: expiryDate,
                    onChanged: (value) {
                      expiryDate = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    label: "Include Shipping Label",
                    items: [
                      {
                        "label": "Include prepaid shipping label",
                        "value": true,
                        "checked": includeShippingLabel,
                      }
                    ],
                    value: includeShippingLabel ? [{"label": "Include prepaid shipping label", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      includeShippingLabel = values.isNotEmpty;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Return Instructions",
                    value: returnInstructions,
                    onChanged: (value) {
                      returnInstructions = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
            ),
            actions: [
              QButton(
                label: "Cancel",
                size: bs.sm,
                onPressed: () => Navigator.pop(context),
              ),
              QButton(
                label: "Approve",
                size: bs.sm,
                onPressed: () {
                  auth["status"] = "Approved";
                  auth["approvalCode"] = approvalCode;
                  auth["expiryDate"] = expiryDate.toIso8601String().split('T')[0];
                  auth["shippingLabel"] = includeShippingLabel;
                  auth["returnInstructions"] = returnInstructions;
                  auth["reviewedBy"] = "Current User";
                  auth["reviewedDate"] = DateTime.now().toIso8601String().split('T')[0];
                  setState(() {});
                  Navigator.pop(context);
                  ss("Return authorization approved: ${auth["id"]}");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _rejectAuthorization(Map<String, dynamic> auth) {
    showDialog(
      context: context,
      builder: (context) {
        String rejectionReason = "";
        
        return AlertDialog(
          title: Text("Reject Return Authorization"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Provide reason for rejection:"),
              SizedBox(height: spSm),
              QMemoField(
                label: "Rejection Reason",
                value: rejectionReason,
                onChanged: (value) {
                  rejectionReason = value;
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
            QButton(
              label: "Reject",
              size: bs.sm,
              onPressed: () {
                if (rejectionReason.isNotEmpty) {
                  auth["status"] = "Rejected";
                  auth["rejectionReason"] = rejectionReason;
                  auth["reviewedBy"] = "Current User";
                  auth["reviewedDate"] = DateTime.now().toIso8601String().split('T')[0];
                  setState(() {});
                  Navigator.pop(context);
                  ss("Return authorization rejected: ${auth["id"]}");
                } else {
                  se("Please provide a rejection reason");
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _assignForInvestigation(Map<String, dynamic> auth) {
    showDialog(
      context: context,
      builder: (context) {
        String assignedTo = "Investigation Team";
        List<String> teams = [
          "Investigation Team",
          "Quality Team",
          "Warranty Team",
          "Customer Service",
          "Technical Support"
        ];
        
        return AlertDialog(
          title: Text("Assign for Investigation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Assign To",
                items: teams.map((team) => {"label": team, "value": team}).toList(),
                value: assignedTo,
                onChanged: (value, label) {
                  assignedTo = value;
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
            QButton(
              label: "Assign",
              size: bs.sm,
              onPressed: () {
                auth["status"] = "Under Investigation";
                auth["assignedTo"] = assignedTo;
                setState(() {});
                Navigator.pop(context);
                ss("Assigned to $assignedTo for investigation: ${auth["id"]}");
              },
            ),
          ],
        );
      },
    );
  }

  void _viewAuthorizationDetails(Map<String, dynamic> auth) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Authorization Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("RMA ID: ${auth["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Return ID: ${auth["returnId"]}"),
              Text("Order: ${auth["orderNumber"]}"),
              Text("Customer: ${auth["customer"]}"),
              Text("Email: ${auth["email"]}"),
              Text("Status: ${auth["status"]}"),
              Text("Type: ${auth["type"]}"),
              Text("Priority: ${auth["priority"]}"),
              Text("Submitted: ${auth["submittedDate"]}"),
              if (auth["reviewDeadline"] != null)
                Text("Deadline: ${auth["reviewDeadline"]}"),
              if (auth["assignedTo"] != null)
                Text("Assigned To: ${auth["assignedTo"]}"),
              if (auth["reviewedBy"] != null)
                Text("Reviewed By: ${auth["reviewedBy"]}"),
              if (auth["approvalCode"] != null)
                Text("Approval Code: ${auth["approvalCode"]}"),
              if (auth["expiryDate"] != null)
                Text("Expires: ${auth["expiryDate"]}"),
              Text("Estimated Value: \$${(auth["estimatedValue"] as double).currency}"),
              if (auth["restockingFee"] > 0)
                Text("Restocking Fee: \$${(auth["restockingFee"] as double).currency}"),
              if (auth["warrantyStatus"] != null)
                Text("Warranty: ${auth["warrantyStatus"]}"),
              SizedBox(height: spSm),
              Text("Reason:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${auth["reason"]}"),
              SizedBox(height: spSm),
              Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${auth["description"]}"),
              if (auth["rejectionReason"] != null) ...[
                SizedBox(height: spSm),
                Text("Rejection Reason:", style: TextStyle(fontWeight: FontWeight.bold, color: dangerColor)),
                Text("${auth["rejectionReason"]}", style: TextStyle(color: dangerColor)),
              ],
              if (auth["returnInstructions"] != null) ...[
                SizedBox(height: spSm),
                Text("Return Instructions:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${auth["returnInstructions"]}"),
              ],
              SizedBox(height: spSm),
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((auth["items"] as List).map((item) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${item["name"]} (${item["quantity"]}) - \$${(item["originalPrice"] as double).currency}"),
              ))),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _viewSupportingDocs(Map<String, dynamic> auth) {
    if ((auth["supportingDocs"] as List).isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Supporting Documents"),
          content: Container(
            height: 400,
            width: double.maxFinite,
            child: QHorizontalScroll(
              children: (auth["supportingDocs"] as List).map<Widget>((docUrl) => 
                Container(
                  width: 250,
                  margin: EdgeInsets.only(right: spSm),
                  child: Image.network(
                    "$docUrl",
                    fit: BoxFit.cover,
                  ),
                )
              ).toList(),
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildAuthorizationCard(Map<String, dynamic> auth) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                      "${auth["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${auth["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(auth["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${auth["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(auth["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory_2, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Order: ${auth["orderNumber"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(auth["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${auth["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(auth["priority"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.category, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "${auth["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${auth["reason"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Submitted: ${auth["submittedDate"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              if (auth["reviewDeadline"] != null) ...[
                Icon(Icons.schedule, size: 16, color: dangerColor),
                SizedBox(width: spXs),
                Text(
                  "Due: ${auth["reviewDeadline"]}",
                  style: TextStyle(fontSize: 12, color: dangerColor),
                ),
              ],
            ],
          ),
          if (auth["assignedTo"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Text(
                  "Assigned to: ${auth["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          if (auth["approvalCode"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Approval Code: ${auth["approvalCode"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  if (auth["expiryDate"] != null)
                    Text(
                      "Expires: ${auth["expiryDate"]}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.attach_money, size: 16, color: successColor),
              SizedBox(width: spXs),
              Text(
                "\$${(auth["estimatedValue"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              if (auth["warrantyStatus"] != null) ...[
                Icon(
                  auth["warrantyStatus"] == "Active" ? Icons.verified : Icons.warning,
                  size: 16,
                  color: auth["warrantyStatus"] == "Active" ? successColor : warningColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Warranty: ${auth["warrantyStatus"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: auth["warrantyStatus"] == "Active" ? successColor : warningColor,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _viewAuthorizationDetails(auth),
                ),
              ),
              SizedBox(width: spSm),
              if ((auth["supportingDocs"] as List).isNotEmpty)
                QButton(
                  label: "Docs",
                  size: bs.sm,
                  onPressed: () => _viewSupportingDocs(auth),
                ),
              SizedBox(width: spSm),
              if (auth["status"] == "Pending Review") ...[
                QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () => _approveAuthorization(auth),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Investigate",
                  size: bs.sm,
                  onPressed: () => _assignForInvestigation(auth),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Reject",
                  size: bs.sm,
                  onPressed: () => _rejectAuthorization(auth),
                ),
              ] else if (auth["status"] == "Under Investigation") ...[
                QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () => _approveAuthorization(auth),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Reject",
                  size: bs.sm,
                  onPressed: () => _rejectAuthorization(auth),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalAuthorizations = authorizations.length;
    int pendingReview = authorizations.where((a) => a["status"] == "Pending Review").length;
    int underInvestigation = authorizations.where((a) => a["status"] == "Under Investigation").length;
    int approved = authorizations.where((a) => a["status"] == "Approved").length;
    int rejected = authorizations.where((a) => a["status"] == "Rejected").length;
    int expired = authorizations.where((a) => a["status"] == "Expired").length;

    double totalValue = authorizations.where((a) => a["status"] == "Approved").fold(0.0, (sum, a) => sum + (a["estimatedValue"] as double));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.assignment, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalAuthorizations",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Authorizations",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pending_actions, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$pendingReview",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Pending Review",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.search, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$underInvestigation",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Under Investigation",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$approved",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Approved",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.cancel, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$rejected",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Rejected",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.payments, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "\$${totalValue.currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Approved Value",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Authorization Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...authorizations.take(5).map((auth) => _buildAuthorizationCard(auth)),
        ],
      ),
    );
  }

  Widget _buildAllTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search authorizations...",
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
                  label: "Filter by Status",
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
                  label: "Filter by Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (filteredAuthorizations.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No authorizations found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...filteredAuthorizations.map((auth) => _buildAuthorizationCard(auth)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Return Authorization",
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Requests", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAllTab(),
      ],
    );
  }
}
