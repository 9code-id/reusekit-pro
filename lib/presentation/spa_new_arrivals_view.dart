import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaNewArrivalsView extends StatefulWidget {
  const SpaNewArrivalsView({Key? key}) : super(key: key);

  @override
  State<SpaNewArrivalsView> createState() => _SpaNewArrivalsViewState();
}

class _SpaNewArrivalsViewState extends State<SpaNewArrivalsView> {
  String selectedTimeFrame = "this_week";
  String selectedCategory = "all";
  String sortBy = "newest";
  bool showFavoritesOnly = false;

  List<Map<String, dynamic>> newArrivals = [
    {
      "id": 1,
      "title": "24K Gold Luxury Facial",
      "price": 385.0,
      "originalPrice": 450.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=gold",
      "spa": "Opulent Skin Studio",
      "category": "facial",
      "rating": 4.8,
      "reviews": 12,
      "duration": "80 min",
      "description": "Revolutionary 24K gold infusion facial for ultimate skin radiance",
      "launchDate": "2024-01-15",
      "daysAgo": 2,
      "isNew": true,
      "isExclusive": true,
      "isPopular": false,
      "isFavorite": false,
      "features": ["Pure 24K gold", "Anti-aging", "Instant glow"],
      "discount": 15,
      "availability": "Limited introduction offer",
      "distance": 1.5,
      "bookings": 45,
      "isHot": true,
    },
    {
      "id": 2,
      "title": "Himalayan Salt Stone Massage",
      "price": 195.0,
      "originalPrice": 220.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=himalayan",
      "spa": "Mountain Wellness Retreat",
      "category": "massage",
      "rating": 4.6,
      "reviews": 8,
      "duration": "70 min",
      "description": "Healing massage with heated Himalayan pink salt stones",
      "launchDate": "2024-01-14",
      "daysAgo": 3,
      "isNew": true,
      "isExclusive": false,
      "isPopular": true,
      "isFavorite": true,
      "features": ["Heated stones", "Detoxifying", "Muscle relief"],
      "discount": 11,
      "availability": "Available today",
      "distance": 2.8,
      "bookings": 28,
      "isHot": false,
    },
    {
      "id": 3,
      "title": "Cryotherapy Skin Tightening",
      "price": 275.0,
      "originalPrice": 325.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=cryotherapy",
      "spa": "Future Skin Technologies",
      "category": "treatment",
      "rating": 4.9,
      "reviews": 15,
      "duration": "45 min",
      "description": "Advanced cryotherapy treatment for skin tightening and rejuvenation",
      "launchDate": "2024-01-13",
      "daysAgo": 4,
      "isNew": true,
      "isExclusive": true,
      "isPopular": false,
      "isFavorite": false,
      "features": ["Non-invasive", "Immediate results", "FDA approved"],
      "discount": 15,
      "availability": "Booking required",
      "distance": 3.7,
      "bookings": 35,
      "isHot": true,
    },
    {
      "id": 4,
      "title": "Aromatherapy Sound Bath Experience",
      "price": 145.0,
      "originalPrice": 165.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=soundbath",
      "spa": "Harmony Healing Center",
      "category": "wellness",
      "rating": 4.7,
      "reviews": 22,
      "duration": "60 min",
      "description": "Immersive sound bath experience with custom aromatherapy blends",
      "launchDate": "2024-01-12",
      "daysAgo": 5,
      "isNew": true,
      "isExclusive": false,
      "isPopular": true,
      "isFavorite": false,
      "features": ["Tibetan bowls", "Custom aromatherapy", "Deep relaxation"],
      "discount": 12,
      "availability": "Group sessions",
      "distance": 1.2,
      "bookings": 67,
      "isHot": false,
    },
    {
      "id": 5,
      "title": "Volcanic Mud Detox Wrap",
      "price": 225.0,
      "originalPrice": 260.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=volcanic",
      "spa": "Earth Elements Spa",
      "category": "body",
      "rating": 4.5,
      "reviews": 9,
      "duration": "85 min",
      "description": "Full body volcanic mud wrap for deep detoxification and skin purification",
      "launchDate": "2024-01-11",
      "daysAgo": 6,
      "isNew": true,
      "isExclusive": false,
      "isPopular": false,
      "isFavorite": true,
      "features": ["Natural volcanic mud", "Detoxifying", "Skin smoothing"],
      "discount": 13,
      "availability": "Available tomorrow",
      "distance": 4.2,
      "bookings": 18,
      "isHot": false,
    },
    {
      "id": 6,
      "title": "LED Light Therapy Facial",
      "price": 165.0,
      "originalPrice": 185.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=led",
      "spa": "Radiance Technology Spa",
      "category": "facial",
      "rating": 4.8,
      "reviews": 31,
      "duration": "50 min",
      "description": "Advanced LED light therapy for acne treatment and skin rejuvenation",
      "launchDate": "2024-01-10",
      "daysAgo": 7,
      "isNew": true,
      "isExclusive": false,
      "isPopular": true,
      "isFavorite": false,
      "features": ["Multiple light wavelengths", "Acne treatment", "Collagen boost"],
      "discount": 11,
      "availability": "Same day booking",
      "distance": 2.4,
      "bookings": 89,
      "isHot": true,
    }
  ];

