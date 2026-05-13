import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaEmergencyServicesView extends StatefulWidget {
  const MhaEmergencyServicesView({super.key});

  @override
  State<MhaEmergencyServicesView> createState() => _MhaEmergencyServicesViewState();
}

class _MhaEmergencyServicesViewState extends State<MhaEmergencyServicesView> {
  List<Map<String, dynamic>> emergencyServices = [
    {
      "id": 1,
      "name": "Emergency Medical Services",
      "category": "Medical",
      "phone": "911",
      "description": "Ambulance, paramedics, medical emergency response",
      "responseTime": "5-8 minutes",
      "isActive": true,
      "availability": "24/7",
      "icon": "medical_services",
      "color": "red",
      "address": "Citywide Response",
      "website": "www.emergency.gov",
    },
    {
      "id": 2,
      "name": "Fire Department",
      "category": "Fire & Rescue",
      "phone": "911",
      "description": "Fire suppression, rescue operations, hazmat response",
      "responseTime": "4-6 minutes",
      "isActive": true,
      "availability": "24/7",
      "icon": "local_fire_department",
      "color": "orange",
      "address": "Multiple stations citywide",
      "website": "www.firedepart.gov",
    },
    {
      "id": 3,
      "name": "Police Department",
      "category": "Law Enforcement",
      "phone": "911",
      "description": "Emergency law enforcement, crime response, public safety",
      "responseTime": "3-5 minutes",
      "isActive": true,
      "availability": "24/7",
      "icon": "local_police",
      "color": "blue",
      "address": "123 Police Plaza",
      "website": "www.police.gov",
    },
    {
      "id": 4,
      "name": "Poison Control Center",
      "category": "Medical",
      "phone": "1-800-222-1222",
      "description": "24/7 poison emergency hotline and guidance",
      "responseTime": "Immediate",
      "isActive": true,
      "availability": "24/7",
      "icon": "warning",
      "color": "purple",
      "address": "National Hotline",
      "website": "www.poison.org",
    },
    {
      "id": 5,
      "name": "Crisis Helpline",
      "category": "Mental Health",
      "phone": "988",
      "description": "Suicide prevention and mental health crisis support",
      "responseTime": "Immediate",
      "isActive": true,
      "availability": "24/7",
      "icon": "psychology",
      "color": "green",
      "address": "National Crisis Line",
      "website": "www.suicidepreventionlifeline.org",
    },
    {
      "id": 6,
      "name": "Coast Guard",
      "category": "Water Rescue",
      "phone": "1-800-835-5957",
      "description": "Marine emergency response and water rescue",
      "responseTime": "10-15 minutes",
      "isActive": true,
      "availability": "24/7",
      "icon": "waves",
      "color": "cyan",
      "address": "Marine Response Station",
      "website": "www.uscg.mil",
    },
    {
      "id": 7,
      "name": "Red Cross Emergency",
      "category": "Disaster Relief",
      "phone": "1-800-733-2767",
      "description": "Disaster relief, emergency shelter, family reunification",
      "responseTime": "30-60 minutes",
      "isActive": true,
      "availability": "24/7",
      "icon": "volunteer_activism",
      "color": "red",
      "address": "Regional Center",
      "website": "www.redcross.org",
    },
  ];

