import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaAgentDetailView extends StatefulWidget {
  const ReaAgentDetailView({super.key});

  @override
  State<ReaAgentDetailView> createState() => _ReaAgentDetailViewState();
}

class _ReaAgentDetailViewState extends State<ReaAgentDetailView> {
  int currentTab = 0;

  Map<String, dynamic> agent = {
    "id": 1,
    "name": "Sarah Johnson",
    "title": "Senior Real Estate Agent",
    "company": "Premier Realty Group",
    "license": "RE-2024-98765",
    "phone": "+1 (555) 123-4567",
    "email": "sarah.johnson@premierrealty.com",
    "avatar": "https://picsum.photos/150/150?random=1&keyword=agent",
    "coverImage": "https://picsum.photos/400/200?random=2&keyword=office",
    "rating": 4.9,
    "totalReviews": 127,
    "totalSales": 284,
    "yearsExperience": 8,
    "totalVolume": 85600000,
    "about": "Sarah is a dedicated real estate professional with over 8 years of experience in the Seattle market. She specializes in luxury properties and first-time homebuyers, providing personalized service and expert guidance throughout the buying and selling process. Sarah's deep knowledge of local neighborhoods and market trends has helped hundreds of families find their dream homes.",
    "specializations": [
      "Luxury Properties",
      "First-Time Buyers",
      "Investment Properties",
      "Relocation Services",
      "Waterfront Homes",
    ],
    "serviceAreas": [
      "Downtown Seattle",
      "Capitol Hill",
      "Queen Anne",
      "Bellevue",
      "Kirkland",
      "Redmond",
    ],
    "certifications": [
      "Certified Residential Specialist (CRS)",
      "Accredited Buyer's Representative (ABR)",
      "Senior Real Estate Specialist (SRES)",
    ],
    "languages": ["English", "Spanish", "French"],
    "socialMedia": {
      "facebook": "sarah.johnson.realty",
      "instagram": "@sarahsellsseattle",
      "linkedin": "sarah-johnson-realtor",
    },
  };

  List<Map<String, dynamic>> listings = [
    {
      "id": 1,
      "title": "Modern Downtown Penthouse",
      "image": "https://picsum.photos/200/150?random=10&keyword=penthouse",
      "price": 2850000,
      "status": "Active",
      "bedrooms": 3,
      "bathrooms": 2.5,
      "sqft": 2375,
      "address": "123 Main Street, Seattle, WA",
      "listedDate": "2024-11-15",
    },
    {
      "id": 2,
      "title": "Waterfront Villa",
      "image": "https://picsum.photos/200/150?random=11&keyword=villa",
      "price": 3200000,
      "status": "Pending",
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 3200,
      "address": "456 Lake View Drive, Bellevue, WA",
      "listedDate": "2024-10-28",
    },
    {
      "id": 3,
      "title": "Historic Capitol Hill Home",
      "image": "https://picsum.photos/200/150?random=12&keyword=historic",
      "price": 1750000,
      "status": "Sold",
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1950,
      "address": "789 Pine Street, Seattle, WA",
      "listedDate": "2024-09-12",
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "clientName": "Michael Chen",
      "clientAvatar": "https://picsum.photos/50/50?random=20&keyword=man",
      "rating": 5,
      "date": "2024-12-01",
      "comment": "Sarah made our home buying experience seamless and stress-free. Her knowledge of the market and attention to detail is exceptional. Highly recommend!",
      "propertyType": "First-time buyer",
    },
    {
      "id": 2,
      "clientName": "Emma Wilson",
      "clientAvatar": "https://picsum.photos/50/50?random=21&keyword=woman",
      "rating": 5,
      "date": "2024-11-18",
      "comment": "Outstanding service! Sarah helped us sell our home above asking price and found us the perfect new place. Professional and caring throughout.",
      "propertyType": "Luxury home sale",
    },
    {
      "id": 3,
      "clientName": "David Rodriguez",
      "clientAvatar": "https://picsum.photos/50/50?random=22&keyword=man",
      "rating": 4,
      "date": "2024-11-05",
      "comment": "Great experience working with Sarah. She was patient with our search and provided valuable insights into the neighborhood. Very satisfied!",
      "propertyType": "Investment property",
    },
  ];

