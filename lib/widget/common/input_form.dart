import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/common/validation.dart' as Validation;

class InputForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> fields;
  final void Function(String key, dynamic data) onUpdateResult;
  bool readOnly;

  InputForm({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onUpdateResult,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: fields.keys.map((key) {
            final field = (fields[key] ?? {}) as Map<String, dynamic>;
            return TextFormField(
              autocorrect: false,
              readOnly: readOnly,
              onSaved: (value) {
                onUpdateResult(key, value);
              },
              validator: (value) => Validation.match(field['type'], value),
              obscureText: field['obscure'] ?? false,
              decoration: InputDecoration(
                hintText: field['hint'] ?? "",
                hintStyle: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.8),
                  fontWeight: FontWeight.w300,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
