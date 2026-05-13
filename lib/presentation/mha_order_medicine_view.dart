import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaOrderMedicineView extends StatefulWidget {
  const MhaOrderMedicineView({super.key});

  @override
  State<MhaOrderMedicineView> createState() => _MhaOrderMedicineViewState();
}

class _MhaOrderMedicineViewState extends State<MhaOrderMedicineView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "name";
  bool prescriptionRequired = false;
  
  // Sample medicine data
  List<Map<String, dynamic>> medicines = [
    {
      "id": "1",
      "name": "Paracetamol 500mg",
      "category": "Pain Relief",
      "price": 15.99,
      "originalPrice": 18.99,
      "discount": 16,
      "inStock": true,
      "quantity": 50,
      "brand": "Tylenol",
      "description": "Fast-acting pain relief and fever reducer",
      "image": "https://picsum.photos/120/120?random=1&keyword=medicine",
      "prescriptionRequired": false,
      "rating": 4.5,
      "reviews": 128,
      "forms": ["Tablet", "Liquid"],
      "dosage": "500mg",
      "manufacturer": "Johnson & Johnson"
    },
    {
      "id": "2", 
      "name": "Amoxicillin 250mg",
      "category": "Antibiotics",
      "price": 24.50,
      "originalPrice": 24.50,
      "discount": 0,
      "inStock": true,
      "quantity": 30,
      "brand": "Amoxil",
      "description": "Broad-spectrum antibiotic for bacterial infections",
      "image": "https://picsum.photos/120/120?random=2&keyword=pills",
      "prescriptionRequired": true,
      "rating": 4.7,
      "reviews": 89,
      "forms": ["Capsule", "Suspension"],
      "dosage": "250mg",
      "manufacturer": "GSK"
    },
    {
      "id": "3",
      "name": "Vitamin D3 1000 IU",
      "category": "Vitamins",
      "price": 12.99,
      "originalPrice": 15.99,
      "discount": 19,
      "inStock": true,
      "quantity": 75,
      "brand": "Nature Made",
      "description": "Essential vitamin for bone health and immunity",
      "image": "https://picsum.photos/120/120?random=3&keyword=vitamins",
      "prescriptionRequired": false,
      "rating": 4.6,
      "reviews": 203,
      "forms": ["Softgel", "Tablet"],
      "dosage": "1000 IU",
      "manufacturer": "Pharmavite"
    },
    {
      "id": "4",
      "name": "Lisinopril 10mg",
      "category": "Heart & Blood",
      "price": 18.75,
      "originalPrice": 18.75,
      "discount": 0,
      "inStock": false,
      "quantity": 0,
      "brand": "Prinivil",
      "description": "ACE inhibitor for high blood pressure",
      "image": "https://picsum.photos/120/120?random=4&keyword=heart",
      "prescriptionRequired": true,
      "rating": 4.3,
      "reviews": 67,
      "forms": ["Tablet"],
      "dosage": "10mg",
      "manufacturer": "Merck"
    },
    {
      "id": "5",
      "name": "Omeprazole 20mg",
      "category": "Digestive",
      "price": 16.25,
      "originalPrice": 19.99,
      "discount": 19,
      "inStock": true,
      "quantity": 40,
      "brand": "Prilosec",
      "description": "Proton pump inhibitor for acid reflux",
      "image": "https://picsum.photos/120/120?random=5&keyword=stomach",
      "prescriptionRequired": false,
      "rating": 4.4,
      "reviews": 156,
      "forms": ["Capsule", "Tablet"],
      "dosage": "20mg",
      "manufacturer": "P&G"
    },
    {
      "id": "6",
      "name": "Metformin 500mg",
      "category": "Diabetes",
      "price": 22.50,
      "originalPrice": 22.50,
      "discount": 0,
      "inStock": true,
      "quantity": 25,
      "brand": "Glucophage",
      "description": "First-line treatment for type 2 diabetes",
      "image": "https://picsum.photos/120/120?random=6&keyword=diabetes",
      "prescriptionRequired": true,
      "rating": 4.8,
      "reviews": 94,
      "forms": ["Tablet", "Extended Release"],
      "dosage": "500mg",
      "manufacturer": "Bristol Myers"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Pain Relief", "value": "Pain Relief"},
    {"label": "Antibiotics", "value": "Antibiotics"},
    {"label": "Vitamins", "value": "Vitamins"},
    {"label": "Heart & Blood", "value": "Heart & Blood"},
    {"label": "Digestive", "value": "Digestive"},
    {"label": "Diabetes", "value": "Diabetes"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name A-Z", "value": "name"},
    {"label": "Price Low to High", "value": "price_asc"},
    {"label": "Price High to Low", "value": "price_desc"},
    {"label": "Best Rating", "value": "rating"},
    {"label": "Most Popular", "value": "reviews"},
  ];

  Map<String, int> cart = {};

  List<Map<String, dynamic>> get filteredMedicines {
    var filtered = medicines.where((medicine) {
      bool matchesSearch = medicine["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          medicine["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || medicine["category"] == selectedCategory;
      bool matchesPrescription = !prescriptionRequired || medicine["prescriptionRequired"] == false;
      
      return matchesSearch && matchesCategory && matchesPrescription;
    }).toList();

    // Sort medicines
    switch (sortBy) {
      case "price_asc":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_desc":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "reviews":
        filtered.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
      default:
        filtered.sort((a, b) => a["name"].toString().compareTo(b["name"].toString()));
    }

    return filtered;
  }

  int get cartItemCount {
    return cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  double get cartTotal {
    double total = 0.0;
    cart.forEach((medicineId, quantity) {
      var medicine = medicines.firstWhere((m) => m["id"] == medicineId);
      total += ((medicine["price"] as double) * quantity);
    });
    return total;
  }

  void addToCart(String medicineId) {
    setState(() {
      cart[medicineId] = (cart[medicineId] ?? 0) + 1;
    });
    ss("Added to cart");
  }

  void removeFromCart(String medicineId) {
    setState(() {
      if (cart.containsKey(medicineId)) {
        if ((cart[medicineId] ?? 0) > 1) {
          cart[medicineId] = (cart[medicineId] ?? 0) - 1;
        } else {
          cart.remove(medicineId);
        }
      }
    });
  }

  void _showMedicineDetail(Map<String, dynamic> medicine) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${medicine["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusMd),
                          child: Image.network(
                            "${medicine["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${medicine["brand"]} - ${medicine["dosage"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${medicine["rating"]} (${medicine["reviews"]} reviews)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
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
                            if ((medicine["discount"] as int) > 0) ...[
                              Text(
                                "\$${(medicine["originalPrice"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(height: spXs),
                            ],
                            Text(
                              "\$${(medicine["price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if ((medicine["discount"] as int) > 0) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${medicine["discount"]}% OFF",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: spMd),
                    if (medicine["prescriptionRequired"] == true) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: warningColor, width: 1),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.medical_services, color: warningColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Prescription Required",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                    ],
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${medicine["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available Forms",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(medicine["forms"] as List).join(", ")}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
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
                                "Manufacturer",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${medicine["manufacturer"]}",
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
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(
                          (medicine["inStock"] as bool) ? Icons.check_circle : Icons.cancel,
                          color: (medicine["inStock"] as bool) ? successColor : dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          (medicine["inStock"] as bool) 
                            ? "${medicine["quantity"]} in stock" 
                            : "Out of stock",
                          style: TextStyle(
                            fontSize: 14,
                            color: (medicine["inStock"] as bool) ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: disabledOutlineBorderColor, width: 1)),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  if (cart.containsKey(medicine["id"])) ...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => removeFromCart(medicine["id"]),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              child: Icon(Icons.remove, color: primaryColor, size: 18),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            child: Text(
                              "${cart[medicine["id"]] ?? 0}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (medicine["inStock"] as bool) ? () => addToCart(medicine["id"]) : null,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              child: Icon(
                                Icons.add, 
                                color: (medicine["inStock"] as bool) ? primaryColor : disabledBoldColor, 
                                size: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                  ],
                  Expanded(
                    child: QButton(
                      label: cart.containsKey(medicine["id"]) ? "Update Cart" : "Add to Cart",
                      size: bs.md,
                      onPressed: (medicine["inStock"] as bool) ? () => addToCart(medicine["id"]) : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Medicine"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigate to cart
                  //navigateTo('MhaMedicineCartView')
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "$cartItemCount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search medicines...",
                        value: searchQuery,
                        hint: "Search by name or brand",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
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
                  ],
                ),
                SizedBox(height: spSm),
                
                // Prescription Filter
                QSwitch(
                  items: [
                    {
                      "label": "Hide prescription medicines",
                      "value": true,
                      "checked": prescriptionRequired,
                    }
                  ],
                  value: [
                    if (prescriptionRequired)
                      {
                        "label": "Hide prescription medicines",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    prescriptionRequired = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Medicine Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  if (filteredMedicines.isEmpty) ...[
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: spXl),
                          Icon(Icons.search_off, size: 64, color: disabledBoldColor),
                          SizedBox(height: spMd),
                          Text(
                            "No medicines found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: filteredMedicines.map((medicine) {
                        bool isInCart = cart.containsKey(medicine["id"]);
                        int cartQuantity = cart[medicine["id"]] ?? 0;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                      child: Image.network(
                                        "${medicine["image"]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if ((medicine["discount"] as int) > 0)
                                    Positioned(
                                      top: spSm,
                                      left: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${medicine["discount"]}% OFF",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (medicine["prescriptionRequired"] == true)
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.medical_services, color: Colors.white, size: 12),
                                      ),
                                    ),
                                  if (!(medicine["inStock"] as bool))
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(128),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "OUT OF STOCK",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${medicine["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${medicine["brand"]} - ${medicine["dosage"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: warningColor, size: 14),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${medicine["rating"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          " (${medicine["reviews"]})",
                                          style: TextStyle(
                                            fontSize: 10,
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
                                              if ((medicine["discount"] as int) > 0) ...[
                                                Text(
                                                  "\$${(medicine["originalPrice"] as double).toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledBoldColor,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ],
                                              Text(
                                                "\$${(medicine["price"] as double).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => _showMedicineDetail(medicine),
                                          child: Container(
                                            padding: EdgeInsets.all(spXs),
                                            decoration: BoxDecoration(
                                              color: infoColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Icon(Icons.info_outline, color: infoColor, size: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    if (isInCart) ...[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: primaryColor, width: 1),
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => removeFromCart(medicine["id"]),
                                                    child: Container(
                                                      padding: EdgeInsets.all(spXs),
                                                      child: Icon(Icons.remove, color: primaryColor, size: 16),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "$cartQuantity",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: (medicine["inStock"] as bool) ? () => addToCart(medicine["id"]) : null,
                                                    child: Container(
                                                      padding: EdgeInsets.all(spXs),
                                                      child: Icon(
                                                        Icons.add, 
                                                        color: (medicine["inStock"] as bool) ? primaryColor : disabledBoldColor, 
                                                        size: 16
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ] else ...[
                                      Container(
                                        width: double.infinity,
                                        child: QButton(
                                          label: "Add to Cart",
                                          size: bs.sm,
                                          onPressed: (medicine["inStock"] as bool) ? () => addToCart(medicine["id"]) : null,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: cartItemCount > 0 ? Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$cartItemCount items in cart",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${cartTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            QButton(
              label: "View Cart",
              size: bs.md,
              onPressed: () {
                // Navigate to cart
                //navigateTo('MhaMedicineCartView')
              },
            ),
          ],
        ),
      ) : null,
    );
  }
}
