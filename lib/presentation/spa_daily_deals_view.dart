import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaDailyDealsView extends StatefulWidget {
  const SpaDailyDealsView({Key? key}) : super(key: key);

  @override
  State<SpaDailyDealsView> createState() => _SpaDailyDealsViewState();
}

class _SpaDailyDealsViewState extends State<SpaDailyDealsView> {
  String selectedDay = "today";
  String selectedCategory = "all";
  bool showFavoritesOnly = false;

  Map<String, List<Map<String, dynamic>>> dailyDeals = {
    "today": [
      {
        "id": 1,
        "title": "Morning Glow Facial",
        "originalPrice": 120.0,
        "dailyPrice": 75.0,
        "discount": 38,
        "image": "https://picsum.photos/300/200?random=1&keyword=morning",
        "spa": "Sunrise Wellness Spa",
        "category": "facial",
        "timeSlots": ["09:00", "10:30", "14:00", "15:30"],
        "rating": 4.6,
        "reviews": 89,
        "description": "Energizing morning facial with vitamin C boost",
        "duration": "60 min",
        "isFavorite": true,
        "isAvailable": true,
        "spotsLeft": 3,
      },
      {
        "id": 2,
        "title": "Express Manicure",
        "originalPrice": 60.0,
        "dailyPrice": 35.0,
        "discount": 42,
        "image": "https://picsum.photos/300/200?random=2&keyword=nails",
        "spa": "Nail Paradise Studio",
        "category": "nails",
        "timeSlots": ["11:00", "13:00", "16:00", "18:00"],
        "rating": 4.4,
        "reviews": 156,
        "description": "Quick and professional manicure service",
        "duration": "30 min",
        "isFavorite": false,
        "isAvailable": true,
        "spotsLeft": 7,
      },
      {
        "id": 3,
        "title": "Relaxation Massage",
        "originalPrice": 180.0,
        "dailyPrice": 108.0,
        "discount": 40,
        "image": "https://picsum.photos/300/200?random=3&keyword=massage",
        "spa": "Tranquil Touch Spa",
        "category": "massage",
        "timeSlots": ["12:00", "14:30", "17:00", "19:00"],
        "rating": 4.8,
        "reviews": 234,
        "description": "Full body relaxation massage with aromatherapy",
        "duration": "75 min",
        "isFavorite": true,
        "isAvailable": false,
        "spotsLeft": 0,
      },
    ],
    "tomorrow": [
      {
        "id": 4,
        "title": "Anti-Aging Treatment",
        "originalPrice": 250.0,
        "dailyPrice": 175.0,
        "discount": 30,
        "image": "https://picsum.photos/300/200?random=4&keyword=antiaging",
        "spa": "Youth Renewal Center",
        "category": "facial",
        "timeSlots": ["10:00", "13:00", "15:30", "18:00"],
        "rating": 4.7,
        "reviews": 167,
        "description": "Advanced anti-aging facial with peptide infusion",
        "duration": "90 min",
        "isFavorite": false,
        "isAvailable": true,
        "spotsLeft": 5,
      },
      {
        "id": 5,
        "title": "Hot Stone Therapy",
        "originalPrice": 200.0,
        "dailyPrice": 130.0,
        "discount": 35,
        "image": "https://picsum.photos/300/200?random=5&keyword=hotstone",
        "spa": "Stone Harmony Spa",
        "category": "massage",
        "timeSlots": ["11:30", "14:00", "16:30", "19:30"],
        "rating": 4.5,
        "reviews": 198,
        "description": "Therapeutic hot stone massage for deep relaxation",
        "duration": "80 min",
        "isFavorite": true,
        "isAvailable": true,
        "spotsLeft": 2,
      },
    ],
    "weekend": [
      {
        "id": 6,
        "title": "Couples Spa Day",
        "originalPrice": 500.0,
        "dailyPrice": 350.0,
        "discount": 30,
        "image": "https://picsum.photos/300/200?random=6&keyword=couples",
        "spa": "Romance Spa Retreat",
        "category": "package",
        "timeSlots": ["10:00", "14:00"],
        "rating": 4.9,
        "reviews": 89,
        "description": "Complete couples spa experience with champagne",
        "duration": "3 hours",
        "isFavorite": false,
        "isAvailable": true,
        "spotsLeft": 4,
      },
      {
        "id": 7,
        "title": "Detox Body Wrap",
        "originalPrice": 160.0,
        "dailyPrice": 96.0,
        "discount": 40,
        "image": "https://picsum.photos/300/200?random=7&keyword=bodywrap",
        "spa": "Purify Wellness Studio",
        "category": "body",
        "timeSlots": ["09:30", "12:00", "15:00", "17:30"],
        "rating": 4.3,
        "reviews": 145,
        "description": "Detoxifying seaweed body wrap treatment",
        "duration": "75 min",
        "isFavorite": true,
        "isAvailable": true,
        "spotsLeft": 6,
      },
    ],
  };

