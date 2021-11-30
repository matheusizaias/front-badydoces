import 'dart:html';

import 'package:badydoces/views/auth/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset('lib/assets/images/LOGO.png'),
                      decoration: BoxDecoration(),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: MyStatefulWidget(),
                  ))
            ],
          ),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showAlertDialog1(BuildContext context) {
// configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

// configura o AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Erro no login"),
      content: Text("Seu email ou/e sua senha não estão correto(s)."),
      actions: [
        okButton,
      ],
    );

// exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            onChanged: (value) {
              Provider.of<AuthController>(context, listen: false)
                  .usuario
                  .email = value;
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(),
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu usuário';
              }
              return null;
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: TextFormField(
              onChanged: (value) {
                Provider.of<AuthController>(context, listen: false)
                    .usuario
                    .password = value;
              },
              decoration: const InputDecoration(
                labelText: 'Senha',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                      shadowColor: Colors.black54,
                      elevation: 4,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await Provider.of<AuthController>(context,
                                listen: false)
                            .login();
                        var loggin =
                            Provider.of<AuthController>(context, listen: false)
                                .isLoggedUser;
                        if (loggin == true) {
                          Provider.of<AuthController>(context, listen: false)
                              .autenticar();
                          Navigator.of(context).pushNamed('/tela_inicial');
                        } else {
                          return showAlertDialog1(context);
                        }
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
