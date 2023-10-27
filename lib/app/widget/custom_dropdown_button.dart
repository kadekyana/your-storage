import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final double width;
  final String value;
  final List items;
  final Widget icon;
  final Color backgroundColor;
  final void Function(String value) changeValue;

  const CustomDropdownButton(
      {super.key,
      required this.width,
      required this.value,
      required this.backgroundColor,
      required this.changeValue,
      required this.icon,
      required this.items});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          iconStyleData: IconStyleData(
            icon: widget.icon,
            iconEnabledColor: const Color(0xFFC5C6CC),
            iconDisabledColor: const Color(0xFFC5C6CC),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(5),
                color: widget.backgroundColor),
          ),
          items: widget.items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontFamily: 'Poppins'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          value: widget.value,
          onChanged: (value) {
            widget.changeValue(value!.toString());
          },
        ),
      ),
    );
  }
}
