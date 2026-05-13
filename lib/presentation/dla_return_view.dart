import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaReturnView extends StatefulWidget {
  const DlaReturnView({super.key});

  @override
  State<DlaReturnView> createState() => _DlaReturnViewState();
}

class _DlaReturnViewState extends State<DlaReturnView> {
  String returnId = "";
  String originalDeliveryId = "DEL-240115-001";
  String packageId = "PKG-240115-001";
  String customerName = "John Doe";
  String customerAddress = "Jl. Sudirman No.123, Jakarta Pusat";
  String customerPhone = "+62 812-3456-7890";
  String returnReason = "damaged_package";
  String returnCondition = "opened";
  String refundMethod = "original_payment";
  String additionalNotes = "";
  bool customerPresent = true;
  bool returnAuthorized = false;
  bool photosRequired = true;
  bool photosTaken = false;
  
  final List<Map<String, dynamic>> returnReasonOptions = [
    {"label": "Damaged Package", "value": "damaged_package"},
    {"label": "Wrong Item Delivered", "value": "wrong_item"},
    {"label": "Item Not as Described", "value": "not_as_described"},
    {"label": "Customer Changed Mind", "value": "changed_mind"},
    {"label": "Defective Product", "value": "defective"},
    {"label": "Late Delivery", "value": "late_delivery"},
    {"label": "Duplicate Order", "value": "duplicate"},
    {"label": "Quality Issues", "value": "quality_issues"},
    {"label": "Size/Color Mismatch", "value": "size_color"},
    {"label": "Other", "value": "other"},
  ];

  final List<Map<String, dynamic>> conditionOptions = [
    {"label": "Sealed/Unopened", "value": "sealed"},
    {"label": "Opened but Unused", "value": "opened_unused"},
    {"label": "Opened and Used", "value": "opened_used"},
    {"label": "Partially Used", "value": "partially_used"},
    {"label": "Damaged", "value": "damaged"},
  ];

  final List<Map<String, dynamic>> refundMethodOptions = [
    {"label": "Original Payment Method", "value": "original_payment"},
    {"label": "Store Credit", "value": "store_credit"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Cash Refund", "value": "cash"},
    {"label": "Exchange for New Item", "value": "exchange"},
  ];

  final List<String> returnPhotos = [
    "https://picsum.photos/300/200?random=20",
    "https://picsum.photos/300/200?random=21",
    "https://picsum.photos/300/200?random=22",
  ];

  Widget _buildReturnHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard_return, color: warningColor, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Package Return Process",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Customer requesting package return",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Original Delivery ID:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      originalDeliveryId,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Package ID:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      packageId,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
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

  Widget _buildCustomerInfo() {
    return Container(
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
              Icon(Icons.person, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        customerName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: customerPresent ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        customerPresent ? "Present" : "Not Present",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: customerPresent ? successColor : dangerColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        customerAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        customerPhone,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    QButton(
                      icon: Icons.call,
                      size: bs.sm,
                      onPressed: () {
                        si("Calling customer");
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

  Widget _buildReturnDetails() {
    return Container(
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
              Icon(Icons.assignment_return, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Return Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Return ID",
            value: returnId,
            hint: "Enter or generate return ID",
            onChanged: (value) {
              returnId = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Return Reason",
            items: returnReasonOptions,
            value: returnReason,
            onChanged: (value, label) {
              returnReason = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Package Condition",
            items: conditionOptions,
            value: returnCondition,
            onChanged: (value, label) {
              returnCondition = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Refund Method",
            items: refundMethodOptions,
            value: refundMethod,
            onChanged: (value, label) {
              refundMethod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReturnPhotos() {
    return Container(
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
              Icon(Icons.camera_alt, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Return Documentation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (photosTaken)
                Icon(Icons.check_circle, color: successColor, size: 24),
            ],
          ),
          if (photosRequired)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Photos are required to document package condition",
                      style: TextStyle(
                        fontSize: 13,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (returnPhotos.isNotEmpty) ...[
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: returnPhotos.map((photo) => Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage(photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Take Photos",
                  icon: Icons.camera_alt,
                  size: bs.sm,
                  onPressed: () {
                    photosTaken = true;
                    setState(() {});
                    ss("Return photos captured");
                  },
                ),
              ),
              if (returnPhotos.isNotEmpty)
                QButton(
                  label: "View All",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("View all return photos");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReturnNotes() {
    return Container(
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
          Text(
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Return Notes",
            value: additionalNotes,
            hint: "Add any additional notes about the return...",
            onChanged: (value) {
              additionalNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorizationSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Return Authorization",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "• Return request will be reviewed by customer service\n• Photos and documentation are required\n• Refund processing may take 3-5 business days\n• Customer will receive confirmation via email/SMS",
            style: TextStyle(
              fontSize: 13,
              color: infoColor,
              height: 1.4,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: returnAuthorized ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        returnAuthorized ? Icons.check_circle : Icons.pending,
                        color: returnAuthorized ? successColor : warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        returnAuthorized ? "Authorized" : "Pending Authorization",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: returnAuthorized ? successColor : warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Request Auth",
                icon: Icons.security,
                size: bs.sm,
                onPressed: () {
                  returnAuthorized = true;
                  setState(() {});
                  ss("Return authorization requested");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool get canProcessReturn {
    return returnId.isNotEmpty && 
           returnReason.isNotEmpty && 
           returnCondition.isNotEmpty &&
           refundMethod.isNotEmpty &&
           (photosRequired ? photosTaken : true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Return"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              si("Help with return process");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildReturnHeader(),
            _buildCustomerInfo(),
            _buildReturnDetails(),
            _buildReturnPhotos(),
            _buildReturnNotes(),
            _buildAuthorizationSection(),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel Return",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () {
                      sw("Return process cancelled");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Process Return",
                    color: canProcessReturn ? successColor : disabledBoldColor,
                    size: bs.md,
                    onPressed: canProcessReturn ? () {
                      ss("Return processed successfully!");
                    } : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
