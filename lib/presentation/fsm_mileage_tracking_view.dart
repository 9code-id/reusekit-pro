import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmMileageTrackingView extends StatefulWidget {
  const FsmMileageTrackingView({super.key});

  @override
  State<FsmMileageTrackingView> createState() => _FsmMileageTrackingViewState();
}

class _FsmMileageTrackingViewState extends State<FsmMileageTrackingView> {
  int selectedTab = 0;
  String currentTrip = "";
  String startLocation = "Office - 123 Business St, Downtown";
  String currentLocation = "En Route - Highway 101 North";
  double totalMiles = 248.5;
  double todayMiles = 32.7;
  double weeklyMiles = 156.3;
  double monthlyMiles = 1247.8;
  bool isTracking = true;
  String currentSpeed = "65";
  String eta = "2:45 PM";
  String nextAppointment = "Johnson Residence";

  List<Map<String, dynamic>> recentTrips = [
    {
      "id": "1",
      "date": "2024-03-15",
      "startTime": "08:30 AM",
      "endTime": "11:45 AM",
      "startLocation": "Office",
      "endLocation": "Smith Residence",
      "distance": 15.2,
      "duration": "3h 15m",
      "purpose": "HVAC Installation",
      "status": "Completed",
      "fuelUsed": 1.8,
      "cost": 28.50
    },
    {
      "id": "2", 
      "date": "2024-03-15",
      "startTime": "12:30 PM",
      "endTime": "03:20 PM",
      "startLocation": "Smith Residence",
      "endLocation": "Downtown Mall",
      "distance": 8.7,
      "duration": "2h 50m",
      "purpose": "Equipment Pickup",
      "status": "Completed",
      "fuelUsed": 1.2,
      "cost": 18.75
    },
    {
      "id": "3",
      "date": "2024-03-14",
      "startTime": "09:15 AM", 
      "endTime": "04:30 PM",
      "startLocation": "Office",
      "endLocation": "Industrial District",
      "distance": 42.3,
      "duration": "7h 15m",
      "purpose": "Maintenance Check",
      "status": "Completed",
      "fuelUsed": 4.5,
      "cost": 67.20
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mileage Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Current", icon: Icon(Icons.navigation)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildCurrentTrackingTab(),
        _buildTripHistoryTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildCurrentTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Trip Status
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isTracking ? successColor.withAlpha(20) : warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: isTracking ? successColor : warningColor,
                width: 2,
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
                        color: isTracking ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        isTracking ? Icons.location_on : Icons.location_off,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isTracking ? "Currently Tracking" : "Tracking Paused",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            isTracking ? "Trip in progress to ${nextAppointment}" : "Resume tracking when ready",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: isTracking ? "Pause" : "Resume",
                      size: bs.sm,
                      onPressed: () {
                        isTracking = !isTracking;
                        setState(() {});
                        ss(isTracking ? "Tracking resumed" : "Tracking paused");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Today's Miles", "${todayMiles}", "miles", Icons.today, primaryColor),
              _buildStatCard("Current Speed", "${currentSpeed}", "mph", Icons.speed, infoColor),
              _buildStatCard("ETA", eta, "", Icons.schedule, warningColor),
              _buildStatCard("Total Miles", "${totalMiles}", "miles", Icons.place, successColor),
            ],
          ),

          // Current Location Info
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Current Location",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.navigation, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          currentLocation,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Icon(Icons.my_location, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Started from:",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            startLocation,
                            style: TextStyle(
                              fontSize: 14,
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

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Start New Trip",
                        icon: Icons.add_location,
                        size: bs.sm,
                        onPressed: () {
                          ss("New trip started");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "End Current Trip",
                        icon: Icons.stop_circle,
                        size: bs.sm,
                        onPressed: () {
                          ss("Trip ended");
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Waypoint",
                        icon: Icons.add_location_alt,
                        size: bs.sm,
                        onPressed: () {
                          ss("Waypoint added");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "View Route",
                        icon: Icons.map,
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening route map");
                        },
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
  }

  Widget _buildTripHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Weekly Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "This Week Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: _buildSummaryItem("Total Miles", "${weeklyMiles}", Icons.straighten, primaryColor),
                    ),
                    Expanded(
                      child: _buildSummaryItem("Trips", "12", Icons.trip_origin, successColor),
                    ),
                    Expanded(
                      child: _buildSummaryItem("Fuel Cost", "\$114.45", Icons.local_gas_station, warningColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Trips List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Recent Trips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {
                        ss("Opening all trips");
                      },
                    ),
                  ],
                ),
                ...recentTrips.map((trip) => _buildTripCard(trip)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Monthly Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "March 2024 Report",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 150,
                  children: [
                    _buildReportCard("Total Miles", "${monthlyMiles}", "miles", Icons.straighten, primaryColor),
                    _buildReportCard("Total Trips", "48", "trips", Icons.trip_origin, successColor),
                    _buildReportCard("Fuel Cost", "\$892.40", "expense", Icons.local_gas_station, warningColor),
                    _buildReportCard("Avg per Trip", "26.0", "miles", Icons.trending_up, infoColor),
                  ],
                ),
              ],
            ),
          ),

          // Export Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Export Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export PDF",
                        icon: Icons.picture_as_pdf,
                        size: bs.sm,
                        onPressed: () {
                          ss("PDF report generated");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Export CSV",
                        icon: Icons.table_chart,
                        size: bs.sm,
                        onPressed: () {
                          ss("CSV report exported");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expense Breakdown
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Expense Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildExpenseItem("Fuel Costs", "\$628.40", "70.4%", primaryColor),
                _buildExpenseItem("Vehicle Maintenance", "\$156.00", "17.5%", warningColor),
                _buildExpenseItem("Tolls & Parking", "\$84.00", "9.4%", infoColor),
                _buildExpenseItem("Other Expenses", "\$24.00", "2.7%", disabledBoldColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (unit.isNotEmpty)
            Text(
              unit,
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trip["startLocation"]} → ${trip["endLocation"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${trip["purpose"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${trip["distance"]} mi",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${trip["startTime"]} - ${trip["endTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.local_gas_station, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "\$${(trip["cost"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 28),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(String title, String amount, String percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
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
                  percentage,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