  String selectedCategory = "All";
  bool showFavoritesOnly = false;
  Set<int> favoriteServices = {1, 2, 3}; // Default favorites

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              _shareLocation();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuickDialSection(),
            _buildFilterSection(),
            _buildServicesList(),
            _buildEmergencyTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickDialSection() {
    var quickServices = emergencyServices.where((service) => 
      service["phone"] == "911" || favoriteServices.contains(service["id"])
    ).take(4).toList();

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.emergency, color: dangerColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Quick Emergency Dial",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: quickServices.map((service) {
              Color serviceColor = _getServiceColor(service["color"]);
              IconData serviceIcon = _getServiceIcon(service["icon"]);
              
              return GestureDetector(
                onTap: () => _makeEmergencyCall(service),
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: serviceColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: serviceColor.withAlpha(40)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        serviceIcon,
                        color: serviceColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${service["phone"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: serviceColor,
                        ),
                      ),
                      Text(
                        "${service["name"]}",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      spacing: spSm,
      children: [
        QDropdownField(
          label: "Service Category",
          items: [
            {"label": "All Services", "value": "All"},
            {"label": "Medical", "value": "Medical"},
            {"label": "Fire & Rescue", "value": "Fire & Rescue"},
            {"label": "Law Enforcement", "value": "Law Enforcement"},
            {"label": "Mental Health", "value": "Mental Health"},
            {"label": "Water Rescue", "value": "Water Rescue"},
            {"label": "Disaster Relief", "value": "Disaster Relief"},
          ],
          value: selectedCategory,
          onChanged: (value, label) {
            selectedCategory = value;
            setState(() {});
          },
        ),
        QSwitch(
          items: [
            {
              "label": "Show Favorites Only",
              "value": true,
              "checked": showFavoritesOnly,
            }
          ],
          value: [if (showFavoritesOnly) {"label": "Show Favorites Only", "value": true, "checked": true}],
          onChanged: (values, ids) {
            showFavoritesOnly = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildServicesList() {
    var filteredServices = emergencyServices;
    
    if (selectedCategory != "All") {
      filteredServices = emergencyServices.where((service) => 
        service["category"] == selectedCategory
      ).toList();
    }
    
    if (showFavoritesOnly) {
      filteredServices = filteredServices.where((service) => 
        favoriteServices.contains(service["id"])
      ).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Emergency Services Directory",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredServices.map((service) => _buildServiceItem(service)).toList(),
      ],
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service) {
    Color serviceColor = _getServiceColor(service["color"]);
    IconData serviceIcon = _getServiceIcon(service["icon"]);
    bool isFavorite = favoriteServices.contains(service["id"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: serviceColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: serviceColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  serviceIcon,
                  color: serviceColor,
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
                        Expanded(
                          child: Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (isFavorite) {
                              favoriteServices.remove(service["id"]);
                            } else {
                              favoriteServices.add(service["id"]);
                            }
                            setState(() {});
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? dangerColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: serviceColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${service["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: serviceColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${service["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${service["phone"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: successColor.withAlpha(40)),
                      ),
                      child: Text(
                        "${service["availability"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Response Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${service["responseTime"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
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
                            "Location",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${service["address"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (service["website"].toString().isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.language, size: 16, color: infoColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${service["website"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call Now",
                  size: bs.sm,
                  onPressed: () => _makeEmergencyCall(service),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Get Directions",
                  size: bs.sm,
                  onPressed: () => _getDirections(service),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyTips() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.lightbulb, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Emergency Preparedness Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          _buildTipItem("Stay calm and speak clearly when calling emergency services"),
          _buildTipItem("Know your exact location and nearest cross streets"),
          _buildTipItem("Keep emergency numbers saved in your phone contacts"),
          _buildTipItem("Have a family emergency plan and meeting point"),
          _buildTipItem("Keep emergency supplies: water, flashlight, first aid kit"),
          _buildTipItem("Learn basic first aid and CPR techniques"),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Full Emergency Guide",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: warningColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Color _getServiceColor(String colorName) {
    switch (colorName) {
      case "red": return dangerColor;
      case "orange": return warningColor;
      case "blue": return primaryColor;
      case "purple": return Color(0xFF9C27B0);
      case "green": return successColor;
      case "cyan": return infoColor;
      default: return primaryColor;
    }
  }

  IconData _getServiceIcon(String iconName) {
    switch (iconName) {
      case "medical_services": return Icons.medical_services;
      case "local_fire_department": return Icons.local_fire_department;
      case "local_police": return Icons.local_police;
      case "warning": return Icons.warning;
      case "psychology": return Icons.psychology;
      case "waves": return Icons.waves;
      case "volunteer_activism": return Icons.volunteer_activism;
      default: return Icons.emergency;
    }
  }

  void _makeEmergencyCall(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Emergency Call"),
        content: Text("Calling ${service["name"]} at ${service["phone"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Calling ${service["phone"]}...");
              // Implementation for making phone call
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: dangerColor,
              foregroundColor: Colors.white,
            ),
            child: Text("Call Now"),
          ),
        ],
      ),
    );
  }

  void _getDirections(Map<String, dynamic> service) {
    ss("Getting directions to ${service["name"]}...");
    // Implementation for getting directions
  }

  void _shareLocation() {
    ss("Sharing current location with emergency services...");
    // Implementation for sharing location
  }
}
