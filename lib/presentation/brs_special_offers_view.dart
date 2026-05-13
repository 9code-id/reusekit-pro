import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsSpecialOffersView extends StatefulWidget {
  const BrsSpecialOffersView({super.key});

  @override
  State<BrsSpecialOffersView> createState() => _BrsSpecialOffersViewState();
}

class _BrsSpecialOffersViewState extends State<BrsSpecialOffersView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Offers", "value": "All"},
    {"label": "Limited Time", "value": "Limited Time"},
    {"label": "New Customer", "value": "New Customer"},
    {"label": "Loyalty Rewards", "value": "Loyalty Rewards"},
    {"label": "Seasonal", "value": "Seasonal"},
  ];

  List<Map<String, dynamic>> offers = [
    {
      "id": "OFFER001",
      "title": "First Visit Special",
      "description": "Get 30% off your first haircut and styling service",
      "discount": 30,
      "discountType": "percentage",
      "category": "New Customer",
      "validUntil": "2024-02-15",
      "image": "https://picsum.photos/400/200?random=1&keyword=haircut",
      "terms": [
        "Valid for new customers only",
        "Cannot be combined with other offers",
        "Valid for haircut and styling services only",
        "Must present coupon code at booking"
      ],
      "code": "FIRST30",
      "isActive": true,
      "isPopular": true,
      "backgroundColor": [76, 175, 80],
      "textColor": [255, 255, 255],
    },
    {
      "id": "OFFER002",
      "title": "Weekend Warriors",
      "description": "Book any service on weekends and save \$15",
      "discount": 15,
      "discountType": "fixed",
      "category": "Limited Time",
      "validUntil": "2024-01-31",
      "image": "https://picsum.photos/400/200?random=2&keyword=weekend",
      "terms": [
        "Valid on Saturday and Sunday only",
        "Minimum service value \$25",
        "Valid for all services",
        "Cannot be combined with other offers"
      ],
      "code": "WEEKEND15",
      "isActive": true,
      "isPopular": false,
      "backgroundColor": [63, 81, 181],
      "textColor": [255, 255, 255],
    },
    {
      "id": "OFFER003",
      "title": "Loyalty Member Exclusive",
      "description": "Earn double points on every visit this month",
      "discount": 0,
      "discountType": "points",
      "category": "Loyalty Rewards",
      "validUntil": "2024-01-31",
      "image": "https://picsum.photos/400/200?random=3&keyword=loyalty",
      "terms": [
        "Valid for loyalty members only",
        "Points earned on all services",
        "Double points applied automatically",
        "Points can be redeemed for future discounts"
      ],
      "code": "DOUBLE2024",
      "isActive": true,
      "isPopular": true,
      "backgroundColor": [255, 152, 0],
      "textColor": [255, 255, 255],
    },
    {
      "id": "OFFER004",
      "title": "Beard & Mustache Combo",
      "description": "Get beard trim + mustache grooming for just \$20",
      "discount": 10,
      "discountType": "combo",
      "category": "Limited Time",
      "validUntil": "2024-02-28",
      "image": "https://picsum.photos/400/200?random=4&keyword=beard",
      "terms": [
        "Includes beard trim and mustache grooming",
        "Regular price would be \$30",
        "Available with select barbers only",
        "Advanced booking required"
      ],
      "code": "BEARD20",
      "isActive": true,
      "isPopular": false,
      "backgroundColor": [121, 85, 72],
      "textColor": [255, 255, 255],
    },
    {
      "id": "OFFER005",
      "title": "Valentine's Special",
      "description": "Couple's grooming package - 2 services for \$60",
      "discount": 25,
      "discountType": "package",
      "category": "Seasonal",
      "validUntil": "2024-02-14",
      "image": "https://picsum.photos/400/200?random=5&keyword=couple",
      "terms": [
        "Valid for couples booking together",
        "Each person gets one premium service",
        "Must book on the same day and time",
        "Valid until Valentine's Day"
      ],
      "code": "VALENTINE60",
      "isActive": true,
      "isPopular": true,
      "backgroundColor": [233, 30, 99],
      "textColor": [255, 255, 255],
    },
    {
      "id": "OFFER006",
      "title": "Student Discount",
      "description": "Show your student ID and get 20% off",
      "discount": 20,
      "discountType": "percentage",
      "category": "New Customer",
      "validUntil": "2024-12-31",
      "image": "https://picsum.photos/400/200?random=6&keyword=student",
      "terms": [
        "Valid student ID required",
        "Available Monday to Friday only",
        "Valid for students aged 16-25",
        "Cannot be combined with other offers"
      ],
      "code": "STUDENT20",
      "isActive": true,
      "isPopular": false,
      "backgroundColor": [0, 150, 136],
      "textColor": [255, 255, 255],
    },
  ];

  List<Map<String, dynamic>> get filteredOffers {
    if (selectedCategory == "All") {
      return offers.where((offer) => offer["isActive"] as bool).toList();
    }
    return offers.where((offer) => 
        offer["isActive"] as bool && 
        "${offer["category"]}" == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Offers"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            QCategoryPicker(
              label: "Filter by Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Popular Offers Section
            if (filteredOffers.where((o) => o["isPopular"] as bool).isNotEmpty) ...[
              Text(
                "Popular Offers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QHorizontalScroll(
                children: filteredOffers
                    .where((offer) => offer["isPopular"] as bool)
                    .map((offer) => _buildPopularOfferCard(offer))
                    .toList(),
              ),
              SizedBox(height: spMd),
            ],
            
            // All Offers Header
            Row(
              children: [
                Text(
                  "All Offers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredOffers.length} available",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // All Offers List
            if (filteredOffers.isEmpty)
              Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 60,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No offers available",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Check back later for new deals",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredOffers.length,
                itemBuilder: (context, index) {
                  final offer = filteredOffers[index];
                  return _buildOfferCard(offer);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularOfferCard(Map<String, dynamic> offer) {
    Color bgColor = Color.fromARGB(
      255,
      (offer["backgroundColor"] as List)[0],
      (offer["backgroundColor"] as List)[1],
      (offer["backgroundColor"] as List)[2],
    );
    Color textColor = Color.fromARGB(
      255,
      (offer["textColor"] as List)[0],
      (offer["textColor"] as List)[1],
      (offer["textColor"] as List)[2],
    );
    
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusMd),
            child: Image.network(
              "${offer["image"]}",
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  bgColor.withAlpha(204),
                ],
              ),
            ),
          ),
          Positioned(
            top: spSm,
            right: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: warningColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "POPULAR",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: spSm,
            left: spSm,
            right: spSm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${offer["title"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor.withAlpha(230),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Code: ${offer["code"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      _getDiscountText(offer),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
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

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offer Image and Header
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${offer["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(128),
                    ],
                  ),
                ),
              ),
              if (offer["isPopular"] as bool)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "POPULAR",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _getDiscountText(offer),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Offer Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${offer["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${offer["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                // Description
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Validity and Code
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Valid Until:",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(offer["validUntil"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
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
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledColor,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${offer["code"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () => _copyCode("${offer["code"]}"),
                            child: Icon(
                              Icons.copy,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Terms",
                        size: bs.sm,
                        onPressed: () {
                          _showTermsDialog(offer);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Book Now",
                        size: bs.sm,
                        onPressed: () {
                          _bookWithOffer(offer);
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
    );
  }

  String _getDiscountText(Map<String, dynamic> offer) {
    switch (offer["discountType"]) {
      case "percentage":
        return "${offer["discount"]}% OFF";
      case "fixed":
        return "\$${offer["discount"]} OFF";
      case "points":
        return "2X POINTS";
      case "combo":
        return "COMBO DEAL";
      case "package":
        return "PACKAGE";
      default:
        return "SPECIAL";
    }
  }

  void _copyCode(String code) {
    // Copy code to clipboard logic would go here
    ss("Code '$code' copied to clipboard!");
  }

  void _showTermsDialog(Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Terms & Conditions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${offer["title"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...(offer["terms"] as List<String>).map((term) => 
              Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ", style: TextStyle(color: primaryColor)),
                    Expanded(
                      child: Text(
                        term,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _bookWithOffer(Map<String, dynamic> offer) {
    ss("Redirecting to booking with offer code: ${offer["code"]}");
    // Navigate to booking with pre-filled offer code
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("How to Use Offers"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1. Browse available offers"),
            SizedBox(height: spXs),
            Text("2. Copy the offer code"),
            SizedBox(height: spXs),
            Text("3. Book a service and enter the code"),
            SizedBox(height: spXs),
            Text("4. Enjoy your discount!"),
          ],
        ),
        actions: [
          QButton(
            label: "OK",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
