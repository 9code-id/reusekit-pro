import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaMultiLocationView extends StatefulWidget {
  const FmaMultiLocationView({super.key});

  @override
  State<FmaMultiLocationView> createState() => _FmaMultiLocationViewState();
}

class _FmaMultiLocationViewState extends State<FmaMultiLocationView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedRegion = "";
  
  List<Map<String, dynamic>> locations = [
    {
      "id": "LOC001",
      "name": "Downtown Store",
      "address": "123 Main Street, Downtown",
      "manager": "John Smith",
      "status": "Active",
      "region": "North",
      "revenue": 125000.0,
      "employees": 12,
      "openDate": "2020-01-15",
      "rating": 4.8,
      "performance": 95,
      "phone": "+1 (555) 123-4567",
      "image": "https://picsum.photos/400/300?random=1&keyword=store"
    },
    {
      "id": "LOC002", 
      "name": "Mall Location",
      "address": "456 Shopping Center, Mall District",
      "manager": "Sarah Johnson",
      "status": "Active",
      "region": "South",
      "revenue": 98000.0,
      "employees": 8,
      "openDate": "2019-06-20",
      "rating": 4.6,
      "performance": 88,
      "phone": "+1 (555) 234-5678",
      "image": "https://picsum.photos/400/300?random=2&keyword=retail"
    },
    {
      "id": "LOC003",
      "name": "Airport Terminal",
      "address": "789 Airport Drive, Terminal 2",
      "manager": "Mike Davis",
      "status": "Under Renovation",
      "region": "Central",
      "revenue": 156000.0,
      "employees": 15,
      "openDate": "2018-03-10",
      "rating": 4.2,
      "performance": 76,
      "phone": "+1 (555) 345-6789",
      "image": "https://picsum.photos/400/300?random=3&keyword=airport"
    },
    {
      "id": "LOC004",
      "name": "Suburban Branch",
      "address": "321 Oak Avenue, Suburban Area",
      "manager": "Lisa Wilson",
      "status": "Active",
      "region": "West",
      "revenue": 87000.0,
      "employees": 6,
      "openDate": "2021-09-05",
      "rating": 4.9,
      "performance": 92,
      "phone": "+1 (555) 456-7890",
      "image": "https://picsum.photos/400/300?random=4&keyword=suburban"
    },
    {
      "id": "LOC005",
      "name": "City Center",
      "address": "654 Business District, City Center",
      "manager": "Robert Brown",
      "status": "Temporary Closed",
      "region": "Central",
      "revenue": 143000.0,
      "employees": 18,
      "openDate": "2017-11-12",
      "rating": 4.4,
      "performance": 82,
      "phone": "+1 (555) 567-8901",
      "image": "https://picsum.photos/400/300?random=5&keyword=business"
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Under Renovation", "value": "Under Renovation"},
    {"label": "Temporary Closed", "value": "Temporary Closed"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "All Regions", "value": ""},
    {"label": "North", "value": "North"},
    {"label": "South", "value": "South"},
    {"label": "East", "value": "East"},
    {"label": "West", "value": "West"},
    {"label": "Central", "value": "Central"},
  ];

  List<Map<String, dynamic>> get filteredLocations {
    return locations.where((location) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${location["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${location["manager"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${location["address"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || location["status"] == selectedStatus;
      bool matchesRegion = selectedRegion.isEmpty || location["region"] == selectedRegion;
      
      return matchesSearch && matchesStatus && matchesRegion;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Under Renovation":
        return warningColor;
      case "Temporary Closed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Multi-Location Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Locations", icon: Icon(Icons.location_on)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Performance", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildLocationsTab(),
        _buildAnalyticsTab(),
        _buildPerformanceTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double totalRevenue = locations.fold(0.0, (sum, location) => sum + (location["revenue"] as double));
    int totalEmployees = locations.fold(0, (sum, location) => sum + (location["employees"] as int));
    int activeLocations = locations.where((loc) => loc["status"] == "Active").length;
    double avgRating = locations.fold(0.0, (sum, location) => sum + (location["rating"] as double)) / locations.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                primaryColor,
              ),
              _buildOverviewCard(
                "Active Locations",
                "$activeLocations",
                Icons.store,
                successColor,
              ),
              _buildOverviewCard(
                "Total Employees", 
                "$totalEmployees",
                Icons.people,
                infoColor,
              ),
              _buildOverviewCard(
                "Average Rating",
                "${avgRating.toStringAsFixed(1)}★",
                Icons.star,
                warningColor,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Regional Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: regionOptions.skip(1).map((region) {
                    int count = locations.where((loc) => loc["region"] == region["value"]).length;
                    double percentage = count / locations.length * 100;
                    
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${region["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: percentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "$count",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search locations...",
                      value: searchQuery,
                      hint: "Search by name, manager, or address",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Status",
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
                      label: "Filter by Region",
                      items: regionOptions,
                      value: selectedRegion,
                      onChanged: (value, label) {
                        selectedRegion = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredLocations.length,
            itemBuilder: (context, index) {
              final location = filteredLocations[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
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
                        "${location["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${location["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
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
                                  color: _getStatusColor(location["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${location["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(location["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${location["address"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${location["manager"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.phone,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${location["phone"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 16,
                                      color: successColor,
                                    ),
                                    Text(
                                      "\$${(location["revenue"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  Text(
                                    "${location["rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    List<Map<String, dynamic>> analyticsData = [
      {"month": "Jan", "revenue": 45000.0, "locations": 3},
      {"month": "Feb", "revenue": 52000.0, "locations": 4},
      {"month": "Mar", "revenue": 48000.0, "locations": 4},
      {"month": "Apr", "revenue": 61000.0, "locations": 5},
      {"month": "May", "revenue": 58000.0, "locations": 5},
      {"month": "Jun", "revenue": 64000.0, "locations": 5},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Revenue Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: analyticsData.map((data) {
                      double maxRevenue = analyticsData.map((d) => d["revenue"] as double).reduce((a, b) => a > b ? a : b);
                      double height = ((data["revenue"] as double) / maxRevenue) * 150;
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((data["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: 30,
                            height: height,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${data["month"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard(
                "Best Performing Location",
                "Downtown Store",
                "\$${(125000.0).currency}",
                Icons.trending_up,
                successColor,
              ),
              _buildAnalyticsCard(
                "Highest Rated Location",
                "Suburban Branch",
                "4.9★ Rating",
                Icons.star,
                warningColor,
              ),
              _buildAnalyticsCard(
                "Most Employees",
                "City Center",
                "18 Employees",
                Icons.people,
                infoColor,
              ),
              _buildAnalyticsCard(
                "Newest Location",
                "Suburban Branch",
                "Sep 2021",
                Icons.new_releases,
                primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: locations.map((location) {
                    Color performanceColor = (location["performance"] as int) >= 90 
                        ? successColor 
                        : (location["performance"] as int) >= 75 
                            ? warningColor 
                            : dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: performanceColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: performanceColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${location["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${location["manager"]} • ${location["region"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (location["performance"] as int) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: performanceColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${location["performance"]}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: performanceColor,
                                      ),
                                    ),
                                  ],
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
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildPerformanceCard(
                "Top Performer",
                "Downtown Store",
                "95% Performance",
                Icons.emoji_events,
                successColor,
              ),
              _buildPerformanceCard(
                "Needs Attention",
                "Airport Terminal",
                "76% Performance",
                Icons.warning,
                warningColor,
              ),
              _buildPerformanceCard(
                "Average Performance",
                "All Locations",
                "86% Average",
                Icons.analytics,
                infoColor,
              ),
              _buildPerformanceCard(
                "Improvement Goal",
                "Target 2024",
                "90% Target",
                Icons.flag,
                primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
