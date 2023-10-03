import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitrine_carros/models/user.dart';
import 'package:vitrine_carros/repositories/api_repository_impl.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final key = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 40,
          color: Colors.white,
          child: Image.asset(
            "assets/VitrineCarros.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Faça seu cadastro',
                  style: TextStyle(fontSize: 24),
                ),
                Form(
                    key: key,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                                controller: nameEC,
                                decoration: const InputDecoration(
                                  hintText: "Digite seu nome",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  fillColor: Colors.grey,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Nome obrigatório";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                                controller: emailEC,
                                decoration: const InputDecoration(
                                  hintText: "Digite seu e-mail",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  fillColor: Colors.grey,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email obrigatório";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                                controller: passwordEC,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Digite sua senha",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  fillColor: Colors.grey,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Senha obrigatória";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (key.currentState?.validate() ?? false) {
                                    try {
                                      await context
                                          .read<ApiRepositoryImpl>()
                                          .registerUser(User(
                                              nome: nameEC.text,
                                              email: emailEC.text,
                                              senha: passwordEC.text));
                                      nav.pop();
                                      const snackBar = SnackBar(
                                          content: Text(
                                              'Usuário registrado com sucesso!'));
                                      scaffold.showSnackBar(snackBar);
                                    } on DioException {
                                      const snackBar = SnackBar(
                                          content: Text(
                                              'Falha ao registrar usuário!'));
                                      scaffold.showSnackBar(snackBar);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 18.0, bottom: 18.0),
                                ),
                                child: const Text(
                                  "CADASTRAR",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
