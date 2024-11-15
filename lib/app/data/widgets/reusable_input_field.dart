import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableInputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;
  final List<String>? suggestions;

  const ReusableInputField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.enabled = true,
    this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      enabled: enabled,
      contentPadding: const EdgeInsets.all(0),
      subtitle: suggestions != null
          ? Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return suggestions!.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                controller.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  validator: validator,
                  enabled: enabled,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  onChanged: (String value) {
                    controller.text = value;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return ListTile(
                            title: Text(option),
                            onTap: () {
                              onSelected(option);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          : TextFormField(
              controller: controller,
              validator: validator,
              enabled: enabled,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
    );
  }
}
