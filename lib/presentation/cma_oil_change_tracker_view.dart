import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaOilChangeTrackerView extends StatefulWidget {
  const CmaOilChangeTrackerView({super.key});

  @override
  State<CmaOilChangeTrackerView> createState() => _CmaOilChangeTrackerViewState();
}

class _CmaOilChangeTrackerViewState extends State<CmaOilChangeTrackerView> {
  List<Map<String, dynamic>> oilChangeHistory = [
    {
      "id": 1,
      "date": "2024-06-15",
      "mileage": 82000,
      "oil_type": "5W-30 Synthetic",
      "oil_brand": "Mobil 1",
      "filter_brand": "Fram",
      "cost": 45.99,
      "shop": "Quick Lube Express",
      "technician": "Mike Johnson",
      "next_due_mileage": 85000,
      "next_due_date": "2024-09-15",
      "notes": "Regular maintenance oil change",
      "receipt_image": "https://picsum.photos/300/400?random=1",
    },
    {
      "id": 2,
      "date": "2024-03-20",
      "mileage": 79000,
      "oil_type": "5W-30 Conventional",
      "oil_brand": "Valvoline",
      "filter_brand": "Purolator",
      "cost": 35.50,
      "shop": "AutoCare Center",
      "technician": "Sarah Wilson",
      "next_due_mileage": 82000,
      "next_due_date": "2024-06-20",
      "notes": "Switched to synthetic oil",
      "receipt_image": "https://picsum.photos/300/400?random=2",
    },
    {
      "id": 3,
      "date": "2023-12-15",
      "mileage": 76000,
      "oil_type": "10W-30 Conventional",
      "oil_brand": "Castrol",
      "filter_brand": "AC Delco",
      "cost": 32.75,
      "shop": "Local Garage",
      "technician": "Bob Thompson",
      "next_due_mileage": 79000,
      "next_due_date": "2024-03-15",
      "notes": "First oil change after purchase",
      "receipt_image": "https://picsum.photos/300/400?random=3",
    },
  ];

  Map<String, dynamic> currentStatus = {
    "current_mileage": 84250,
    "next_due_mileage": 85000,
    "next_due_date": "2024-09-15",
    "miles_remaining": 750,
    "days_remaining": 12,
    "oil_life_percentage": 15,
    "current_oil_type": "5W-30 Synthetic",
    "last_change_date": "2024-06-15",
    "last_change_mileage": 82000,
  };

  List<Map<String, dynamic>> oilTypes = [
    {"label": "5W-30 Synthetic", "value": "5w30_synthetic"},
    {"label": "5W-30 Conventional", "value": "5w30_conventional"},
    {"label": "0W-20 Synthetic", "value": "0w20_synthetic"},
    {"label": "10W-30 Conventional", "value": "10w30_conventional"},
    {"label": "5W-20 Synthetic", "value": "5w20_synthetic"},
  ];

