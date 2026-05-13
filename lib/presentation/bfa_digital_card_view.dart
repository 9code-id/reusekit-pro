import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaDigitalCardView extends StatefulWidget {
  const BfaDigitalCardView({super.key});

  @override
  State<BfaDigitalCardView> createState() => _BfaDigitalCardViewState();
}

class _BfaDigitalCardViewState extends State<BfaDigitalCardView> {
  int selectedCardIndex = 0;
  bool isCardVisible = true;
  
  List<Map<String, dynamic>> cards = [
    {
      "id": 1,
      "type": "Credit Card",
      "bank": "Premium Bank",
      "cardNumber": "1234 5678 9012 3456",
      "cardHolder": "John Doe",
      "expiryDate": "12/28",
      "cvv": "123",
      "balance": 15420.50,
      "limit": 25000.00,
      "color": Colors.blue,
      "gradientColors": [Colors.blue.shade800, Colors.blue.shade400],
      "logo": "https://picsum.photos/80/40?random=1&keyword=bank+logo",
      "isDefault": true,
      "status": "active",
    },
    {
      "id": 2,
      "type": "Debit Card",
      "bank": "Global Bank",
      "cardNumber": "9876 5432 1098 7654",
      "cardHolder": "John Doe",
      "expiryDate": "06/27",
      "cvv": "456",
      "balance": 8750.25,
      "limit": 10000.00,
      "color": Colors.purple,
      "gradientColors": [Colors.purple.shade800, Colors.purple.shade400],
      "logo": "https://picsum.photos/80/40?random=2&keyword=bank+logo",
      "isDefault": false,
      "status": "active",
    },
    {
      "id": 3,
      "type": "Business Card",
      "bank": "Business Bank",
      "cardNumber": "5555 4444 3333 2222",
      "cardHolder": "John Doe",
      "expiryDate": "09/26",
      "cvv": "789",
      "balance": 32150.75,
      "limit": 50000.00,
      "color": Colors.green,
      "gradientColors": [Colors.green.shade800, Colors.green.shade400],
      "logo": "https://picsum.photos/80/40?random=3&keyword=bank+logo",
      "isDefault": false,
      "status": "active",
    },
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": 1,
      "title": "Online Shopping",
      "merchant": "Amazon",
      "amount": -125.99,
      "date": "2024-12-18",
      "category": "Shopping",
      "icon": Icons.shopping_cart,
    },
    {
      "id": 2,
      "title": "Salary Deposit",
      "merchant": "Company Inc",
      "amount": 3500.00,
      "date": "2024-12-15",
      "category": "Income",
      "icon": Icons.account_balance,
    },
    {
      "id": 3,
      "title": "Gas Station",
      "merchant": "Shell",
      "amount": -45.50,
      "date": "2024-12-14",
      "category": "Transportation",
      "icon": Icons.local_gas_station,
    },
    {
      "id": 4,
      "title": "Restaurant",
      "merchant": "Pizza Palace",
      "amount": -28.75,
      "date": "2024-12-13",
      "category": "Food",
      "icon": Icons.restaurant,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Wallet"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_card),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Card Carousel
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "My Cards",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        isCardVisible = !isCardVisible;
                        setState(() {});
                      },
                      child: Icon(
                        isCardVisible ? Icons.visibility : Icons.visibility_off,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                Container(
                  height: 220,
                  child: QHorizontalScroll(
                    children: cards.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> card = entry.value;
                      bool isSelected = selectedCardIndex == index;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedCardIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          width: 320,
                          margin: EdgeInsets.only(right: spSm),
                          child: Stack(
                            children: [
                              // Card Background
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: card["gradientColors"],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  boxShadow: [
                                    if (isSelected) shadowLg else shadowMd,
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(spMd),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Card Header
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${card["bank"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white.withAlpha(200),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "${card["type"]}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          if (card["isDefault"] as bool)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: spXs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withAlpha(50),
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                              child: Text(
                                                "DEFAULT",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),

                                      Spacer(),

                                      // Card Number
                                      Text(
                                        isCardVisible ? "${card["cardNumber"]}" : "**** **** **** ****",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2,
                                        ),
                                      ),

                                      SizedBox(height: spSm),

                                      // Card Details
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "CARD HOLDER",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white.withAlpha(200),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "${card["cardHolder"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "EXPIRES",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white.withAlpha(200),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                isCardVisible ? "${card["expiryDate"]}" : "**/**",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Selection Indicator
                              if (isSelected)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: card["color"],
                                      size: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            // Card Balance & Limit
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Balance",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          isCardVisible ? "\$${((cards[selectedCardIndex]["balance"] as double)).currency}" : "\$****.**",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credit Limit",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          isCardVisible ? "\$${((cards[selectedCardIndex]["limit"] as double)).currency}" : "\$****.**",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(25), secondaryColor.withAlpha(25)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
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
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Transfer",
                          icon: Icons.send,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Pay Bills",
                          icon: Icons.receipt,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Top Up",
                          icon: Icons.add_circle,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Settings",
                          icon: Icons.settings,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Transactions
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
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

            // Transaction List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: transactions.map((transaction) {
                  bool isIncome = (transaction["amount"] as double) > 0;
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isIncome ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            transaction["icon"],
                            color: isIncome ? successColor : dangerColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${transaction["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "${transaction["merchant"]} • ${transaction["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${isIncome ? '+' : ''}\$${((transaction["amount"] as double).abs()).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isIncome ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