  List<Map<String, dynamic>> awards = [
    {
      "year": 2024,
      "title": "Top Producer Award",
      "organization": "Seattle Real Estate Association",
      "description": "Ranked in top 5% of agents by sales volume",
    },
    {
      "year": 2023,
      "title": "Client Choice Award",
      "organization": "Premier Realty Group",
      "description": "Highest client satisfaction ratings",
    },
    {
      "year": 2022,
      "title": "Rising Star Award",
      "organization": "Washington State Realtors",
      "description": "Outstanding performance by agents under 35",
    },
  ];

  Widget _buildStarRating(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : 
          index < rating ? Icons.star_half : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QTabBar(
        withoutAppBar: true,
        selectedIndex: currentTab,
        tabs: [
          Tab(text: "Overview", icon: Icon(Icons.person)),
          Tab(text: "Listings", icon: Icon(Icons.home)),
          Tab(text: "Reviews", icon: Icon(Icons.star)),
        ],
        tabChildren: [
          // Overview Tab
          SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Stack(
                  children: [
                    // Cover Image
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        "${agent["coverImage"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(100),
                            Colors.transparent,
                            Colors.black.withAlpha(120),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    
                    // Back Button
                    Positioned(
                      top: MediaQuery.of(context).padding.top + spSm,
                      left: spMd,
                      child: GestureDetector(
                        onTap: () => back(),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    
                    // Agent Profile
                    Positioned(
                      bottom: -50,
                      left: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("${agent["avatar"]}"),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${agent["name"]}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${agent["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      _buildStarRating(agent["rating"] as double),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${agent["rating"]} (${agent["totalReviews"]})",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
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
                    ),
                  ],
                ),
                
                SizedBox(height: 70),
                
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Cards
                      Row(
                        children: [
                          _buildStatCard("${agent["totalSales"]}", "Properties Sold", Icons.home_filled),
                          SizedBox(width: spSm),
                          _buildStatCard("${agent["yearsExperience"]}", "Years Experience", Icons.access_time),
                          SizedBox(width: spSm),
                          _buildStatCard("\$${(((agent["totalVolume"] as int).toDouble()) / 1000000).toInt()}M", "Total Volume", Icons.trending_up),
                        ],
                      ),

                      SizedBox(height: spLg),

                      // Contact Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Call Now",
                              icon: Icons.call,
                              size: bs.md,
                              onPressed: () {
                                // Make call
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Send Message",
                              icon: Icons.message,
                              size: bs.md,
                              onPressed: () {
                                // Send message
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spLg),

                      // About Section
                      Text(
                        "About ${agent["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${agent["about"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: spLg),

                      // Specializations
                      Text(
                        "Specializations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spSm,
                        children: (agent["specializations"] as List).map((spec) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: primaryColor.withAlpha(60)),
                            ),
                            child: Text(
                              "$spec",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: spLg),

                      // Service Areas
                      Text(
                        "Service Areas",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...( agent["serviceAreas"] as List).map((area) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: primaryColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "$area",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      SizedBox(height: spLg),

                      // Awards & Recognition
                      Text(
                        "Awards & Recognition",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...awards.map((award) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.emoji_events,
                                  color: warningColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${award["title"]} (${award["year"]})",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${award["organization"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${award["description"]}",
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
                        );
                      }).toList(),

                      SizedBox(height: spLg),

                      // Contact Information
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.business, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${agent["company"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.badge, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "License: ${agent["license"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.phone, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${agent["phone"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.email, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${agent["email"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
              ],
            ),
          ),

          // Listings Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Listings (${listings.length})",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...listings.map((listing) {
                  Color statusColor = listing["status"] == "Active" ? successColor :
                                    listing["status"] == "Pending" ? warningColor : primaryColor;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${listing["image"]}",
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${listing["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${listing["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${((listing["price"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${listing["bedrooms"]} bed • ${listing["bathrooms"]} bath • ${listing["sqft"]} sqft",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${listing["address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Reviews Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating Summary
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${agent["rating"]}",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          _buildStarRating(agent["rating"] as double),
                          SizedBox(height: spXs),
                          Text(
                            "${agent["totalReviews"]} reviews",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spLg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Client Satisfaction",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text("5★", style: TextStyle(fontSize: 12)),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: 0.85,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text("85%", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text("4★", style: TextStyle(fontSize: 12)),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: 0.12,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text("12%", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text("3★", style: TextStyle(fontSize: 12)),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: 0.03,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text("3%", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spLg),

                Text(
                  "Client Reviews",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),

                ...reviews.map((review) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
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
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${review["clientAvatar"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${review["clientName"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _buildStarRating((review["rating"] as int).toDouble()),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${DateTime.parse(review["date"] as String).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${review["propertyType"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${review["comment"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
