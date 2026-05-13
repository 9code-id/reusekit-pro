import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDealsView extends StatefulWidget {
  const FdaDealsView({super.key});

  @override
  State<FdaDealsView> createState() => _FdaDealsViewState();
}

class _FdaDealsViewState extends State<FdaDealsView> {
  String selectedCategory = "All";
  bool loading = false;

  List<Map<String, dynamic>> dealCategories = [
    {"label": "All", "value": "All"},
    {"label": "Limited Time", "value": "limited_time"},
    {"label": "Buy 1 Get 1", "value": "bogo"},
    {"label": "Free Delivery", "value": "free_delivery"},
    {"label": "Combo Deals", "value": "combo"},
    {"label": "Weekend Special", "value": "weekend"},
  ];

  List<Map<String, dynamic>> deals = [
    {
      "id": "deal1",
      "title": "50% Off Your First Order",
      "description": "New customers get 50% off their first order up to \$20",
      "discount": "50% OFF",
      "category": "limited_time",
      "validUntil": "2024-04-30",
      "minOrder": 25.00,
      "maxDiscount": 20.00,
      "code": "WELCOME50",
      "image": "https://picsum.photos/300/200?random=1&keyword=burger",
      "restaurant": "All Restaurants",
      "isNew": true,
      "isPopular": false,
      "usageLimit": "One time use",
      "termsAndConditions": "Valid for new users only. Cannot be combined with other offers.",
    },
    {
      "id": "deal2",
      "title": "Free Delivery Weekend",
      "description": "Enjoy free delivery on all orders this weekend",
      "discount": "FREE DELIVERY",
      "category": "free_delivery",
      "validUntil": "2024-03-24",
      "minOrder": 15.00,
      "maxDiscount": 5.00,
      "code": "FREEWEEKEND",
      "image": "https://picsum.photos/300/200?random=2&keyword=pizza",
      "restaurant": "All Restaurants",
      "isNew": false,
      "isPopular": true,
      "usageLimit": "Unlimited",
      "termsAndConditions": "Valid on weekends only. Standard delivery fees apply on weekdays.",
    },
    {
      "id": "deal3",
      "title": "Buy 1 Get 1 Free Pizzas",
      "description": "Order any large pizza and get another one absolutely free",
      "discount": "BOGO FREE",
      "category": "bogo",
      "validUntil": "2024-04-15",
      "minOrder": 0.00,
      "maxDiscount": 25.00,
      "code": "PIZZA2FOR1",
      "image": "https://picsum.photos/300/200?random=3&keyword=pizza",
      "restaurant": "Tony's Pizza Place",
      "isNew": false,
      "isPopular": true,
      "usageLimit": "Twice per week",
      "termsAndConditions": "Valid for large pizzas only. Free pizza must be of equal or lesser value.",
    },
    {
      "id": "deal4",
      "title": "Lunch Combo Special",
      "description": "Get lunch combo with drink and dessert for just \$12.99",
      "discount": "30% OFF",
      "category": "combo",
      "validUntil": "2024-03-31",
      "minOrder": 0.00,
      "maxDiscount": 8.00,
      "code": "LUNCH12",
      "image": "https://picsum.photos/300/200?random=4&keyword=lunch",
      "restaurant": "Healthy Bites",
      "isNew": true,
      "isPopular": false,
      "usageLimit": "Daily 11AM-3PM",
      "termsAndConditions": "Valid Monday to Friday, 11 AM to 3 PM only. Dine-in and takeaway.",
    },
    {
      "id": "deal5",
      "title": "20% Off Asian Cuisine",
      "description": "Enjoy 20% discount on all Asian restaurants",
      "discount": "20% OFF",
      "category": "limited_time",
      "validUntil": "2024-04-10",
      "minOrder": 30.00,
      "maxDiscount": 15.00,
      "code": "ASIAN20",
      "image": "https://picsum.photos/300/200?random=5&keyword=asian",
      "restaurant": "Asian Restaurants",
      "isNew": false,
      "isPopular": true,
      "usageLimit": "3 times per month",
      "termsAndConditions": "Valid at participating Asian restaurants only. Cannot be used with delivery promotions.",
    },
    {
      "id": "deal6",
      "title": "Weekend Brunch Bonanza",
      "description": "All-day brunch with 25% off and complimentary coffee",
      "discount": "25% OFF + FREE COFFEE",
      "category": "weekend",
      "validUntil": "2024-04-28",
      "minOrder": 20.00,
      "maxDiscount": 12.00,
      "code": "BRUNCH25",
      "image": "https://picsum.photos/300/200?random=6&keyword=brunch",
      "restaurant": "Brunch Spots",
      "isNew": true,
      "isPopular": false,
      "usageLimit": "Weekends only",
      "termsAndConditions": "Valid weekends 9 AM to 4 PM. Free coffee with any brunch order over \$20.",
    },
  ];

