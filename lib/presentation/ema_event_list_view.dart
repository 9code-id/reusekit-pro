import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaEventListView extends StatefulWidget {
  const EmaEventListView({super.key});

  @override
  State<EmaEventListView> createState() => _EmaEventListViewState();
}

class _EmaEventListViewState extends State<EmaEventListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedTimeframe = "all";
  String selectedLocation = "all";
  String selectedPriceRange = "all";
  String sortBy = "date";
  bool showOnlyBookmarked = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Business & Professional", "value": "business"},
    {"label": "Technology", "value": "technology"},
    {"label": "Health & Wellness", "value": "health"},
    {"label": "Arts & Culture", "value": "arts"},
    {"label": "Sports & Fitness", "value": "sports"},
    {"label": "Food & Drink", "value": "food"},
    {"label": "Travel & Outdoor", "value": "travel"},
    {"label": "Music & Entertainment", "value": "music"},
    {"label": "Education", "value": "education"},
    {"label": "Charity & Causes", "value": "charity"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "All Time", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "This Week", "value": "week"},
    {"label": "Next Week", "value": "next_week"},
    {"label": "This Month", "value": "month"},
    {"label": "Next Month", "value": "next_month"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "Online Events", "value": "online"},
    {"label": "New York", "value": "new_york"},
    {"label": "Los Angeles", "value": "los_angeles"},
    {"label": "Chicago", "value": "chicago"},
    {"label": "Houston", "value": "houston"},
    {"label": "Phoenix", "value": "phoenix"},
    {"label": "Philadelphia", "value": "philadelphia"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Free", "value": "free"},
    {"label": "Under \$25", "value": "under_25"},
    {"label": "\$25 - \$50", "value": "25_50"},
    {"label": "\$50 - \$100", "value": "50_100"},
    {"label": "\$100 - \$250", "value": "100_250"},
    {"label": "Over \$250", "value": "over_250"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date (Earliest)", "value": "date"},
    {"label": "Date (Latest)", "value": "date_desc"},
    {"label": "Price (Low to High)", "value": "price_asc"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Popularity", "value": "popularity"},
    {"label": "Distance", "value": "distance"},
    {"label": "Name (A-Z)", "value": "name"},
  ];

  List<String> bookmarkedEvents = ["evt_001", "evt_003", "evt_007"];

  List<Map<String, dynamic>> publicEvents = [
    {
      "id": "evt_001",
      "title": "Annual Tech Summit 2024",
      "description": "Join industry leaders for a comprehensive look at emerging technologies and future trends",
      "category": "technology",
      "date": "2024-03-20",
      "time": "09:00",
      "endTime": "18:00",
      "location": "San Francisco Convention Center",
      "city": "San Francisco",
      "state": "CA",
      "country": "USA",
      "venue": "Main Hall A",
      "price": 149.99,
      "currency": "USD",
      "isOnline": false,
      "capacity": 1500,
      "attendees": 1247,
      "organizer": "Tech Events Inc.",
      "rating": 4.8,
      "reviews": 324,
      "image": "https://picsum.photos/400/250?random=1&keyword=technology",
      "tags": ["AI", "Machine Learning", "Innovation", "Startups"],
      "speakers": [
        {"name": "Dr. Sarah Chen", "title": "AI Research Lead at Google", "image": "https://picsum.photos/100/100?random=1"},
        {"name": "Mark Rodriguez", "title": "CTO at Meta", "image": "https://picsum.photos/100/100?random=2"},
        {"name": "Lisa Wang", "title": "Founder of TechStart", "image": "https://picsum.photos/100/100?random=3"}
      ],
      "highlights": ["Networking Lunch", "Live Demos", "Q&A Sessions"],
      "requirements": ["Photo ID Required", "Business Attire Recommended"],
    },
    {
      "id": "evt_002",
      "title": "Yoga & Mindfulness Retreat",
      "description": "A peaceful weekend retreat focusing on yoga practice, meditation, and mental wellness",
      "category": "health",
      "date": "2024-03-25",
      "time": "08:00",
      "endTime": "16:00",
      "location": "Serenity Wellness Center",
      "city": "Los Angeles",
      "state": "CA",
      "country": "USA",
      "venue": "Garden Pavilion",
      "price": 89.00,
      "currency": "USD",
      "isOnline": false,
      "capacity": 50,
      "attendees": 35,
      "organizer": "Mindful Living LA",
      "rating": 4.9,
      "reviews": 87,
      "image": "https://picsum.photos/400/250?random=2&keyword=yoga",
      "tags": ["Yoga", "Meditation", "Wellness", "Relaxation"],
      "speakers": [
        {"name": "Amanda Stone", "title": "Certified Yoga Instructor", "image": "https://picsum.photos/100/100?random=4"},
        {"name": "Dr. Michael Green", "title": "Mindfulness Expert", "image": "https://picsum.photos/100/100?random=5"}
      ],
      "highlights": ["Healthy Lunch Included", "Take-home Materials", "Group Meditation"],
      "requirements": ["Comfortable Clothing", "Yoga Mat (provided if needed)"],
    },
    {
      "id": "evt_003",
      "title": "Digital Marketing Masterclass",
      "description": "Learn advanced digital marketing strategies from industry experts and boost your career",
      "category": "business",
      "date": "2024-03-18",
      "time": "13:00",
      "endTime": "17:00",
      "location": "Online Event",
      "city": "Virtual",
      "state": "",
      "country": "Global",
      "venue": "Zoom Platform",
      "price": 0.00,
      "currency": "USD",
      "isOnline": true,
      "capacity": 500,
      "attendees": 387,
      "organizer": "Digital Pros Academy",
      "rating": 4.7,
      "reviews": 156,
      "image": "https://picsum.photos/400/250?random=3&keyword=marketing",
      "tags": ["Marketing", "Digital", "SEO", "Social Media"],
      "speakers": [
        {"name": "Jennifer Kim", "title": "Marketing Director at Adobe", "image": "https://picsum.photos/100/100?random=6"},
        {"name": "Alex Thompson", "title": "SEO Specialist", "image": "https://picsum.photos/100/100?random=7"}
      ],
      "highlights": ["Interactive Workshops", "Free Resources", "Certificate of Completion"],
      "requirements": ["Stable Internet Connection", "Laptop/Desktop Recommended"],
    },
    {
      "id": "evt_004",
      "title": "Food & Wine Festival",
      "description": "Celebrate culinary excellence with local chefs, wine tastings, and live entertainment",
      "category": "food",
      "date": "2024-04-05",
      "time": "12:00",
      "endTime": "22:00",
      "location": "Central Park",
      "city": "New York",
      "state": "NY",
      "country": "USA",
      "venue": "Great Lawn",
      "price": 65.00,
      "currency": "USD",
      "isOnline": false,
      "capacity": 2000,
      "attendees": 1650,
      "organizer": "NYC Food Events",
      "rating": 4.6,
      "reviews": 243,
      "image": "https://picsum.photos/400/250?random=4&keyword=food",
      "tags": ["Food", "Wine", "Culinary", "Entertainment"],
      "speakers": [
        {"name": "Chef Maria Gonzalez", "title": "Executive Chef", "image": "https://picsum.photos/100/100?random=8"},
        {"name": "Robert Wine", "title": "Sommelier", "image": "https://picsum.photos/100/100?random=9"}
      ],
      "highlights": ["Live Cooking Demos", "Wine Tastings", "Live Music"],
      "requirements": ["21+ for Wine Tastings", "Valid ID Required"],
    },
    {
      "id": "evt_005",
      "title": "Charity Run for Education",
      "description": "5K charity run to support local education initiatives and underprivileged students",
      "category": "charity",
      "date": "2024-03-30",
      "time": "07:00",
      "endTime": "11:00",
      "location": "Riverside Park",
      "city": "Chicago",
      "state": "IL",
      "country": "USA",
      "venue": "Main Trail",
      "price": 25.00,
      "currency": "USD",
      "isOnline": false,
      "capacity": 300,
      "attendees": 234,
      "organizer": "Education First Foundation",
      "rating": 4.8,
      "reviews": 92,
      "image": "https://picsum.photos/400/250?random=5&keyword=running",
      "tags": ["Charity", "Running", "Education", "Community"],
      "speakers": [
        {"name": "Mayor Johnson", "title": "City Mayor", "image": "https://picsum.photos/100/100?random=10"}
      ],
      "highlights": ["Finisher Medals", "Healthy Breakfast", "Awards Ceremony"],
      "requirements": ["Running Attire", "Water Bottle Recommended"],
    },
    {
      "id": "evt_006",
      "title": "Art Gallery Opening",
      "description": "Exclusive opening of contemporary art exhibition featuring emerging local artists",
      "category": "arts",
      "date": "2024-03-22",
      "time": "18:00",
      "endTime": "21:00",
      "location": "Modern Art Gallery",
      "city": "Philadelphia",
      "state": "PA",
      "country": "USA",
      "venue": "Main Exhibition Hall",
      "price": 35.00,
      "currency": "USD",
      "isOnline": false,
      "capacity": 120,
      "attendees": 98,
      "organizer": "Contemporary Arts Society",
      "rating": 4.5,
      "reviews": 67,
      "image": "https://picsum.photos/400/250?random=6&keyword=art",
      "tags": ["Art", "Gallery", "Contemporary", "Culture"],
      "speakers": [
        {"name": "Elena Rossi", "title": "Art Curator", "image": "https://picsum.photos/100/100?random=11"},
        {"name": "James Miller", "title": "Featured Artist", "image": "https://picsum.photos/100/100?random=12"}
      ],
      "highlights": ["Artist Meet & Greet", "Wine Reception", "Guided Tours"],
      "requirements": ["Smart Casual Attire", "No Photography in Gallery"],
    },
    {
      "id": "evt_007",
      "title": "Jazz Night Under the Stars",
      "description": "Outdoor jazz concert featuring renowned musicians in an intimate setting",
      "category": "music",
      "date": "2024-04-12",
      "time": "19:30",
      "endTime": "23:00",
      "location": "Rooftop Gardens",
      "city": "Houston",
      "state": "TX",
      "country": "USA",
      "venue": "Sky Terrace",
      "price": 45.00,
      "currency": "USD",
      "isOnline": false,
      "capacity": 150,
      "attendees": 127,
      "organizer": "Houston Jazz Society",
      "rating": 4.9,
      "reviews": 134,
      "image": "https://picsum.photos/400/250?random=7&keyword=jazz",
      "tags": ["Jazz", "Music", "Outdoor", "Evening"],
      "speakers": [
        {"name": "Marcus Blue", "title": "Jazz Pianist", "image": "https://picsum.photos/100/100?random=13"},
        {"name": "Sophie Green", "title": "Vocalist", "image": "https://picsum.photos/100/100?random=14"}
      ],
      "highlights": ["Premium Seating", "Complimentary Drinks", "Meet the Artists"],
      "requirements": ["Weather Dependent", "Blankets Recommended"],
    },
    {
      "id": "evt_008",
      "title": "Entrepreneurship Workshop",
      "description": "Intensive workshop for aspiring entrepreneurs covering business planning and funding",
      "category": "business",
      "date": "2024-03-28",
      "time": "10:00",
      "endTime": "16:00",
      "location": "Business Innovation Center",
      "city": "Phoenix",
      "state": "AZ",
      "country": "USA",
      "venue": "Conference Room A",
      "price": 125.00,
      "currency": "USD",
      "isOnline": false,
      "capacity": 80,
      "attendees": 72,
      "organizer": "Startup Phoenix",
      "rating": 4.7,
      "reviews": 89,
      "image": "https://picsum.photos/400/250?random=8&keyword=business",
      "tags": ["Business", "Entrepreneurship", "Startup", "Workshop"],
      "speakers": [
        {"name": "David Chang", "title": "Serial Entrepreneur", "image": "https://picsum.photos/100/100?random=15"},
        {"name": "Rachel Adams", "title": "VC Partner", "image": "https://picsum.photos/100/100?random=16"}
      ],
      "highlights": ["Networking Lunch", "Business Plan Template", "1-on-1 Sessions"],
      "requirements": ["Notebook & Pen", "Business Idea (Optional)"],
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = publicEvents.where((event) {
      // Search filter
      bool matchesSearch = searchQuery.isEmpty || 
        event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        event["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (event["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      // Category filter
      bool matchesCategory = selectedCategory == "all" || event["category"] == selectedCategory;
      
      // Location filter  
      bool matchesLocation = selectedLocation == "all" || 
        (selectedLocation == "online" && event["isOnline"]) ||
        event["city"].toString().toLowerCase().contains(selectedLocation.replaceAll("_", " ").toLowerCase());
      
      // Price filter
      bool matchesPrice = true;
      double price = event["price"] as double;
      switch (selectedPriceRange) {
        case "free":
          matchesPrice = price == 0;
          break;
        case "under_25":
          matchesPrice = price > 0 && price < 25;
          break;
        case "25_50":
          matchesPrice = price >= 25 && price <= 50;
          break;
        case "50_100":
          matchesPrice = price > 50 && price <= 100;
          break;
        case "100_250":
          matchesPrice = price > 100 && price <= 250;
          break;
        case "over_250":
          matchesPrice = price > 250;
          break;
      }
      
      // Bookmark filter
      bool matchesBookmark = !showOnlyBookmarked || bookmarkedEvents.contains(event["id"]);
      
      return matchesSearch && matchesCategory && matchesLocation && matchesPrice && matchesBookmark;
    }).toList();

    // Sort events
    filtered.sort((a, b) {
      switch (sortBy) {
        case "date":
          return DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
        case "date_desc":
          return DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"]));
        case "price_asc":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "price_desc":
          return (b["price"] as double).compareTo(a["price"] as double);
        case "popularity":
          return (b["attendees"] as int).compareTo(a["attendees"] as int);
        case "name":
          return a["title"].toString().compareTo(b["title"].toString());
        case "distance":
          return 0; // Would need user location to implement
        default:
          return 0;
      }
    });

    return filtered;
  }

  void _toggleBookmark(String eventId) {
    if (bookmarkedEvents.contains(eventId)) {
      bookmarkedEvents.remove(eventId);
      ss("Event removed from bookmarks");
    } else {
      bookmarkedEvents.add(eventId);
      ss("Event added to bookmarks");
    }
    setState(() {});
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${event["title"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleBookmark(event["id"]),
                    child: Icon(
                      bookmarkedEvents.contains(event["id"]) ? Icons.bookmark : Icons.bookmark_border,
                      color: bookmarkedEvents.contains(event["id"]) ? warningColor : disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "${event["image"]}",
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      children: [
                        if (event["price"] == 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "FREE",
                              style: TextStyle(
                                color: successColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "\$${((event["price"] as double).toDouble()).currency}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        SizedBox(width: spSm),
                        if (event["isOnline"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "ONLINE",
                              style: TextStyle(
                                color: infoColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${event["rating"]} (${event["reviews"]})",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${event["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 20, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "${DateTime.parse(event["date"]).dMMMy}",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 20, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "${event["time"]} - ${event["endTime"]}",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 20, color: primaryColor),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${event["location"]}, ${event["city"]}${event["state"].isNotEmpty ? ", ${event["state"]}" : ""}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.business, size: 20, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Organized by ${event["organizer"]}",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${event["attendees"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Going",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${((event["capacity"] as int) - (event["attendees"] as int))}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Available",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if ((event["speakers"] as List).isNotEmpty) ...[
                      Text(
                        "Featured Speakers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        spacing: spSm,
                        children: (event["speakers"] as List).map((speaker) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    speaker["image"],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        speaker["name"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        speaker["title"],
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
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
                    if ((event["highlights"] as List).isNotEmpty) ...[
                      Text(
                        "Event Highlights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        spacing: spXs,
                        children: (event["highlights"] as List).map((highlight) {
                          return Row(
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 16),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  highlight,
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                    if ((event["requirements"] as List).isNotEmpty) ...[
                      Text(
                        "Requirements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        spacing: spXs,
                        children: (event["requirements"] as List).map((requirement) {
                          return Row(
                            children: [
                              Icon(Icons.info, color: infoColor, size: 16),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  requirement,
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                    if ((event["tags"] as List).isNotEmpty) ...[
                      Text(
                        "Tags",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (event["tags"] as List).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Share Event",
                      color: secondaryColor,
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Event sharing options opened");
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: event["price"] == 0 ? "Register Free" : "Buy Tickets",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Redirecting to registration...");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Filter Events",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Location",
                      items: locations,
                      value: selectedLocation,
                      onChanged: (value, label) {
                        selectedLocation = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Price Range",
                      items: priceRanges,
                      value: selectedPriceRange,
                      onChanged: (value, label) {
                        selectedPriceRange = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Sort By",
                      items: sortOptions,
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Show only bookmarked events",
                          "value": true,
                          "checked": showOnlyBookmarked,
                        }
                      ],
                      value: [if (showOnlyBookmarked) {"label": "Show only bookmarked events", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        showOnlyBookmarked = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Clear All",
                      color: disabledColor,
                      size: bs.md,
                      onPressed: () {
                        selectedCategory = "all";
                        selectedLocation = "all";
                        selectedPriceRange = "all";
                        sortBy = "date";
                        showOnlyBookmarked = false;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Apply Filters",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    bool isBookmarked = bookmarkedEvents.contains(event["id"]);
    double attendanceRate = ((event["attendees"] as int) / (event["capacity"] as int)) * 100;

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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Stack(
              children: [
                Image.network(
                  "${event["image"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Row(
                    children: [
                      if (event["price"] == 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "FREE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () => _toggleBookmark(event["id"]),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? warningColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (event["isOnline"])
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "ONLINE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${event["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${event["rating"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(event["date"]).dMMMy}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.access_time, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "${event["time"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${event["location"]}, ${event["city"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (event["price"] > 0) ...[
                      Icon(Icons.attach_money, size: 16, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "\$${((event["price"] as double).toDouble()).currency}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ] else ...[
                      Text(
                        "FREE EVENT",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ],
                    Text(
                      "${event["attendees"]} going",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: attendanceRate / 100,
                  backgroundColor: disabledColor.withAlpha(50),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    attendanceRate > 80 ? dangerColor : 
                    attendanceRate > 60 ? warningColor : 
                    successColor
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${attendanceRate.toStringAsFixed(0)}% capacity filled",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _showEventDetails(event),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = filteredEvents;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Events"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search events...",
                        value: searchQuery,
                        hint: "Search by title, description, or tags",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: _showFilterOptions,
                    ),
                  ],
                ),
                if (selectedCategory != "all" || selectedLocation != "all" || selectedPriceRange != "all" || showOnlyBookmarked)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_alt, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Active filters: ${[
                              if (selectedCategory != "all") "Category",
                              if (selectedLocation != "all") "Location", 
                              if (selectedPriceRange != "all") "Price",
                              if (showOnlyBookmarked) "Bookmarked"
                            ].join(", ")}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectedCategory = "all";
                            selectedLocation = "all";
                            selectedPriceRange = "all";
                            showOnlyBookmarked = false;
                            setState(() {});
                          },
                          child: Icon(Icons.close, size: 16, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty 
              ? Container(
                  padding: EdgeInsets.all(spXl),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No Events Found",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Try adjusting your search or filter criteria",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      QButton(
                        label: "Clear All Filters",
                        color: primaryColor,
                        size: bs.sm,
                        onPressed: () {
                          searchQuery = "";
                          selectedCategory = "all";
                          selectedLocation = "all";
                          selectedPriceRange = "all";
                          showOnlyBookmarked = false;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return _buildEventCard(filtered[index]);
                  },
                ),
          ),
        ],
      ),
    );
  }
}
