import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDriverListView extends StatefulWidget {
  const DlaDriverListView({super.key});

  @override
  State<DlaDriverListView> createState() => _DlaDriverListViewState();
}

class _DlaDriverListViewState extends State<DlaDriverListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedVehicle = "all";
  String sortBy = "rating";
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Online", "value": "online"},
    {"label": "Offline", "value": "offline"},
    {"label": "On Delivery", "value": "busy"},
    {"label": "Break", "value": "break"},
  ];

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "All Vehicles", "value": "all"},
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Car", "value": "car"},
    {"label": "Van", "value": "van"},
    {"label": "Bicycle", "value": "bicycle"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "rating"},
    {"label": "Total Deliveries", "value": "deliveries"},
    {"label": "Join Date", "value": "join_date"},
    {"label": "Name", "value": "name"},
  ];

  List<Map<String, dynamic>> drivers = [
    {
      "id": "DRV001",
      "name": "Mike Johnson",
      "photo": "https://picsum.photos/100/100?random=1&keyword=person",
      "rating": 4.9,
      "total_deliveries": 1250,
      "status": "online",
      "vehicle": "motorcycle",
      "license_plate": "ABC 1234",
      "phone": "+1 234 567 8890",
      "join_date": "2023-01-15",
      "current_location": "Downtown Area",
      "completion_rate": 98.5,
      "average_delivery_time": 25,
      "earnings_today": 145.50,
      "deliveries_today": 12
    },
    {
      "id": "DRV002",
      "name": "Sarah Wilson",
      "photo": "https://picsum.photos/100/100?random=2&keyword=woman",
      "rating": 4.8,
      "total_deliveries": 980,
      "status": "busy",
      "vehicle": "car",
      "license_plate": "XYZ 5678",
      "phone": "+1 234 567 8891",
      "join_date": "2023-02-20",
      "current_location": "Uptown District",
      "completion_rate": 97.2,
      "average_delivery_time": 22,
      "earnings_today": 98.25,
      "deliveries_today": 8
    },
    {
      "id": "DRV003",
      "name": "John Smith",
      "photo": "https://picsum.photos/100/100?random=3&keyword=man",
      "rating": 4.7,
      "total_deliveries": 1450,
      "status": "offline",
      "vehicle": "van",
      "license_plate": "DEF 9012",
      "phone": "+1 234 567 8892",
      "join_date": "2022-11-10",
      "current_location": "Industrial Zone",
      "completion_rate": 96.8,
      "average_delivery_time": 30,
      "earnings_today": 0.0,
      "deliveries_today": 0
    },
    {
      "id": "DRV004",
      "name": "Emma Davis",
      "photo": "https://picsum.photos/100/100?random=4&keyword=person",
      "rating": 4.6,
      "total_deliveries": 745,
      "status": "online",
      "vehicle": "bicycle",
      "license_plate": "N/A",
      "phone": "+1 234 567 8893",
      "join_date": "2023-06-05",
      "current_location": "City Center",
      "completion_rate": 95.1,
      "average_delivery_time": 18,
      "earnings_today": 67.75,
      "deliveries_today": 6
    },
    {
      "id": "DRV005",
      "name": "Robert Brown",
      "photo": "https://picsum.photos/100/100?random=5&keyword=driver",
      "rating": 4.5,
      "total_deliveries": 892,
      "status": "break",
      "vehicle": "motorcycle",
      "license_plate": "GHI 3456",
      "phone": "+1 234 567 8894",
      "join_date": "2023-03-12",
      "current_location": "Suburb Area",
      "completion_rate": 94.7,
      "average_delivery_time": 28,
      "earnings_today": 112.30,
      "deliveries_today": 9
    },
  ];

  List<Map<String, dynamic>> get filteredDrivers {
    var filtered = drivers.where((driver) {
      bool matchesSearch = driver["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || driver["status"] == selectedStatus;
      bool matchesVehicle = selectedVehicle == "all" || driver["vehicle"] == selectedVehicle;
      
      return matchesSearch && matchesStatus && matchesVehicle;
    }).toList();
    
    // Sort
    filtered.sort((a, b) {
      switch (sortBy) {
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "deliveries":
          return (b["total_deliveries"] as int).compareTo(a["total_deliveries"] as int);
        case "name":
          return a["name"].toString().compareTo(b["name"].toString());
        case "join_date":
          return DateTime.parse(b["join_date"]).compareTo(DateTime.parse(a["join_date"]));
        default:
          return 0;
      }
    });
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "online":
        return successColor;
      case "busy":
        return warningColor;
      case "offline":
        return disabledColor;
      case "break":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "online":
        return "Available";
      case "busy":
        return "On Delivery";
      case "offline":
        return "Offline";
      case "break":
        return "On Break";
      default:
        return "Unknown";
    }
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${driver["photo"]}"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getStatusColor(driver["status"]),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${driver["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (driver["rating"] as double) ? Icons.star : Icons.star_border,
                              color: index < (driver["rating"] as double) ? warningColor : disabledColor,
                              size: 14,
                            );
                          }),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(driver["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${driver["total_deliveries"]} deliveries",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(driver["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusText(driver["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(driver["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          _getVehicleIcon(driver["vehicle"]),
                          size: 12,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${driver["vehicle"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "ID: ${driver["id"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  if ((driver["deliveries_today"] as int) > 0) ...[
                    Text(
                      "${driver["deliveries_today"]} today",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Completion Rate",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(driver["completion_rate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
                            "Avg. Time",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${driver["average_delivery_time"]} min",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                            "Today's Earnings",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(driver["earnings_today"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                if (driver["status"] != "offline") ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Location: ${driver["current_location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                color: successColor,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                color: infoColor,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                color: disabledBoldColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getVehicleIcon(String vehicle) {
    switch (vehicle) {
      case "motorcycle":
        return Icons.motorcycle;
      case "car":
        return Icons.directions_car;
      case "van":
        return Icons.airport_shuttle;
      case "bicycle":
        return Icons.pedal_bike;
      default:
        return Icons.local_shipping;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drivers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search drivers...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                QHorizontalScroll(
                  children: [
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: spSm),
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
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: spSm),
                      child: QDropdownField(
                        label: "Vehicle",
                        items: vehicleOptions,
                        value: selectedVehicle,
                        onChanged: (value, label) {
                          selectedVehicle = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      width: 150,
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
            ),
            child: Row(
              children: [
                Text(
                  "${filteredDrivers.length} drivers found",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "Online: ${filteredDrivers.where((d) => d["status"] == "online").length}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Busy: ${filteredDrivers.where((d) => d["status"] == "busy").length}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.all(spSm),
                    itemCount: filteredDrivers.length,
                    itemBuilder: (context, index) {
                      return _buildDriverCard(filteredDrivers[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
