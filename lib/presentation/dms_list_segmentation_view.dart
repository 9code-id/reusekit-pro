import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsListSegmentationView extends StatefulWidget {
  const DmsListSegmentationView({super.key});

  @override
  State<DmsListSegmentationView> createState() => _DmsListSegmentationViewState();
}

class _DmsListSegmentationViewState extends State<DmsListSegmentationView> {
  String selectedTab = "all";
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  bool isCreatingSegment = false;
  String segmentName = "";
  String segmentDescription = "";
  String segmentType = "behavioral";
  List<String> selectedCriteria = [];

  List<Map<String, dynamic>> segments = [
    {
      "id": "seg_001",
      "name": "High Value Customers",
      "description": "Customers with purchase value > \$500",
      "type": "behavioral",
      "subscribers": 2847,
      "criteria": ["Purchase value > \$500", "Active in last 30 days"],
      "status": "active",
      "engagement_rate": 78.5,
      "conversion_rate": 12.3,
      "created_date": "2024-01-15",
      "last_updated": "2024-03-15",
      "color": "#4CAF50"
    },
    {
      "id": "seg_002", 
      "name": "Recent Subscribers",
      "description": "Subscribers joined in last 7 days",
      "type": "demographic",
      "subscribers": 534,
      "criteria": ["Subscribed in last 7 days", "No purchases yet"],
      "status": "active",
      "engagement_rate": 65.2,
      "conversion_rate": 8.7,
      "created_date": "2024-03-10",
      "last_updated": "2024-03-18",
      "color": "#2196F3"
    },
    {
      "id": "seg_003",
      "name": "Cart Abandoners",
      "description": "Users who abandoned cart in last 24h",
      "type": "behavioral",
      "subscribers": 1245,
      "criteria": ["Added to cart", "No purchase in 24h", "Still active"],
      "status": "active",
      "engagement_rate": 45.8,
      "conversion_rate": 15.6,
      "created_date": "2024-02-20",
      "last_updated": "2024-03-18",
      "color": "#FF9800"
    },
    {
      "id": "seg_004",
      "name": "Geographic: New York",
      "description": "Subscribers from New York region",
      "type": "geographic",
      "subscribers": 3421,
      "criteria": ["Location: New York", "Active subscription"],
      "status": "active",
      "engagement_rate": 82.1,
      "conversion_rate": 14.2,
      "created_date": "2024-01-05",
      "last_updated": "2024-03-17",
      "color": "#9C27B0"
    },
    {
      "id": "seg_005",
      "name": "Inactive Users",
      "description": "No engagement in last 90 days",
      "type": "behavioral",
      "subscribers": 892,
      "criteria": ["No opens in 90 days", "No clicks in 90 days"],
      "status": "paused",
      "engagement_rate": 12.4,
      "conversion_rate": 2.1,
      "created_date": "2024-01-30",
      "last_updated": "2024-03-15",
      "color": "#757575"
    }
  ];

  List<Map<String, dynamic>> segmentTypes = [
    {"label": "Behavioral", "value": "behavioral"},
    {"label": "Demographic", "value": "demographic"},
    {"label": "Geographic", "value": "geographic"},
    {"label": "Psychographic", "value": "psychographic"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Paused", "value": "paused"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Behavioral", "value": "behavioral"},
    {"label": "Demographic", "value": "demographic"},
    {"label": "Geographic", "value": "geographic"},
    {"label": "Psychographic", "value": "psychographic"},
  ];

