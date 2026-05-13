import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReceipt7View extends StatefulWidget {
  @override
  State<GrlReceipt7View> createState() => _GrlReceipt7ViewState();
}

class _GrlReceipt7ViewState extends State<GrlReceipt7View> {
  Map<String, dynamic> receipt = {
    "id": "GRO-2024-456",
    "date": "2024-06-22",
    "time": "14:20",
    "store": "FreshMart Supermarket",
    "address": "456 Market Street, Greenville",
    "phone": "+1 555 654 3210",
    "cashier": "Emma Wilson",
    "register": "Register #5",
    "loyalty": {
      "member_id": "FM789456123",
      "points_earned": 45,
      "points_balance": 1250
    },
    "items": [
      {
        "category": "Produce",
        "items": [
          {"name": "Organic Bananas", "qty": 2.5, "unit": "lbs", "price": 1.99, "total": 4.98},
          {"name": "Fresh Spinach", "qty": 1, "unit": "bunch", "price": 2.49, "total": 2.49},
          {"name": "Red Apples", "qty": 3.2, "unit": "lbs", "price": 2.99, "total": 9.57},
        ]
      },
      {
        "category": "Dairy & Eggs",
        "items": [
          {"name": "Organic Milk 1 Gallon", "qty": 2, "unit": "gallon", "price": 4.99, "total": 9.98},
          {"name": "Free Range Eggs", "qty": 1, "unit": "dozen", "price": 3.99, "total": 3.99},
          {"name": "Greek Yogurt", "qty": 3, "unit": "container", "price": 1.89, "total": 5.67},
        ]
      },
      {
        "category": "Pantry",
        "items": [
          {"name": "Whole Wheat Bread", "qty": 2, "unit": "loaf", "price": 2.79, "total": 5.58},
          {"name": "Pasta Sauce", "qty": 1, "unit": "jar", "price": 3.49, "total": 3.49},
          {"name": "Brown Rice", "qty": 1, "unit": "bag", "price": 4.99, "total": 4.99},
        ]
      },
      {
        "category": "Frozen",
        "items": [
          {"name": "Frozen Berries", "qty": 2, "unit": "bag", "price": 4.49, "total": 8.98},
          {"name": "Veggie Burgers", "qty": 1, "unit": "box", "price": 5.99, "total": 5.99},
        ]
      }
    ],
    "subtotal": 75.71,
    "discounts": [
      {"name": "Member Discount (5%)", "amount": 3.79},
      {"name": "Weekly Special - Organic Milk", "amount": 2.00}
    ],
    "tax": 6.73,
    "total": 76.65,
    "payment_method": "Debit Card",
    "card_number": "**** 4321",
    "savings": 5.79
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Receipt"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.loyalty),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowLg],
          ),
          child: Column(
            children: [
              _buildStoreHeader(),
              _buildTransactionInfo(),
              _buildLoyaltyInfo(),
              _buildItemsList(),
              _buildDiscounts(),
              _buildTotalSection(),
              _buildPaymentInfo(),
              _buildSavingsSummary(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[600]!, Colors.lime[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusLg),
          topRight: Radius.circular(radiusLg),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.green[600],
              size: 48,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${receipt["store"]}",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${receipt["address"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${receipt["phone"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction ID",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${receipt["id"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${receipt["register"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              Text(
                "Cashier: ${receipt["cashier"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Date & Time",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${receipt["date"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  "${receipt["time"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyInfo() {
    final loyalty = receipt["loyalty"] as Map<String, dynamic>;
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.amber[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.card_membership,
              color: Colors.amber[700],
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LOYALTY MEMBER",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[700],
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  "ID: ${loyalty["member_id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber[700],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "+${loyalty["points_earned"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[700],
                    ),
                  ),
                  SizedBox(width: spXs),
                  Icon(
                    Icons.stars,
                    color: Colors.amber[600],
                    size: 16,
                  ),
                ],
              ),
              Text(
                "Balance: ${loyalty["points_balance"]} pts",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.amber[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: Colors.green[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "ITEMS PURCHASED",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...List.generate((receipt["items"] as List).length, (categoryIndex) {
            final category = (receipt["items"] as List)[categoryIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: spSm,
                    horizontal: spMd,
                  ),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[100]!, Colors.lime[100]!],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getCategoryIcon("${category["category"]}"),
                        color: Colors.green[700],
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${category["category"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate((category["items"] as List).length, (itemIndex) {
                  final item = (category["items"] as List)[itemIndex];
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: spSm,
                      horizontal: spMd,
                    ),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.green[300]!,
                          width: 3,
                        ),
                      ),
                      color: Colors.green[25],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(item["qty"] as num).toString()} ${item["unit"]} @ \$${(item["price"] as double).toStringAsFixed(2)}/${item["unit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${(item["total"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: spSm),
              ],
            );
          }),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Produce":
        return Icons.eco;
      case "Dairy & Eggs":
        return Icons.egg;
      case "Pantry":
        return Icons.kitchen;
      case "Frozen":
        return Icons.ac_unit;
      default:
        return Icons.shopping_basket;
    }
  }

  Widget _buildDiscounts() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer,
                color: Colors.green[600],
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "DISCOUNTS & SAVINGS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...List.generate((receipt["discounts"] as List).length, (index) {
            final discount = (receipt["discounts"] as List)[index];
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.green[200]!,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.discount,
                    color: Colors.green[600],
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${discount["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "-\$${(discount["amount"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    final totalDiscounts = (receipt["discounts"] as List)
        .fold(0.0, (sum, discount) => sum + (discount["amount"] as double));

    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[100]!, Colors.lime[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.green[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildTotalRow("Subtotal", (receipt["subtotal"] as double)),
          SizedBox(height: spSm),
          _buildTotalRow("Total Discounts", -totalDiscounts, isDiscount: true),
          SizedBox(height: spSm),
          _buildTotalRow("Tax", (receipt["tax"] as double)),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.symmetric(vertical: spMd),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.green[400]!,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL AMOUNT",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  "\$${(receipt["total"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "${isDiscount ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.green[600] : Colors.green[700],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.blue[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.blue[600],
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "PAYMENT SUCCESSFUL",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Method:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.payment,
                    color: Colors.blue[600],
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${receipt["payment_method"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Card Number:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${receipt["card_number"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsSummary() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[100]!, Colors.amber[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.orange[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.savings,
                color: Colors.orange[600],
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "YOU SAVED TODAY!",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "\$${(receipt["savings"] as double).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Thanks to member discounts and weekly specials!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.orange[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        children: [
          Text(
            "🛒 Thank You for Shopping! 🛒",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Fresh quality, great prices, every day!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.w600,
              color: Colors.green[700],
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Text(
                  "Store Hours: Mon-Sun 7AM-11PM",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[600],
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Need help? Call us at ${receipt["phone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.green[700],
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Download Our App",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.lime[200],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.feedback,
                      color: Colors.lime[700],
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Leave Review",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.lime[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
