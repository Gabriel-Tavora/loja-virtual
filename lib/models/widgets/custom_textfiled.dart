import 'package:flutter/material.dart';

class CustomTextfiled extends StatefulWidget {
  const CustomTextfiled({
    super.key,
    required this.controller,
    required this.labeltext,
  });

  final TextEditingController controller;
  final String labeltext;

  @override
  State<CustomTextfiled> createState() => _CustomTextfiledState();
}

class _CustomTextfiledState extends State<CustomTextfiled> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.labeltext == "Senha";

    return TextFormField(
      controller: widget.controller,
      obscureText: isPassword ? obscurePassword : false,
      validator: (value) {
        if (widget.labeltext == "Nome Completo") {
          if (value == null ||
              value.isEmpty ||
              RegExp(r'^[0-9]+$').hasMatch(value)) {
            return "Nome Inválido";
          }
        }

        if (widget.labeltext == "Endereço") {
          if (value == null || value.isEmpty || value.length < 5) {
            return "Endereço inválido!";
          }
        }

        if (widget.labeltext == "Email") {
          if (value == null || value.isEmpty || !value.contains("@")) {
            return "E-mail inválido!";
          }
        }

        if (widget.labeltext == "Senha") {
          if (value == null || value.isEmpty || value.length < 8) {
            return "Senha inválida!";
          }
        }

        return null;
      },
      decoration: InputDecoration(
        prefixIcon: widget.labeltext == "Email"
            ? const Icon(Icons.email)
            : widget.labeltext == "Senha"
                ? const Icon(Icons.lock)
                : widget.labeltext == "Nome Completo"
                    ? const Icon(Icons.person)
                    : widget.labeltext == "Endereço"
                        ? const Icon(Icons.location_on)
                        : null,

        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              )
            : null,

        labelText: widget.labeltext,

        labelStyle: TextStyle(
          color: Colors.grey.shade700,
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.cyan.shade700,
          ),
        ),

        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.cyan.shade400,
          ),
        ),
      ),
    );
  }
}
