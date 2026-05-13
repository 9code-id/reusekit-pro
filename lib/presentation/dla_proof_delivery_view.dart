import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaProofDeliveryView extends StatefulWidget {
  const DlaProofDeliveryView({super.key});

  @override
  State<DlaProofDeliveryView> createState() => _DlaProofDeliveryViewState();
}

class _DlaProofDeliveryViewState extends State<DlaProofDeliveryView> {
  String deliveryId = "DEL-240115-001";
  String customerName = "John Doe";
  String customerAddress = "Jl. Sudirman No.123, Jakarta Pusat";
  String customerPhone = "+62 812-3456-7890";
  String deliveryNotes = "";
  String proofType = "photo";
  String recipientName = "";
  String recipientRelation = "self";
  bool requireSignature = true;
  bool photoTaken = false;
  bool signatureCaptured = false;
  
  final List<Map<String, dynamic>> proofTypeOptions = [
    {"label": "Photo Proof", "value": "photo"},
    {"label": "Digital Signature", "value": "signature"},
    {"label": "Photo + Signature", "value": "both"},
    {"label": "SMS Confirmation", "value": "sms"},
  ];

  final List<Map<String, dynamic>> recipientRelationOptions = [
    {"label": "Customer (Self)", "value": "self"},
    {"label": "Family Member", "value": "family"},
    {"label": "Neighbor", "value": "neighbor"},
    {"label": "Security Guard", "value": "security"},
    {"label": "Office Staff", "value": "office"},
  ];

  final List<String> capturedPhotos = [
    "https://picsum.photos/300/200?random=1",
    "https://picsum.photos/300/200?random=2",
  ];

  Widget _buildDeliveryInfo() {
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
              Icon(Icons.local_shipping, color: primaryColor, size: 24),
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
                    Text(
                      "Delivery ID:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      deliveryId,
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person, color: disabledBoldColor, size: 16),
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

  Widget _buildProofTypeSelection() {
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
            "Proof of Delivery Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Proof Type",
            items: proofTypeOptions,
            value: proofType,
            onChanged: (value, label) {
              proofType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoProof() {
    if (proofType != "photo" && proofType != "both") return SizedBox.shrink();
    
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
                "Photo Proof",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (photoTaken)
                Icon(Icons.check_circle, color: successColor, size: 24),
            ],
          ),
          if (capturedPhotos.isNotEmpty) ...[
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: capturedPhotos.map((photo) => Container(
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
                  label: "Take Photo",
                  icon: Icons.camera_alt,
                  size: bs.sm,
                  onPressed: () {
                    photoTaken = true;
                    setState(() {});
                    ss("Photo captured successfully");
                  },
                ),
              ),
              if (capturedPhotos.isNotEmpty)
                QButton(
                  label: "View All",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("View all photos");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureProof() {
    if (proofType != "signature" && proofType != "both") return SizedBox.shrink();
    
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
              Icon(Icons.draw, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Digital Signature",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (signatureCaptured)
                Icon(Icons.check_circle, color: successColor, size: 24),
            ],
          ),
          QTextField(
            label: "Recipient Name",
            value: recipientName,
            hint: "Name of person receiving the package",
            onChanged: (value) {
              recipientName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Recipient Relation",
            items: recipientRelationOptions,
            value: recipientRelation,
            onChanged: (value, label) {
              recipientRelation = value;
              setState(() {});
            },
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    signatureCaptured ? Icons.check_circle : Icons.draw,
                    size: 40,
                    color: signatureCaptured ? successColor : primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    signatureCaptured 
                        ? "Signature Captured"
                        : "Tap to Capture Signature",
                    style: TextStyle(
                      color: signatureCaptured ? successColor : primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          QButton(
            label: signatureCaptured ? "Retake Signature" : "Capture Signature",
            icon: Icons.draw,
            size: bs.sm,
            onPressed: () {
              signatureCaptured = true;
              setState(() {});
              ss("Signature captured");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryNotes() {
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
            "Delivery Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Additional Notes",
            value: deliveryNotes,
            hint: "Add any additional notes about the delivery...",
            onChanged: (value) {
              deliveryNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  bool get isProofComplete {
    if (proofType == "photo") return photoTaken;
    if (proofType == "signature") return signatureCaptured && recipientName.isNotEmpty;
    if (proofType == "both") return photoTaken && signatureCaptured && recipientName.isNotEmpty;
    if (proofType == "sms") return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proof of Delivery"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () {
              si("Help with proof of delivery");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDeliveryInfo(),
            _buildProofTypeSelection(),
            _buildPhotoProof(),
            _buildSignatureProof(),
            _buildDeliveryNotes(),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Complete Delivery",
                color: isProofComplete ? successColor : disabledBoldColor,
                size: bs.md,
                onPressed: isProofComplete ? () {
                  ss("Delivery completed successfully!");
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
