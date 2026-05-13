import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCardBlockView extends StatefulWidget {
  const BfaCardBlockView({super.key});

  @override
  State<BfaCardBlockView> createState() => _BfaCardBlockViewState();
}

class _BfaCardBlockViewState extends State<BfaCardBlockView> {
  String selectedCard = "card_001";
  String blockReason = "temporary";
  bool confirmBlock = false;
  
  List<Map<String, dynamic>> cards = [
    {
      "id": "card_001",
      "name": "Premium Debit Card",
      "number": "**** 1234",
      "type": "Debit",
      "status": "Active",
      "balance": 2500000.0,
      "color": Colors.blue,
    },
    {
      "id": "card_002",
      "name": "Platinum Credit Card", 
      "number": "**** 5678",
      "type": "Credit",
      "status": "Active",
      "limit": 10000000.0,
      "used": 1500000.0,
      "color": Colors.black,
    },
    {
      "id": "card_003",
      "name": "Business Card",
      "number": "**** 9012",
      "type": "Business",
      "status": "Blocked",
      "balance": 500000.0,
      "color": Colors.orange,
    },
  ];
  
  List<Map<String, dynamic>> blockReasons = [
    {
      "value": "temporary",
      "label": "Temporary Block",
      "description": "Block card temporarily for security",
      "icon": Icons.pause_circle,
      "color": Colors.orange,
    },
    {
      "value": "lost",
      "label": "Lost Card",
      "description": "Card has been lost or misplaced",
      "icon": Icons.help_outline,
      "color": Colors.blue,
    },
    {
      "value": "stolen",
      "label": "Stolen Card",
      "description": "Card has been stolen",
      "icon": Icons.warning,
      "color": Colors.red,
    },
    {
      "value": "suspicious",
      "label": "Suspicious Activity",
      "description": "Detected unauthorized transactions",
      "icon": Icons.security,
      "color": Colors.purple,
    },
    {
      "value": "damaged",
      "label": "Damaged Card",
      "description": "Card is physically damaged",
      "icon": Icons.broken_image,
      "color": Colors.grey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentCard = cards.firstWhere((card) => card["id"] == selectedCard);
    final isCurrentlyBlocked = currentCard["status"] == "Blocked";
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isCurrentlyBlocked ? "Unblock Card" : "Block Card"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isCurrentlyBlocked 
                  ? infoColor.withAlpha(30)
                  : warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isCurrentlyBlocked 
                    ? infoColor.withAlpha(100)
                    : warningColor.withAlpha(100),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isCurrentlyBlocked ? Icons.info : Icons.warning,
                    color: isCurrentlyBlocked ? infoColor : warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCurrentlyBlocked 
                            ? "Card Currently Blocked"
                            : "Important Security Notice",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCurrentlyBlocked ? infoColor : warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          isCurrentlyBlocked
                            ? "This card is currently blocked. You can unblock it if you have it in your possession."
                            : "Blocking your card will prevent all transactions. You can unblock it anytime if it's a temporary block.",
                          style: TextStyle(
                            fontSize: 12,
                            color: isCurrentlyBlocked ? infoColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Card Selection
            Text(
              "Select Card",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: cards.map((card) {
                final isSelected = selectedCard == card["id"];
                final isBlocked = card["status"] == "Blocked";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: RadioListTile<String>(
                    value: card["id"],
                    groupValue: selectedCard,
                    onChanged: (value) {
                      selectedCard = value!;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                    contentPadding: EdgeInsets.all(spSm),
                    title: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                            color: card["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${card["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isBlocked
                                        ? dangerColor.withAlpha(30)
                                        : successColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${card["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isBlocked ? dangerColor : successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${card["number"]} • ${card["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            if (!isCurrentlyBlocked) ...[
              SizedBox(height: spLg),
              
              // Block Reason Selection
              Text(
                "Reason for Blocking",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spSm),
              
              Column(
                children: blockReasons.map((reason) {
                  final isSelected = blockReason == reason["value"];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: RadioListTile<String>(
                      value: reason["value"],
                      groupValue: blockReason,
                      onChanged: (value) {
                        blockReason = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                      contentPadding: EdgeInsets.all(spSm),
                      title: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (reason["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              reason["icon"] as IconData,
                              color: reason["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${reason["label"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${reason["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spLg),
              
              // Confirmation Checkbox
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: dangerColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: confirmBlock,
                      onChanged: (value) {
                        confirmBlock = value ?? false;
                        setState(() {});
                      },
                      activeColor: dangerColor,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          confirmBlock = !confirmBlock;
                          setState(() {});
                        },
                        child: Text(
                          "I confirm that I want to block this card. I understand that all transactions will be prevented until I unblock it.",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spLg),
            
            // Action Buttons
            if (isCurrentlyBlocked) ...[
              // Unblock Card Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.lock_open,
                      color: successColor,
                      size: 60,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Unblock Card",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Your card will be reactivated and ready for use immediately.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Unblock Card",
                        onPressed: () {
                          _unblockCard();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Block Card",
                  onPressed: confirmBlock ? () {
                    _blockCard();
                  } : null,
                ),
              ),
            ],
            
            SizedBox(height: spSm),
            
            // Help Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "If your card is lost or stolen, block it immediately and contact customer support for a replacement card.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () {
                            // Contact support
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Request Replacement",
                          size: bs.sm,
                          onPressed: () {
                            // Request replacement
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

  void _blockCard() async {
    bool isConfirmed = await confirm(
      "Are you sure you want to block this card? This action will prevent all transactions."
    );
    
    if (isConfirmed) {
      // Update card status
      final cardIndex = cards.indexWhere((card) => card["id"] == selectedCard);
      if (cardIndex != -1) {
        cards[cardIndex]["status"] = "Blocked";
        setState(() {});
        
        ss("Card has been blocked successfully");
        
        // Navigate back or show success
        Navigator.pop(context);
      }
    }
  }

  void _unblockCard() async {
    bool isConfirmed = await confirm(
      "Are you sure you want to unblock this card? It will be immediately available for transactions."
    );
    
    if (isConfirmed) {
      // Update card status
      final cardIndex = cards.indexWhere((card) => card["id"] == selectedCard);
      if (cardIndex != -1) {
        cards[cardIndex]["status"] = "Active";
        setState(() {});
        
        ss("Card has been unblocked successfully");
        
        // Navigate back or show success
        Navigator.pop(context);
      }
    }
  }
}
