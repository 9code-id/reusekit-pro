import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPickupRequestView extends StatefulWidget {
  const LtaPickupRequestView({super.key});

  @override
  State<LtaPickupRequestView> createState() => _LtaPickupRequestViewState();
}

class _LtaPickupRequestViewState extends State<LtaPickupRequestView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedVehicleType = "All";
  
  List<Map<String, dynamic>> pickupRequests = [
    {
      "id": "PR-2024-001",
      "customerName": "Michael Johnson",
      "customerPhone": "+1 (555) 123-4567",
      "pickupAddress": "123 Main Street, Downtown",
      "destinationAddress": "456 Oak Avenue, Uptown",
      "requestDate": "2024-12-18",
      "preferredTime": "09:30",
      "status": "Pending",
      "priority": "High",
      "vehicleType": "SUV",
      "passengers": 4,
      "luggage": 3,
      "estimatedDuration": "45 minutes",
      "estimatedDistance": "12.5 km",
      "specialRequests": "Child seat required, wheelchair accessible",
      "driverAssigned": "",
      "vehicleAssigned": "",
      "createdAt": "2024-12-18 08:15",
      "notes": "Customer requested early pickup for flight departure",
    },
    {
      "id": "PR-2024-002",
      "customerName": "Sarah Davis",
      "customerPhone": "+1 (555) 234-5678",
      "pickupAddress": "789 Pine Road, Westside",
      "destinationAddress": "321 Elm Street, Eastside",
      "requestDate": "2024-12-18",
      "preferredTime": "14:00",
      "status": "Assigned",
      "priority": "Medium",
      "vehicleType": "Sedan",
      "passengers": 2,
      "luggage": 1,
      "estimatedDuration": "30 minutes",
      "estimatedDistance": "8.2 km",
      "specialRequests": "No smoking vehicle",
      "driverAssigned": "John Smith",
      "vehicleAssigned": "Toyota Camry - ABC123",
      "createdAt": "2024-12-18 10:30",
      "notes": "Regular customer, business meeting",
    },
    {
      "id": "PR-2024-003",
      "customerName": "Robert Wilson",
      "customerPhone": "+1 (555) 345-6789",
      "pickupAddress": "654 Cedar Lane, Northside",
      "destinationAddress": "987 Maple Drive, Southside",
      "requestDate": "2024-12-18",
      "preferredTime": "16:45",
      "status": "In Progress",
      "priority": "Medium",
      "vehicleType": "Van",
      "passengers": 6,
      "luggage": 5,
      "estimatedDuration": "60 minutes",
      "estimatedDistance": "18.7 km",
      "specialRequests": "Group travel, multiple stops",
      "driverAssigned": "Maria Garcia",
      "vehicleAssigned": "Honda Odyssey - XYZ789",
      "createdAt": "2024-12-18 12:00",
      "notes": "Family trip to airport with multiple luggage",
    },
    {
      "id": "PR-2024-004",
      "customerName": "Jennifer Martinez",
      "customerPhone": "+1 (555) 456-7890",
      "pickupAddress": "321 Birch Street, Central",
      "destinationAddress": "654 Spruce Avenue, Riverside",
      "requestDate": "2024-12-18",
      "preferredTime": "11:15",
      "status": "Completed",
      "priority": "Low",
      "vehicleType": "Sedan",
      "passengers": 1,
      "luggage": 2,
      "estimatedDuration": "25 minutes",
      "estimatedDistance": "6.8 km",
      "specialRequests": "Quick service preferred",
      "driverAssigned": "David Lee",
      "vehicleAssigned": "Honda Accord - DEF456",
      "createdAt": "2024-12-18 09:45",
      "notes": "Medical appointment, completed successfully",
    },
    {
      "id": "PR-2024-005",
      "customerName": "Amanda Thompson",
      "customerPhone": "+1 (555) 567-8901",
      "pickupAddress": "159 Willow Court, Hillside",
      "destinationAddress": "753 Poplar Street, Valley",
      "requestDate": "2024-12-18",
      "preferredTime": "18:30",
      "status": "Cancelled",
      "priority": "Low",
      "vehicleType": "Compact",
      "passengers": 2,
      "luggage": 1,
      "estimatedDuration": "35 minutes",
      "estimatedDistance": "9.4 km",
      "specialRequests": "Economy option",
      "driverAssigned": "",
      "vehicleAssigned": "",
      "createdAt": "2024-12-18 15:20",
      "notes": "Customer cancelled due to schedule change",
    },
  ];

  List<Map<String, dynamic>> availableDrivers = [
    {
      "id": "D001",
      "name": "John Smith",
      "phone": "+1 (555) 111-2222",
      "vehicle": "Toyota Camry - ABC123",
      "status": "Available",
      "rating": 4.8,
      "location": "Downtown Area",
    },
    {
      "id": "D002",
      "name": "Maria Garcia",
      "phone": "+1 (555) 222-3333",
      "vehicle": "Honda Odyssey - XYZ789",
      "status": "On Trip",
      "rating": 4.9,
      "location": "Northside",
    },
    {
      "id": "D003",
      "name": "David Lee",
      "phone": "+1 (555) 333-4444",
      "vehicle": "Honda Accord - DEF456",
      "status": "Available",
      "rating": 4.7,
      "location": "Central Area",
    },
  ];

  List<String> statusOptions = ["All", "Pending", "Assigned", "In Progress", "Completed", "Cancelled"];
  List<String> priorityOptions = ["All", "High", "Medium", "Low"];
  List<String> vehicleTypeOptions = ["All", "Sedan", "SUV", "Van", "Compact"];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pickup Requests",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Requests", icon: Icon(Icons.list)),
        Tab(text: "Assign", icon: Icon(Icons.assignment_ind)),
        Tab(text: "Tracking", icon: Icon(Icons.location_on)),
      ],
      tabChildren: [
        // Requests Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Status Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor.withAlpha(25), warningColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.pending,
                                color: warningColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${pickupRequests.where((req) => req["status"] == "Pending").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Pending Requests",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Awaiting Assignment",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [infoColor.withAlpha(25), infoColor.withAlpha(50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping,
                                color: infoColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${pickupRequests.where((req) => req["status"] == "In Progress").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Active Trips",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions.map((status) => {
                        "label": status,
                        "value": status,
                      }).toList(),
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
                      label: "Priority",
                      items: priorityOptions.map((priority) => {
                        "label": priority,
                        "value": priority,
                      }).toList(),
                      value: selectedPriority,
                      onChanged: (value, label) {
                        selectedPriority = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QDropdownField(
                label: "Vehicle Type",
                items: vehicleTypeOptions.map((type) => {
                  "label": type,
                  "value": type,
                }).toList(),
                value: selectedVehicleType,
                onChanged: (value, label) {
                  selectedVehicleType = value;
                  setState(() {});
                },
              ),

              // Pickup Requests List
              Column(
                children: pickupRequests
                    .where((request) {
                      if (selectedStatus != "All" && request["status"] != selectedStatus) return false;
                      if (selectedPriority != "All" && request["priority"] != selectedPriority) return false;
                      if (selectedVehicleType != "All" && request["vehicleType"] != selectedVehicleType) return false;
                      return true;
                    })
                    .map((request) {
                  Color statusColor = request["status"] == "Pending" ? warningColor :
                                     request["status"] == "Assigned" ? infoColor :
                                     request["status"] == "In Progress" ? primaryColor :
                                     request["status"] == "Completed" ? successColor : dangerColor;

                  Color priorityColor = request["priority"] == "High" ? dangerColor :
                                        request["priority"] == "Medium" ? warningColor : successColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${request["id"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: priorityColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${request["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${request["customerName"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${request["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Pickup Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.my_location,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "From: ${request["pickupAddress"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "To: ${request["destinationAddress"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Trip Details
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${request["preferredTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${request["vehicleType"]}",
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

                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${request["passengers"]} passengers",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.luggage,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${request["luggage"]} bags",
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

                        if (request["specialRequests"].toString().isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${request["specialRequests"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        if (request["driverAssigned"].toString().isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "Assigned: ${request["driverAssigned"]} - ${request["vehicleAssigned"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            if (request["status"] == "Pending")
                              QButton(
                                label: "Assign Driver",
                                size: bs.sm,
                                onPressed: () {
                                  selectedTab = 1;
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Assign Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Available Drivers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: availableDrivers.map((driver) {
                  Color statusColor = driver["status"] == "Available" ? successColor : warningColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
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
                                "${driver["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${driver["vehicle"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${driver["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${driver["location"]}",
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
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${driver["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            if (driver["status"] == "Available")
                              QButton(
                                label: "Assign",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              Text(
                "Pending Assignments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: pickupRequests
                    .where((req) => req["status"] == "Pending")
                    .map((request) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          color: warningColor,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${request["id"]} - ${request["customerName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${request["preferredTime"]} • ${request["vehicleType"]} • ${request["passengers"]} pax",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Quick Assign",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Tracking Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Active Trips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: pickupRequests
                    .where((req) => req["status"] == "In Progress" || req["status"] == "Assigned")
                    .map((request) {
                  Color statusColor = request["status"] == "In Progress" ? primaryColor : infoColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${request["id"]} - ${request["customerName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${request["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Driver Info
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Driver: ${request["driverAssigned"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              QButton(
                                icon: Icons.phone,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),

                        // Vehicle Info
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${request["vehicleAssigned"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        // Trip Info
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${request["estimatedDuration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.straighten,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${request["estimatedDistance"]}",
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

                        Row(
                          children: [
                            QButton(
                              label: "Track Live",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Contact Customer",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              if (pickupRequests.where((req) => req["status"] == "In Progress" || req["status"] == "Assigned").isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_disabled,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No Active Trips",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "All trips are completed or pending assignment",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
