import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosBirthdayOffersView extends StatefulWidget {
  const PosBirthdayOffersView({super.key});

  @override
  State<PosBirthdayOffersView> createState() => _PosBirthdayOffersViewState();
}

class _PosBirthdayOffersViewState extends State<PosBirthdayOffersView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedMonth = "";
  String offerTitle = "";
  String offerDescription = "";
  String discountType = "percentage";
  String discountValue = "";
  String validityDays = "7";
  bool isAutoSend = true;
  bool isActive = true;

  List<Map<String, dynamic>> birthdayOffers = [
    {
      "id": "1",
      "title": "Birthday Special 25% Off",
      "description": "Get 25% off on your special day!",
      "discountType": "percentage",
      "discountValue": 25,
      "validityDays": 7,
      "isAutoSend": true,
      "isActive": true,
      "totalSent": 245,
      "totalRedeemed": 189,
      "redemptionRate": 77.1,
      "created": "2024-01-15",
      "lastUpdated": "2024-06-10",
    },
    {
      "id": "2", 
      "title": "Birthday Bonus Points",
      "description": "Earn 500 bonus points on your birthday!",
      "discountType": "points",
      "discountValue": 500,
      "validityDays": 5,
      "isAutoSend": true,
      "isActive": true,
      "totalSent": 156,
      "totalRedeemed": 142,
      "redemptionRate": 91.0,
      "created": "2024-02-20",
      "lastUpdated": "2024-06-05",
    },
    {
      "id": "3",
      "title": "Free Birthday Dessert",
      "description": "Enjoy a complimentary dessert on us!",
      "discountType": "freeItem",
      "discountValue": 0,
      "validityDays": 3,
      "isAutoSend": false,
      "isActive": false,
      "totalSent": 89,
      "totalRedeemed": 67,
      "redemptionRate": 75.3,
      "created": "2024-03-10",
      "lastUpdated": "2024-05-30",
    },
  ];

  List<Map<String, dynamic>> upcomingBirthdays = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 555-0123",
      "birthday": "2024-06-20",
      "daysUntil": 1,
      "preferredOffer": "Birthday Special 25% Off",
      "customerGroup": "VIP",
      "lastVisit": "2024-06-18",
      "totalSpent": 1250,
      "orderCount": 15,
    },
    {
      "id": "2",
      "name": "Mike Chen",
      "email": "mike.chen@email.com", 
      "phone": "+1 555-0124",
      "birthday": "2024-06-22",
      "daysUntil": 3,
      "preferredOffer": "Birthday Bonus Points",
      "customerGroup": "Regular",
      "lastVisit": "2024-06-17",
      "totalSpent": 890,
      "orderCount": 12,
    },
    {
      "id": "3",
      "name": "Emma Davis",
      "email": "emma.davis@email.com",
      "phone": "+1 555-0125",
      "birthday": "2024-06-25",
      "daysUntil": 6,
      "preferredOffer": "Birthday Special 25% Off",
      "customerGroup": "Student",
      "lastVisit": "2024-06-16",
      "totalSpent": 450,
      "orderCount": 8,
    },
  ];

  List<Map<String, dynamic>> sentOffers = [
    {
      "id": "1",
      "customerId": "1",
      "customerName": "Sarah Johnson",
      "offerTitle": "Birthday Special 25% Off",
      "sentDate": "2024-06-19T09:00:00",
      "validUntil": "2024-06-26T23:59:59",
      "status": "sent",
      "isRedeemed": false,
      "redeemedDate": null,
      "orderValue": 0,
    },
    {
      "id": "2",
      "customerId": "4",
      "customerName": "John Smith", 
      "offerTitle": "Birthday Bonus Points",
      "sentDate": "2024-06-18T08:30:00",
      "validUntil": "2024-06-23T23:59:59",
      "status": "redeemed",
      "isRedeemed": true,
      "redeemedDate": "2024-06-18T15:45:00",
      "orderValue": 125,
    },
    {
      "id": "3",
      "customerId": "5",
      "customerName": "Lisa Brown",
      "offerTitle": "Birthday Special 25% Off",
      "sentDate": "2024-06-17T10:15:00",
      "validUntil": "2024-06-24T23:59:59",
      "status": "expired",
      "isRedeemed": false,
      "redeemedDate": null,
      "orderValue": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Birthday Offers",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Offers", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Upcoming", icon: Icon(Icons.cake)), 
        Tab(text: "Sent", icon: Icon(Icons.send)),
      ],
      tabChildren: [
        _buildOffersTab(),
        _buildUpcomingTab(),
        _buildSentTab(),
      ],
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildOffersStats(),
          _buildCreateOfferButton(),
          _buildOffersList(),
        ],
      ),
    );
  }

  Widget _buildOffersStats() {
    int totalOffers = birthdayOffers.length;
    int activeOffers = birthdayOffers.where((offer) => offer["isActive"] == true).length;
    double avgRedemptionRate = birthdayOffers.fold(0.0, (sum, offer) => sum + (offer["redemptionRate"] as double)) / totalOffers;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.card_giftcard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$totalOffers",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Total Offers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$activeOffers",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Active Offers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.trending_up,
                color: infoColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "${avgRedemptionRate.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Avg Redemption",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreateOfferButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Create New Offer",
        icon: Icons.add,
        size: bs.md,
        onPressed: _showCreateOfferDialog,
      ),
    );
  }

  Widget _buildOffersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Birthday Offers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...birthdayOffers.map((offer) => _buildOfferCard(offer)),
      ],
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: offer["isActive"] ? successColor : dangerColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${offer["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${offer["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: offer["isActive"] ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  offer["isActive"] ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 12,
                    color: offer["isActive"] ? successColor : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showOfferOptionsDialog(offer),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        offer["discountType"] == "percentage" ? Icons.percent : 
                        offer["discountType"] == "points" ? Icons.stars : Icons.free_breakfast,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        offer["discountType"] == "percentage" ? "${offer["discountValue"]}%" :
                        offer["discountType"] == "points" ? "${offer["discountValue"]} pts" : "Free Item",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${offer["validityDays"]} days",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Validity",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.send,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${offer["totalSent"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Sent",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.redeem,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${offer["totalRedeemed"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(offer["redemptionRate"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildUpcomingFilters(),
          _buildUpcomingStats(),
          _buildUpcomingBirthdaysList(),
        ],
      ),
    );
  }

  Widget _buildUpcomingFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search customers...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Filter by Month",
          items: [
            {"label": "All Months", "value": ""},
            {"label": "June", "value": "06"},
            {"label": "July", "value": "07"},
            {"label": "August", "value": "08"},
          ],
          value: selectedMonth,
          onChanged: (value, label) {
            selectedMonth = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildUpcomingStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.today,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "1",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Today's Birthdays",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.date_range,
                color: warningColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "3",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "This Week",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month,
                color: infoColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "12",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "This Month",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingBirthdaysList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Upcoming Birthdays",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...upcomingBirthdays.map((birthday) => _buildBirthdayCard(birthday)),
      ],
    );
  }

  Widget _buildBirthdayCard(Map<String, dynamic> birthday) {
    Color priorityColor = birthday["daysUntil"] <= 1 ? dangerColor : 
                         birthday["daysUntil"] <= 3 ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.cake,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${birthday["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${birthday["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${birthday["daysUntil"]} day${birthday["daysUntil"] == 1 ? "" : "s"}",
                            style: TextStyle(
                              fontSize: 10,
                              color: priorityColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "• ${birthday["customerGroup"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Send Offer",
                size: bs.sm,
                onPressed: () => _showSendOfferDialog(birthday),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${birthday["preferredOffer"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Preferred Offer",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${birthday["totalSpent"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Total Spent",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${birthday["orderCount"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Orders",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
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

  Widget _buildSentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSentStats(),
          _buildSentOffersList(),
        ],
      ),
    );
  }

  Widget _buildSentStats() {
    int totalSent = sentOffers.length;
    int redeemed = sentOffers.where((offer) => offer["isRedeemed"] == true).length;
    int expired = sentOffers.where((offer) => offer["status"] == "expired").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.send,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$totalSent",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Offers Sent",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.redeem,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$redeemed",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Redeemed",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.schedule,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "$expired",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Expired",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSentOffersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Recent Sent Offers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...sentOffers.map((offer) => _buildSentOfferCard(offer)),
      ],
    );
  }

  Widget _buildSentOfferCard(Map<String, dynamic> offer) {
    Color statusColor = offer["status"] == "redeemed" ? successColor : 
                       offer["status"] == "expired" ? dangerColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${offer["customerName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${offer["offerTitle"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${offer["status"].toString().toUpperCase()}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sent: ${DateTime.parse("${offer["sentDate"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Valid until: ${DateTime.parse("${offer["validUntil"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (offer["isRedeemed"]) ...[
                      Text(
                        "Redeemed: ${DateTime.parse("${offer["redeemedDate"]}").dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Order Value: \$${offer["orderValue"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateOfferDialog() {
    offerTitle = "";
    offerDescription = "";
    discountType = "percentage";
    discountValue = "";
    validityDays = "7";
    isAutoSend = true;
    isActive = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Birthday Offer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Offer Title",
              value: offerTitle,
              onChanged: (value) {
                offerTitle = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Description",
              value: offerDescription,
              onChanged: (value) {
                offerDescription = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Discount Type",
              items: [
                {"label": "Percentage", "value": "percentage"},
                {"label": "Points", "value": "points"},
                {"label": "Free Item", "value": "freeItem"},
              ],
              value: discountType,
              onChanged: (value, label) {
                discountType = value;
                setState(() {});
              },
            ),
            if (discountType != "freeItem") ...[
              QNumberField(
                label: discountType == "percentage" ? "Discount Percentage" : "Points Amount",
                value: discountValue,
                onChanged: (value) {
                  discountValue = value;
                  setState(() {});
                },
              ),
            ],
            QNumberField(
              label: "Validity (Days)",
              value: validityDays,
              onChanged: (value) {
                validityDays = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Offer",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Birthday offer created successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showOfferOptionsDialog(Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${offer["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: ${offer["description"]}"),
            Text("Validity: ${offer["validityDays"]} days"),
            Text("Total Sent: ${offer["totalSent"]}"),
            Text("Total Redeemed: ${offer["totalRedeemed"]}"),
            Text("Redemption Rate: ${(offer["redemptionRate"] as double).toStringAsFixed(1)}%"),
            Text("Status: ${offer["isActive"] ? "Active" : "Inactive"}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Edit",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Opening offer edit dialog");
            },
          ),
        ],
      ),
    );
  }

  void _showSendOfferDialog(Map<String, dynamic> birthday) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Send Birthday Offer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text("Customer: ${birthday["name"]}"),
            Text("Birthday: ${birthday["birthday"]}"),
            Text("Days Until: ${birthday["daysUntil"]}"),
            QDropdownField(
              label: "Select Offer",
              items: birthdayOffers.where((offer) => offer["isActive"]).map((offer) => {
                "label": "${offer["title"]}",
                "value": "${offer["id"]}",
              }).toList(),
              value: "",
              onChanged: (value, label) {
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send Offer",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Birthday offer sent successfully");
            },
          ),
        ],
      ),
    );
  }
}
