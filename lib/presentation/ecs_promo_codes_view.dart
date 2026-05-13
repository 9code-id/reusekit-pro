import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPromoCodesView extends StatefulWidget {
  const EcsPromoCodesView({super.key});

  @override
  State<EcsPromoCodesView> createState() => _EcsPromoCodesViewState();
}

class _EcsPromoCodesViewState extends State<EcsPromoCodesView> {
  String promoCodeInput = "";
  bool isValidating = false;
  String validationMessage = "";
  bool isValidCode = false;

  List<Map<String, dynamic>> activeCodes = [
    {
      "code": "SUMMER2025",
      "title": "Summer Mega Sale",
      "description": "Get 40% off on summer collection",
      "discount": 40,
      "type": "percentage",
      "validUntil": "2025-09-01",
      "category": "Seasonal",
      "minOrder": 75.0,
      "isActive": true,
      "usageCount": 1456,
      "maxUsage": 5000,
    },
    {
      "code": "FLASH24H",
      "title": "24 Hour Flash Sale",
      "description": "Limited time 35% discount",
      "discount": 35,
      "type": "percentage",
      "validUntil": "2025-06-16",
      "category": "Flash Sale",
      "minOrder": 50.0,
      "isActive": true,
      "usageCount": 789,
      "maxUsage": 1000,
    },
    {
      "code": "FIRSTBUY20",
      "title": "First Purchase Bonus",
      "description": "20% off for new customers",
      "discount": 20,
      "type": "percentage",
      "validUntil": "2025-12-31",
      "category": "New Customer",
      "minOrder": 0.0,
      "isActive": true,
      "usageCount": 2345,
      "maxUsage": 0,
    },
  ];

  List<Map<String, dynamic>> expiredCodes = [
    {
      "code": "SPRING25",
      "title": "Spring Sale",
      "description": "Spring collection discount",
      "discount": 25,
      "type": "percentage",
      "validUntil": "2025-05-31",
      "category": "Seasonal",
      "usageCount": 3456,
      "maxUsage": 5000,
    },
    {
      "code": "VALENTINE15",
      "title": "Valentine's Special",
      "description": "Love discount for couples",
      "discount": 15,
      "type": "percentage",
      "validUntil": "2025-02-14",
      "category": "Holiday",
      "usageCount": 1234,
      "maxUsage": 2000,
    },
  ];

