import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaGiftCardsView extends StatefulWidget {
  const SpaGiftCardsView({super.key});

  @override
  State<SpaGiftCardsView> createState() => _SpaGiftCardsViewState();
}

class _SpaGiftCardsViewState extends State<SpaGiftCardsView> {
  List<Map<String, dynamic>> myGiftCards = [
    {
      "id": "GC001",
      "design": "https://picsum.photos/300/180?random=1&keyword=luxury",
      "balance": 150.00,
      "originalAmount": 200.00,
      "recipientName": "Sarah Johnson",
      "senderName": "Michael Davis",
      "message": "Happy Birthday! Enjoy a relaxing spa day!",
      "purchaseDate": "2024-11-15",
      "expiryDate": "2025-11-15",
      "status": "active",
      "code": "SPA2024ABC123",
    },
    {
      "id": "GC002",
      "design": "https://picsum.photos/300/180?random=2&keyword=wellness",
      "balance": 75.00,
      "originalAmount": 100.00,
      "recipientName": "Emily Wilson",
      "senderName": "Jessica Brown",
      "message": "Congratulations on your promotion!",
      "purchaseDate": "2024-10-20",
      "expiryDate": "2025-10-20",
      "status": "active",
      "code": "SPA2024XYZ789",
    },
    {
      "id": "GC003",
      "design": "https://picsum.photos/300/180?random=3&keyword=relaxation",
      "balance": 0.00,
      "originalAmount": 250.00,
      "recipientName": "Lisa Chen",
      "senderName": "David Miller",
      "message": "Thank you for being an amazing friend!",
      "purchaseDate": "2024-09-10",
      "expiryDate": "2025-09-10",
      "status": "used",
      "code": "SPA2024DEF456",
    },
    {
      "id": "GC004",
      "design": "https://picsum.photos/300/180?random=4&keyword=spa",
      "balance": 300.00,
      "originalAmount": 300.00,
      "recipientName": "Amanda Taylor",
      "senderName": "Robert Johnson",
      "message": "Merry Christmas! Treat yourself to something special.",
      "purchaseDate": "2024-12-01",
      "expiryDate": "2025-12-01",
      "status": "active",
      "code": "SPA2024GHI012",
    },
  ];

  List<Map<String, dynamic>> giftCardTemplates = [
    {
      "id": "template1",
      "name": "Luxury Spa",
      "design": "https://picsum.photos/300/180?random=10&keyword=luxury",
      "description": "Elegant gold and cream design",
      "category": "Premium",
    },
    {
      "id": "template2",
      "name": "Wellness Zen",
      "design": "https://picsum.photos/300/180?random=11&keyword=zen",
      "description": "Peaceful green nature theme",
      "category": "Wellness",
    },
    {
      "id": "template3",
      "name": "Birthday Special",
      "design": "https://picsum.photos/300/180?random=12&keyword=birthday",
      "description": "Colorful celebration design",
      "category": "Birthday",
    },
    {
      "id": "template4",
      "name": "Holiday Wishes",
      "design": "https://picsum.photos/300/180?random=13&keyword=holiday",
      "description": "Festive holiday theme",
      "category": "Holiday",
    },
    {
      "id": "template5",
      "name": "Thank You",
      "design": "https://picsum.photos/300/180?random=14&keyword=gratitude",
      "description": "Warm appreciation design",
      "category": "Gratitude",
    },
    {
      "id": "template6",
      "name": "Congratulations",
      "design": "https://picsum.photos/300/180?random=15&keyword=celebration",
      "description": "Achievement celebration theme",
      "category": "Achievement",
    },
  ];

  int selectedTab = 0;
  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Active", "Used", "Expired"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCards = _getFilteredCards();
    double totalBalance = myGiftCards
        .where((card) => card["status"] == "active")
        .fold(0.0, (sum, card) => sum + (card["balance"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Gift Cards"),
        actions: [
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
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "\$${totalBalance.currency}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Balance Overview
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.card_giftcard,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Gift Card Balance",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "\$${totalBalance.currency}",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${myGiftCards.where((c) => c["status"] == "active").length} active cards",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "My Cards",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Buy Gift Card",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Content
          Expanded(
            child: selectedTab == 0 ? _buildMyCardsTab(filteredCards) : _buildBuyCardTab(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to redeem gift card
        },
        backgroundColor: primaryColor,
        icon: Icon(Icons.redeem, color: Colors.white),
        label: Text(
          "Redeem Card",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMyCardsTab(List<Map<String, dynamic>> filteredCards) {
    return Column(
      children: [
        // Filter Options
        Container(
          margin: EdgeInsets.symmetric(horizontal: spMd),
          child: QCategoryPicker(
            items: filterOptions.map((filter) => {
              "label": filter,
              "value": filter,
            }).toList(),
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ),

        SizedBox(height: spMd),

        // Gift Cards List
        Expanded(
          child: filteredCards.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No gift cards found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Try adjusting your filter or purchase a new gift card",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Column(
                    children: filteredCards.map((card) => _buildGiftCard(card)).toList(),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildGiftCard(Map<String, dynamic> card) {
    Color statusColor = _getStatusColor(card["status"]);
    IconData statusIcon = _getStatusIcon(card["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gift Card Design
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${card["design"]}",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${card["status"]}".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${(card["balance"] as double).currency}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "of \$${(card["originalAmount"] as double).currency}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Card Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "To: ${card["recipientName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "From: ${card["senderName"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "ID: ${card["id"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                if (card["message"] != null && (card["message"] as String).isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${card["message"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                ],

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchased: ${DateTime.parse(card["purchaseDate"]).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "Expires: ${DateTime.parse(card["expiryDate"]).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (card["status"] == "active") ...[
                      Row(
                        children: [
                          QButton(
                            label: "View Code",
                            size: bs.sm,
                            onPressed: () {
                              _showGiftCardCode(card);
                            },
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Use Card",
                            size: bs.sm,
                            onPressed: () {
                              _useGiftCard(card);
                            },
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyCardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose a Design",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            minItemWidth: 200,
            children: giftCardTemplates.map((template) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${template["design"]}",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${template["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${template["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Select Design",
                              size: bs.sm,
                              onPressed: () {
                                _selectGiftCardTemplate(template);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCards() {
    if (selectedFilter == "All") {
      return myGiftCards;
    }
    return myGiftCards.where((card) => 
        card["status"].toString().toLowerCase() == selectedFilter.toLowerCase()).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "used":
        return disabledColor;
      case "expired":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "active":
        return Icons.check_circle;
      case "used":
        return Icons.check_circle_outline;
      case "expired":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  void _showGiftCardCode(Map<String, dynamic> card) {
    ss("Gift card code: ${card["code"]}");
  }

  void _useGiftCard(Map<String, dynamic> card) {
    ss("Using gift card for booking...");
  }

  void _selectGiftCardTemplate(Map<String, dynamic> template) {
    ss("Selected ${template["name"]} design");
  }
}
