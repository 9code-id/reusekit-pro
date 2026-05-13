import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaHomeView extends StatefulWidget {
  const ReaHomeView({super.key});

  @override
  State<ReaHomeView> createState() => _ReaHomeViewState();
}

class _ReaHomeViewState extends State<ReaHomeView> {
  String searchQuery = "";
  String selectedPropertyType = "All";
  String selectedLocation = "All Locations";

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "All", "value": "All"},
    {"label": "Apartment", "value": "Apartment"},
    {"label": "House", "value": "House"},
    {"label": "Villa", "value": "Villa"},
    {"label": "Commercial", "value": "Commercial"},
  ];

  List<Map<String, dynamic>> featuredProperties = [
    {
      "id": 1,
      "title": "Luxury Apartment",
      "location": "Downtown, NY",
      "price": 850000,
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1200,
      "type": "Apartment",
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "rating": 4.8,
      "agent": "Sarah Johnson",
    },
    {
      "id": 2,
      "title": "Modern Villa",
      "location": "Beverly Hills, CA",
      "price": 2500000,
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 3500,
      "type": "Villa",
      "image": "https://picsum.photos/300/200?random=2&keyword=villa",
      "rating": 4.9,
      "agent": "Michael Brown",
    },
    {
      "id": 3,
      "title": "Cozy House",
      "location": "Suburbs, TX",
      "price": 450000,
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2100,
      "type": "House",
      "image": "https://picsum.photos/300/200?random=3&keyword=house",
      "rating": 4.6,
      "agent": "Emma Davis",
    },
  ];

  List<Map<String, dynamic>> quickStats = [
    {
      "title": "Properties",
      "value": "12.5K+",
      "icon": Icons.home_work,
      "color": primaryColor,
    },
    {
      "title": "Agents",
      "value": "850+",
      "icon": Icons.people,
      "color": successColor,
    },
    {
      "title": "Sold",
      "value": "8.2K+",
      "icon": Icons.trending_up,
      "color": infoColor,
    },
    {
      "title": "Cities",
      "value": "250+",
      "icon": Icons.location_city,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spLg),
            _buildHeader(),
            SizedBox(height: spLg),
            _buildSearchSection(),
            SizedBox(height: spLg),
            _buildQuickStats(),
            SizedBox(height: spLg),
            _buildPropertyTypes(),
            SizedBox(height: spLg),
            _buildFeaturedProperties(),
            SizedBox(height: spLg),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning!",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Find Your Dream Property",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search properties...",
                  value: searchQuery,
                  hint: "Enter location, property name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.md,
                onPressed: () {
                  // --
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Property Type",
                  items: propertyTypes,
                  value: selectedPropertyType,
                  onChanged: (value, label) {
                    selectedPropertyType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Filters",
                  icon: Icons.tune,
                  size: bs.md,
                  color: disabledBoldColor,
                  onPressed: () {
                    // --
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Market Overview",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 150,
          children: quickStats.map((stat) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      stat["icon"],
                      color: stat["color"],
                      size: 24,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${stat["value"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${stat["title"]}",
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
      ],
    );
  }

  Widget _buildPropertyTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Property Types",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // --
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: [
            _buildPropertyTypeCard(
                "Apartment", Icons.apartment, "2.1K+", primaryColor),
            _buildPropertyTypeCard("House", Icons.house, "1.8K+", successColor),
            _buildPropertyTypeCard("Villa", Icons.villa, "950+", infoColor),
            _buildPropertyTypeCard(
                "Commercial", Icons.business, "480+", warningColor),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyTypeCard(
      String type, IconData icon, String count, Color color) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            type,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProperties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Properties",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // --
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: featuredProperties.map((property) {
            return _buildPropertyCard(property);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
              image: DecorationImage(
                image: NetworkImage("${property["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${(property["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
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
                  "${property["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${property["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "\$${(property["price"] as int).currency}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildPropertyFeature(Icons.bed, "${property["bedrooms"]}"),
                    SizedBox(width: spSm),
                    _buildPropertyFeature(
                        Icons.bathroom, "${property["bathrooms"]}"),
                    SizedBox(width: spSm),
                    _buildPropertyFeature(
                        Icons.square_foot, "${property["area"]} sqft"),
                  ],
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // --
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyFeature(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 14,
        ),
        SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: _buildActionCard("Mortgage Calculator", Icons.calculate,
                  primaryColor, () => {}),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildActionCard(
                  "Find Agent", Icons.person_search, successColor, () => {}),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                "Map View",
                Icons.map,
                infoColor,
                () {},
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildActionCard(
                "Saved Properties",
                Icons.favorite,
                dangerColor,
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