  List<Map<String, dynamic>> get filteredDeals {
    if (selectedCategory == "All") return deals;
    return deals.where((deal) => deal["category"] == selectedCategory).toList();
  }

  void _useDealtNow(Map<String, dynamic> deal) {
    ss("Deal code ${deal["code"]} copied to clipboard!");
    // Navigate to restaurant or apply deal
  }

  void _viewDealDetails(Map<String, dynamic> deal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${deal["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${deal["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${deal["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    // Deal Info
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow("Discount Code", "${deal["code"]}"),
                          _buildDetailRow("Valid Until", "${deal["validUntil"]}"),
                          _buildDetailRow("Minimum Order", "\$${(deal["minOrder"] as double).toStringAsFixed(2)}"),
                          _buildDetailRow("Maximum Discount", "\$${(deal["maxDiscount"] as double).toStringAsFixed(2)}"),
                          _buildDetailRow("Usage Limit", "${deal["usageLimit"]}"),
                          _buildDetailRow("Restaurant", "${deal["restaurant"]}"),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Terms and Conditions:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${deal["termsAndConditions"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spLg),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Use Deal Now",
                        size: bs.md,
                        onPressed: () {
                          back();
                          _useDealtNow(deal);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _searchDeals() {
    // Implement search functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deals & Offers"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchDeals,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Hero Banner
                Container(
                  margin: EdgeInsets.all(spMd),
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withAlpha(200)],
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amazing Deals",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Save big on your favorite food",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.local_offer,
                        size: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                // Category Filter
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    children: dealCategories.map((category) {
                      bool isSelected = selectedCategory == category["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedCategory = category["value"];
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              "${category["label"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: spMd),

                // Deals List
                Expanded(
                  child: filteredDeals.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_offer,
                                size: 80,
                                color: disabledColor,
                              ),
                              SizedBox(height: spMd),
                              Text(
                                "No deals available",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Check back later for new offers",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          itemCount: filteredDeals.length,
                          itemBuilder: (context, index) {
                            final deal = filteredDeals[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Deal Image
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(radiusMd),
                                            topRight: Radius.circular(radiusMd),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage("${deal["image"]}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // Badges
                                      Positioned(
                                        top: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${deal["discount"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (deal["isNew"] == true)
                                        Positioned(
                                          top: spSm,
                                          right: spSm,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                            decoration: BoxDecoration(
                                              color: successColor,
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "NEW",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (deal["isPopular"] == true)
                                        Positioned(
                                          top: spSm,
                                          right: spSm,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                            decoration: BoxDecoration(
                                              color: warningColor,
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "POPULAR",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),

                                  // Deal Content
                                  Padding(
                                    padding: EdgeInsets.all(spMd),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${deal["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: spSm),
                                        Text(
                                          "${deal["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: spMd),
                                        // Deal Info
                                        Row(
                                          children: [
                                            Icon(Icons.restaurant, size: 16, color: disabledBoldColor),
                                            SizedBox(width: spXs),
                                            Expanded(
                                              child: Text(
                                                "${deal["restaurant"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ),
                                            Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                            SizedBox(width: spXs),
                                            Text(
                                              "Valid until ${deal["validUntil"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spMd),
                                        // Action Buttons
                                        Row(
                                          children: [
                                            Expanded(
                                              child: QButton(
                                                label: "View Details",
                                                size: bs.sm,
                                                onPressed: () => _viewDealDetails(deal),
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Expanded(
                                              child: QButton(
                                                label: "Use Now",
                                                size: bs.sm,
                                                onPressed: () => _useDealtNow(deal),
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
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
