import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleListView extends StatefulWidget {
  const CmaVehicleListView({super.key});

  @override
  State<CmaVehicleListView> createState() => _CmaVehicleListViewState();
}

class _CmaVehicleListViewState extends State<CmaVehicleListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  String sortBy = "name";
  
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "veh_001",
      "name": "Honda Civic 2024",
      "type": "Sedan",
      "licensePlate": "ABC-1234",
      "year": 2024,
      "color": "Silver",
      "mileage": 15000,
      "status": "Active",
      "fuelType": "Gasoline",
      "lastService": "2025-05-15",
      "nextService": "2025-08-15",
      "image": "https://picsum.photos/300/200?random=1&keyword=car"
    },
    {
      "id": "veh_002",
      "name": "Toyota Camry 2023",
      "type": "Sedan",
      "licensePlate": "XYZ-5678",
      "year": 2023,
      "color": "White",
      "mileage": 28000,
      "status": "Maintenance",
      "fuelType": "Hybrid",
      "lastService": "2025-06-01",
      "nextService": "2025-09-01",
      "image": "https://picsum.photos/300/200?random=2&keyword=car"
    },
    {
      "id": "veh_003",
      "name": "Ford F-150 2022",
      "type": "Truck",
      "licensePlate": "DEF-9012",
      "year": 2022,
      "color": "Blue",
      "mileage": 45000,
      "status": "Active",
      "fuelType": "Gasoline",
      "lastService": "2025-04-20",
      "nextService": "2025-07-20",
      "image": "https://picsum.photos/300/200?random=3&keyword=truck"
    },
    {
      "id": "veh_004",
      "name": "BMW X5 2023",
      "type": "SUV",
      "licensePlate": "GHI-3456",
      "year": 2023,
      "color": "Black",
      "mileage": 22000,
      "status": "Active",
      "fuelType": "Gasoline",
      "lastService": "2025-05-30",
      "nextService": "2025-08-30",
      "image": "https://picsum.photos/300/200?random=4&keyword=suv"
    },
    {
      "id": "veh_005",
      "name": "Tesla Model 3 2024",
      "type": "Sedan",
      "licensePlate": "JKL-7890", 
      "year": 2024,
      "color": "Red",
      "mileage": 8000,
      "status": "Active",
      "fuelType": "Electric",
      "lastService": "2025-03-15",
      "nextService": "2025-06-15",
      "image": "https://picsum.photos/300/200?random=5&keyword=electric"
    },
    {
      "id": "veh_006",
      "name": "Nissan Altima 2022",
      "type": "Sedan",
      "licensePlate": "MNO-2468",
      "year": 2022,
      "color": "Gray",
      "mileage": 38000,
      "status": "Out of Service",
      "fuelType": "Gasoline",
      "lastService": "2025-02-10",
      "nextService": "2025-05-10",
      "image": "https://picsum.photos/300/200?random=6&keyword=sedan"
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "Active"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Out of Service", "value": "Out of Service"}
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Sedan", "value": "Sedan"},
    {"label": "SUV", "value": "SUV"},
    {"label": "Truck", "value": "Truck"},
    {"label": "Hatchback", "value": "Hatchback"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Year", "value": "year"},
    {"label": "Mileage", "value": "mileage"},
    {"label": "Status", "value": "status"}
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    List<Map<String, dynamic>> filtered = vehicles.where((vehicle) {
      bool matchesSearch = searchQuery.isEmpty || 
          (vehicle["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vehicle["licensePlate"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || vehicle["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || vehicle["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    // Sort the filtered results
    filtered.sort((a, b) {
      switch (sortBy) {
        case "year":
          return (b["year"] as int).compareTo(a["year"] as int);
        case "mileage":
          return (a["mileage"] as int).compareTo(b["mileage"] as int);
        case "status":
          return (a["status"] as String).compareTo(b["status"] as String);
        default:
          return (a["name"] as String).compareTo(b["name"] as String);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CmaAddVehicleView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Summary
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${vehicles.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${vehicles.where((v) => v["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: warningColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Maintenance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${vehicles.where((v) => v["status"] == "Maintenance").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Filters & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Search Vehicles",
                    value: searchQuery,
                    hint: "Search by name or license plate",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
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
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Vehicle List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Text(
                        "Vehicles (${filteredVehicles.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Vehicle",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('CmaAddVehicleView')
                        },
                      ),
                    ],
                  ),
                  ...filteredVehicles.map((vehicle) {
                    Color statusColor;
                    switch (vehicle["status"]) {
                      case "Active":
                        statusColor = successColor;
                        break;
                      case "Maintenance":
                        statusColor = warningColor;
                        break;
                      default:
                        statusColor = dangerColor;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${vehicle["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${vehicle["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${vehicle["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${vehicle["licensePlate"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${vehicle["year"]} • ${vehicle["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${vehicle["color"]} • ${vehicle["fuelType"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${(vehicle["mileage"] as int).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} miles",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Last Service: ${DateTime.parse(vehicle["lastService"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Next: ${DateTime.parse(vehicle["nextService"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            spacing: spXs,
                            children: [
                              QButton(
                                icon: Icons.visibility,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('CmaVehicleDetailsView', arguments: vehicle)
                                },
                              ),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('CmaEditVehicleView', arguments: vehicle)
                                },
                              ),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showVehicleActions(vehicle);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVehicleActions(Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "Vehicle Actions - ${vehicle["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Details",
                  onPressed: () {
                    back();
                    // navigateTo('CmaVehicleDetailsView', arguments: vehicle)
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Edit Vehicle",
                  onPressed: () {
                    back();
                    // navigateTo('CmaEditVehicleView', arguments: vehicle)
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Schedule Maintenance",
                  onPressed: () {
                    back();
                    ss("Maintenance scheduled for ${vehicle["name"]}");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Documents",
                  onPressed: () {
                    back();
                    // navigateTo('CmaVehicleDocumentsView', arguments: vehicle)
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Remove Vehicle",
                  onPressed: () async {
                    back();
                    bool isConfirmed = await confirm("Are you sure you want to remove ${vehicle["name"]} from the fleet?");
                    if (isConfirmed) {
                      ss("Vehicle ${vehicle["name"]} has been removed");
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