  List<Map<String, dynamic>> oilBrands = [
    {"label": "Mobil 1", "value": "mobil1"},
    {"label": "Valvoline", "value": "valvoline"},
    {"label": "Castrol", "value": "castrol"},
    {"label": "Shell", "value": "shell"},
    {"label": "Pennzoil", "value": "pennzoil"},
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Oil Change Tracker",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Status", icon: Icon(Icons.oil_barrel)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Add Record", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildStatusTab(),
        _buildHistoryTab(),
        _buildAddRecordTab(),
      ],
    );
  }

  Widget _buildStatusTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCurrentStatusCard(),
          _buildOilLifeProgress(),
          _buildRecommendations(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildCurrentStatusCard() {
    bool isOverdue = currentStatus["miles_remaining"] < 0 || currentStatus["days_remaining"] < 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : 
                   currentStatus["miles_remaining"] < 500 ? warningColor : successColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.oil_barrel,
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Current Oil Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: isOverdue ? dangerColor : 
                         currentStatus["miles_remaining"] < 500 ? warningColor : successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  isOverdue ? "OVERDUE" : 
                  currentStatus["miles_remaining"] < 500 ? "DUE SOON" : "GOOD",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Mileage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(currentStatus["current_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                      "Next Due",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(currentStatus["next_due_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                      "Miles Remaining",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${currentStatus["miles_remaining"]} mi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isOverdue ? dangerColor : 
                               currentStatus["miles_remaining"] < 500 ? warningColor : successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Next due date: ${DateTime.parse(currentStatus["next_due_date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${currentStatus["days_remaining"]} days remaining",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: currentStatus["days_remaining"] < 7 ? dangerColor : primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOilLifeProgress() {
    int oilLife = currentStatus["oil_life_percentage"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Oil Life Monitor",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Oil Life Remaining",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: LinearProgressIndicator(
                        value: oilLife / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          oilLife > 30 ? successColor : 
                          oilLife > 15 ? warningColor : dangerColor,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "$oilLife%",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: oilLife > 30 ? successColor : 
                         oilLife > 15 ? warningColor : dangerColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Current Oil: ${currentStatus["current_oil_type"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          Text(
            "Last changed: ${DateTime.parse(currentStatus["last_change_date"]).dMMMy} at ${(currentStatus["last_change_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Container(
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
              Icon(
                Icons.lightbulb,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Recommendations",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          _buildRecommendationItem(
            "Schedule oil change soon",
            "Your oil change is due in ${currentStatus["miles_remaining"]} miles",
            Icons.schedule,
            warningColor,
          ),
          
          _buildRecommendationItem(
            "Consider upgrading to full synthetic",
            "Better protection and longer intervals",
            Icons.upgrade,
            infoColor,
          ),
          
          _buildRecommendationItem(
            "Check oil level monthly",
            "Regular monitoring prevents engine damage",
            Icons.check_circle,
            successColor,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
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
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Change",
                  icon: Icons.schedule,
                  size: bs.sm,
                  onPressed: () {
                    _scheduleOilChange();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Find Shops",
                  icon: Icons.location_on,
                  size: bs.sm,
                  onPressed: () {
                    _findNearbyShops();
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Update Mileage",
                  icon: Icons.speed,
                  size: bs.sm,
                  onPressed: () {
                    _updateMileage();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Set Reminder",
                  icon: Icons.notifications,
                  size: bs.sm,
                  onPressed: () {
                    _setReminder();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Oil Change History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.analytics,
                size: bs.sm,
                onPressed: () {
                  _viewAnalytics();
                },
              ),
            ],
          ),

          _buildHistorySummary(),

          ...oilChangeHistory.map((record) => Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                    Icon(
                      Icons.oil_barrel,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${DateTime.parse(record["date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${(record["mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Oil Type",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${record["oil_type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                            "Brand",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${record["oil_brand"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                            "Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(record["cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${record["shop"]} - ${record["technician"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "${record["notes"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Receipt",
                        size: bs.sm,
                        onPressed: () {
                          _viewReceipt(record);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        _editRecord(record);
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

  Widget _buildHistorySummary() {
    double totalCost = oilChangeHistory.fold(0.0, (sum, record) => sum + (record["cost"] as double));
    double averageCost = totalCost / oilChangeHistory.length;
    int totalChanges = oilChangeHistory.length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Oil Change Summary",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$totalChanges",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Changes",
                      textAlign: TextAlign.center,
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
                  children: [
                    Text(
                      "\$${totalCost.currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Spent",
                      textAlign: TextAlign.center,
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
                  children: [
                    Text(
                      "\$${averageCost.currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Average Cost",
                      textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  Widget _buildAddRecordTab() {
    String date = "";
    String mileage = "";
    String oilType = "";
    String oilBrand = "";
    String filterBrand = "";
    String cost = "";
    String shop = "";
    String technician = "";
    String notes = "";
    String receiptImage = "";

    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Oil Change Record",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Service Date",
                          value: date.isNotEmpty ? DateTime.parse(date) : DateTime.now(),
                          onChanged: (value) {
                            date = value.toString();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Mileage",
                          value: mileage,
                          hint: "Current vehicle mileage",
                          validator: Validator.required,
                          onChanged: (value) {
                            mileage = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Oil Type",
                          items: oilTypes,
                          value: oilType,
                          validator: Validator.required,
                          onChanged: (value, label) {
                            oilType = value;
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Oil Brand",
                          items: oilBrands,
                          value: oilBrand,
                          validator: Validator.required,
                          onChanged: (value, label) {
                            oilBrand = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Filter Brand",
                          value: filterBrand,
                          hint: "Oil filter brand",
                          onChanged: (value) {
                            filterBrand = value;
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Total Cost (\$)",
                          value: cost,
                          hint: "Total service cost",
                          validator: Validator.required,
                          onChanged: (value) {
                            cost = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Service Shop",
                          value: shop,
                          hint: "Name of service provider",
                          validator: Validator.required,
                          onChanged: (value) {
                            shop = value;
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Technician",
                          value: technician,
                          hint: "Technician name",
                          onChanged: (value) {
                            technician = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  QMemoField(
                    label: "Service Notes",
                    value: notes,
                    hint: "Additional notes about the service",
                    onChanged: (value) {
                      notes = value;
                    },
                  ),

                  QImagePicker(
                    label: "Receipt Photo",
                    value: receiptImage,
                    hint: "Upload receipt or invoice",
                    onChanged: (value) {
                      receiptImage = value;
                    },
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Oil Change Record",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _saveOilChangeRecord();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scheduleOilChange() {
    si("Schedule oil change feature coming soon");
  }

  void _findNearbyShops() {
    si("Find nearby oil change shops feature coming soon");
  }

  void _updateMileage() {
    si("Update current mileage feature coming soon");
  }

  void _setReminder() {
    si("Set oil change reminder feature coming soon");
  }

  void _viewAnalytics() {
    si("Oil change analytics feature coming soon");
  }

  void _viewReceipt(Map<String, dynamic> record) {
    si("Viewing receipt for oil change on ${DateTime.parse(record["date"]).dMMMy}");
  }

  void _editRecord(Map<String, dynamic> record) {
    si("Edit oil change record feature coming soon");
  }

  void _saveOilChangeRecord() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Oil change record saved successfully!");
    
    // Reset form and switch to history tab
    selectedTab = 1;
    setState(() {});
  }
}
