import 'package:flutter/material.dart';
import 'package:lojavirtual/informations/users/user_type.dart';
import 'package:lojavirtual/models/widgets/custom_button.dart';
import 'package:lojavirtual/models/widgets/custom_text.dart';
import 'package:lojavirtual/models/widgets/custom_textfiled.dart';
import 'package:lojavirtual/view/pages/new_user.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: GestureDetector(
                  child: CustomText(
                    colortype: Colors.white,
                    fontsize: 18,
                    textform: "Criar Conta",
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NewUser()));
                  },
                ))
          ],
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
                          controller: emailController,
                          labeltext: "Email",
                        ),
                        const SizedBox(height: 12),
                        CustomTextfiled(
                          controller: passwordController,
                          labeltext: "Senha",
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              if (emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "insira um Email para recuperacão da senha!"),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  duration: const Duration(seconds: 4),
                                ));
                              } else {
                                user.recoverPass(emailController.text);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "mensagem de recuperação enviada para seu email"),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  duration: const Duration(seconds: 4),
                                ));
                              }
                            },
                            child: Text("Esqueci Minha Senha"),
                          ),
                        ),
                        SizedBox(height: 12),
                        CustomButtom(
                          textform: "Entrar",
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<UserType>().signIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    onSuccess: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              "Login realizado com sucesso!"),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    onFailed: (message) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(message.isNotEmpty
                                              ? message
                                              : "Erro ao fazer login!"),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    },
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
