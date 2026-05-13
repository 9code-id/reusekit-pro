import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDeliveryConfirmationView extends StatefulWidget {
  const DlaDeliveryConfirmationView({super.key});

  @override
  State<DlaDeliveryConfirmationView> createState() => _DlaDeliveryConfirmationViewState();
}

class _DlaDeliveryConfirmationViewState extends State<DlaDeliveryConfirmationView> {
  String deliveryId = "DEL-240115-001";
  String packageId = "PKG-240115-001";
  String customerName = "John Doe";
  String customerAddress = "Jl. Sudirman No.123, Jakarta Pusat";
  String customerPhone = "+62 812-3456-7890";
  String recipientName = "John Doe";
  String recipientRelation = "self";
  String deliveryTime = "14:30";
  String deliveryDate = "2024-01-15";
  String deliveryNotes = "";
  bool proofPhotoTaken = true;
  bool signatureCaptured = true;
  bool customerSatisfied = true;
  bool packageIntact = true;
  String deliveryStatus = "delivered";
  
  final List<String> proofPhotos = [
    "https://picsum.photos/300/200?random=1",
    "https://picsum.photos/300/200?random=2",
  ];

  Widget _buildDeliveryHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Completed",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Package delivered successfully",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
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
            child: Row(
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientInfo() {
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
              Icon(Icons.how_to_reg, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Recipient Details",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Received By",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        recipientName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Relationship",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        recipientRelation.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        deliveryDate,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        deliveryTime,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProofDocuments() {
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
              Icon(Icons.verified, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Proof of Delivery",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: proofPhotoTaken ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        proofPhotoTaken ? Icons.check_circle : Icons.cancel,
                        color: proofPhotoTaken ? successColor : dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Photo Proof",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: proofPhotoTaken ? successColor : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: signatureCaptured ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        signatureCaptured ? Icons.check_circle : Icons.cancel,
                        color: signatureCaptured ? successColor : dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Signature",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: signatureCaptured ? successColor : dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (proofPhotos.isNotEmpty) ...[
            Text(
              "Delivery Photos:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 100,
              child: QHorizontalScroll(
                children: proofPhotos.map((photo) => Container(
                  width: 120,
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
        ],
      ),
    );
  }

  Widget _buildDeliveryStatus() {
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
              Icon(Icons.assessment, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Delivery Assessment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: packageIntact ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        packageIntact ? Icons.check_circle : Icons.error,
                        color: packageIntact ? successColor : dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Package Condition",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: packageIntact ? successColor : dangerColor,
                        ),
                      ),
                      Text(
                        packageIntact ? "Intact" : "Damaged",
                        style: TextStyle(
                          fontSize: 10,
                          color: packageIntact ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: customerSatisfied ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        customerSatisfied ? Icons.sentiment_satisfied : Icons.sentiment_dissatisfied,
                        color: customerSatisfied ? successColor : dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Customer Satisfaction",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: customerSatisfied ? successColor : dangerColor,
                        ),
                      ),
                      Text(
                        customerSatisfied ? "Satisfied" : "Unsatisfied",
                        style: TextStyle(
                          fontSize: 10,
                          color: customerSatisfied ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
            hint: "Add any additional notes about this delivery...",
            onChanged: (value) {
              deliveryNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Share Receipt",
            icon: Icons.share,
            color: infoColor,
            size: bs.md,
            onPressed: () {
              si("Sharing delivery receipt");
            },
          ),
        ),
        Expanded(
          child: QButton(
            label: "Print Receipt",
            icon: Icons.print,
            color: primaryColor,
            size: bs.md,
            onPressed: () {
              si("Printing delivery receipt");
            },
          ),
        ),
        QButton(
          icon: Icons.email,
          color: disabledBoldColor,
          size: bs.md,
          onPressed: () {
            si("Email receipt to customer");
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Confirmation"),
        actions: [
          QButton(
            icon: Icons.receipt,
            size: bs.sm,
            onPressed: () {
              si("View full receipt");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDeliveryHeader(),
            _buildCustomerInfo(),
            _buildRecipientInfo(),
            _buildProofDocuments(),
            _buildDeliveryStatus(),
            _buildDeliveryNotes(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
