import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEarlyBirdPricingView extends StatefulWidget {
  const EcmEarlyBirdPricingView({super.key});

  @override
  State<EcmEarlyBirdPricingView> createState() => _EcmEarlyBirdPricingViewState();
}

class _EcmEarlyBirdPricingViewState extends State<EcmEarlyBirdPricingView> {
  bool isLoading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> earlyBirdOffers = [
    {
      "id": 1,
      "name": "Super Early Bird",
      "description": "Limited time offer for the first 50 registrants",
      "original_price": 150.0,
      "discounted_price": 99.0,
      "discount_percentage": 34,
      "discount_amount": 51.0,
      "valid_from": "2025-01-01",
      "valid_until": "2025-02-15",
      "max_usage": 50,
      "current_usage": 23,
      "status": "active",
      "conditions": ["First 50 registrants only", "Non-refundable", "One per customer"],
      "ticket_type": "General Admission"
    },
    {
      "id": 2,
      "name": "Early Bird Special",
      "description": "Special pricing for early registrations",
      "original_price": 200.0,
      "discounted_price": 160.0,
      "discount_percentage": 20,
      "discount_amount": 40.0,
      "valid_from": "2025-01-15",
      "valid_until": "2025-03-01",
      "max_usage": 100,
      "current_usage": 67,
      "status": "active",
      "conditions": ["Valid until March 1st", "Transferable", "Full refund available"],
      "ticket_type": "VIP Package"
    },
    {
      "id": 3,
      "name": "Student Early Bird",
      "description": "Exclusive early bird pricing for students",
      "original_price": 100.0,
      "discounted_price": 65.0,
      "discount_percentage": 35,
      "discount_amount": 35.0,
      "valid_from": "2025-01-01",
      "valid_until": "2025-04-01",
      "max_usage": 75,
      "current_usage": 12,
      "status": "active",
      "conditions": ["Valid student ID required", "Limited availability", "Educational institutions only"],
      "ticket_type": "Student Ticket"
    },
    {
      "id": 4,
      "name": "Weekend Flash Sale",
      "description": "48-hour flash sale for weekend warriors",
      "original_price": 120.0,
      "discounted_price": 89.0,
      "discount_percentage": 26,
      "discount_amount": 31.0,
      "valid_from": "2025-01-25",
      "valid_until": "2025-01-27",
      "max_usage": 30,
      "current_usage": 30,
      "status": "expired",
      "conditions": ["Weekend only", "Limited time", "Final sale"],
      "ticket_type": "Weekend Pass"
    }
  ];

  List<Map<String, dynamic>> earlyBirdAnalytics = [
    {
      "offer_name": "Super Early Bird",
      "registrations": 23,
      "revenue": 2277.0,
      "conversion_rate": 15.3,
      "avg_days_before_event": 45
    },
    {
      "offer_name": "Early Bird Special",
      "registrations": 67,
      "revenue": 10720.0,
      "conversion_rate": 22.7,
      "avg_days_before_event": 32
    },
    {
      "offer_name": "Student Early Bird",
      "registrations": 12,
      "revenue": 780.0,
      "conversion_rate": 8.5,
      "avg_days_before_event": 38
    }
  ];

  Widget _buildEarlyBirdCard(Map<String, dynamic> offer) {
    Color statusColor = offer["status"] == "active" 
        ? successColor 
        : offer["status"] == "expired" 
            ? dangerColor 
            : warningColor;
    
    double usagePercentage = (offer["current_usage"] as int) / (offer["max_usage"] as int);
    bool isFullyUsed = usagePercentage >= 1.0;
    DateTime validFrom = DateTime.parse(offer["valid_from"]);
    DateTime validUntil = DateTime.parse(offer["valid_until"]);
    int daysLeft = validUntil.difference(DateTime.now()).inDays;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: offer["status"] == "active" 
            ? Border.all(color: successColor.withAlpha(77), width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(26),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.flash_on,
                  color: statusColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${offer["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${offer["status"]}".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.local_activity, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${offer["ticket_type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (daysLeft > 0 && offer["status"] == "active")
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$daysLeft days left",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((offer["discounted_price"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${((offer["original_price"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${offer["discount_percentage"]}% OFF (Save \$${((offer["discount_amount"] as double)).currency})",
                              style: TextStyle(
                                color: dangerColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${offer["current_usage"]} / ${offer["max_usage"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isFullyUsed ? dangerColor : primaryColor,
                          ),
                        ),
                        Text(
                          "used",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: usagePercentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isFullyUsed ? dangerColor : usagePercentage > 0.8 ? warningColor : successColor
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(usagePercentage * 100).toInt()}% of slots used",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Validity Period:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${validFrom.dMMMy} - ${validUntil.dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Terms & Conditions:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(offer["conditions"] as List).map<Widget>((condition) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledBoldColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$condition",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit Offer",
                        size: bs.sm,
                        onPressed: () => _editOffer(offer),
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.visibility,
                      size: bs.sm,
                      onPressed: () => _viewOfferDetails(offer),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: offer["status"] == "active" ? Icons.pause : Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () => _toggleOfferStatus(offer),
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

  Widget _buildAnalyticsCard(Map<String, dynamic> analytics) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.analytics, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${analytics["offer_name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Registrations",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${analytics["registrations"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((analytics["revenue"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Conversion",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(analytics["conversion_rate"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: secondaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Avg. Booking",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${analytics["avg_days_before_event"]} days",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
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

  Widget _buildOffersTab() {
    int totalOffers = earlyBirdOffers.length;
    int activeOffers = earlyBirdOffers.where((offer) => offer["status"] == "active").length;
    double totalRevenue = earlyBirdAnalytics.fold(0.0, (sum, analytics) => sum + (analytics["revenue"] as double));
    int totalRegistrations = earlyBirdAnalytics.fold(0, (sum, analytics) => sum + (analytics["registrations"] as int));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.local_offer, color: primaryColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Offers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalOffers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.check_circle, color: successColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Active Offers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$activeOffers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.attach_money, color: warningColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(totalRevenue).currency}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.people, color: infoColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Registrations",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalRegistrations",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Text(
                "Early Bird Offers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Create Offer",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _createNewOffer,
              ),
            ],
          ),
          SizedBox(height: spSm),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            ...earlyBirdOffers.map((offer) => _buildEarlyBirdCard(offer)).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Early Bird Performance",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Track the performance of your early bird campaigns",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ...earlyBirdAnalytics.map((analytics) => _buildAnalyticsCard(analytics)).toList(),
        ],
      ),
    );
  }

  void _editOffer(Map<String, dynamic> offer) {
    // Navigate to edit offer
  }

  void _viewOfferDetails(Map<String, dynamic> offer) {
    // Show offer details
  }

  void _toggleOfferStatus(Map<String, dynamic> offer) {
    // Toggle offer status
  }

  void _createNewOffer() {
    // Navigate to create new offer
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Early Bird Pricing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOffersTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
