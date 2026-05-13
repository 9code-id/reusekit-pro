import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaGroceryListView extends StatefulWidget {
  const FwaGroceryListView({super.key});

  @override
  State<FwaGroceryListView> createState() => _FwaGroceryListViewState();
}

class _FwaGroceryListViewState extends State<FwaGroceryListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Category";
  bool showCompleted = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Fruits", "value": "Fruits"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Protein", "value": "Protein"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Pantry", "value": "Pantry"},
    {"label": "Frozen", "value": "Frozen"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Category", "value": "Category"},
    {"label": "Alphabetical", "value": "Alphabetical"},
    {"label": "Priority", "value": "Priority"},
    {"label": "Store Section", "value": "Store Section"},
  ];

  List<Map<String, dynamic>> groceryItems = [
    {
      "id": 1,
      "name": "Bananas",
      "category": "Fruits",
      "quantity": "6 pieces",
      "priority": "High",
      "price": 2.99,
      "store": "Produce Section",
      "notes": "Choose ripe ones",
      "completed": false,
      "recipe": "Protein Smoothie",
      "urgent": true,
    },
    {
      "id": 2,
      "name": "Chicken Breast",
      "category": "Protein",
      "quantity": "2 lbs",
      "priority": "High",
      "price": 8.99,
      "store": "Meat Section",
      "notes": "Organic preferred",
      "completed": true,
      "recipe": "Grilled Chicken Salad",
      "urgent": false,
    },
    {
      "id": 3,
      "name": "Greek Yogurt",
      "category": "Dairy",
      "quantity": "32 oz",
      "priority": "Medium",
      "price": 5.49,
      "store": "Dairy Section",
      "notes": "Plain, low-fat",
      "completed": false,
      "recipe": "Greek Yogurt with Nuts",
      "urgent": false,
    },
    {
      "id": 4,
      "name": "Spinach",
      "category": "Vegetables",
      "quantity": "1 bag",
      "priority": "Medium",
      "price": 3.99,
      "store": "Produce Section",
      "notes": "Fresh, not frozen",
      "completed": false,
      "recipe": "Protein Smoothie",
      "urgent": false,
    },
    {
      "id": 5,
      "name": "Quinoa",
      "category": "Grains",
      "quantity": "1 lb",
      "priority": "Low",
      "price": 4.99,
      "store": "Pantry Section",
      "notes": "Tri-color variety",
      "completed": false,
      "recipe": "Baked Salmon with Quinoa",
      "urgent": false,
    },
    {
      "id": 6,
      "name": "Salmon Fillet",
      "category": "Protein",
      "quantity": "4 fillets",
      "priority": "High",
      "price": 16.99,
      "store": "Seafood Section",
      "notes": "Fresh, skin-on",
      "completed": false,
      "recipe": "Baked Salmon with Quinoa",
      "urgent": true,
    },
    {
      "id": 7,
      "name": "Almonds",
      "category": "Pantry",
      "quantity": "1 lb",
      "priority": "Low",
      "price": 7.99,
      "store": "Nuts Section",
      "notes": "Raw, unsalted",
      "completed": true,
      "recipe": "Greek Yogurt with Nuts",
      "urgent": false,
    },
    {
      "id": 8,
      "name": "Oats",
      "category": "Grains",
      "quantity": "18 oz",
      "priority": "Medium",
      "price": 3.49,
      "store": "Cereal Aisle",
      "notes": "Steel-cut preferred",
      "completed": false,
      "recipe": "Overnight Oats with Berries",
      "urgent": false,
    },
    {
      "id": 9,
      "name": "Mixed Berries",
      "category": "Frozen",
      "quantity": "1 bag",
      "priority": "Medium",
      "price": 4.99,
      "store": "Frozen Section",
      "notes": "Organic blend",
      "completed": false,
      "recipe": "Overnight Oats with Berries",
      "urgent": false,
    },
    {
      "id": 10,
      "name": "Almond Milk",
      "category": "Dairy",
      "quantity": "64 oz",
      "priority": "Medium",
      "price": 3.99,
      "store": "Dairy Section",
      "notes": "Unsweetened",
      "completed": false,
      "recipe": "Protein Smoothie",
      "urgent": false,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = groceryItems.where((item) {
      bool matchesSearch = item["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["category"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool showItem = showCompleted || !item["completed"];
      return matchesSearch && matchesCategory && showItem;
    }).toList();

    // Sort items
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Alphabetical":
          return a["name"].compareTo(b["name"]);
        case "Priority":
          Map<String, int> priorityOrder = {"High": 3, "Medium": 2, "Low": 1};
          return (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
        case "Store Section":
          return a["store"].compareTo(b["store"]);
        default:
          return a["category"].compareTo(b["category"]);
      }
    });

    return filtered;
  }

  Map<String, dynamic> get listSummary {
    int totalItems = groceryItems.length;
    int completedItems = groceryItems.where((item) => item["completed"]).length;
    double totalCost = groceryItems.fold(0.0, (sum, item) => sum + (item["price"] as double));
    int urgentItems = groceryItems.where((item) => item["urgent"] && !item["completed"]).length;

    return {
      "total": totalItems,
      "completed": completedItems,
      "remaining": totalItems - completedItems,
      "cost": totalCost,
      "urgent": urgentItems,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Card
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
                      Icon(Icons.shopping_cart, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Shopping Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Total Items",
                          "${listSummary["total"]}",
                          Icons.list,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Completed",
                          "${listSummary["completed"]}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Est. Cost",
                          "\$${(listSummary["cost"] as double).toStringAsFixed(2)}",
                          Icons.attach_money,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Urgent",
                          "${listSummary["urgent"]}",
                          Icons.priority_high,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search items...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Category Filter
            QCategoryPicker(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Sort and View Options
            Row(
              children: [
                Expanded(
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
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Completed",
                        "value": true,
                        "checked": showCompleted,
                      }
                    ],
                    value: [if (showCompleted) {"label": "Show Completed", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showCompleted = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Grocery Items List
            ...filteredItems.map((item) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: item["urgent"] && !item["completed"]
                      ? Border.all(color: dangerColor, width: 2)
                      : item["completed"]
                          ? Border.all(color: successColor, width: 2)
                          : null,
                ),
                child: Row(
                  children: [
                    // Checkbox
                    GestureDetector(
                      onTap: () {
                        item["completed"] = !item["completed"];
                        setState(() {});
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: item["completed"] ? successColor : Colors.transparent,
                          border: Border.all(
                            color: item["completed"] ? successColor : disabledBoldColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: item["completed"]
                            ? Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                    SizedBox(width: spSm),

                    // Item Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: item["completed"] ? disabledBoldColor : primaryColor,
                                    decoration: item["completed"] ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ),
                              if (item["urgent"] && !item["completed"])
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "URGENT",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(item["category"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getCategoryColor(item["category"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${(item["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: item["completed"] ? disabledBoldColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          if (item["notes"].isNotEmpty)
                            Text(
                              "${item["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          if (item["recipe"].isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.restaurant, size: 12, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "For: ${item["recipe"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Icon(Icons.store, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${item["store"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(item["priority"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["priority"]} Priority",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: _getPriorityColor(item["priority"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Menu
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }).toList(),

            // Quick Add Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Quick Add",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Item name",
                          value: "",
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Add",
                        size: bs.sm,
                        onPressed: () {},
                      ),
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

  Widget _buildSummaryCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Fruits":
        return warningColor;
      case "Vegetables":
        return successColor;
      case "Protein":
        return dangerColor;
      case "Dairy":
        return infoColor;
      case "Grains":
        return secondaryColor;
      case "Pantry":
        return primaryColor;
      case "Frozen":
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
