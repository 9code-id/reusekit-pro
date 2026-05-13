import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaQuickTransferView extends StatefulWidget {
  const BfaQuickTransferView({super.key});

  @override
  State<BfaQuickTransferView> createState() => _BfaQuickTransferViewState();
}

class _BfaQuickTransferViewState extends State<BfaQuickTransferView> {
  String selectedQuickAmount = "";
  String customAmount = "";
  String selectedRecipient = "";
  String transferNote = "";
  
  // Quick amount options
  List<Map<String, dynamic>> quickAmounts = [
    {"label": "\$25", "value": "25"},
    {"label": "\$50", "value": "50"},
    {"label": "\$100", "value": "100"},
    {"label": "\$250", "value": "250"},
    {"label": "\$500", "value": "500"},
    {"label": "\$1,000", "value": "1000"},
  ];

  // Sample recent recipients
  List<Map<String, dynamic>> recentRecipients = [
    {
      "id": "rec001",
      "name": "John Williams",
      "account": "****1234",
      "bank": "ABC Bank",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "lastTransfer": "2024-12-14T16:45:00Z",
      "isFrequent": true,
    },
    {
      "id": "rec002",
      "name": "Sarah Johnson", 
      "account": "****5678",
      "bank": "XYZ Bank",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "lastTransfer": "2024-12-13T09:15:00Z",
      "isFrequent": true,
    },
    {
      "id": "rec003",
      "name": "Michael Brown",
      "account": "****9012",
      "bank": "DEF Bank",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "lastTransfer": "2024-12-12T14:20:00Z",
      "isFrequent": false,
    },
    {
      "id": "rec004",
      "name": "Emma Davis",
      "account": "****3456",
      "bank": "GHI Bank",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "lastTransfer": "2024-12-11T11:00:00Z",
      "isFrequent": true,
    },
    {
      "id": "rec005",
      "name": "David Wilson",
      "account": "****7890",
      "bank": "JKL Bank",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "lastTransfer": "2024-12-10T13:30:00Z",
      "isFrequent": false,
    },
  ];

  // Account balance
  double accountBalance = 12575.50;
  
  bool loading = false;

  double get transferAmount {
    if (selectedQuickAmount.isNotEmpty) {
      return double.tryParse(selectedQuickAmount) ?? 0.0;
    }
    return double.tryParse(customAmount) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Transfer"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              //navigateTo('BfaQrScanView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Account Balance Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Balance",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${accountBalance.currency}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Savings Account (****5678)",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Amount Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select Amount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Quick amount buttons
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 100,
                    children: quickAmounts.map((amount) {
                      bool isSelected = selectedQuickAmount == amount["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedQuickAmount = amount["value"];
                          customAmount = "";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Text(
                            "${amount["label"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Custom amount input
                  QNumberField(
                    label: "Custom Amount (\$)",
                    value: customAmount,
                    hint: "Enter custom amount",
                    onChanged: (value) {
                      customAmount = value;
                      selectedQuickAmount = "";
                      setState(() {});
                    },
                  ),

                  if (transferAmount > 0) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: transferAmount > accountBalance ? 
                              dangerColor.withAlpha(20) : 
                              successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            transferAmount > accountBalance ? 
                                Icons.warning : Icons.check_circle,
                            color: transferAmount > accountBalance ? 
                                  dangerColor : successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              transferAmount > accountBalance ? 
                                  "Insufficient balance" : 
                                  "Transfer amount: \$${transferAmount.currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: transferAmount > accountBalance ? 
                                      dangerColor : successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Recent Recipients
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spLg),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Recipients",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //navigateTo('BfaBeneficiaryListView')
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  QHorizontalScroll(
                    children: recentRecipients.map((recipient) {
                      bool isSelected = selectedRecipient == recipient["id"];
                      return GestureDetector(
                        onTap: () {
                          selectedRecipient = recipient["id"];
                          setState(() {});
                        },
                        child: Container(
                          width: 120,
                          margin: EdgeInsets.only(right: spSm, bottom: spLg, left: spLg),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      boxShadow: [shadowXs],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      child: Image.network(
                                        "${recipient["avatar"]}",
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: primaryColor.withAlpha(20),
                                            child: Icon(
                                              Icons.person,
                                              color: primaryColor,
                                              size: 24,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  if (recipient["isFrequent"] == true) ...[
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusLg),
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${recipient["name"]}",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${recipient["account"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
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

            // Transfer Note
            if (selectedRecipient.isNotEmpty && transferAmount > 0) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Add Note (Optional)",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QMemoField(
                      label: "Transfer Note",
                      value: transferNote,
                      hint: "Add a note for this transfer...",
                      onChanged: (value) {
                        transferNote = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Transfer Summary
            if (selectedRecipient.isNotEmpty && transferAmount > 0) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Transfer Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow("To", _getSelectedRecipientName()),
                          _buildSummaryRow("Amount", "\$${transferAmount.currency}"),
                          _buildSummaryRow("Fee", "\$${_calculateFee().currency}"),
                          Divider(color: disabledOutlineBorderColor),
                          _buildSummaryRow("Total", "\$${(transferAmount + _calculateFee()).currency}", true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Quick Transfer Button
            if (selectedRecipient.isNotEmpty && transferAmount > 0 && transferAmount <= accountBalance) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Processing..." : "Send Money",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: loading ? null : () async {
                    loading = true;
                    setState(() {});
                    
                    // Simulate quick transfer
                    await Future.delayed(Duration(seconds: 2));
                    
                    loading = false;
                    setState(() {});
                    
                    //navigateTo('BfaTransferReceiptView')
                    ss("Quick transfer completed successfully");
                  },
                ),
              ),
            ],

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "QR Code",
                          icon: Icons.qr_code_scanner,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaQrScanView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Request Money",
                          icon: Icons.request_quote,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaRequestMoneyView')
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Split Bill",
                          icon: Icons.receipt_long,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaSplitBillView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Add Contact",
                          icon: Icons.person_add,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaAddBeneficiaryView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Quick Transfer Tips",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Quick transfers are processed immediately\n• Use QR codes for contactless payments\n• Frequent recipients are marked with a star\n• All transfers are secure and encrypted",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, [bool isBold = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: isBold ? primaryColor : disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _getSelectedRecipientName() {
    final recipient = recentRecipients.firstWhere(
      (r) => r["id"] == selectedRecipient,
      orElse: () => {"name": "Unknown"},
    );
    return "${recipient["name"]}";
  }

  double _calculateFee() {
    if (transferAmount <= 100) {
      return 1.0; // \$1 fee for transfers \$100 or less
    } else if (transferAmount <= 500) {
      return 2.5; // \$2.50 fee for transfers up to \$500
    } else {
      return 5.0; // \$5 fee for transfers over \$500
    }
  }
}
