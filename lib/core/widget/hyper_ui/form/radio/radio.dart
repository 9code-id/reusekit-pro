//#TEMPLATE reuseable_radio_field
import 'package:flutter/material.dart';
import 'package:reusekit/core/theme/theme_config.dart';

class QRadioField extends StatefulWidget {
  const QRadioField({
    required this.label,
    required this.items,
    required this.onChanged,
    super.key,
    this.validator,
    this.hint,
    this.helper,
    this.value,
  });
  final String label;
  final String? hint;
  final String? helper;
  final List<Map<String, dynamic>> items;
  final String? Function(List<Map<String, dynamic>> item)? validator;
  final Function(dynamic value, String? label) onChanged;
  final String? value;

  @override
  State<QRadioField> createState() => _QRadioFieldState();
}

class _QRadioFieldState extends State<QRadioField> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    for (final item in widget.items) {
      items.add(Map.from(item));
      if (items.last['value'] == widget.value) {
        items.last['checked'] = true;
      }
    }
  }

  void setAllItemsToFalse() {
    for (final item in items) {
      item['checked'] = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: textfieldMaxHeight * items.length,
      child: FormField(
        initialValue: false,
        validator: (value) => widget.validator!(items),
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
                    setAllItemsToFalse();
                    items[index]['checked'] = true;
                    field.didChange(true);
                    setState(() {});

                    final String? label = items[index]['label'];
                    final foundIndex = items
                        .indexWhere((item) => item['label'] == label);
                    final dynamic value = items[foundIndex]['value'];
                    widget.onChanged(value, label);
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
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: item['checked'] == true
                                  ? primaryColor
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            color: Colors.transparent,
                          ),
                          child: item['checked'] == true
                              ? Container(
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                )
                              : null,
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
