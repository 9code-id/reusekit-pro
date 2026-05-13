import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingAnalyticsView extends StatefulWidget {
  const BrsBookingAnalyticsView({super.key});

  @override
  State<BrsBookingAnalyticsView> createState() => _BrsBookingAnalyticsViewState();
}

class _BrsBookingAnalyticsViewState extends State<BrsBookingAnalyticsView> {
  String selectedPeriod = "This Year";
  String selectedMetric = "Bookings";

  List<String> periods = ["This Month", "Last 3 Months", "This Year", "All Time"];
  List<String> metrics = ["Bookings", "Spending", "Frequency", "Services"];

  Map<String, dynamic> analyticsData = {
    "total_bookings": 24,
    "total_spending": 840.0,
    "average_per_booking": 35.0,
    "favorite_barber": "John Smith",
    "favorite_service": "Premium Haircut",
    "most_visited_location": "Downtown Barbershop",
    "booking_frequency": "Every 4 weeks",
    "growth_rate": 15.5,
  };

  List<Map<String, dynamic>> monthlyBookings = [
    {"month": "Jan", "bookings": 2, "spending": 70.0},
    {"month": "Feb", "bookings": 2, "spending": 70.0},
    {"month": "Mar", "bookings": 3, "spending": 105.0},
    {"month": "Apr", "bookings": 2, "spending": 70.0},
    {"month": "May", "bookings": 3, "spending": 105.0},
    {"month": "Jun", "bookings": 2, "spending": 70.0},
    {"month": "Jul", "bookings": 3, "spending": 105.0},
    {"month": "Aug", "bookings": 2, "spending": 70.0},
    {"month": "Sep", "bookings": 2, "spending": 70.0},
    {"month": "Oct", "bookings": 1, "spending": 35.0},
    {"month": "Nov", "bookings": 1, "spending": 35.0},
    {"month": "Dec", "bookings": 1, "spending": 35.0},
  ];

  List<Map<String, dynamic>> serviceBreakdown = [
    {"service": "Premium Haircut", "count": 15, "percentage": 62.5, "total_spent": 525.0},
    {"service": "Beard Trim", "count": 6, "percentage": 25.0, "total_spent": 120.0},
    {"service": "Hair Wash", "count": 2, "percentage": 8.3, "total_spent": 40.0},
    {"service": "Styling", "count": 1, "percentage": 4.2, "total_spent": 25.0},
  ];

  List<Map<String, dynamic>> barberPreferences = [
    {"name": "John Smith", "visits": 12, "percentage": 50.0, "rating": 4.9},
    {"name": "Mike Johnson", "visits": 7, "percentage": 29.2, "rating": 4.7},
    {"name": "David Brown", "visits": 3, "percentage": 12.5, "rating": 4.8},
    {"name": "Chris Wilson", "visits": 2, "percentage": 8.3, "rating": 4.6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Analytics"),
      ),
      body: Column(
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Primary Metric",
                    items: metrics.map((metric) => {
                      "label": metric,
                      "value": metric,
                    }).toList(),
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Analytics Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Key Metrics
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: [
                      _buildMetricCard(
                        "Total Bookings",
                        "${analyticsData["total_bookings"]}",
                        Icons.calendar_month,
                        primaryColor,
                        "+${analyticsData["growth_rate"]}% vs last period",
                      ),
                      _buildMetricCard(
                        "Total Spending",
                        "\$${(analyticsData["total_spending"] as double).toStringAsFixed(2)}",
                        Icons.attach_money,
                        successColor,
                        "\$${(analyticsData["average_per_booking"] as double).toStringAsFixed(2)} avg per booking",
                      ),
                      _buildMetricCard(
                        "Booking Frequency",
                        "${analyticsData["booking_frequency"]}",
                        Icons.schedule,
                        warningColor,
                        "Regular customer pattern",
                      ),
                      _buildMetricCard(
                        "Favorite Barber",
                        "${analyticsData["favorite_barber"]}",
                        Icons.person,
                        infoColor,
                        "50% of all bookings",
                      ),
                    ],
                  ),

                  // Monthly Trend Chart
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
                          "Monthly Trend",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: monthlyBookings.map((data) {
                              final maxBookings = monthlyBookings
                                  .map((e) => e["bookings"] as int)
                                  .reduce((a, b) => a > b ? a : b);
                              final height = ((data["bookings"] as int) / maxBookings) * 150;
                              
                              return Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${data["bookings"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      height: height,
                                      margin: EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${data["month"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Service Breakdown
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
                          "Service Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...serviceBreakdown.map((service) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${service["service"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${service["count"]} times",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(service["percentage"] as double).toStringAsFixed(1)}% of bookings",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(service["total_spent"] as double).toStringAsFixed(2)} total",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                // Progress Bar
                                Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (service["percentage"] as double) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Barber Preferences
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
                          "Barber Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...barberPreferences.map((barber) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${barber["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: warningColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs/2),
                                          Text(
                                            "${barber["rating"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${(barber["percentage"] as double).toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${barber["visits"]} visits",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Insights & Recommendations
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Insights & Recommendations",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "• You visit the barbershop consistently every 4 weeks - great routine!",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "• John Smith is your go-to barber - consider booking in advance",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "• Premium Haircuts are your favorite - try the deluxe package",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "• Your spending has increased 15.5% this year - investing in quality!",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick Actions
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
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Book with John",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to booking with preferred barber
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Export Data",
                                size: bs.sm,
                                onPressed: () {
                                  si("Analytics data exported");
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
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
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
