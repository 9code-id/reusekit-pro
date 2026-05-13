import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDnrOrderView extends StatefulWidget {
  const HcaDnrOrderView({super.key});

  @override
  State<HcaDnrOrderView> createState() => _HcaDnrOrderViewState();
}

class _HcaDnrOrderViewState extends State<HcaDnrOrderView> {
  bool hasDnrOrder = false;
  String orderType = "";
  String physicianName = "";
  String physicianContact = "";
  String orderDate = "";
  String orderNumber = "";
  String hospitalName = "";
  String witnessName = "";
  String witnessContact = "";
  String notaryName = "";
  String notaryNumber = "";
  String specialInstructions = "";
  bool isRevoked = false;
  String revocationDate = "";
  String revocationReason = "";
  bool loading = false;

  List<Map<String, dynamic>> orderTypes = [
    {"label": "Full DNR (Do Not Resuscitate)", "value": "full_dnr"},
    {"label": "Limited DNR", "value": "limited_dnr"},
    {"label": "DNR with Exceptions", "value": "dnr_exceptions"},
    {"label": "POLST (Physician Orders)", "value": "polst"},
  ];

  List<Map<String, dynamic>> dnrDocuments = [
    {
      "title": "DNR Order Form",
      "date": "2024-01-15",
      "status": "Active",
      "type": "Full DNR",
      "doctor": "Dr. Sarah Wilson",
      "hospital": "Memorial Hospital",
    },
    {
      "title": "POLST Form",
      "date": "2024-01-10",
      "status": "Pending",
      "type": "POLST",
      "doctor": "Dr. Michael Chen",
      "hospital": "City Medical Center",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DNR Order"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showDnrInfo(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildDnrStatusCard(),
                  _buildActiveOrdersSection(),
                  _buildNewOrderSection(),
                  _buildRevocationSection(),
                  _buildImportantNotesSection(),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildDnrStatusCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: hasDnrOrder ? successColor.withAlpha(20) : warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: hasDnrOrder ? successColor : warningColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                hasDnrOrder ? Icons.verified_user : Icons.warning,
                color: hasDnrOrder ? successColor : warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  hasDnrOrder ? "DNR Order Active" : "No Active DNR Order",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: hasDnrOrder ? successColor : warningColor,
                  ),
                ),
              ),
            ],
          ),
          if (hasDnrOrder) ...[
            Text(
              "Your Do Not Resuscitate order is currently active and legally binding.",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order Type:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Full DNR",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Issued Date:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "January 15, 2024",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              "Consider discussing DNR options with your healthcare provider if you have specific end-of-life preferences.",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "DNR Documents",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...dnrDocuments.map((doc) => _buildDocumentCard(doc)),
      ],
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> doc) {
    Color statusColor = doc["status"] == "Active" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${doc["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${doc["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${doc["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.medical_services, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${doc["type"]}",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${doc["doctor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.local_hospital, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${doc["hospital"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Document",
                  size: bs.sm,
                  onPressed: () => _viewDocument(doc),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: doc["status"] == "Active" ? "Revoke" : "Activate",
                  size: bs.sm,
                  onPressed: () => _toggleDocumentStatus(doc),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewOrderSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Create New DNR Order",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Order Type",
            items: orderTypes,
            value: orderType,
            onChanged: (value, label) {
              orderType = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Physician Name",
                  value: physicianName,
                  onChanged: (value) {
                    physicianName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Physician Contact",
                  value: physicianContact,
                  onChanged: (value) {
                    physicianContact = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Order Date",
                  value: orderDate.isNotEmpty ? DateTime.parse(orderDate) : DateTime.now(),
                  onChanged: (value) {
                    orderDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Order Number",
                  value: orderNumber,
                  onChanged: (value) {
                    orderNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Hospital/Facility Name",
            value: hospitalName,
            onChanged: (value) {
              hospitalName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Witness Name",
                  value: witnessName,
                  onChanged: (value) {
                    witnessName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Witness Contact",
                  value: witnessContact,
                  onChanged: (value) {
                    witnessContact = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Notary Name",
                  value: notaryName,
                  onChanged: (value) {
                    notaryName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Notary Number",
                  value: notaryNumber,
                  onChanged: (value) {
                    notaryNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Special Instructions",
            value: specialInstructions,
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRevocationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.cancel, color: dangerColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Order Revocation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          Text(
            "You can revoke your DNR order at any time. This action is immediate and irreversible.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Revoke DNR Order",
                "value": true,
                "checked": isRevoked,
              }
            ],
            value: [if (isRevoked) {"label": "Revoke DNR Order", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isRevoked = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (isRevoked) ...[
            QDatePicker(
              label: "Revocation Date",
              value: revocationDate.isNotEmpty ? DateTime.parse(revocationDate) : DateTime.now(),
              onChanged: (value) {
                revocationDate = value.toString();
                setState(() {});
              },
            ),
            QMemoField(
              label: "Revocation Reason",
              value: revocationReason,
              onChanged: (value) {
                revocationReason = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImportantNotesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Important Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "• DNR orders must be signed by a licensed physician\n"
            "• Orders should be reviewed regularly with your healthcare provider\n"
            "• Copies should be provided to all relevant healthcare facilities\n"
            "• Emergency contacts should be aware of your DNR status\n"
            "• Orders can be revoked at any time by the patient or legal representative",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save DNR Order",
            onPressed: () => _saveDnrOrder(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Print Order",
                size: bs.sm,
                onPressed: () => _printOrder(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Share Copy",
                size: bs.sm,
                onPressed: () => _shareOrder(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDnrInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("About DNR Orders"),
        content: Text(
          "A Do Not Resuscitate (DNR) order is a legal document that instructs healthcare providers not to perform cardiopulmonary resuscitation (CPR) if your heart stops beating or if you stop breathing.\n\n"
          "This decision should be made carefully with your healthcare provider and loved ones.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Understood"),
          ),
        ],
      ),
    );
  }

  void _viewDocument(Map<String, dynamic> doc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${doc["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: ${doc["status"]}"),
            Text("Date: ${doc["date"]}"),
            Text("Type: ${doc["type"]}"),
            Text("Doctor: ${doc["doctor"]}"),
            Text("Hospital: ${doc["hospital"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle document download/view
            },
            child: Text("Download"),
          ),
        ],
      ),
    );
  }

  void _toggleDocumentStatus(Map<String, dynamic> doc) async {
    String action = doc["status"] == "Active" ? "revoke" : "activate";
    bool isConfirmed = await confirm("Are you sure you want to $action this DNR order?");
    
    if (isConfirmed) {
      // Handle status toggle
      ss("DNR order ${action}d successfully");
      setState(() {});
    }
  }

  void _saveDnrOrder() async {
    if (orderType.isEmpty || physicianName.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate save operation
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    hasDnrOrder = true;
    setState(() {});

    ss("DNR order saved successfully");
  }

  void _printOrder() {
    si("Printing DNR order...");
  }

  void _shareOrder() {
    si("Sharing DNR order copy...");
  }
}
