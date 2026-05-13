import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEventTypeSelectionView extends StatefulWidget {
  const EcmEventTypeSelectionView({super.key});

  @override
  State<EcmEventTypeSelectionView> createState() => _EcmEventTypeSelectionViewState();
}

class _EcmEventTypeSelectionViewState extends State<EcmEventTypeSelectionView> {
  String selectedType = "";
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedFormat = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Business", "value": "Business"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Education", "value": "Education"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Entertainment", "value": "Entertainment"},
  ];
  
  List<Map<String, dynamic>> formatOptions = [
    {"label": "All Formats", "value": "All"},
    {"label": "In-Person", "value": "In-Person"},
    {"label": "Virtual", "value": "Virtual"},
    {"label": "Hybrid", "value": "Hybrid"},
  ];

  List<Map<String, dynamic>> eventTypes = [
    {
      "id": "conference",
      "title": "Conference",
      "description": "Large-scale professional gatherings with multiple speakers and sessions",
      "icon": Icons.people,
      "category": "Business",
      "format": "In-Person",
      "duration": "1-3 days",
      "capacity": "100-1000+ attendees",
      "features": ["Keynote speakers", "Breakout sessions", "Networking", "Exhibition"],
      "isPopular": true,
    },
    {
      "id": "workshop",
      "title": "Workshop",
      "description": "Interactive learning sessions focused on hands-on experience",
      "icon": Icons.build,
      "category": "Education",
      "format": "In-Person",
      "duration": "2-8 hours",
      "capacity": "10-50 attendees",
      "features": ["Hands-on activities", "Small groups", "Practical skills", "Interactive"],
      "isPopular": true,
    },
    {
      "id": "seminar",
      "title": "Seminar",
      "description": "Educational presentations by experts in specific fields",
      "icon": Icons.school,
      "category": "Education",
      "format": "In-Person",
      "duration": "1-4 hours",
      "capacity": "20-100 attendees",
      "features": ["Expert speakers", "Q&A sessions", "Educational content", "Professional development"],
      "isPopular": true,
    },
    {
      "id": "webinar",
      "title": "Webinar",
      "description": "Online seminars and presentations for remote audiences",
      "icon": Icons.videocam,
      "category": "Technology",
      "format": "Virtual",
      "duration": "30 minutes - 2 hours",
      "capacity": "10-10,000+ attendees",
      "features": ["Live streaming", "Chat interaction", "Screen sharing", "Recording"],
      "isPopular": true,
    },
    {
      "id": "networking",
      "title": "Networking Event",
      "description": "Professional meetups focused on building business relationships",
      "icon": Icons.connect_without_contact,
      "category": "Business",
      "format": "In-Person",
      "duration": "2-4 hours",
      "capacity": "20-200 attendees",
      "features": ["Business cards exchange", "Casual conversations", "Refreshments", "Industry connections"],
      "isPopular": false,
    },
    {
      "id": "tradeshow",
      "title": "Trade Show",
      "description": "Industry exhibitions showcasing products and services",
      "icon": Icons.store,
      "category": "Business",
      "format": "In-Person",
      "duration": "1-5 days",
      "capacity": "500-50,000+ attendees",
      "features": ["Exhibition booths", "Product demos", "Business meetings", "Industry showcase"],
      "isPopular": false,
    },
    {
      "id": "meetup",
      "title": "Meetup",
      "description": "Informal gatherings of people with shared interests",
      "icon": Icons.group,
      "category": "Entertainment",
      "format": "In-Person",
      "duration": "1-3 hours",
      "capacity": "5-100 attendees",
      "features": ["Casual atmosphere", "Shared interests", "Community building", "Regular meetings"],
      "isPopular": false,
    },
    {
      "id": "summit",
      "title": "Summit",
      "description": "High-level meetings of industry leaders and decision makers",
      "icon": Icons.business_center,
      "category": "Business",
      "format": "In-Person",
      "duration": "1-2 days",
      "capacity": "50-500 attendees",
      "features": ["Industry leaders", "Strategic discussions", "Policy making", "High-level networking"],
      "isPopular": false,
    },
  ];

  List<Map<String, dynamic>> get filteredEventTypes {
    return eventTypes.where((type) {
      final matchesSearch = searchQuery.isEmpty ||
          type["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          type["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory == "All" || type["category"] == selectedCategory;
      final matchesFormat = selectedFormat == "All" || type["format"] == selectedFormat;
      
      return matchesSearch && matchesCategory && matchesFormat;
    }).toList();
  }

  List<Map<String, dynamic>> get popularEventTypes {
    return eventTypes.where((type) => type["isPopular"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Event Type"),
        actions: [
          QButton(
            label: "Continue",
            size: bs.sm,
            onPressed: selectedType.isNotEmpty ? _continueToNextStep : null,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchAndFilters(),
            _buildPopularTypesSection(),
            _buildAllTypesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Event Types",
            value: searchQuery,
            hint: "Search by name or description",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Format",
                  items: formatOptions,
                  value: selectedFormat,
                  onChanged: (value, label) {
                    selectedFormat = value;
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

  Widget _buildPopularTypesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: warningColor,
              size: 20,
            ),
            SizedBox(width: spXs),
            Text(
              "Popular Event Types",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: popularEventTypes.map((type) => _buildEventTypeCardHorizontal(type)).toList(),
        ),
      ],
    );
  }

  Widget _buildAllTypesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Event Types (${filteredEventTypes.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredEventTypes.map((type) => _buildEventTypeCard(type)),
      ],
    );
  }

  Widget _buildEventTypeCardHorizontal(Map<String, dynamic> type) {
    final isSelected = selectedType == type["id"];
    
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  type["icon"],
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${type["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${type["category"]} • ${type["format"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (type["isPopular"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${type["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${type["duration"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${type["capacity"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QButton(
            label: isSelected ? "Selected" : "Select",
            size: bs.sm,
            onPressed: () => _selectEventType(type["id"]),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTypeCard(Map<String, dynamic> type) {
    final isSelected = selectedType == type["id"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  type["icon"],
                  color: primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${type["title"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (type["isPopular"] == true) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Popular",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${type["category"]} • ${type["format"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: isSelected ? "Selected" : "Select",
                size: bs.sm,
                onPressed: () => _selectEventType(type["id"]),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${type["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${type["duration"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spMd),
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${type["capacity"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (type["features"] as List).map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Text(
                  "$feature",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _selectEventType(String typeId) {
    selectedType = typeId;
    setState(() {});
  }

  void _continueToNextStep() {
    if (selectedType.isNotEmpty) {
      ss("Event type selected: $selectedType");
    }
  }
}
