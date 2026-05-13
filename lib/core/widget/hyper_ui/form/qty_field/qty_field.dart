//#TEMPLATE reuseable_number_field
import 'package:flutter/material.dart';
import 'package:reusekit/core/theme/theme_config.dart';

class QtyField extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final MainAxisAlignment mainAxisAlignment;

  const QtyField({
    super.key,
    required this.value,
    required this.onChanged,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  _QtyFieldState createState() => _QtyFieldState();
}

class _QtyFieldState extends State<QtyField> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  void _increment() {
    setState(() {
      _currentValue++;
    });
    widget.onChanged(_currentValue);
  }

  void _decrement() {
    if (_currentValue > 0) {
      setState(() {
        _currentValue--;
      });
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: textfieldMaxHeight),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXxs,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(radiusXl),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _decrement,
              child: Icon(Icons.remove, size: iconSm),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                ),
                child: Text(
                  '$_currentValue',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fs3xl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _increment,
              child: Icon(Icons.add, size: iconSm),
            ),
          ],
        ),
      ),
    );
  }
}
