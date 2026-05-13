//#TEMPLATE reuseable_switch
import 'package:flutter/material.dart';
import 'package:reusekit/core/theme/theme_config.dart';

class QSwitch extends StatefulWidget {
  const QSwitch({
    required this.items,
    required this.onChanged,
    super.key,
    this.label,
    this.validator,
    this.value,
    this.hint,
    this.helper,
  });
  final String? label;
  final String? hint;
  final String? helper;
  final List<Map<String, dynamic>> items;
  final String? Function(List<Map<String, dynamic>> item)? validator;
  final List? value;
  final Function(List<Map<String, dynamic>> values, List ids) onChanged;

  @override
  State<QSwitch> createState() => _QSwitchState();
}

class _QSwitchState extends State<QSwitch> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    for (final item in widget.items) {
      items.add(Map.from(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: textfieldMaxHeight * items.length,
      child: FormField(
        initialValue: false,
        validator: (value) =>
            widget.validator == null ? null : widget.validator!(items),
        builder: (FormFieldState<bool> field) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: spMd,
              ),
              labelText: widget.label,
              errorText: field.errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryColor),
              ),
              helperText: widget.helper,
              hintText: widget.hint,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: spMd,
              children: items.map((item) {
                final index = items.indexOf(item);
                return InkWell(
                  onTap: () {
                    items[index]['checked'] =
                        items[index]['checked'] == true ? false : true;
                    field.didChange(true);
                    setState(() {});

                    final selectedValues =
                        items.where((i) => i['checked'] == true).toList();

                    final ids = selectedValues.map((e) => e['value']).toList();
                    widget.onChanged(selectedValues, ids);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Container(
                          height: 18.0,
                          child: Transform.scale(
                            scale: 0.7,
                            alignment: Alignment.centerRight,
                            child: Switch(
                              padding: EdgeInsets.zero,
                              value: item['checked'] ?? false,
                              onChanged: (val) {
                                items[index]['checked'] = val;
                                field.didChange(true);
                                setState(() {});

                                final selectedValues = items
                                    .where((i) => i['checked'] == true)
                                    .toList();

                                final ids = selectedValues
                                    .map((e) => e['value'])
                                    .toList();
                                widget.onChanged(selectedValues, ids);
                              },
                              activeColor: primaryColor,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

//#END
