import 'package:flutter/material.dart';
import 'package:lojavirtual/informations/users/user_type.dart';
import 'package:lojavirtual/models/widgets/custom_button.dart';
import 'package:lojavirtual/models/widgets/custom_text.dart';
import 'package:lojavirtual/models/widgets/custom_textfiled.dart';
import 'package:provider/provider.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});
  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final completeNameController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            textform: "Entrar",
            fontsize: 25,
            colortype: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 4, 125, 141),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
        body: Consumer<UserType>(
          builder: (context, user, child) => user.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: ListView(
                      children: [
                        CustomTextfiled(
                          controller: completeNameController,
                          labeltext: "Nome Completo",
                        ),
                        const SizedBox(height: 12),
                        CustomTextfiled(
                          controller: emailController,
                          labeltext: "Email",
                        ),
                        CustomTextfiled(
                          controller: passwordController,
                          labeltext: "Senha",
                        ),
                        CustomTextfiled(
                          controller: addressController,
                          labeltext: "Endereço",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButtom(
                            textform: "Criar Usuário",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> userData = {
                                  "name": completeNameController.text,
                                  "email": emailController.text,
                                  "address": addressController.text,
                                };
                                user.signUp(
                                  userData: userData,
                                  password: passwordController.text,
                                  onSuccess: onSuccess,
                                  onFailed: onFail,
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
        ));
  }

  void onSuccess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Usuário criado com sucesso!"),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void onFail(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
