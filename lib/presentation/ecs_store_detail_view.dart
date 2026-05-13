import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsStoreDetailView extends StatefulWidget {
  const EcsStoreDetailView({super.key});

  @override
  State<EcsStoreDetailView> createState() => _EcsStoreDetailViewState();
}

class _EcsStoreDetailViewState extends State<EcsStoreDetailView> {
  int selectedTabIndex = 0;
  bool isFavorite = false;
  
  Map<String, dynamic> store = {
    "id": "1",
    "name": "Downtown Flagship Store",
    "address": "123 Main Street, Downtown",
    "city": "New York",
    "state": "NY",
    "zipCode": "10001",
    "phone": "(555) 123-4567",
    "email": "downtown@store.com",
    "website": "www.store.com/downtown",
    "latitude": 40.7589,
    "longitude": -73.9851,
    "distance": 0.5,
    "isOpen": true,
    "is24Hours": false,
    "rating": 4.5,
    "reviews": 324,
    "description": "Our flagship downtown location offers the complete shopping experience with three floors of products, exclusive items, and premium customer service. Visit us for the latest collections and personalized shopping assistance.",
    "images": [
      "https://picsum.photos/400/300?random=1&keyword=store",
      "https://picsum.photos/400/300?random=2&keyword=retail",
      "https://picsum.photos/400/300?random=3&keyword=shopping",
      "https://picsum.photos/400/300?random=4&keyword=interior",
    ],
    "openingHours": {
      "Monday": {"open": "08:00", "close": "22:00"},
      "Tuesday": {"open": "08:00", "close": "22:00"},
      "Wednesday": {"open": "08:00", "close": "22:00"},
      "Thursday": {"open": "08:00", "close": "22:00"},
      "Friday": {"open": "08:00", "close": "23:00"},
      "Saturday": {"open": "09:00", "close": "23:00"},
      "Sunday": {"open": "10:00", "close": "21:00"},
    },
    "services": [
      {
        "name": "Personal Shopping",
        "description": "One-on-one styling sessions",
        "icon": "person",
        "available": true,
      },
      {
        "name": "Gift Wrapping",
        "description": "Complimentary gift wrapping service",
        "icon": "card_giftcard",
        "available": true,
      },
      {
        "name": "Same-day Delivery",
        "description": "Order by 2 PM for same-day delivery",
        "icon": "local_shipping",
        "available": true,
      },
      {
        "name": "Click & Collect",
        "description": "Order online, pick up in store",
        "icon": "shopping_bag",
        "available": true,
      },
      {
        "name": "Alterations",
        "description": "Professional tailoring services",
        "icon": "content_cut",
        "available": false,
      },
    ],
    "departments": [
      {"name": "Women's Fashion", "floor": "Ground Floor", "section": "A-D"},
      {"name": "Men's Fashion", "floor": "Ground Floor", "section": "E-H"},
      {"name": "Electronics", "floor": "First Floor", "section": "A-C"},
      {"name": "Home & Garden", "floor": "First Floor", "section": "D-F"},
      {"name": "Beauty & Health", "floor": "Second Floor", "section": "A-B"},
      {"name": "Sports & Outdoors", "floor": "Second Floor", "section": "C-D"},
    ],
    "amenities": [
      {"name": "Free WiFi", "icon": "wifi", "available": true},
      {"name": "Parking", "icon": "local_parking", "available": true},
      {"name": "ATM", "icon": "local_atm", "available": true},
      {"name": "Wheelchair Access", "icon": "accessible", "available": true},
      {"name": "Baby Change", "icon": "child_friendly", "available": true},
      {"name": "Restrooms", "icon": "wc", "available": true},
      {"name": "Food Court", "icon": "restaurant", "available": true},
      {"name": "Customer Service", "icon": "help", "available": true},
    ],
  };

  List<Map<String, dynamic>> storeEvents = [
    {
      "title": "Flash Sale Weekend",
      "description": "Up to 70% off selected items",
      "date": "2024-01-20",
      "time": "10:00",
      "endDate": "2024-01-21",
      "type": "Sale",
    },
    {
      "title": "New Collection Launch",
      "description": "Spring collection preview event",
      "date": "2024-01-25",
      "time": "18:00",
      "endDate": "2024-01-25",
      "type": "Event",
    },
    {
      "title": "Personal Styling Day",
      "description": "Free styling consultations",
      "date": "2024-01-28",
      "time": "12:00",
      "endDate": "2024-01-28",
      "type": "Service",
    },
  ];

