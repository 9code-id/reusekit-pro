import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaDeliveryConfirmationView extends StatefulWidget {
  const SpaDeliveryConfirmationView({super.key});

  @override
  State<SpaDeliveryConfirmationView> createState() => _SpaDeliveryConfirmationViewState();
}

class _SpaDeliveryConfirmationViewState extends State<SpaDeliveryConfirmationView> {
  String orderNumber = "SPA-ORD-2024-001";
  bool isConfirmed = false;
  String signature = "";
  String receiverName = "";
  String receiverRole = "Spa Manager";
  DateTime deliveryTime = DateTime.now();
  String deliveryNotes = "";
  List<String> deliveryPhotos = [];
  bool hasIssues = false;
  String issueDescription = "";
  
  List<Map<String, dynamic>> deliveredItems = [
    {
      "name": "Premium Massage Oil Set",
      "quantity": 5,
      "deliveredQuantity": 5,
      "price": 89.99,
      "image": "https://picsum.photos/80/80?random=101&keyword=oil",
      "hasIssue": false,
      "issueType": ""
    },
    {
      "name": "Organic Face Mask Collection",
      "quantity": 12,
      "deliveredQuantity": 10,
      "price": 149.99,
      "image": "https://picsum.photos/80/80?random=102&keyword=mask",
      "hasIssue": true,
      "issueType": "Partial Delivery"
    },
    {
      "name": "Aromatherapy Candle Set",
      "quantity": 8,
      "deliveredQuantity": 8,
      "price": 79.99,
      "image": "https://picsum.photos/80/80?random=103&keyword=candle",
      "hasIssue": false,
      "issueType": ""
    },
    {
      "name": "Spa Towel Premium Pack",
      "quantity": 20,
      "deliveredQuantity": 20,
      "price": 199.99,
      "image": "https://picsum.photos/80/80?random=104&keyword=towel",
      "hasIssue": false,
      "issueType": ""
    },
  ];

  Map<String, dynamic> deliveryDetails = {
    "driverName": "John Martinez",
    "driverPhone": "+1 (555) 123-4567",
    "vehicleNumber": "DELV-789",
    "deliveryDate": "December 16, 2024",
    "deliveryTime": "2:15 PM",
    "address": "123 Wellness Street, Spa District",
    "totalValue": 519.96
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Confirmation"),
        actions: [
          if (isConfirmed)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spMd),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "CONFIRMED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Delivery Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isConfirmed ? successColor.withAlpha(30) : primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          isConfirmed ? Icons.check_circle : Icons.local_shipping,
                          color: isConfirmed ? successColor : primaryColor,
                          size: 40,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order #$orderNumber",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              isConfirmed ? "Delivery Confirmed" : "Pending Confirmation",
                              style: TextStyle(
                                color: isConfirmed ? successColor : warningColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${deliveryDetails["deliveryDate"]} at ${deliveryDetails["deliveryTime"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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

            // Driver Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Delivery Driver",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.person,
                          color: infoColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${deliveryDetails["driverName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Vehicle: ${deliveryDetails["vehicleNumber"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${deliveryDetails["driverPhone"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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

            // Delivered Items
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Delivered Items",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${deliveredItems.length} items",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  ...deliveredItems.map((item) => _buildDeliveryItem(item)).toList(),
                  if (deliveredItems.any((item) => item["hasIssue"]))
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Some items have delivery issues. Please review before confirming.",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Confirmation Form
            if (!isConfirmed) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Confirmation Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Receiver Name",
                      value: receiverName,
                      hint: "Enter full name of person receiving delivery",
                      onChanged: (value) {
                        receiverName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Role/Position",
                      value: receiverRole,
                      hint: "e.g., Spa Manager, Receptionist",
                      onChanged: (value) {
                        receiverRole = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Delivery Notes (Optional)",
                      value: deliveryNotes,
                      hint: "Any additional notes about the delivery",
                      onChanged: (value) {
                        deliveryNotes = value;
                        setState(() {});
                      },
                    ),
                    QMultiImagePicker(
                      label: "Delivery Photos",
                      value: deliveryPhotos,
                      hint: "Take photos of delivered items for verification",
                      onChanged: (value) {
                        deliveryPhotos = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Issues Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Report Issues",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Report delivery issues",
                          "value": true,
                          "checked": hasIssues,
                        }
                      ],
                      value: [if (hasIssues) {"label": "Report delivery issues", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        hasIssues = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (hasIssues)
                      QMemoField(
                        label: "Issue Description",
                        value: issueDescription,
                        hint: "Describe any issues with the delivery",
                        onChanged: (value) {
                          issueDescription = value;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Confirmation Actions
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Reject Delivery",
                            size: bs.md,
                            color: dangerColor,
                            onPressed: () {
                              _rejectDelivery();
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          flex: 2,
                          child: QButton(
                            label: "Confirm Delivery",
                            size: bs.md,
                            onPressed: () {
                              _confirmDelivery();
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "By confirming, you acknowledge receipt of all delivered items",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Confirmation Summary (shown after confirmation)
            if (isConfirmed)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 48,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Delivery Confirmed Successfully",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Thank you for confirming the delivery. A receipt has been sent to your email.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: successColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Receipt",
                            size: bs.sm,
                            color: successColor,
                            onPressed: () {
                              _viewReceipt();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Download PDF",
                            size: bs.sm,
                            color: primaryColor,
                            onPressed: () {
                              _downloadPDF();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryItem(Map<String, dynamic> item) {
    bool hasIssue = item["hasIssue"];
    int ordered = item["quantity"];
    int delivered = item["deliveredQuantity"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: hasIssue ? dangerColor.withAlpha(20) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: hasIssue ? Border.all(color: dangerColor.withAlpha(100)) : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Ordered: $ordered",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Delivered: $delivered",
                      style: TextStyle(
                        color: delivered == ordered ? successColor : dangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (hasIssue)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${item["issueType"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((item["price"] as double) * delivered).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              if (delivered != ordered)
                Text(
                  "(\$${((item["price"] as double) * ordered).toStringAsFixed(2)})",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelivery() async {
    if (receiverName.isEmpty) {
      se("Please enter receiver name");
      return;
    }

    bool confirmed = await confirm("Confirm delivery receipt? This action cannot be undone.");
    if (confirmed) {
      isConfirmed = true;
      setState(() {});
      ss("Delivery confirmed successfully");
    }
  }

  void _rejectDelivery() async {
    bool confirmed = await confirm("Reject this delivery? Please make sure to report any issues.");
    if (confirmed) {
      se("Delivery rejected. Support team will contact you shortly.");
    }
  }

  void _viewReceipt() {
    ss("Opening delivery receipt...");
  }

  void _downloadPDF() {
    ss("Downloading delivery confirmation PDF...");
  }
}
