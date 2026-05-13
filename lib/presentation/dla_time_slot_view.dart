import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaTimeSlotView extends StatefulWidget {
  const DlaTimeSlotView({super.key});

  @override
  State<DlaTimeSlotView> createState() => _DlaTimeSlotViewState();
}

class _DlaTimeSlotViewState extends State<DlaTimeSlotView> {
  DateTime selectedDate = DateTime.now();
  String selectedSlot = "";
  bool loading = false;

  List<Map<String, dynamic>> timeSlots = [
    {
      "id": "morning_early",
      "label": "Early Morning",
      "time_range": "06:00 - 09:00",
      "available_slots": 5,
      "booked_slots": 2,
      "total_slots": 7,
      "price_modifier": 0.8,
      "peak_hours": false,
    },
    {
      "id": "morning",
      "label": "Morning",
      "time_range": "09:00 - 12:00",
      "available_slots": 3,
      "booked_slots": 7,
      "total_slots": 10,
      "price_modifier": 1.0,
      "peak_hours": true,
    },
    {
      "id": "afternoon_early",
      "label": "Early Afternoon",
      "time_range": "12:00 - 15:00",
      "available_slots": 6,
      "booked_slots": 4,
      "total_slots": 10,
      "price_modifier": 1.2,
      "peak_hours": true,
    },
    {
      "id": "afternoon",
      "label": "Afternoon",
      "time_range": "15:00 - 18:00",
      "available_slots": 2,
      "booked_slots": 8,
      "total_slots": 10,
      "price_modifier": 1.1,
      "peak_hours": true,
    },
    {
      "id": "evening",
      "label": "Evening",
      "time_range": "18:00 - 21:00",
      "available_slots": 4,
      "booked_slots": 3,
      "total_slots": 7,
      "price_modifier": 0.9,
      "peak_hours": false,
    },
    {
      "id": "night",
      "label": "Night",
      "time_range": "21:00 - 00:00",
      "available_slots": 5,
      "booked_slots": 1,
      "total_slots": 6,
      "price_modifier": 0.7,
      "peak_hours": false,
    },
  ];

  List<Map<String, dynamic>> bookedDeliveries = [
    {
      "time": "09:30",
      "customer": "ABC Electronics",
      "delivery_id": "DEL-001",
      "driver": "John Smith",
      "vehicle": "TRK-001",
      "status": "scheduled",
    },
    {
      "time": "10:15",
      "customer": "Fashion Hub Store",
      "delivery_id": "DEL-002",
      "driver": "Sarah Johnson",
      "vehicle": "VAN-002",
      "status": "in_transit",
    },
    {
      "time": "11:45",
      "customer": "Tech Solutions",
      "delivery_id": "DEL-003",
      "driver": "Mike Wilson",
      "vehicle": "TRK-003",
      "status": "scheduled",
    },
    {
      "time": "14:30",
      "customer": "Medical Supplies",
      "delivery_id": "DEL-004",
      "driver": "Lisa Chen",
      "vehicle": "VAN-001",
      "status": "scheduled",
    },
    {
      "time": "16:00",
      "customer": "Office Solutions",
      "delivery_id": "DEL-005",
      "driver": "Tom Anderson",
      "vehicle": "TRK-002",
      "status": "scheduled",
    },
  ];

  Color _getAvailabilityColor(Map<String, dynamic> slot) {
    double availability = (slot["available_slots"] as int) / (slot["total_slots"] as int);
    if (availability > 0.6) return successColor;
    if (availability > 0.3) return warningColor;
    return dangerColor;
  }

  String _getAvailabilityText(Map<String, dynamic> slot) {
    int available = slot["available_slots"] as int;
    if (available == 0) return "Full";
    if (available <= 2) return "Almost Full";
    return "Available";
  }

  void _selectTimeSlot(Map<String, dynamic> slot) {
    if ((slot["available_slots"] as int) == 0) {
      sw("This time slot is fully booked");
      return;
    }

    selectedSlot = slot["id"];
    setState(() {});
    
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildTimeSlotDetails(slot),
    );
  }

  void _refreshSlots() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    ss("Time slots refreshed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Slots"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshSlots,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // navigateTo('date_picker_view')
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Date Selection
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${selectedDate.dMMMy}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Change Date",
                          size: bs.sm,
                          onPressed: () {
                            // Show date picker
                          },
                        ),
                      ],
                    ),
                  ),

                  // Summary Statistics
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Slots",
                        "${timeSlots.fold(0, (sum, slot) => sum + (slot["total_slots"] as int))}",
                        Icons.access_time,
                        primaryColor,
                      ),
                      _buildSummaryCard(
                        "Available",
                        "${timeSlots.fold(0, (sum, slot) => sum + (slot["available_slots"] as int))}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Booked",
                        "${timeSlots.fold(0, (sum, slot) => sum + (slot["booked_slots"] as int))}",
                        Icons.event_busy,
                        warningColor,
                      ),
                      _buildSummaryCard(
                        "Peak Hours",
                        "${timeSlots.where((slot) => slot["peak_hours"] as bool).length}",
                        Icons.trending_up,
                        dangerColor,
                      ),
                    ],
                  ),

                  // Time Slots Grid
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.schedule, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Available Time Slots",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 200,
                            children: timeSlots.map((slot) => _buildTimeSlotCard(slot)).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Current Bookings
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.event, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Today's Bookings",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...bookedDeliveries.map((booking) => _buildBookingCard(booking)),
                      ],
                    ),
                  ),

                  // Legend
                  Container(
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
                          "Legend",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            _buildLegendItem("Available", successColor),
                            SizedBox(width: spMd),
                            _buildLegendItem("Almost Full", warningColor),
                            SizedBox(width: spMd),
                            _buildLegendItem("Full", dangerColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
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
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotCard(Map<String, dynamic> slot) {
    Color availabilityColor = _getAvailabilityColor(slot);
    String availabilityText = _getAvailabilityText(slot);
    bool isPeakHour = slot["peak_hours"] as bool;
    
    return GestureDetector(
      onTap: () => _selectTimeSlot(slot),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: availabilityColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: selectedSlot == slot["id"] ? primaryColor : availabilityColor,
            width: selectedSlot == slot["id"] ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${slot["label"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                if (isPeakHour)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "PEAK",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spXs),
            Text(
              "${slot["time_range"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: availabilityColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  availabilityText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: availabilityColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Text(
                  "${slot["available_slots"]}/${slot["total_slots"]} slots",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${((slot["price_modifier"] as double) * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (slot["booked_slots"] as int) / (slot["total_slots"] as int),
                child: Container(
                  decoration: BoxDecoration(
                    color: availabilityColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "${booking["time"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${booking["customer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${booking["delivery_id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${booking["driver"]}",
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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(booking["status"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${booking["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(booking["status"]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return infoColor;
      case "in_transit":
        return primaryColor;
      case "delivered":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildTimeSlotDetails(Map<String, dynamic> slot) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${slot["label"]} Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => back(),
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildDetailRow("Time Range", "${slot["time_range"]}"),
          _buildDetailRow("Available Slots", "${slot["available_slots"]} of ${slot["total_slots"]}"),
          _buildDetailRow("Price Modifier", "${((slot["price_modifier"] as double) * 100).toInt()}%"),
          _buildDetailRow("Peak Hours", "${slot["peak_hours"] ? 'Yes' : 'No'}"),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Book This Slot",
              onPressed: () {
                back();
                ss("Time slot booking initiated");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