  List<Map<String, dynamic>> nearbyStores = [
    {
      "name": "Westside Mall",
      "distance": 1.2,
      "address": "456 Shopping Blvd",
      "rating": 4.2,
    },
    {
      "name": "Central Plaza",
      "distance": 0.8,
      "address": "321 Central Avenue",
      "rating": 4.7,
    },
    {
      "name": "Eastside Market",
      "distance": 1.5,
      "address": "654 Market Street",
      "rating": 4.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QTabBar(
        title: "${store["name"]}",
        selectedIndex: selectedTabIndex,
        withoutAppBar: false,
        tabs: [
          Tab(text: "Overview", icon: Icon(Icons.info)),
          Tab(text: "Services", icon: Icon(Icons.room_service)),
          Tab(text: "Hours", icon: Icon(Icons.schedule)),
          Tab(text: "Events", icon: Icon(Icons.event)),
        ],
        tabChildren: [
          _buildOverviewTab(),
          _buildServicesTab(),
          _buildHoursTab(),
          _buildEventsTab(),
        ],
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
              ss(isFavorite ? "Added to favorites" : "Removed from favorites");
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Call Store",
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  _callStore();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Get Directions",
                icon: Icons.directions,
                size: bs.sm,
                onPressed: () {
                  _getDirections();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store Images
          Container(
            height: 200,
            child: QHorizontalScroll(
              children: (store["images"] as List<String>).map((image) => 
                Container(
                  width: 300,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Store Status and Rating
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: (store["isOpen"] as bool) 
                      ? successColor.withAlpha(25) 
                      : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: (store["isOpen"] as bool) ? successColor : dangerColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      (store["isOpen"] as bool) ? "Open Now" : "Closed",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (store["isOpen"] as bool) ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 18),
                  SizedBox(width: spXs),
                  Text(
                    "${store["rating"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "(${store["reviews"]} reviews)",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Description
          Text(
            "About This Store",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${store["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Contact Information
          _buildInfoSection(
            title: "Contact Information",
            children: [
              _buildInfoRow(Icons.location_on, "${store["address"]}, ${store["city"]}, ${store["state"]} ${store["zipCode"]}"),
              _buildInfoRow(Icons.phone, "${store["phone"]}"),
              _buildInfoRow(Icons.email, "${store["email"]}"),
              _buildInfoRow(Icons.web, "${store["website"]}"),
              _buildInfoRow(Icons.navigation, "${(store["distance"] as double).toStringAsFixed(1)} miles away"),
            ],
          ),
          
          // Departments
          _buildInfoSection(
            title: "Store Departments",
            children: [
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: (store["departments"] as List).map((dept) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dept["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${dept["floor"]} - Section ${dept["section"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
          
          // Amenities
          _buildInfoSection(
            title: "Store Amenities",
            children: [
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: (store["amenities"] as List).map((amenity) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (amenity["available"] as bool) 
                          ? primaryColor.withAlpha(25)
                          : disabledColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getIconData("${amenity["icon"]}"),
                          size: 16,
                          color: (amenity["available"] as bool) ? primaryColor : disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${amenity["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (amenity["available"] as bool) ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
          
          // Nearby Stores
          _buildInfoSection(
            title: "Other Nearby Stores",
            children: [
              Column(
                children: nearbyStores.map((nearbyStore) => 
                  Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${nearbyStore["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${nearbyStore["address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${nearbyStore["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${(nearbyStore["distance"] as double).toStringAsFixed(1)} mi",
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
                ).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (store["services"] as List).length,
            itemBuilder: (context, index) {
              final service = (store["services"] as List)[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (service["available"] as bool) ? successColor : disabledColor,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getIconData("${service["icon"]}"),
                      color: (service["available"] as bool) ? primaryColor : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: (service["available"] as bool) ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${service["description"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                        color: (service["available"] as bool) 
                            ? successColor.withAlpha(25)
                            : disabledColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        (service["available"] as bool) ? "Available" : "Unavailable",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: (service["available"] as bool) ? successColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHoursTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Opening Hours",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledColor),
            ),
            child: Column(
              children: (store["openingHours"] as Map<String, dynamic>).entries.map((entry) {
                String day = entry.key;
                Map<String, String> hours = entry.value as Map<String, String>;
                bool isToday = _isToday(day);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isToday ? primaryColor.withAlpha(25) : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                            color: isToday ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${hours["open"]} - ${hours["close"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isToday ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Store hours may vary during holidays and special events. Please call ahead to confirm.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          if (storeEvents.isEmpty)
            Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event,
                      size: 60,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No upcoming events",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
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
              itemCount: storeEvents.length,
              itemBuilder: (context, index) {
                final event = storeEvents[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${event["title"]}",
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
                              color: _getEventTypeColor("${event["type"]}").withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${event["type"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getEventTypeColor("${event["type"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse(event["date"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${event["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({required String title, required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "person": return Icons.person;
      case "card_giftcard": return Icons.card_giftcard;
      case "local_shipping": return Icons.local_shipping;
      case "shopping_bag": return Icons.shopping_bag;
      case "content_cut": return Icons.content_cut;
      case "wifi": return Icons.wifi;
      case "local_parking": return Icons.local_parking;
      case "local_atm": return Icons.local_atm;
      case "accessible": return Icons.accessible;
      case "child_friendly": return Icons.child_friendly;
      case "wc": return Icons.wc;
      case "restaurant": return Icons.restaurant;
      case "help": return Icons.help;
      default: return Icons.info;
    }
  }

  bool _isToday(String day) {
    List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    int today = DateTime.now().weekday - 1;
    return weekdays[today] == day;
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case "Sale": return dangerColor;
      case "Event": return primaryColor;
      case "Service": return successColor;
      default: return infoColor;
    }
  }

  void _callStore() {
    ss("Calling ${store["name"]} at ${store["phone"]}");
  }

  void _getDirections() {
    ss("Opening directions to ${store["name"]}");
  }
}
