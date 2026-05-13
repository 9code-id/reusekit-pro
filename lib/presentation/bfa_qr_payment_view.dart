import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaQrPaymentView extends StatefulWidget {
  const BfaQrPaymentView({super.key});

  @override
  State<BfaQrPaymentView> createState() => _BfaQrPaymentViewState();
}

class _BfaQrPaymentViewState extends State<BfaQrPaymentView> {
  int currentTab = 0;
  String paymentAmount = "";
  String paymentNote = "";
  
  List<Map<String, dynamic>> savedContacts = [
    {
      "name": "John Smith",
      "phone": "+1 555-123-4567",
      "avatar": "https://picsum.photos/40/40?random=1&face",
      "lastAmount": 25.0,
      "frequency": "Weekly"
    },
    {
      "name": "Emily Johnson", 
      "phone": "+1 555-987-6543",
      "avatar": "https://picsum.photos/40/40?random=2&face",
      "lastAmount": 150.0,
      "frequency": "Monthly"
    },
    {
      "name": "Mike Wilson",
      "phone": "+1 555-555-5555", 
      "avatar": "https://picsum.photos/40/40?random=3&face",
      "lastAmount": 45.0,
      "frequency": "Occasional"
    }
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": 1,
      "type": "Sent",
      "recipient": "Coffee Shop",
      "amount": 12.50,
      "date": "2025-01-15T14:30:00",
      "status": "Success",
      "qrType": "Merchant",
      "icon": Icons.local_cafe,
      "color": Colors.brown
    },
    {
      "id": 2,
      "type": "Received",
      "sender": "Sarah Davis",
      "amount": 75.0,
      "date": "2025-01-14T10:20:00",
      "status": "Success",
      "qrType": "P2P",
      "icon": Icons.person,
      "color": Colors.green
    },
    {
      "id": 3,
      "type": "Sent",
      "recipient": "Restaurant",
      "amount": 28.75,
      "date": "2025-01-13T19:45:00",
      "status": "Success",
      "qrType": "Merchant",
      "icon": Icons.restaurant,
      "color": Colors.orange
    },
    {
      "id": 4,
      "type": "Sent",
      "recipient": "Gas Station",
      "amount": 45.00,
      "date": "2025-01-12T08:15:00",
      "status": "Success", 
      "qrType": "Merchant",
      "icon": Icons.local_gas_station,
      "color": Colors.blue
    }
  ];

  // Sample QR code data - in real app this would be generated
  Map<String, dynamic> myQRData = {
    "name": "John Doe",
    "phone": "+1 555-123-4567",
    "accountId": "QR123456789",
    "bankName": "My Bank",
    "qrCode": "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=PAY:QR123456789"
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "QR Payment",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Scan", icon: Icon(Icons.qr_code_scanner)),
        Tab(text: "My QR", icon: Icon(Icons.qr_code)),
        Tab(text: "Pay", icon: Icon(Icons.payment)),
      ],
      tabChildren: [
        // Scan QR Tab
        _buildScanQRTab(),
        // My QR Code Tab
        _buildMyQRTab(),
        // Quick Pay Tab
        _buildQuickPayTab(),
      ],
    );
  }

  Widget _buildScanQRTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Scan Instructions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scan QR Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Point your camera at a QR code to pay instantly",
                        style: TextStyle(
                          color: Colors.white.withAlpha(230),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Camera Scanner Placeholder
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Stack(
              children: [
                // Camera preview placeholder
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/400/300?random=1&camera"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withAlpha(128),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                // Scan overlay
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Stack(
                      children: [
                        // Corner brackets
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: primaryColor, width: 3),
                                left: BorderSide(color: primaryColor, width: 3),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: primaryColor, width: 3),
                                right: BorderSide(color: primaryColor, width: 3),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: primaryColor, width: 3),
                                left: BorderSide(color: primaryColor, width: 3),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: primaryColor, width: 3),
                                right: BorderSide(color: primaryColor, width: 3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Instructions
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Align QR code within the frame",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Camera Controls
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Open Camera",
                  icon: Icons.camera,
                  onPressed: () {
                    // Open camera scanner
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.flash_on,
                size: bs.sm,
                onPressed: () {
                  // Toggle flash
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.image,
                size: bs.sm,
                onPressed: () {
                  // Select from gallery
                },
              ),
            ],
          ),

          // Recent QR Transactions
          if (recentTransactions.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent QR Transactions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...recentTransactions.take(3).map((transaction) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (transaction["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              transaction["icon"] as IconData,
                              color: transaction["color"] as Color,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${transaction["type"] == "Sent" ? transaction["recipient"] : transaction["sender"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${transaction["type"]} • ${DateTime.parse(transaction["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${transaction["type"] == "Sent" ? "-" : "+"}\$${(transaction["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: transaction["type"] == "Sent" ? dangerColor : successColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMyQRTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // My QR Code
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Text(
                  "My QR Code",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                // QR Code
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${myQRData["qrCode"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${myQRData["name"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${myQRData["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${myQRData["bankName"]} • ${myQRData["accountId"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Share QR",
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () {
                          // Share QR code
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Save Image",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          // Save QR code image
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Usage Instructions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(128)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "How to use your QR code",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Show this QR code to receive payments from others\n• Others can scan this code to send you money instantly\n• Your QR code contains your payment information securely\n• You can share this QR code via message, email, or social media",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Request Money
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Request Money",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QNumberField(
                  label: "Amount (\$)",
                  value: paymentAmount,
                  hint: "Enter amount to request",
                  onChanged: (value) {
                    paymentAmount = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Note (Optional)",
                  value: paymentNote,
                  hint: "What's this for?",
                  onChanged: (value) {
                    paymentNote = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate Request QR",
                    icon: Icons.qr_code,
                    onPressed: paymentAmount.isNotEmpty ? () {
                      // Generate payment request QR
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Pay Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.payment,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quick Pay",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Send money quickly to your contacts",
                        style: TextStyle(
                          color: Colors.white.withAlpha(230),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Saved Contacts
          if (savedContacts.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Send",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: savedContacts.map((contact) {
                      return GestureDetector(
                        onTap: () {
                          // Quick send to contact
                        },
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("${contact["avatar"]}"),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${contact["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Last: \$${(contact["lastAmount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${contact["frequency"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],

          // Send Money Form
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send Money",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Recipient Phone or QR ID",
                  value: "",
                  hint: "+1 555-123-4567 or QR123456789",
                  onChanged: (value) {
                    // Handle recipient input
                  },
                ),
                SizedBox(height: spSm),
                QNumberField(
                  label: "Amount (\$)",
                  value: "",
                  hint: "Enter amount to send",
                  onChanged: (value) {
                    // Handle amount input
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Note (Optional)",
                  value: "",
                  hint: "What's this for?",
                  onChanged: (value) {
                    // Handle note input
                  },
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Send Money",
                    icon: Icons.send,
                    onPressed: () {
                      // Send money via QR
                    },
                  ),
                ),
              ],
            ),
          ),

          // Recent Transactions
          if (recentTransactions.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: Text(
                          "Recent QR Payments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // navigateTo(QRPaymentHistoryView());
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...recentTransactions.map((transaction) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (transaction["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              transaction["icon"] as IconData,
                              color: transaction["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${transaction["type"] == "Sent" ? transaction["recipient"] : transaction["sender"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${transaction["qrType"]} • ${DateTime.parse(transaction["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${transaction["type"] == "Sent" ? "-" : "+"}\$${(transaction["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: transaction["type"] == "Sent" ? dangerColor : successColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${transaction["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
