import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaTicketPurchaseView extends StatefulWidget {
  const EmaTicketPurchaseView({super.key});

  @override
  State<EmaTicketPurchaseView> createState() => _EmaTicketPurchaseViewState();
}

class _EmaTicketPurchaseViewState extends State<EmaTicketPurchaseView> {
  bool loading = false;
  String purchaseStatus = "pending"; // pending, processing, success, failed
  String orderId = "";
  String confirmationCode = "";
  
  Map<String, dynamic> purchaseDetails = {
    "eventName": "Grand Concert 2025",
    "venue": "Madison Square Garden",
    "date": "2025-07-15",
    "time": "19:30",
    "ticketType": "VIP Experience Package",
    "quantity": 2,
    "section": "VIP Section A",
    "seats": ["A-R5-S12", "A-R5-S13"],
    "addOns": ["VIP Parking", "Official T-Shirt"],
    "subtotal": 1000.0,
    "fees": 50.0,
    "taxes": 80.0,
    "discount": 100.0,
    "total": 1030.0,
    "paymentMethod": "Credit Card ending in 4567",
    "customerName": "John Doe",
    "customerEmail": "john.doe@example.com",
    "customerPhone": "+1-555-0123",
  };

  List<Map<String, dynamic>> tickets = [];

  @override
  void initState() {
    super.initState();
    _simulatePurchaseProcess();
  }

  void _simulatePurchaseProcess() async {
    loading = true;
    setState(() {});

    // Simulate processing delay
    await Future.delayed(Duration(seconds: 2));
    
    purchaseStatus = "processing";
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    // Simulate success
    purchaseStatus = "success";
    orderId = "ORD-${DateTime.now().millisecondsSinceEpoch}";
    confirmationCode = "CNF-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";
    
    // Generate tickets
    _generateTickets();
    
    loading = false;
    setState(() {});
  }

  void _generateTickets() {
    tickets.clear();
    List<String> seats = purchaseDetails["seats"] as List<String>;
    
    for (int i = 0; i < seats.length; i++) {
      tickets.add({
        "ticketId": "TKT-${DateTime.now().millisecondsSinceEpoch + i}",
        "seat": seats[i],
        "qrCode": "https://picsum.photos/200/200?random=${i + 1}",
        "barcode": "${DateTime.now().millisecondsSinceEpoch + i}",
        "holderName": purchaseDetails["customerName"],
        "isTransferred": false,
      });
    }
  }

  void downloadTickets() {
    ss("Tickets downloaded successfully to Downloads folder");
  }

  void sendTicketsEmail() {
    ss("Tickets sent to ${purchaseDetails["customerEmail"]}");
  }

  void addToWallet() {
    ss("Tickets added to mobile wallet");
  }

  void shareTickets() {
    ss("Tickets shared successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Confirmation"),
        automaticallyImplyLeading: purchaseStatus == "success",
        actions: [
          if (purchaseStatus == "success") ...[
            QButton(
              icon: Icons.help,
              size: bs.sm,
              onPressed: () {
                //navigateTo('SupportView')
              },
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Status Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(sp2xl),
              decoration: BoxDecoration(
                color: _getStatusColor().withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: _getStatusColor().withAlpha(50)),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  if (loading || purchaseStatus == "processing") ...[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
                    ),
                  ] else ...[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _getStatusColor(),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        _getStatusIcon(),
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                  Text(
                    _getStatusTitle(),
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(),
                    ),
                  ),
                  Text(
                    _getStatusMessage(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (purchaseStatus == "success") ...[
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "Order ID: $orderId",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Confirmation: $confirmationCode",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (purchaseStatus == "success") ...[
              // Event Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.event, size: 20, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${purchaseDetails["eventName"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${purchaseDetails["venue"]}",
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 20, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "${DateTime.parse("${purchaseDetails["date"]}").dMMMy} at ${purchaseDetails["time"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.event_seat, size: 20, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${purchaseDetails["section"]} - ${(purchaseDetails["seats"] as List).join(", ")}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tickets
              Text(
                "Your Tickets",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ...tickets.map((ticket) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      // Ticket Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.confirmation_number,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${ticket["ticketId"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Seat: ${ticket["seat"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
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
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "VALID",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Ticket Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          spacing: spMd,
                          children: [
                            // QR Code
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${ticket["qrCode"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Ticket Info
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ticket Holder",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${ticket["holderName"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Barcode",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${ticket["barcode"]}",
                                    style: TextStyle(
                                      fontFamily: "monospace",
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${purchaseDetails["ticketType"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
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
                    ],
                  ),
                );
              }),

              // Purchase Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("Subtotal:"),
                        Spacer(),
                        Text("\$${(purchaseDetails["subtotal"] as double).currency}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Fees:"),
                        Spacer(),
                        Text("\$${(purchaseDetails["fees"] as double).currency}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Taxes:"),
                        Spacer(),
                        Text("\$${(purchaseDetails["taxes"] as double).currency}"),
                      ],
                    ),
                    if ((purchaseDetails["discount"] as double) > 0) ...[
                      Row(
                        children: [
                          Text(
                            "Discount:",
                            style: TextStyle(color: successColor),
                          ),
                          Spacer(),
                          Text(
                            "-\$${(purchaseDetails["discount"] as double).currency}",
                            style: TextStyle(color: successColor),
                          ),
                        ],
                      ),
                    ],
                    Divider(),
                    Row(
                      children: [
                        Text(
                          "Total Paid:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(purchaseDetails["total"] as double).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Payment Method:"),
                        Spacer(),
                        Text("${purchaseDetails["paymentMethod"]}"),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Download Tickets",
                      size: bs.sm,
                      onPressed: downloadTickets,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Email Tickets",
                      size: bs.sm,
                      onPressed: sendTicketsEmail,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add to Wallet",
                      size: bs.sm,
                      onPressed: addToWallet,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Share Tickets",
                      size: bs.sm,
                      onPressed: shareTickets,
                    ),
                  ),
                ],
              ),

              // Important Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Important Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Please arrive 30 minutes before the event start time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "• Bring a valid ID for entry verification",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "• Screenshots of tickets are not accepted - use the app or printed tickets",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "• For support, contact us at support@eventmanager.com",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Navigation
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View My Tickets",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo('EmaTicketView')
                  },
                ),
              ),
            ],

            if (purchaseStatus == "failed") ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "What went wrong?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your payment could not be processed. This might be due to insufficient funds, expired card, or network issues.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Try Again",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('EmaPaymentView')
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Contact Support",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('SupportView')
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (purchaseStatus) {
      case "pending":
      case "processing":
        return primaryColor;
      case "success":
        return successColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon() {
    switch (purchaseStatus) {
      case "success":
        return Icons.check_circle;
      case "failed":
        return Icons.error;
      default:
        return Icons.access_time;
    }
  }

  String _getStatusTitle() {
    switch (purchaseStatus) {
      case "pending":
        return "Processing Payment";
      case "processing":
        return "Confirming Purchase";
      case "success":
        return "Purchase Successful!";
      case "failed":
        return "Purchase Failed";
      default:
        return "Processing";
    }
  }

  String _getStatusMessage() {
    switch (purchaseStatus) {
      case "pending":
        return "Please wait while we process your payment...";
      case "processing":
        return "Generating your tickets and sending confirmation...";
      case "success":
        return "Your tickets have been purchased successfully. You will receive an email confirmation shortly.";
      case "failed":
        return "There was an issue processing your payment. Please try again or contact support.";
      default:
        return "Processing your request...";
    }
  }
}