  List<Map<String, dynamic>> myPromoCodes = [
    {
      "code": "WELCOME10-USER123",
      "title": "Personal Welcome Code",
      "description": "Your exclusive 10% welcome discount",
      "discount": 10,
      "type": "percentage",
      "validUntil": "2025-08-15",
      "category": "Personal",
      "isPersonal": true,
      "isUsed": false,
    },
    {
      "code": "BIRTHDAY30-USER123",
      "title": "Birthday Special",
      "description": "Happy birthday! 30% off everything",
      "discount": 30,
      "type": "percentage",
      "validUntil": "2025-07-20",
      "category": "Birthday",
      "isPersonal": true,
      "isUsed": true,
      "usedDate": "2025-06-10",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promo Codes"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Promo codes refreshed!");
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildPromoCodeHeader(),
            _buildCodeInputSection(),
            _buildMyPromoCodes(),
            _buildActivePromoCodes(),
            _buildExpiredPromoCodes(),
            _buildHowToUse(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            secondaryColor,
            secondaryColor.withAlpha(180),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.confirmation_number, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Text(
                "Promo Codes",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Enter codes for instant savings",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withAlpha(220),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Combine with other offers for maximum savings",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInputSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Enter Promo Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Promo Code",
                  value: promoCodeInput,
                  hint: "Enter your code here",
                  onChanged: (value) {
                    promoCodeInput = value.toUpperCase();
                    validationMessage = "";
                    isValidCode = false;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: isValidating ? "Checking..." : "Apply",
                size: bs.sm,
                onPressed: promoCodeInput.isEmpty ? null : _validatePromoCode,
              ),
            ],
          ),
          if (validationMessage.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isValidCode 
                    ? successColor.withAlpha(20) 
                    : dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isValidCode 
                      ? successColor.withAlpha(100) 
                      : dangerColor.withAlpha(100),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isValidCode ? Icons.check_circle : Icons.error,
                    color: isValidCode ? successColor : dangerColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      validationMessage,
                      style: TextStyle(
                        fontSize: 14,
                        color: isValidCode ? successColor : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          _buildQuickCodes(),
        ],
      ),
    );
  }

  Widget _buildQuickCodes() {
    List<String> quickCodes = ["SUMMER2025", "FLASH24H", "FIRSTBUY20"];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Quick Apply",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Wrap(
          spacing: spSm,
          runSpacing: spXs,
          children: quickCodes.map((code) {
            return GestureDetector(
              onTap: () {
                promoCodeInput = code;
                setState(() {});
                _validatePromoCode();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMyPromoCodes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.person, color: primaryColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "My Personal Codes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        ...myPromoCodes.map((code) => _buildPersonalCodeCard(code)),
      ],
    );
  }

  Widget _buildPersonalCodeCard(Map<String, dynamic> code) {
    bool isUsed = code["isUsed"] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isUsed 
              ? disabledColor 
              : primaryColor.withAlpha(100),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isUsed 
                  ? disabledColor.withAlpha(30) 
                  : primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              isUsed ? Icons.check_circle : Icons.card_giftcard,
              color: isUsed ? disabledBoldColor : primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${code["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isUsed ? disabledBoldColor : primaryColor,
                  ),
                ),
                Text(
                  "${code["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: code["category"] == "Birthday" 
                            ? warningColor.withAlpha(20) 
                            : primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${code["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: code["category"] == "Birthday" 
                              ? warningColor 
                              : primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${code["discount"]}% OFF",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isUsed ? disabledBoldColor : successColor,
                      ),
                    ),
                  ],
                ),
                if (isUsed)
                  Text(
                    "Used on ${DateTime.parse(code["usedDate"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else
                  Text(
                    "Valid until ${DateTime.parse(code["validUntil"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
          ),
          if (!isUsed)
            GestureDetector(
              onTap: () {
                promoCodeInput = code["code"];
                setState(() {});
                _validatePromoCode();
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActivePromoCodes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.local_offer, color: successColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Active Promo Codes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        ...activeCodes.map((code) => _buildPromoCodeCard(code, isActive: true)),
      ],
    );
  }

  Widget _buildExpiredPromoCodes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.schedule, color: disabledBoldColor, size: 20),
            SizedBox(width: spXs),
            Text(
              "Recently Expired",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...expiredCodes.map((code) => _buildPromoCodeCard(code, isActive: false)),
      ],
    );
  }

  Widget _buildPromoCodeCard(Map<String, dynamic> code, {required bool isActive}) {
    double usagePercentage = code["maxUsage"] > 0 
        ? (code["usageCount"] as int) / (code["maxUsage"] as int)
        : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isActive 
              ? successColor.withAlpha(100) 
              : disabledColor,
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isActive 
                      ? successColor.withAlpha(20) 
                      : disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  isActive ? Icons.local_offer : Icons.schedule,
                  color: isActive ? successColor : disabledBoldColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${code["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isActive ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${code["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isActive 
                                ? successColor.withAlpha(20) 
                                : disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${code["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isActive ? successColor : disabledBoldColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${code["discount"]}% OFF",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isActive ? successColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isActive)
                GestureDetector(
                  onTap: () {
                    promoCodeInput = code["code"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.copy,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: isActive ? primaryColor : disabledColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Code:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${code["code"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? primaryColor : disabledBoldColor,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          if (code["maxUsage"] > 0)
            Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Used: ${code["usageCount"]}/${code["maxUsage"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(usagePercentage * 100).toInt()}% claimed",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isActive ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: usagePercentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isActive ? primaryColor : disabledBoldColor,
                  ),
                ),
              ],
            ),
          Text(
            isActive 
                ? "Valid until ${DateTime.parse(code["validUntil"]).dMMMy}"
                : "Expired on ${DateTime.parse(code["validUntil"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: isActive ? primaryColor : disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToUse() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "How to Use Promo Codes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              _buildHowToStep("1", "Enter the promo code in the field above"),
              _buildHowToStep("2", "Click 'Apply' to validate the code"),
              _buildHowToStep("3", "Add items to cart and proceed to checkout"),
              _buildHowToStep("4", "Your discount will be applied automatically"),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Tip: Check for minimum order requirements and expiry dates",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToStep(String number, String description) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  void _validatePromoCode() async {
    if (promoCodeInput.isEmpty) return;
    
    setState(() {
      isValidating = true;
      validationMessage = "";
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 1));

    // Check if code exists in active codes
    Map<String, dynamic>? foundCode = activeCodes
        .where((code) => code["code"] == promoCodeInput)
        .isNotEmpty 
            ? activeCodes.firstWhere((code) => code["code"] == promoCodeInput)
            : null;

    // Check personal codes
    if (foundCode == null) {
      foundCode = myPromoCodes
          .where((code) => code["code"] == promoCodeInput && code["isUsed"] == false)
          .isNotEmpty 
              ? myPromoCodes.firstWhere((code) => code["code"] == promoCodeInput && code["isUsed"] == false)
              : null;
    }

    setState(() {
      isValidating = false;
      if (foundCode != null) {
        isValidCode = true;
        validationMessage = "✅ Valid! ${foundCode["discount"]}% discount applied to your cart";
        ss("Promo code applied successfully!");
      } else {
        isValidCode = false;
        validationMessage = "❌ Invalid or expired promo code";
        se("Promo code not found or expired");
      }
    });
  }
}