  List<Map<String, dynamic>> get filteredArrivals {
    List<Map<String, dynamic>> filtered = List.from(newArrivals);

    // Filter by time frame
    if (selectedTimeFrame != "all") {
      int maxDays;
      switch (selectedTimeFrame) {
        case "today":
          maxDays = 1;
          break;
        case "this_week":
          maxDays = 7;
          break;
        case "this_month":
          maxDays = 30;
          break;
        default:
          maxDays = 365;
      }
      filtered = filtered.where((item) => (item["daysAgo"] as int) <= maxDays).toList();
    }

    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }

    // Filter by favorites
    if (showFavoritesOnly) {
      filtered = filtered.where((item) => item["isFavorite"] == true).toList();
    }

    // Sort
    switch (sortBy) {
      case "newest":
        filtered.sort((a, b) => (a["daysAgo"] as int).compareTo(b["daysAgo"] as int));
        break;
      case "price_low":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "popular":
        filtered.sort((a, b) => (b["bookings"] as int).compareTo(a["bookings"] as int));
        break;
    }

    return filtered;
  }

  void _toggleFavorite(int id) {
    setState(() {
      final index = newArrivals.indexWhere((item) => item["id"] == id);
      if (index != -1) {
        newArrivals[index]["isFavorite"] = !newArrivals[index]["isFavorite"];
        if (newArrivals[index]["isFavorite"]) {
          ss("Added to favorites");
        } else {
          si("Removed from favorites");
        }
      }
    });
  }

  void _bookTreatment(Map<String, dynamic> treatment) {
    ss("Booking ${treatment["title"]} at ${treatment["spa"]}");
    // Navigate to booking page
  }

  void _showTreatmentDetails(Map<String, dynamic> treatment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "${treatment["image"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        if (treatment["isNew"]) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
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
                          SizedBox(width: spXs),
                        ],
                        if (treatment["isExclusive"]) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "EXCLUSIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                        ],
                        if (treatment["isHot"]) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "🔥 HOT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${treatment["title"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${treatment["spa"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 18),
                        SizedBox(width: spXs),
                        Text(
                          "${treatment["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "(${treatment["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${treatment["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${treatment["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Key Features",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(treatment["features"] as List).map((feature) => Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((treatment["originalPrice"] as double) > (treatment["price"] as double)) ...[
                                Text(
                                  "\$${(treatment["originalPrice"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(height: spXs),
                              ],
                              Text(
                                "\$${(treatment["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if ((treatment["discount"] as int) > 0) ...[
                                SizedBox(height: spXs),
                                Text(
                                  "${treatment["discount"]}% off launch offer",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Launched ${treatment["daysAgo"]} days ago",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${treatment["bookings"]} bookings",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Book Now",
                            onPressed: () {
                              back();
                              _bookTreatment(treatment);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () => _toggleFavorite(treatment["id"]),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              treatment["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                              color: treatment["isFavorite"] ? dangerColor : disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
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

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter New Arrivals",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Time Frame",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QCategoryPicker(
                    items: [
                      {"label": "All Time", "value": "all"},
                      {"label": "Today", "value": "today"},
                      {"label": "This Week", "value": "this_week"},
                      {"label": "This Month", "value": "this_month"},
                    ],
                    value: selectedTimeFrame,
                    onChanged: (index, label, value, item) {
                      setState(() {
                        selectedTimeFrame = value;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QCategoryPicker(
                    items: [
                      {"label": "All", "value": "all"},
                      {"label": "Facial", "value": "facial"},
                      {"label": "Massage", "value": "massage"},
                      {"label": "Body", "value": "body"},
                      {"label": "Treatment", "value": "treatment"},
                      {"label": "Wellness", "value": "wellness"},
                    ],
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Show favorites only",
                        "value": true,
                        "checked": showFavoritesOnly,
                      }
                    ],
                    value: [
                      if (showFavoritesOnly)
                        {
                          "label": "Show favorites only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        showFavoritesOnly = values.isNotEmpty;
                      });
                    },
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Apply Filters",
                          onPressed: () {
                            back();
                            si("Filters applied");
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = filteredArrivals;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Arrivals"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: [
                          {"label": "Newest First", "value": "newest"},
                          {"label": "Price: Low to High", "value": "price_low"},
                          {"label": "Price: High to Low", "value": "price_high"},
                          {"label": "Highest Rated", "value": "rating"},
                          {"label": "Most Popular", "value": "popular"},
                        ],
                        value: sortBy,
                        onChanged: (value, label) {
                          setState(() {
                            sortBy = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: infoColor, size: 18),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Showing ${filteredList.length} new treatments",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.new_releases_outlined,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No new arrivals found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your filters",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final treatment = filteredList[index];
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
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                  child: GestureDetector(
                                    onTap: () => _showTreatmentDetails(treatment),
                                    child: Image.network(
                                      "${treatment["image"]}",
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Row(
                                    children: [
                                      if (treatment["isNew"]) ...[
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
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
                                        SizedBox(width: spXs),
                                      ],
                                      if (treatment["isExclusive"]) ...[
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: warningColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "EXCLUSIVE",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                      ],
                                      if (treatment["isHot"])
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "🔥 HOT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: GestureDetector(
                                    onTap: () => _toggleFavorite(treatment["id"]),
                                    child: Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(230),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        treatment["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                        color: treatment["isFavorite"] ? dangerColor : disabledBoldColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                if ((treatment["discount"] as int) > 0)
                                  Positioned(
                                    bottom: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${treatment["discount"]}% OFF",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${treatment["title"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${treatment["daysAgo"]} days ago",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${treatment["spa"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: warningColor, size: 16),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${treatment["rating"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "(${treatment["reviews"]})",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${treatment["duration"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${treatment["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spMd),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if ((treatment["originalPrice"] as double) > (treatment["price"] as double)) ...[
                                              Text(
                                                "\$${(treatment["originalPrice"] as double).currency}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: disabledBoldColor,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              SizedBox(height: spXs),
                                            ],
                                            Text(
                                              "\$${(treatment["price"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: QButton(
                                          label: "Book Now",
                                          size: bs.sm,
                                          onPressed: () => _bookTreatment(treatment),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if ((treatment["bookings"] as int) > 0) ...[
                                    SizedBox(height: spSm),
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.trending_up, color: successColor, size: 16),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${treatment["bookings"]} people have booked this treatment",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
