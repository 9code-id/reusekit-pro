import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaPeriodicTableView extends StatefulWidget {
  const ElaPeriodicTableView({super.key});

  @override
  State<ElaPeriodicTableView> createState() => _ElaPeriodicTableViewState();
}

class _ElaPeriodicTableViewState extends State<ElaPeriodicTableView> {
  String selectedCategory = "All";
  String searchQuery = "";
  Map<String, dynamic>? selectedElement;
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Alkali Metals", "value": "Alkali Metals"},
    {"label": "Noble Gases", "value": "Noble Gases"},
    {"label": "Halogens", "value": "Halogens"},
    {"label": "Transition Metals", "value": "Transition Metals"},
    {"label": "Metalloids", "value": "Metalloids"},
  ];

  List<Map<String, dynamic>> elements = [
    {
      "symbol": "H",
      "name": "Hydrogen",
      "atomicNumber": 1,
      "atomicMass": 1.008,
      "category": "Nonmetal",
      "color": "#FFEB3B",
      "electrons": "1",
      "protons": 1,
      "neutrons": 0,
      "group": 1,
      "period": 1,
      "discoverer": "Henry Cavendish",
      "yearDiscovered": 1766,
      "uses": ["Fuel", "Chemical processes", "Weather balloons"],
      "properties": {
        "meltingPoint": -259.14,
        "boilingPoint": -252.87,
        "density": 0.00009,
        "state": "Gas"
      }
    },
    {
      "symbol": "He",
      "name": "Helium",
      "atomicNumber": 2,
      "atomicMass": 4.003,
      "category": "Noble Gases",
      "color": "#E1F5FE",
      "electrons": "2",
      "protons": 2,
      "neutrons": 2,
      "group": 18,
      "period": 1,
      "discoverer": "Pierre Janssen",
      "yearDiscovered": 1868,
      "uses": ["Balloons", "Cooling systems", "Medical applications"],
      "properties": {
        "meltingPoint": -272.2,
        "boilingPoint": -268.93,
        "density": 0.0001785,
        "state": "Gas"
      }
    },
    {
      "symbol": "Li",
      "name": "Lithium",
      "atomicNumber": 3,
      "atomicMass": 6.941,
      "category": "Alkali Metals",
      "color": "#F8BBD9",
      "electrons": "2,1",
      "protons": 3,
      "neutrons": 4,
      "group": 1,
      "period": 2,
      "discoverer": "Johan August Arfwedson",
      "yearDiscovered": 1817,
      "uses": ["Batteries", "Ceramics", "Mental health medication"],
      "properties": {
        "meltingPoint": 180.5,
        "boilingPoint": 1342,
        "density": 0.534,
        "state": "Solid"
      }
    },
    {
      "symbol": "C",
      "name": "Carbon",
      "atomicNumber": 6,
      "atomicMass": 12.011,
      "category": "Nonmetal",
      "color": "#FFEB3B",
      "electrons": "2,4",
      "protons": 6,
      "neutrons": 6,
      "group": 14,
      "period": 2,
      "discoverer": "Ancient",
      "yearDiscovered": -3750,
      "uses": ["Steel production", "Diamonds", "Organic compounds"],
      "properties": {
        "meltingPoint": 3550,
        "boilingPoint": 4027,
        "density": 2.267,
        "state": "Solid"
      }
    },
    {
      "symbol": "N",
      "name": "Nitrogen",
      "atomicNumber": 7,
      "atomicMass": 14.007,
      "category": "Nonmetal",
      "color": "#FFEB3B",
      "electrons": "2,5",
      "protons": 7,
      "neutrons": 7,
      "group": 15,
      "period": 2,
      "discoverer": "Daniel Rutherford",
      "yearDiscovered": 1772,
      "uses": ["Fertilizers", "Explosives", "Food preservation"],
      "properties": {
        "meltingPoint": -210.0,
        "boilingPoint": -195.79,
        "density": 0.0012506,
        "state": "Gas"
      }
    },
    {
      "symbol": "O",
      "name": "Oxygen",
      "atomicNumber": 8,
      "atomicMass": 15.999,
      "category": "Nonmetal",
      "color": "#FFEB3B",
      "electrons": "2,6",
      "protons": 8,
      "neutrons": 8,
      "group": 16,
      "period": 2,
      "discoverer": "Joseph Priestley",
      "yearDiscovered": 1774,
      "uses": ["Breathing", "Combustion", "Medical applications"],
      "properties": {
        "meltingPoint": -218.79,
        "boilingPoint": -182.96,
        "density": 0.001429,
        "state": "Gas"
      }
    },
    {
      "symbol": "F",
      "name": "Fluorine",
      "atomicNumber": 9,
      "atomicMass": 18.998,
      "category": "Halogens",
      "color": "#DCEDC8",
      "electrons": "2,7",
      "protons": 9,
      "neutrons": 10,
      "group": 17,
      "period": 2,
      "discoverer": "Henri Moissan",
      "yearDiscovered": 1886,
      "uses": ["Toothpaste", "Teflon", "Refrigerants"],
      "properties": {
        "meltingPoint": -219.67,
        "boilingPoint": -188.11,
        "density": 0.001696,
        "state": "Gas"
      }
    },
    {
      "symbol": "Ne",
      "name": "Neon",
      "atomicNumber": 10,
      "atomicMass": 20.180,
      "category": "Noble Gases",
      "color": "#E1F5FE",
      "electrons": "2,8",
      "protons": 10,
      "neutrons": 10,
      "group": 18,
      "period": 2,
      "discoverer": "William Ramsay",
      "yearDiscovered": 1898,
      "uses": ["Neon signs", "Lasers", "Cryogenic refrigerant"],
      "properties": {
        "meltingPoint": -248.59,
        "boilingPoint": -246.05,
        "density": 0.0009002,
        "state": "Gas"
      }
    },
  ];

  List<Map<String, dynamic>> get filteredElements {
    return elements.where((element) {
      bool categoryMatch = selectedCategory == "All" || element["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty ||
          element["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          element["symbol"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Periodic Table"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Show periodic table info
            },
          ),
          IconButton(
            icon: Icon(Icons.quiz),
            onPressed: () {
              // Navigate to element quiz
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search elements...",
                  value: searchQuery,
                  hint: "Enter element name or symbol",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Periodic Table Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.science,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interactive Periodic Table",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tap on any element to explore its properties",
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
                      spacing: spXs,
                      children: [
                        Text(
                          "Element Categories",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spXs,
                          children: [
                            _buildLegendItem("Alkali Metals", Color(0xFFF8BBD9)),
                            _buildLegendItem("Noble Gases", Color(0xFFE1F5FE)),
                            _buildLegendItem("Halogens", Color(0xFFDCEDC8)),
                            _buildLegendItem("Nonmetals", Color(0xFFFFEB3B)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Elements Grid
                  Text(
                    "Elements (${filteredElements.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredElements.map((element) {
                      return GestureDetector(
                        onTap: () {
                          selectedElement = element;
                          _showElementDetails();
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Color(int.parse(element["color"].toString().replaceAll("#", "0xFF"))),
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: primaryColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${element["atomicNumber"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${element["category"]}",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "${element["symbol"]}",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${element["name"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${element["atomicMass"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
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
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(
              color: primaryColor.withAlpha(50),
              width: 1,
            ),
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

  void _showElementDetails() {
    if (selectedElement == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Element Header
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Color(int.parse(selectedElement!["color"].toString().replaceAll("#", "0xFF"))),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Center(
                              child: Text(
                                "${selectedElement!["symbol"]}",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${selectedElement!["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Atomic Number: ${selectedElement!["atomicNumber"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Atomic Mass: ${selectedElement!["atomicMass"]}",
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
                    ),

                    // Atomic Structure
                    _buildDetailSection(
                      "Atomic Structure",
                      Icons.science,
                      [
                        "Protons: ${selectedElement!["protons"]}",
                        "Neutrons: ${selectedElement!["neutrons"]}",
                        "Electrons: ${selectedElement!["electrons"]}",
                        "Group: ${selectedElement!["group"]}",
                        "Period: ${selectedElement!["period"]}",
                      ],
                    ),

                    // Physical Properties
                    _buildDetailSection(
                      "Physical Properties",
                      Icons.thermostat,
                      [
                        "State: ${selectedElement!["properties"]["state"]}",
                        "Melting Point: ${selectedElement!["properties"]["meltingPoint"]}°C",
                        "Boiling Point: ${selectedElement!["properties"]["boilingPoint"]}°C",
                        "Density: ${selectedElement!["properties"]["density"]} g/cm³",
                      ],
                    ),

                    // Discovery
                    _buildDetailSection(
                      "Discovery",
                      Icons.history_edu,
                      [
                        "Discoverer: ${selectedElement!["discoverer"]}",
                        "Year: ${selectedElement!["yearDiscovered"]}",
                      ],
                    ),

                    // Uses
                    Container(
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
                              Icon(
                                Icons.build,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Common Uses",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (selectedElement!["uses"] as List).map((use) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$use",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Close Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Close",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, IconData icon, List<String> properties) {
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
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ...properties.map((property) {
            return Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  property,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
