import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyListView extends StatefulWidget {
  const ReaPropertyListView({super.key});

  @override
  State<ReaPropertyListView> createState() => _ReaPropertyListViewState();
}

class _ReaPropertyListViewState extends State<ReaPropertyListView> {
  String searchQuery = "";
  String selectedSort = "Price: Low to High";
  String selectedPropertyType = "All";
  String selectedLocation = "All";
  String viewMode = "grid"; // grid or list

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Area: Largest", "value": "area_desc"},
    {"label": "Area: Smallest", "value": "area_asc"},
  ];

  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "title": "Luxury Apartment Downtown",
      "location": "Manhattan, NY",
      "price": 850000,
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1200,
      "type": "Apartment",
      "image": "https://picsum.photos/400/300?random=1&keyword=apartment",
      "rating": 4.8,
      "agent": "Sarah Johnson",
      "status": "For Sale",
      "featured": true,
    },
    {
      "id": 2,
      "title": "Modern Villa with Pool",
      "location": "Beverly Hills, CA",
      "price": 2500000,
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 3500,
      "type": "Villa",
      "image": "https://picsum.photos/400/300?random=2&keyword=villa",
      "rating": 4.9,
      "agent": "Michael Brown",
      "status": "For Sale",
      "featured": true,
    },
    {
      "id": 3,
      "title": "Cozy Family House",
      "location": "Austin, TX",
      "price": 450000,
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2100,
      "type": "House",
      "image": "https://picsum.photos/400/300?random=3&keyword=house",
      "rating": 4.6,
      "agent": "Emma Davis",
      "status": "For Sale",
      "featured": false,
    },
    {
      "id": 4,
      "title": "Penthouse with City View",
      "location": "Miami, FL",
      "price": 1800000,
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2800,
      "type": "Apartment",
      "image": "https://picsum.photos/400/300?random=4&keyword=penthouse",
      "rating": 4.7,
      "agent": "James Wilson",
      "status": "For Sale",
      "featured": true,
    },
    {
      "id": 5,
      "title": "Commercial Office Space",
      "location": "Seattle, WA",
      "price": 950000,
      "bedrooms": 0,
      "bathrooms": 4,
      "area": 1800,
      "type": "Commercial",
      "image": "https://picsum.photos/400/300?random=5&keyword=office",
      "rating": 4.5,
      "agent": "Lisa Chen",
      "status": "For Sale",
      "featured": false,
    },
    {
      "id": 6,
      "title": "Suburban Family Home",
      "location": "Phoenix, AZ",
      "price": 380000,
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1650,
      "type": "House",
      "image": "https://picsum.photos/400/300?random=6&keyword=suburban",
      "rating": 4.4,
      "agent": "Robert Miller",
      "status": "For Sale",
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    return properties.where((property) {
      bool matchesSearch = searchQuery.isEmpty ||
          property["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          property["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedPropertyType == "All" || property["type"] == selectedPropertyType;
      
      return matchesSearch && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Properties"),
        actions: [
          IconButton(
            icon: Icon(viewMode == "grid" ? Icons.list : Icons.grid_view),
            onPressed: () {
              viewMode = viewMode == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: viewMode == "grid" ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search properties...",
                  value: searchQuery,
                  hint: "Enter property name or location",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.tune,
                size: bs.sm,
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
                  label: "Sort by",
                  items: sortOptions,
                  value: selectedSort,
                  onChanged: (value, label) {
                    selectedSort = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Property Type",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Apartment", "value": "Apartment"},
                    {"label": "House", "value": "House"},
                    {"label": "Villa", "value": "Villa"},
                    {"label": "Commercial", "value": "Commercial"},
                  ],
                  value: selectedPropertyType,
                  onChanged: (value, label) {
                    selectedPropertyType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.all(0),
        minItemWidth: 280,
        children: filteredProperties.map((property) {
          return _buildPropertyGridCard(property);
        }).toList(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredProperties.length,
      itemBuilder: (context, index) {
        final property = filteredProperties[index];
        return _buildPropertyListCard(property);
      },
    );
  }

  Widget _buildPropertyGridCard(Map<String, dynamic> property) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
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
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: property["featured"] ? warningColor : successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    property["featured"] ? "Featured" : "${property["status"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: dangerColor,
                    size: 20,
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
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
                if (property["type"] != "Commercial") ...[
                  Row(
                    children: [
                      _buildPropertyFeature(Icons.bed, "${property["bedrooms"]}"),
                      SizedBox(width: spSm),
                      _buildPropertyFeature(Icons.bathroom, "${property["bathrooms"]}"),
                      SizedBox(width: spSm),
                      _buildPropertyFeature(Icons.square_foot, "${property["area"]} sqft"),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      _buildPropertyFeature(Icons.business, "${property["type"]}"),
                      SizedBox(width: spSm),
                      _buildPropertyFeature(Icons.square_foot, "${property["area"]} sqft"),
                    ],
                  ),
                ],
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      // --
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyListCard(Map<String, dynamic> property) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusSm),
                    bottomLeft: Radius.circular(radiusSm),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${property["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (property["featured"])
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Featured",
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${property["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: dangerColor,
                        size: 20,
                      ),
                    ],
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
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  if (property["type"] != "Commercial") ...[
                    Row(
                      children: [
                        _buildPropertyFeature(Icons.bed, "${property["bedrooms"]}"),
                        SizedBox(width: spSm),
                        _buildPropertyFeature(Icons.bathroom, "${property["bathrooms"]}"),
                        SizedBox(width: spSm),
                        _buildPropertyFeature(Icons.square_foot, "${property["area"]} sqft"),
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        _buildPropertyFeature(Icons.business, "${property["type"]}"),
                        SizedBox(width: spSm),
                        _buildPropertyFeature(Icons.square_foot, "${property["area"]} sqft"),
                      ],
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // --
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
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
                    ],
                  ),
                ],
              ),
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
}
