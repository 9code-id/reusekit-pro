import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaSignatureCaptureView extends StatefulWidget {
  const LtaSignatureCaptureView({super.key});

  @override
  State<LtaSignatureCaptureView> createState() => _LtaSignatureCaptureViewState();
}

class _LtaSignatureCaptureViewState extends State<LtaSignatureCaptureView> {
  bool loading = false;
  String deliveryId = "DEL-2024-001523";
  String customerName = "John Mitchell";
  String packageType = "Standard Package";
  String deliveryAddress = "125 Business Plaza, Suite 402, Downtown District";
  bool signatureRequired = true;
  String signatureType = "Customer";
  String selectedSigner = "Customer";
  String recipientName = "";
  String relationship = "";
  String idNumber = "";
  bool confirmIdentity = false;
  List<String> capturedSignatures = [];
  String additionalNotes = "";
  bool requireIdVerification = true;
  String capturedAt = "";

  List<Map<String, dynamic>> signerOptions = [
    {"label": "Customer", "value": "Customer"},
    {"label": "Authorized Representative", "value": "Representative"},
    {"label": "Family Member", "value": "Family"},
    {"label": "Neighbor", "value": "Neighbor"},
    {"label": "Security/Concierge", "value": "Security"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> relationshipOptions = [
    {"label": "Spouse", "value": "Spouse"},
    {"label": "Child", "value": "Child"},
    {"label": "Parent", "value": "Parent"},
    {"label": "Sibling", "value": "Sibling"},
    {"label": "Business Partner", "value": "Business Partner"},
    {"label": "Employee", "value": "Employee"},
    {"label": "Assistant", "value": "Assistant"},
    {"label": "Other", "value": "Other"},
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    capturedAt = DateTime.now().toIso8601String();

    loading = false;
    setState(() {});
  }

  void _captureSignature() {
    // Simulate signature capture
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Signature Capture",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: disabledBoldColor),
                borderRadius: BorderRadius.circular(radiusSm),
                color: Colors.grey[50],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Please sign here",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Use your finger or stylus to sign above",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Clear",
            size: bs.sm,
            onPressed: () {},
          ),
          QButton(
            label: "Save Signature",
            size: bs.sm,
            onPressed: () {
              _saveSignature();
              back();
            },
          ),
        ],
      ),
    );
  }

  void _saveSignature() {
    String signatureId = "SIG-${DateTime.now().millisecondsSinceEpoch}";
    capturedSignatures.add(signatureId);
    
    ss("Signature captured successfully");
    setState(() {});
  }

  void _completeSignatureProcess() async {
    if (selectedSigner != "Customer" && recipientName.isEmpty) {
      se("Please enter recipient name");
      return;
    }

    if (capturedSignatures.isEmpty) {
      se("Please capture signature before completing");
      return;
    }

    if (requireIdVerification && !confirmIdentity) {
      se("Please confirm identity verification");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Signature capture completed successfully");
    //navigateTo ('')
  }

  void _retakeSignature() {
    capturedSignatures.clear();
    setState(() {});
    _captureSignature();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Signature Capture"),
        actions: [
          IconButton(
            onPressed: () {
              // Show help dialog
            },
            icon: Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Information Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildInfoRow("Delivery ID", deliveryId),
                  _buildInfoRow("Customer", customerName),
                  _buildInfoRow("Package Type", packageType),
                  _buildInfoRow("Address", deliveryAddress),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Signature Type Selection
            Text(
              "Signature Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Who is signing?",
              items: signerOptions,
              value: selectedSigner,
              onChanged: (value, label) {
                selectedSigner = value;
                setState(() {});
              },
            ),

            if (selectedSigner != "Customer") ...[
              SizedBox(height: spSm),
              QTextField(
                label: "Recipient Name",
                value: recipientName,
                hint: "Enter the name of the person signing",
                onChanged: (value) {
                  recipientName = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spSm),
              QDropdownField(
                label: "Relationship to Customer",
                items: relationshipOptions,
                value: relationship,
                onChanged: (value, label) {
                  relationship = value;
                  setState(() {});
                },
              ),
            ],

            if (requireIdVerification) ...[
              SizedBox(height: spSm),
              QTextField(
                label: "ID Number (Last 4 digits)",
                value: idNumber,
                hint: "Enter last 4 digits of ID",
                onChanged: (value) {
                  idNumber = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Identity Verified",
                          "value": true,
                          "checked": confirmIdentity,
                        }
                      ],
                      value: [
                        if (confirmIdentity)
                          {
                            "label": "Identity Verified",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          confirmIdentity = values.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: spMd),

            // Signature Capture Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Digital Signature",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),

                  if (capturedSignatures.isEmpty) ...[
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledBoldColor, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.gesture,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No signature captured",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Tap 'Capture Signature' to begin",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Capture Signature",
                        icon: Icons.edit,
                        size: bs.md,
                        onPressed: _captureSignature,
                      ),
                    ),
                  ] else ...[
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: successColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: Colors.green[50],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 48,
                            color: successColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Signature Captured",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Captured at ${DateTime.now().toString().split('.')[0]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Retake",
                            icon: Icons.refresh,
                            size: bs.sm,
                            onPressed: _retakeSignature,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Preview",
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () {
                              // Show signature preview
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Additional Notes
            QMemoField(
              label: "Additional Notes (Optional)",
              value: additionalNotes,
              hint: "Any special notes about the delivery or signature",
              onChanged: (value) {
                additionalNotes = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Legal Disclaimer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Legal Notice",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "By signing, the recipient acknowledges receipt of the package in good condition and agrees to the terms of delivery. This signature serves as proof of delivery and releases the courier from further liability.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Complete Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Complete Delivery",
                icon: Icons.check_circle,
                size: bs.md,
                onPressed: _completeSignatureProcess,
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
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