  List<Map<String, dynamic>> dayOptions = [
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "Weekend", "value": "weekend"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Facial Treatments", "value": "facial"},
    {"label": "Massage Therapy", "value": "massage"},
    {"label": "Body Treatments", "value": "body"},
    {"label": "Nail Services", "value": "nails"},
    {"label": "Spa Packages", "value": "package"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Deals"),
        actions: [
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () {
              _showDealCalendar();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Daily Deals Header
          _buildDailyDealsHeader(),

          // Filter Controls
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Select Day",
                        items: dayOptions,
                        value: selectedDay,
                        onChanged: (value, label) {
                          selectedDay = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Show favorites only",
                      "value": "favorites",
                      "checked": showFavoritesOnly,
                    }
                  ],
                  value: showFavoritesOnly
                      ? [
                          {
                            "label": "Show favorites only",
                            "value": "favorites",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    showFavoritesOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Deals List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: _getFilteredDeals().length,
              itemBuilder: (context, index) {
                final deal = _getFilteredDeals()[index];
                return _buildDealCard(deal);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyDealsHeader() {
    String currentDate = DateTime.now().toString().split(' ')[0];
    int totalDeals = dailyDeals[selectedDay]?.length ?? 0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.today, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Spa Deals",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Special offers updated daily",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "$totalDeals Deals",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Quick Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickStat("Today", dailyDeals["today"]?.length ?? 0),
              _buildQuickStat("Tomorrow", dailyDeals["tomorrow"]?.length ?? 0),
              _buildQuickStat("Weekend", dailyDeals["weekend"]?.length ?? 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, int count) {
    bool isSelected = (label.toLowerCase() == selectedDay) ||
                     (label == "Today" && selectedDay == "today") ||
                     (label == "Tomorrow" && selectedDay == "tomorrow") ||
                     (label == "Weekend" && selectedDay == "weekend");

    return GestureDetector(
      onTap: () {
        if (label == "Today") selectedDay = "today";
        else if (label == "Tomorrow") selectedDay = "tomorrow";
        else if (label == "Weekend") selectedDay = "weekend";
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryColor : Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealCard(Map<String, dynamic> deal) {
    bool isAvailable = deal["isAvailable"] as bool;
    int spotsLeft = deal["spotsLeft"] as int;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: !isAvailable 
            ? Border.all(color: disabledColor, width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: ColorFiltered(
                  colorFilter: !isAvailable
                      ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
                      : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                  child: Image.network(
                    "${deal["image"]}",
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Discount Badge
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${deal["discount"]}% OFF",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Favorite Button
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _toggleFavorite(deal["id"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      deal["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                      color: deal["isFavorite"] ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Sold Out Overlay
              if (!isAvailable)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(127),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "SOLD OUT",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title and Spa
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${deal["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: !isAvailable ? disabledBoldColor : null,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${deal["spa"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Description and Duration
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${deal["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${deal["duration"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Price and Rating
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${((deal["dailyPrice"] as double)).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: !isAvailable ? disabledBoldColor : successColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((deal["originalPrice"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Save \$${(((deal["originalPrice"] as double) - (deal["dailyPrice"] as double))).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: !isAvailable ? disabledBoldColor : successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${deal["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: !isAvailable ? disabledBoldColor : null,
                              ),
                            ),
                            Text(
                              " (${deal["reviews"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (isAvailable && spotsLeft <= 5) ...[
                          SizedBox(height: spXs),
                          Text(
                            "$spotsLeft spots left",
                            style: TextStyle(
                              fontSize: 12,
                              color: spotsLeft <= 2 ? dangerColor : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                // Time Slots
                if (isAvailable) ...[
                  Text(
                    "Available Times:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (deal["timeSlots"] as List<String>).map((time) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(100),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                // Action Buttons
                Row(
                  children: [
                    if (isAvailable) ...[
                      Expanded(
                        child: QButton(
                          label: "Book Now",
                          size: bs.sm,
                          onPressed: () {
                            _bookDeal(deal);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.share,
                        size: bs.sm,
                        color: secondaryColor,
                        onPressed: () {
                          _shareDeal(deal);
                        },
                      ),
                    ] else ...[
                      Expanded(
                        child: QButton(
                          label: "Notify When Available",
                          size: bs.sm,
                          color: secondaryColor,
                          onPressed: () {
                            _notifyWhenAvailable(deal);
                          },
                        ),
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

  List<Map<String, dynamic>> _getFilteredDeals() {
    List<Map<String, dynamic>> deals = dailyDeals[selectedDay] ?? [];

    if (selectedCategory != "all") {
      deals = deals.where((deal) => deal["category"] == selectedCategory).toList();
    }

    if (showFavoritesOnly) {
      deals = deals.where((deal) => deal["isFavorite"] as bool).toList();
    }

    return deals;
  }

  void _showDealCalendar() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deal Calendar",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              // Calendar view placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 48, color: disabledBoldColor),
                      SizedBox(height: spSm),
                      Text(
                        "Deal calendar coming soon",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Close",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavorite(int dealId) {
    setState(() {
      for (var dayDeals in dailyDeals.values) {
        final index = dayDeals.indexWhere((d) => d["id"] == dealId);
        if (index != -1) {
          dayDeals[index]["isFavorite"] = !(dayDeals[index]["isFavorite"] as bool);
          break;
        }
      }
    });

    // Find if favorite was added or removed
    bool isFavorite = false;
    for (var dayDeals in dailyDeals.values) {
      final deal = dayDeals.firstWhere((d) => d["id"] == dealId, orElse: () => {});
      if (deal.isNotEmpty) {
        isFavorite = deal["isFavorite"];
        break;
      }
    }

    if (isFavorite) {
      ss("Added to favorites");
    } else {
      si("Removed from favorites");
    }
  }

  void _bookDeal(Map<String, dynamic> deal) {
    ss("Booking ${deal["title"]}...");
    //navigateTo ( SpaBookingView )
  }

  void _shareDeal(Map<String, dynamic> deal) {
    si("Deal shared successfully");
  }

  void _notifyWhenAvailable(Map<String, dynamic> deal) {
    si("You'll be notified when ${deal["title"]} becomes available");
  }
}
