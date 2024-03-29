import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';

class KTextFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmit;

  final TextEditingController? controller;
  final String? hint;
  final String? initialValue;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final String? desc;
  final bool? enabled;
  final IconData? prefix;
  final Widget? sufixIcon;
  final TextCapitalization? textCapitalization;
  final bool requiredText;
  final bool marginBottom;
  final VoidCallback? onTap;
  final bool showError;
  final bool? autofocus;
  final bool isFilled;
  final List<TextInputFormatter>? inputFormatter;
  const KTextFormField(
      {Key? key,
      this.validator,
      this.onChanged,
      this.onFieldSubmit,
      this.enabled = true,
      this.marginBottom = true,
      this.hint,
      required this.label,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.maxLines = 1,
      this.maxLength,
      this.controller,
      this.prefix,
      this.desc,
      this.textCapitalization,
      this.requiredText = false,
      this.initialValue,
      this.onTap,
      this.sufixIcon,
      this.autofocus,
      this.inputFormatter,
      this.showError = true,
      this.isFilled = false})
      : super(key: key);

  @override
  _KTextFormFieldState createState() =>
      // ignore: no_logic_in_create_state
      _KTextFormFieldState(obscureText: obscureText);
}

class _KTextFormFieldState extends State<KTextFormField> {
  String? errorText;
  bool interacted = false;

  bool obscureText;

  _KTextFormFieldState({required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.marginBottom ? EdgeInsets.only(bottom: 10.h) : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisSize: MainAxisSize.,
        children: [
          if (widget.label.isNotEmpty)
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.label,
                style: GoogleFonts.mulish(
                    color: textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.2),
              ),
            ),
          if (widget.desc != null)
            Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.info_outline_rounded, color: Color(0xff545454)),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        widget.desc ?? "",
                        // overflow: TextOverflow.visible,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            height: 1.3,
                            color: Color.fromARGB(255, 122, 122, 122)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            onTap: () {
              widget.onTap?.call();
            },
            autofocus: widget.autofocus ?? false,
            enabled: widget.enabled,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            obscureText: obscureText,
            initialValue: widget.initialValue,
            maxLength: widget.maxLength ?? (widget.maxLines > 1 ? 1000 : 100),
            maxLines: widget.maxLines,
            textAlignVertical: TextAlignVertical.center,
            style: GoogleFonts.mulish(
                color: textPrimary, fontSize: 16.sp, height: 1.2),
            cursorColor: textPrimary,
            inputFormatters: widget.inputFormatter,
            decoration: InputDecoration(
              counterText: "",

              border: widget.isFilled
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.h),
                      borderSide: BorderSide(color: Colors.transparent))
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.h),
                      borderSide: BorderSide(color: textPrimary)),
              hintText: widget.hint,
              focusedBorder: widget.isFilled
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.h),
                      borderSide: BorderSide(color: Colors.transparent))
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.h),
                      borderSide: BorderSide(color: textPrimary)),

              hintStyle: GoogleFonts.mulish(
                  color: Color(0xff828282), fontSize: 12.sp, height: 1.2),

              prefixIcon: widget.prefix != null
                  ? Icon(
                      widget.prefix,
                      color: Color(0xff828282),
                      size: 18.w,
                    )
                  : null,
              filled: widget.isFilled,

              fillColor: Color(0xff0A85B4).withOpacity(.1),
              isDense: true, // Added this
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              errorStyle: TextStyle(
                inherit: false,
                height: 0,
                fontSize: 0,
              ),

              suffixIcon: widget.sufixIcon ??
                  (widget.maxLines == 1
                      ? widget.obscureText
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                icon: Icon(
                                  obscureText
                                      ? FlutterRemix.eye_off_line
                                      : FlutterRemix.eye_line,
                                  color: Color(0xff828282),
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                            )
                          : interacted && errorText == null
                              ? Icon(Icons.check,
                                  color: Theme.of(context).primaryColor)
                              : null
                      : null),

              enabledBorder: widget.isFilled
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.h),
                      borderSide: BorderSide(color: Colors.transparent))
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.h),
                      borderSide: BorderSide(color: textPrimary)),
            ),
            validator: (value) {
              if (widget.validator != null) {
                setState(() {
                  errorText = widget.validator!(value);
                });
              }
              return errorText == null ? null : '';
            },
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: widget.onChanged != null
                ? widget.onChanged?.call
                : (value) {
                    if (widget.validator != null) {
                      setState(() {
                        errorText = widget.validator!(value);
                      });
                    }
                  },
            onSaved: (value) {
              if (widget.validator != null) {
                setState(() {
                  errorText = widget.validator!(value);
                });
              }
            },
            onFieldSubmitted: (value) {
              if (widget.onFieldSubmit != null) {
                widget.onFieldSubmit!.call(value);
              } else if (widget.validator != null) {
                setState(() {
                  errorText = widget.validator!(value);
                });
              }
            },
          ),
          widget.showError
              ? errorText != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Icon(Icons.error_outline_rounded,
                                size: 12.sp, color: redColor),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                errorText ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    height: 1,
                                    color: redColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 12.sp,
                    )
              : Container()
        ],
      ),
    );
  }
}
