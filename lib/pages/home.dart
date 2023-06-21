import 'package:flutter/material.dart';
import 'package:trabalho_final_pdm/pages/login.dart';
import 'package:trabalho_final_pdm/pages/register.dart';
import 'package:trabalho_final_pdm/services/database/connection.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var banco = Connection();

  @override
  Widget build(BuildContext context) {
    banco.criaTabelaUsuer();
    banco.criaTabelaAFazer();
    banco.criaConstraint();
    banco.criaSequenceUser();
    banco.criaSequenceTask();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realize'),
      ),
      body: Center(
          child: ListView(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bem vindo a Realize. \nPlataforma de controle de afazeres",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15, left: 90),
              child: Row(
                children: [
                  ElevatedButton(
                      child: const Text("Entrar"),
                      onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Login()))
                          }),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton(
                        onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Register()))
                            },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff646464))),
                        child: const Text("Cadastrar")),
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
