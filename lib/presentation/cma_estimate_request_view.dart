import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaEstimateRequestView extends StatefulWidget {
  const CmaEstimateRequestView({super.key});

  @override
  State<CmaEstimateRequestView> createState() => _CmaEstimateRequestViewState();
}

class _CmaEstimateRequestViewState extends State<CmaEstimateRequestView> {
  int currentTab = 0;
  
  // Form fields
  String vehicleMake = "";
  String vehicleModel = "";
  String vehicleYear = "";
  String vehicleMileage = "";
  String serviceType = "";
  String problemDescription = "";
  String urgencyLevel = "";
  String preferredDate = "";
  String customerName = "";
  String customerPhone = "";
  String customerEmail = "";
  String customerAddress = "";
  List<String> attachments = [];

  List<Map<String, dynamic>> serviceTypes = [
    {"label": "Engine Repair", "value": "engine_repair"},
    {"label": "Transmission Service", "value": "transmission"},
    {"label": "Brake Repair", "value": "brake_repair"},
    {"label": "A/C Repair", "value": "ac_repair"},
    {"label": "Electrical Issues", "value": "electrical"},
    {"label": "Suspension Repair", "value": "suspension"},
    {"label": "Body Work", "value": "body_work"},
    {"label": "Tire Service", "value": "tire_service"},
    {"label": "Oil Change", "value": "oil_change"},
    {"label": "General Maintenance", "value": "maintenance"},
    {"label": "Diagnostic", "value": "diagnostic"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> urgencyLevels = [
    {"label": "Not Urgent - Within 2 weeks", "value": "low"},
    {"label": "Moderate - Within 1 week", "value": "medium"},
    {"label": "Urgent - Within 3 days", "value": "high"},
    {"label": "Emergency - ASAP", "value": "emergency"},
  ];

  List<Map<String, dynamic>> estimates = [
    {
      "id": "EST-001",
      "date": "2024-12-15",
      "vehicle": "2018 Honda Civic",
      "service": "Brake Repair",
      "status": "Completed",
      "estimatedCost": 450.00,
      "finalCost": 425.00,
      "shopName": "Downtown Auto Repair",
      "shopRating": 4.8,
      "responseTime": "2 hours",
      "description": "Complete brake pad replacement and rotor resurfacing",
    },
    {
      "id": "EST-002",
      "date": "2024-12-12",
      "vehicle": "2020 Toyota Camry",
      "service": "Engine Diagnostic",
      "status": "Pending",
      "estimatedCost": 125.00,
      "finalCost": null,
      "shopName": "North Side Auto Care",
      "shopRating": 4.6,
      "responseTime": "4 hours",
      "description": "Check engine light diagnostic and repair estimate",
    },
    {
      "id": "EST-003",
      "date": "2024-12-10",
      "vehicle": "2019 Ford F-150",
      "service": "A/C Repair",
      "status": "In Review",
      "estimatedCost": 275.00,
      "finalCost": null,
      "shopName": "South End Garage",
      "shopRating": 4.7,
      "responseTime": "1 hour",
      "description": "A/C compressor replacement and system recharge",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Estimates",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "New Request", icon: Icon(Icons.add_circle)),
        Tab(text: "My Estimates", icon: Icon(Icons.receipt_long)),
        Tab(text: "Find Shops", icon: Icon(Icons.location_on)),
      ],
      tabChildren: [
        _buildNewRequestTab(),
        _buildMyEstimatesTab(),
        _buildFindShopsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildNewRequestTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Get Free Estimates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Submit your vehicle service request and receive estimates from qualified local auto shops. No obligation required.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Vehicle Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vehicle Information",
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
                        label: "Year",
                        value: vehicleYear,
                        hint: "2020",
                        onChanged: (value) {
                          vehicleYear = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      flex: 2,
                      child: QTextField(
                        label: "Make",
                        value: vehicleMake,
                        hint: "Honda",
                        onChanged: (value) {
                          vehicleMake = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Model",
                  value: vehicleModel,
                  hint: "Civic",
                  onChanged: (value) {
                    vehicleModel = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Mileage",
                  value: vehicleMileage,
                  hint: "75,000",
                  onChanged: (value) {
                    vehicleMileage = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Service Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Service Type",
                  items: serviceTypes,
                  value: serviceType,
                  onChanged: (value, label) {
                    serviceType = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Problem Description",
                  value: problemDescription,
                  hint: "Describe the issue in detail. Include any symptoms, noises, or recent problems...",
                  onChanged: (value) {
                    problemDescription = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Urgency Level",
                  items: urgencyLevels,
                  value: urgencyLevel,
                  onChanged: (value, label) {
                    urgencyLevel = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Preferred Date",
                  value: preferredDate,
                  hint: "When would you like the service?",
                  onChanged: (value) {
                    preferredDate = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Photos & Documents
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Photos & Documents",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Upload photos of the problem area or any relevant documents",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QMultiImagePicker(
                  label: "Attach Photos",
                  value: attachments,
                  maxImages: 5,
                  hint: "Take photos of the problem area",
                  onChanged: (value) {
                    attachments = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Contact Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
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
                QTextField(
                  label: "Full Name",
                  value: customerName,
                  hint: "Your full name",
                  onChanged: (value) {
                    customerName = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Phone",
                        value: customerPhone,
                        hint: "(555) 123-4567",
                        onChanged: (value) {
                          customerPhone = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Email",
                        value: customerEmail,
                        hint: "your@email.com",
                        onChanged: (value) {
                          customerEmail = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QMemoField(
                  label: "Address",
                  value: customerAddress,
                  hint: "Your address for service location preference",
                  onChanged: (value) {
                    customerAddress = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Submit Button
          QButton(
            label: "Submit Estimate Request",
            size: bs.md,
            onPressed: _canSubmit() ? _submitRequest : null,
          ),
        ],
      ),
    );
  }

  Widget _buildMyEstimatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Estimate Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (estimates.isEmpty)
            Center(
              child: Column(
                spacing: spMd,
                children: [
                  SizedBox(height: 100),
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: disabledBoldColor,
                  ),
                  Text(
                    "No estimates yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Submit a new estimate request to get started",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "New Request",
                    size: bs.sm,
                    onPressed: () {
                      currentTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          else
            ...estimates.map((estimate) {
              Color statusColor = estimate["status"] == "Completed" ? successColor :
                                 estimate["status"] == "Pending" ? warningColor : infoColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${estimate["id"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${estimate["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "${estimate["vehicle"]} - ${estimate["service"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    Text(
                      "${estimate["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    Row(
                      children: [
                        Icon(Icons.business, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${estimate["shopName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          "${estimate["shopRating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Response time: ${estimate["responseTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${estimate["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Estimated Cost:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(estimate["estimatedCost"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        if (estimate["finalCost"] != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Final Cost:",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(estimate["finalCost"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            QButton(
                              label: "Details",
                              size: bs.sm,
                              onPressed: () => _showEstimateDetails(estimate),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              label: "Contact",
                              size: bs.sm,
                              onPressed: () => _contactShop(estimate),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildFindShopsTab() {
    List<Map<String, dynamic>> shops = [
      {
        "name": "Downtown Auto Repair",
        "address": "123 Main St, Downtown",
        "phone": "(555) 123-4567",
        "rating": 4.8,
        "reviews": 156,
        "specialties": ["Engine", "Brake", "Transmission"],
        "hours": "Mon-Fri: 7AM-6PM",
        "image": "https://picsum.photos/300/200?random=1&keyword=garage",
        "priceRange": "\$\$",
        "responseTime": "Usually responds within 2 hours",
      },
      {
        "name": "North Side Auto Care",
        "address": "456 North Ave, Northside",
        "phone": "(555) 234-5678",
        "rating": 4.6,
        "reviews": 89,
        "specialties": ["Electrical", "A/C", "Diagnostic"],
        "hours": "Mon-Fri: 8AM-7PM",
        "image": "https://picsum.photos/300/200?random=2&keyword=workshop",
        "priceRange": "\$\$\$",
        "responseTime": "Usually responds within 4 hours",
      },
      {
        "name": "South End Garage",
        "address": "789 South Blvd, Southend",
        "phone": "(555) 345-6789",
        "rating": 4.7,
        "reviews": 203,
        "specialties": ["Body Work", "Paint", "Collision"],
        "hours": "Mon-Sat: 7AM-6PM",
        "image": "https://picsum.photos/300/200?random=3&keyword=mechanic",
        "priceRange": "\$\$",
        "responseTime": "Usually responds within 1 hour",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Local Auto Shops",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Text(
            "Browse qualified auto shops in your area",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          ...shops.map((shop) => Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${shop["image"]}",
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${shop["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${shop["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " (${shop["reviews"]} reviews)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${shop["priceRange"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${shop["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${shop["hours"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                Text(
                  "Specialties: ${(shop["specialties"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  "${shop["responseTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Request Estimate",
                        size: bs.sm,
                        onPressed: () {
                          currentTab = 0;
                          setState(() {});
                          si("Auto shop pre-selected for estimate request");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {
                        si("Calling ${shop["phone"]}");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {
                        si("Opening directions to ${shop["name"]}");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  bool _canSubmit() {
    return vehicleMake.isNotEmpty &&
           vehicleModel.isNotEmpty &&
           vehicleYear.isNotEmpty &&
           serviceType.isNotEmpty &&
           problemDescription.isNotEmpty &&
           customerName.isNotEmpty &&
           customerPhone.isNotEmpty &&
           customerEmail.isNotEmpty;
  }

  void _submitRequest() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    ss("Estimate request submitted successfully!");
    
    // Reset form
    vehicleMake = "";
    vehicleModel = "";
    vehicleYear = "";
    vehicleMileage = "";
    serviceType = "";
    problemDescription = "";
    urgencyLevel = "";
    preferredDate = "";
    customerName = "";
    customerPhone = "";
    customerEmail = "";
    customerAddress = "";
    attachments = [];
    
    // Switch to estimates tab
    currentTab = 1;
    setState(() {});
  }

  void _showEstimateDetails(Map<String, dynamic> estimate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Estimate Details"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${estimate["id"]}"),
              Text("Vehicle: ${estimate["vehicle"]}"),
              Text("Service: ${estimate["service"]}"),
              Text("Description: ${estimate["description"]}"),
              Text("Shop: ${estimate["shopName"]}"),
              Text("Status: ${estimate["status"]}"),
              Text("Estimated Cost: \$${(estimate["estimatedCost"] as double).toStringAsFixed(2)}"),
              if (estimate["finalCost"] != null)
                Text("Final Cost: \$${(estimate["finalCost"] as double).toStringAsFixed(2)}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _contactShop(Map<String, dynamic> estimate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact Shop"),
        content: Text("Contact ${estimate["shopName"]} about estimate ${estimate["id"]}?"),
        actions: [
          QButton(
            label: "Call",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Calling shop...");
            },
          ),
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
