import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaVacancyManagementView extends StatefulWidget {
  const RmaVacancyManagementView({super.key});

  @override
  State<RmaVacancyManagementView> createState() => _RmaVacancyManagementViewState();
}

class _RmaVacancyManagementViewState extends State<RmaVacancyManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";

  List<Map<String, dynamic>> vacancies = [
    {
      "id": "VAC001",
      "property": "Sunset Villa #101",
      "address": "123 Sunset Blvd, Los Angeles",
      "type": "Apartment",
      "bedrooms": 2,
      "bathrooms": 2,
      "rent": 2500.0,
      "status": "Ready to Rent",
      "vacantSince": "2025-06-15",
      "lastTenant": "Emily Johnson",
      "reasonVacant": "Lease Ended",
      "daysVacant": 5,
      "image": "https://picsum.photos/300/200?random=601&keyword=apartment",
      "marketingStatus": "Listed",
      "showings": 8,
      "applications": 3,
      "monthlyLoss": 2500.0,
    },
    {
      "id": "VAC002",
      "property": "Ocean View #205",
      "address": "456 Ocean Ave, Santa Monica",
      "type": "Condo",
      "bedrooms": 3,
      "bathrooms": 2,
      "rent": 3200.0,
      "status": "Under Maintenance",
      "vacantSince": "2025-06-10",
      "lastTenant": "Michael Brown",
      "reasonVacant": "Tenant Moved",
      "daysVacant": 10,
      "image": "https://picsum.photos/300/200?random=602&keyword=condo",
      "marketingStatus": "Not Listed",
      "showings": 0,
      "applications": 0,
      "monthlyLoss": 3200.0,
    },
    {
      "id": "VAC003",
      "property": "Garden Court #12",
      "address": "789 Garden St, Beverly Hills",
      "type": "House",
      "bedrooms": 4,
      "bathrooms": 3,
      "rent": 4500.0,
      "status": "Ready to Rent",
      "vacantSince": "2025-06-08",
      "lastTenant": "Jessica Miller",
      "reasonVacant": "Eviction",
      "daysVacant": 12,
      "image": "https://picsum.photos/300/200?random=603&keyword=house",
      "marketingStatus": "Listed",
      "showings": 15,
      "applications": 7,
      "monthlyLoss": 4500.0,
    },
    {
      "id": "VAC004",
      "property": "Metro Heights #304",
      "address": "321 Metro Ave, Downtown",
      "type": "Studio",
      "bedrooms": 0,
      "bathrooms": 1,
      "rent": 1800.0,
      "status": "Needs Repair",
      "vacantSince": "2025-05-28",
      "lastTenant": "Robert Taylor",
      "reasonVacant": "Property Damage",
      "daysVacant": 23,
      "image": "https://picsum.photos/300/200?random=604&keyword=studio",
      "marketingStatus": "Not Listed",
      "showings": 0,
      "applications": 0,
      "monthlyLoss": 1800.0,
    },
    {
      "id": "VAC005",
      "property": "Riverside Loft #8",
      "address": "654 River Rd, Pasadena",
      "type": "Loft",
      "bedrooms": 2,
      "bathrooms": 2,
      "rent": 2800.0,
      "status": "Ready to Rent",
      "vacantSince": "2025-06-12",
      "lastTenant": "Amanda White",
      "reasonVacant": "Lease Ended",
      "daysVacant": 8,
      "image": "https://picsum.photos/300/200?random=605&keyword=loft",
      "marketingStatus": "Listed",
      "showings": 12,
      "applications": 5,
      "monthlyLoss": 2800.0,
    },
  ];

  List<Map<String, dynamic>> analytics = [
    {
      "title": "Total Vacant Units",
      "value": 15,
      "change": -8,
      "color": primaryColor,
      "icon": Icons.home_outlined,
    },
    {
      "title": "Average Days Vacant",
      "value": 11,
      "change": 15,
      "color": warningColor,
      "icon": Icons.schedule,
    },
    {
      "title": "Monthly Loss",
      "value": 42500,
      "change": -12,
      "color": dangerColor,
      "icon": Icons.money_off,
    },
    {
      "title": "Ready to Rent",
      "value": 8,
      "change": 20,
      "color": successColor,
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> strategies = [
    {
      "title": "Price Reduction",
      "description": "Consider reducing rent by 5-10% for units vacant over 30 days",
      "applicableUnits": 3,
      "potentialSavings": 2400.0,
      "icon": Icons.trending_down,
      "color": warningColor,
    },
    {
      "title": "Fast Track Maintenance",
      "description": "Prioritize repairs for high-demand properties",
      "applicableUnits": 2,
      "potentialSavings": 5000.0,
      "icon": Icons.build,
      "color": infoColor,
    },
    {
      "title": "Enhanced Marketing",
      "description": "Increase online presence and professional photography",
      "applicableUnits": 5,
      "potentialSavings": 3200.0,
      "icon": Icons.campaign,
      "color": primaryColor,
    },
    {
      "title": "Flexible Terms",
      "description": "Offer move-in incentives or flexible lease terms",
      "applicableUnits": 7,
      "potentialSavings": 4800.0,
      "icon": Icons.handshake,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Ready to Rent", "value": "Ready to Rent"},
    {"label": "Under Maintenance", "value": "Under Maintenance"},
    {"label": "Needs Repair", "value": "Needs Repair"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Apartment", "value": "Apartment"},
    {"label": "Condo", "value": "Condo"},
    {"label": "House", "value": "House"},
    {"label": "Studio", "value": "Studio"},
    {"label": "Loft", "value": "Loft"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ready to Rent':
        return successColor;
      case 'Under Maintenance':
        return warningColor;
      case 'Needs Repair':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMarketingColor(String marketing) {
    return marketing == 'Listed' ? infoColor : disabledBoldColor;
  }

  List<Map<String, dynamic>> _getFilteredVacancies() {
    return vacancies.where((vacancy) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${vacancy["property"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vacancy["address"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || vacancy["status"] == selectedStatus;
      bool matchesType = selectedType.isEmpty || vacancy["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Widget _buildVacanciesTab() {
    final filteredVacancies = _getFilteredVacancies();
    
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
                  label: "Search vacant properties...",
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
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Vacancies Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredVacancies.map((vacancy) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor("${vacancy["status"]}"),
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
                            "${vacancy["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          
                          // Days Vacant Badge
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (vacancy["daysVacant"] as int) > 14 ? dangerColor : warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${vacancy["daysVacant"]} days",
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
                            "${vacancy["property"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          // Address
                          Text(
                            "${vacancy["address"]}",
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
                              if ((vacancy["bedrooms"] as int) > 0) ...[
                                Icon(Icons.bed, size: 12, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "${vacancy["bedrooms"]}",
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
                                "${vacancy["bathrooms"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              Spacer(),
                              
                              Text(
                                "\$${((vacancy["rent"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Status and Marketing
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${vacancy["status"]}").withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${vacancy["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${vacancy["status"]}"),
                                  ),
                                ),
                              ),
                              
                              Spacer(),
                              
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getMarketingColor("${vacancy["marketingStatus"]}").withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${vacancy["marketingStatus"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getMarketingColor("${vacancy["marketingStatus"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Vacancy Details
                          Row(
                            children: [
                              Icon(Icons.person_off, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${vacancy["reasonVacant"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Since ${vacancy["vacantSince"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          // Marketing Stats (if listed)
                          if (vacancy["marketingStatus"] == "Listed") ...[
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.visibility, size: 12, color: infoColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${vacancy["showings"]} showings",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.description, size: 12, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${vacancy["applications"]} apps",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Monthly Loss
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Loss: \$${((vacancy["monthlyLoss"] as double)).currency}/month",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: vacancy["status"] == "Ready to Rent" ? "View Details" : "Manage",
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
                            color: (metric["change"] as int) <= 0 ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(metric["change"] as int) >= 0 ? '+' : ''}${metric["change"]}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as int) <= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      metric["title"] == "Monthly Loss" 
                          ? "\$${((metric["value"] as int).toDouble()).currency}"
                          : "${metric["value"]}${metric["title"] == "Average Days Vacant" ? " days" : ""}",
                      style: TextStyle(
                        fontSize: 20,
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
          
          // Vacancy Breakdown
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
                  "Vacancy Breakdown",
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
                          "0-7 days",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "2 units",
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
                          "8-14 days",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "2 units",
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
                          "15+ days",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        Text(
                          "1 unit",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
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

  Widget _buildStrategiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Fill Vacancy Strategies",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Recommended strategies to reduce vacancy time and maximize rental income",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Strategies Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: strategies.map((strategy) {
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
                    // Strategy Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (strategy["color"] as Color).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            strategy["icon"] as IconData,
                            size: 20,
                            color: strategy["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${strategy["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Description
                    Text(
                      "${strategy["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Stats
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${strategy["applicableUnits"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Applicable Units",
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
                                "\$${((strategy["potentialSavings"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Potential Savings",
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
                    
                    // Action Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Implement Strategy",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Actions
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Schedule Showings",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Update Listings",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Review Applications",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Generate Report",
                            size: bs.sm,
                            onPressed: () {},
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
      title: "Vacancy Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Vacant Units", icon: Icon(Icons.home_outlined)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Strategies", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildVacanciesTab(),
        _buildAnalyticsTab(),
        _buildStrategiesTab(),
      ],
    );
  }
}
