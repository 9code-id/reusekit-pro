import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRentalListingsView extends StatefulWidget {
  const RmaRentalListingsView({super.key});

  @override
  State<RmaRentalListingsView> createState() => _RmaRentalListingsViewState();
}

class _RmaRentalListingsViewState extends State<RmaRentalListingsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedPlatform = "";

  List<Map<String, dynamic>> listings = [
    {
      "id": "LST001",
      "property": "Sunset Villa #101",
      "address": "123 Sunset Blvd, Los Angeles",
      "type": "Apartment",
      "bedrooms": 2,
      "bathrooms": 2,
      "rent": 2500.0,
      "status": "Active",
      "datePosted": "2025-06-15",
      "views": 145,
      "inquiries": 12,
      "applications": 3,
      "platforms": ["Zillow", "Apartments.com", "Craigslist"],
      "image": "https://picsum.photos/300/200?random=701&keyword=apartment",
      "description": "Beautiful 2-bedroom apartment with ocean views and modern amenities",
      "featured": true,
      "score": 85,
    },
    {
      "id": "LST002",
      "property": "Ocean View #205",
      "address": "456 Ocean Ave, Santa Monica",
      "type": "Condo",
      "bedrooms": 3,
      "bathrooms": 2,
      "rent": 3200.0,
      "status": "Pending",
      "datePosted": "2025-06-10",
      "views": 89,
      "inquiries": 8,
      "applications": 5,
      "platforms": ["Zillow", "Trulia"],
      "image": "https://picsum.photos/300/200?random=702&keyword=condo",
      "description": "Spacious condo with balcony overlooking the ocean, premium location",
      "featured": false,
      "score": 92,
    },
    {
      "id": "LST003",
      "property": "Garden Court #12",
      "address": "789 Garden St, Beverly Hills",
      "type": "House",
      "bedrooms": 4,
      "bathrooms": 3,
      "rent": 4500.0,
      "status": "Draft",
      "datePosted": "2025-06-18",
      "views": 0,
      "inquiries": 0,
      "applications": 0,
      "platforms": [],
      "image": "https://picsum.photos/300/200?random=703&keyword=house",
      "description": "Luxury single-family home with garden, garage, and modern fixtures",
      "featured": true,
      "score": 0,
    },
    {
      "id": "LST004",
      "property": "Metro Heights #304",
      "address": "321 Metro Ave, Downtown",
      "type": "Studio",
      "bedrooms": 0,
      "bathrooms": 1,
      "rent": 1800.0,
      "status": "Active",
      "datePosted": "2025-06-12",
      "views": 234,
      "inquiries": 18,
      "applications": 7,
      "platforms": ["Zillow", "Apartments.com", "PadMapper"],
      "image": "https://picsum.photos/300/200?random=704&keyword=studio",
      "description": "Modern studio in downtown, perfect for professionals, all amenities included",
      "featured": false,
      "score": 78,
    },
    {
      "id": "LST005",
      "property": "Riverside Loft #8",
      "address": "654 River Rd, Pasadena",
      "type": "Loft",
      "bedrooms": 2,
      "bathrooms": 2,
      "rent": 2800.0,
      "status": "Expired",
      "datePosted": "2025-05-20",
      "views": 67,
      "inquiries": 4,
      "applications": 1,
      "platforms": ["Craigslist"],
      "image": "https://picsum.photos/300/200?random=705&keyword=loft",
      "description": "Industrial-style loft with high ceilings and exposed brick walls",
      "featured": false,
      "score": 45,
    },
  ];

  List<Map<String, dynamic>> platforms = [
    {
      "name": "Zillow",
      "logo": "https://picsum.photos/60/60?random=801&keyword=logo",
      "activeListings": 12,
      "totalViews": 1420,
      "averageViews": 118,
      "status": "Connected",
      "lastSync": "2025-06-20 10:30 AM",
      "cost": 149.0,
    },
    {
      "name": "Apartments.com",
      "logo": "https://picsum.photos/60/60?random=802&keyword=logo",
      "activeListings": 8,
      "totalViews": 890,
      "averageViews": 111,
      "status": "Connected",
      "lastSync": "2025-06-20 09:15 AM",
      "cost": 99.0,
    },
    {
      "name": "Trulia",
      "logo": "https://picsum.photos/60/60?random=803&keyword=logo",
      "activeListings": 6,
      "totalViews": 456,
      "averageViews": 76,
      "status": "Connected",
      "lastSync": "2025-06-20 08:45 AM",
      "cost": 79.0,
    },
    {
      "name": "Craigslist",
      "logo": "https://picsum.photos/60/60?random=804&keyword=logo",
      "activeListings": 15,
      "totalViews": 678,
      "averageViews": 45,
      "status": "Connected",
      "lastSync": "2025-06-20 11:00 AM",
      "cost": 0.0,
    },
    {
      "name": "PadMapper",
      "logo": "https://picsum.photos/60/60?random=805&keyword=logo",
      "activeListings": 4,
      "totalViews": 234,
      "averageViews": 58,
      "status": "Disconnected",
      "lastSync": "2025-06-18 02:00 PM",
      "cost": 59.0,
    },
  ];

  List<Map<String, dynamic>> analytics = [
    {
      "title": "Total Listings",
      "value": 25,
      "change": 15,
      "color": primaryColor,
      "icon": Icons.list,
    },
    {
      "title": "Active Listings",
      "value": 18,
      "change": 20,
      "color": successColor,
      "icon": Icons.visibility,
    },
    {
      "title": "Total Views",
      "value": 3678,
      "change": 8,
      "color": infoColor,
      "icon": Icons.remove_red_eye,
    },
    {
      "title": "Applications",
      "value": 42,
      "change": 25,
      "color": warningColor,
      "icon": Icons.description,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> platformOptions = [
    {"label": "All Platforms", "value": ""},
    {"label": "Zillow", "value": "Zillow"},
    {"label": "Apartments.com", "value": "Apartments.com"},
    {"label": "Trulia", "value": "Trulia"},
    {"label": "Craigslist", "value": "Craigslist"},
    {"label": "PadMapper", "value": "PadMapper"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return successColor;
      case 'Pending':
        return warningColor;
      case 'Draft':
        return infoColor;
      case 'Expired':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPlatformStatusColor(String status) {
    return status == 'Connected' ? successColor : dangerColor;
  }

  List<Map<String, dynamic>> _getFilteredListings() {
    return listings.where((listing) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${listing["property"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${listing["address"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${listing["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || listing["status"] == selectedStatus;
      bool matchesPlatform = selectedPlatform.isEmpty || 
          (listing["platforms"] as List).contains(selectedPlatform);
      
      return matchesSearch && matchesStatus && matchesPlatform;
    }).toList();
  }

  Widget _buildListingsTab() {
    final filteredListings = _getFilteredListings();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search listings...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Filter Dropdowns
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Platform",
                  items: platformOptions,
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Listings Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredListings.map((listing) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor("${listing["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusSm),
                        topRight: Radius.circular(radiusSm),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${listing["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          
                          // Featured Badge
                          if (listing["featured"] == true)
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 10, color: Colors.white),
                                    SizedBox(width: 2),
                                    Text(
                                      "Featured",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          
                          // Status Badge
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${listing["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${listing["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
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
                          // Property Name
                          Text(
                            "${listing["property"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          // Address
                          Text(
                            "${listing["address"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Property Details
                          Row(
                            children: [
                              if ((listing["bedrooms"] as int) > 0) ...[
                                Icon(Icons.bed, size: 12, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "${listing["bedrooms"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                              ],
                              
                              Icon(Icons.bathtub, size: 12, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${listing["bathrooms"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              Spacer(),
                              
                              Text(
                                "\$${((listing["rent"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Description
                          Text(
                            "${listing["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Listing Stats
                          if (listing["status"] != "Draft") ...[
                            Row(
                              children: [
                                Icon(Icons.visibility, size: 12, color: infoColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${listing["views"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                
                                SizedBox(width: spSm),
                                
                                Icon(Icons.question_answer, size: 12, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${listing["inquiries"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                
                                Spacer(),
                                
                                Icon(Icons.description, size: 12, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${listing["applications"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                          ],
                          
                          // Performance Score (if not draft)
                          if (listing["status"] != "Draft" && listing["score"] > 0) ...[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: (listing["score"] as int) >= 80 
                                    ? successColor.withAlpha(30)
                                    : (listing["score"] as int) >= 60 
                                        ? warningColor.withAlpha(30)
                                        : dangerColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Performance Score: ${listing["score"]}/100",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: (listing["score"] as int) >= 80 
                                      ? successColor
                                      : (listing["score"] as int) >= 60 
                                          ? warningColor
                                          : dangerColor,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                          ],
                          
                          // Platforms
                          if ((listing["platforms"] as List).isNotEmpty) ...[
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: (listing["platforms"] as List).map((platform) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$platform",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                          ],
                          
                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: listing["status"] == "Draft" ? "Publish" : "Manage",
                              size: bs.sm,
                              onPressed: () {},
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
      ),
    );
  }

  Widget _buildPlatformsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                "Listing Platforms",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Platform",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Platforms Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: platforms.map((platform) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPlatformStatusColor("${platform["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Platform Header
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${platform["logo"]}",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${platform["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPlatformStatusColor("${platform["status"]}").withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${platform["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getPlatformStatusColor("${platform["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Platform Stats
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${platform["activeListings"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Active Listings",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${platform["totalViews"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Total Views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Performance
                    Row(
                      children: [
                        Icon(Icons.trending_up, size: 12, color: successColor),
                        SizedBox(width: spXs),
                        Text(
                          "Avg: ${platform["averageViews"]} views/listing",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    // Cost
                    Row(
                      children: [
                        Icon(Icons.attach_money, size: 12, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          platform["cost"] == 0 
                              ? "Free"
                              : "\$${((platform["cost"] as double)).currency}/month",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    // Last Sync
                    Row(
                      children: [
                        Icon(Icons.sync, size: 12, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Last sync: ${platform["lastSync"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                            label: platform["status"] == "Connected" ? "Sync Now" : "Connect",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.settings,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
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
          // Key Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: analytics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
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
                            color: (metric["color"] as Color).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            size: 20,
                            color: metric["color"] as Color,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (metric["change"] as int) >= 0 ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(metric["change"] as int) >= 0 ? '+' : ''}${metric["change"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as int) >= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${metric["value"]}${metric["title"] == "Total Views" ? "" : ""}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Performance Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Platform Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Performing",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "Zillow (118 avg views)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Listings",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "Craigslist (15 active)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Monthly Cost",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "\$386 total",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Conversion Rate",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "1.14% (views to apps)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rental Listings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Listings", icon: Icon(Icons.list)),
        Tab(text: "Platforms", icon: Icon(Icons.language)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildListingsTab(),
        _buildPlatformsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