  List<Map<String, dynamic>> criteriaOptions = [
    {"label": "Purchase value > \$100", "value": "purchase_100"},
    {"label": "Purchase value > \$500", "value": "purchase_500"},
    {"label": "Active in last 30 days", "value": "active_30"},
    {"label": "Active in last 7 days", "value": "active_7"},
    {"label": "Subscribed in last 7 days", "value": "subscribed_7"},
    {"label": "No purchases yet", "value": "no_purchase"},
    {"label": "Added to cart", "value": "cart_add"},
    {"label": "No purchase in 24h", "value": "no_purchase_24h"},
    {"label": "Location: New York", "value": "location_ny"},
    {"label": "Location: California", "value": "location_ca"},
    {"label": "Age: 25-35", "value": "age_25_35"},
    {"label": "Age: 35-45", "value": "age_35_45"},
    {"label": "No opens in 90 days", "value": "no_opens_90"},
    {"label": "No clicks in 90 days", "value": "no_clicks_90"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Segmentation"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              isCreatingSegment = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildMetricsCards(),
            _buildFilters(),
            if (isCreatingSegment) _buildCreateSegmentForm(),
            _buildSegmentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.segment,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Audience Segmentation",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Create targeted segments for personalized campaigns",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildMetricCard(
          "Total Segments",
          "${segments.length}",
          Icons.pie_chart,
          primaryColor,
        ),
        _buildMetricCard(
          "Active Segments",
          "${segments.where((s) => s["status"] == "active").length}",
          Icons.check_circle,
          successColor,
        ),
        _buildMetricCard(
          "Total Subscribers",
          "${segments.fold(0, (sum, s) => sum + (s["subscribers"] as int)).toString()}",
          Icons.people,
          infoColor,
        ),
        _buildMetricCard(
          "Avg Engagement",
          "${(segments.fold(0.0, (sum, s) => sum + (s["engagement_rate"] as double)) / segments.length).toStringAsFixed(1)}%",
          Icons.trending_up,
          warningColor,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
          Text(
            "Filter Segments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search segments",
                  value: searchQuery,
                  hint: "Search by name or description",
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
                onPressed: () {
                  si("Searching segments...");
                },
              ),
            ],
          ),
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
        ],
      ),
    );
  }

  Widget _buildCreateSegmentForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Create New Segment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  isCreatingSegment = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Segment Name",
            value: segmentName,
            hint: "Enter segment name",
            onChanged: (value) {
              segmentName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: segmentDescription,
            hint: "Describe your segment criteria",
            onChanged: (value) {
              segmentDescription = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Segment Type",
            items: segmentTypes,
            value: segmentType,
            onChanged: (value, label) {
              segmentType = value;
              setState(() {});
            },
          ),
          QCategoryPicker(
            label: "Segmentation Criteria",
            items: criteriaOptions,
            value: selectedCriteria.isNotEmpty ? selectedCriteria.first : "",
            onChanged: (index, label, value, item) {
              if (!selectedCriteria.contains(value)) {
                selectedCriteria.add(value);
                setState(() {});
              }
            },
          ),
          if (selectedCriteria.isNotEmpty) ...[
            Text(
              "Selected Criteria:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: selectedCriteria.map((criteria) {
                final criteriaLabel = criteriaOptions
                    .firstWhere((c) => c["value"] == criteria)["label"];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        criteriaLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          selectedCriteria.remove(criteria);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          size: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    isCreatingSegment = false;
                    segmentName = "";
                    segmentDescription = "";
                    selectedCriteria.clear();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Segment",
                  size: bs.sm,
                  onPressed: () {
                    if (segmentName.isNotEmpty && selectedCriteria.isNotEmpty) {
                      ss("Segment created successfully!");
                      isCreatingSegment = false;
                      segmentName = "";
                      segmentDescription = "";
                      selectedCriteria.clear();
                      setState(() {});
                    } else {
                      se("Please fill in required fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentsList() {
    var filteredSegments = segments.where((segment) {
      bool matchesSearch = searchQuery.isEmpty ||
          segment["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          segment["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || segment["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || segment["type"] == selectedType;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Segments (${filteredSegments.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  color: disabledBoldColor,
                  onPressed: () {
                    si("Refreshing segments...");
                  },
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredSegments.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final segment = filteredSegments[index];
              return _buildSegmentItem(segment);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentItem(Map<String, dynamic> segment) {
    Color statusColor = segment["status"] == "active" ? successColor : 
                       segment["status"] == "paused" ? warningColor : disabledBoldColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(int.parse(segment["color"].replaceAll("#", "0xFF"))),
                  borderRadius: BorderRadius.circular(radiusXs),
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
                          segment["name"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${segment["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          color: disabledBoldColor,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      segment["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildSegmentStat("Subscribers", "${segment["subscribers"]}", Icons.people),
              SizedBox(width: spMd),
              _buildSegmentStat("Engagement", "${segment["engagement_rate"]}%", Icons.trending_up),
              SizedBox(width: spMd),
              _buildSegmentStat("Conversion", "${segment["conversion_rate"]}%", Icons.monetization_on),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Criteria:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (segment["criteria"] as List).map<Widget>((criteria) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      criteria,
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  icon: Icons.edit,
                  size: bs.sm,
                  color: infoColor,
                  onPressed: () {
                    si("Opening segment editor...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View List",
                  icon: Icons.list,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening subscriber list...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Campaign",
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    si("Creating campaign for segment...");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentStat(String label, String value, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
