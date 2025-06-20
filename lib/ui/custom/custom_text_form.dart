import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/design_colors.dart';

class DesignFormField extends StatelessWidget {
  const DesignFormField({
    super.key,
    required this.controller,
     this.labelText,
    this.hintText,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.readOnly = false,
    this.isOptional = false,
    this.obscureText = false,
    this.validator,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.contentPadding,
    this.prefixIcon,
    this.inputFormatters,
    this.suffixIcon,
    this.fillColor,
    this.maxLength,
    this.style,
    this.labelStyle,
    this.borderRadius,
  });
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool? enabled;
  final bool autofocus;
  final bool isOptional;
  final bool obscureText;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          readOnly: readOnly,
          style: style,
          enabled: enabled,
          autofocus: autofocus,
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          validator: isOptional
              ? null
              : validator ??
                  (val) {
                    if (isOptional) {
                      return null;
                    }
                    if (val == null || val.isEmpty) {
                      return "$labelText is required";
                    }
                    return null;
                  },
          onTapOutside: (event) {
            final currentFocus = FocusScope.of(context);
            if (currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          maxLength: maxLength,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            labelStyle: labelStyle ??
                const TextStyle(
                  color: DesignColor.grey400,
                ),
            filled: true,
            isDense: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            fillColor: fillColor ?? DesignColor.grey50,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: contentPadding ?? const EdgeInsets.all(10),
            //contentPadding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: DesignColor.grey300, width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: DesignColor.grey300, width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: DesignColor.grey300, width: 1.0),
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
          ),
          textCapitalization: TextCapitalization.sentences,
          keyboardType: keyboardType,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          // enableInteractiveSelection: false,
        ),
        // if (!isOptional && controller.text.isEmpty)
        //   const Positioned(
        //     top: 2,
        //     left: 4,
        //     child: DesignText(
        //       '*',
        //       fontSize: 10,
        //       fontWeight: 600,
        //       color: Colors.red,
        //     ),
        //   )
      ],
    );
  }
}

class DesignDropDownForm extends StatelessWidget {
  const DesignDropDownForm({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.readOnly = false,
    this.items,
    this.onChanged,
    this.isOptional = false,
    this.value,
    this.onTap,
    this.contentPadding,
    this.prefixIcon,
  });
  final String labelText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool? enabled;
  final bool isOptional;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final Object? value;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            onTap: onTap,
            items: items,
            value: value,
            alignment: Alignment.center,
            onChanged: onChanged,
            padding: EdgeInsets.zero,
            validator: (val) {
              if (isOptional) {
                return null;
              }
              if (val == null) {
                return "Field Required";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: labelText,
              filled: true,
              isDense: true,
              prefixIcon: prefixIcon,
              labelStyle: const TextStyle(
                color: DesignColor.grey400,
              ),
              fillColor: DesignColor.grey50,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: contentPadding ?? const EdgeInsets.all(10),
              //contentPadding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: DesignColor.grey300, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: DesignColor.grey300, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: DesignColor.grey300, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            isExpanded: true,
          ),
        ),
        // if (!isOptional)
        //   const Positioned(
        //     top: 2,
        //     left: 4,
        //     child: DesignText(
        //       '*',
        //       fontSize: 10,
        //       fontWeight: 600,
        //       color: Colors.red,
        //     ),
        //   )
      ],
    );
  }
}
