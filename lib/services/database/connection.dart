import 'dart:async';

import 'package:postgres/postgres.dart';

class Connection {
  PostgreSQLConnection? _connection;
  List<Map<String, Map<String, dynamic>>>? _result;
  int? _numRegistros;

  Connection() {
    _init();
  }

  _init() async {
    try {
      _connection = PostgreSQLConnection("200.19.1.18", 5432, "enzosilva",
          queryTimeoutInSeconds: 90,
          timeoutInSeconds: 90,
          username: "enzosilva",
          password: "123456");
      print("conexão estabelecida");
    } catch (e) {
      print("Não foi possível conectar-se ao banco -$e");
      close();
    }
  }

  open() async {
    await _connection!.open();
  }

  close() {
    _connection!.close();
  }

  Future mappedQuery(String query, Function function, errorFunction,
      {Map<String, dynamic>? variables}) async {
    try {
      await open();
      _result = await _connection!.mappedResultsQuery(
        query,substitutionValues: variables
      );
      _numRegistros = _result!.length;
      return function(_result, _numRegistros);
    } catch (e) {
      errorFunction(e);
    } finally {
      close();
    }
  }

  criaSequenceUser() {
    mappedQuery(
        "Create sequence if exist user_sequence increment by 1 minvalue 1 owned by tb_user.id_usuario",
        criaSequenceCompleta,
        erroCriaSequence);
  }

  criaSequenceTask() {
    mappedQuery(
        "Create sequence if exist taks_sequence increment by 1 minvalue 1 owned by tb_task.id_task",
        criaSequenceCompleta,
        erroCriaSequence);
  }

  criaTabelaUsuer() {
    mappedQuery(
        "Create table if not exist tb_user(id_usuario int not null PRIMARY KEY, nm_nome varchar(50) not null, nm_email varchar(50) not null, ps_senha varchar(12) not null)",
        createTableCompleto,
        erroCreateTable);
  }

  criaTabelaAFazer() {
    mappedQuery(
        "Create table if not exist tb_task(id_task int not null PRIMARY KEY, nm_titulo varchar(50) not null, nm_desc varchar(20), bl_feito boolean  not null, id_user int not null)",
        createTableCompleto,
        erroCreateTable);
  }

  criaConstraint() {
    mappedQuery(
        "alter table tb_task add foreign key (id_user) references tb_user(id_user)",
        createConstraintCompleto,
        erroCrateConstraint);
  }

  criaSequenceCompleta(result, numRegistros) {
    print("Sequence criada");
  }

  createTableCompleto(result, numRegistros) {
    print("Tabela Criada");
  }

  createConstraintCompleto() {
    print("Constraint Criada");
  }

  insertCompleto(result, numRegistros) {
    print("Dado inserido na tabela");
  }

  erroCriaSequence(e) {
    print("Não foi possível criar a sequence -> $e");
  }

  erroCrateConstraint(e) {
    print("Não foi possível criar a constraint -> $e");
  }

  erroCreateTable(e) {
    print("Não foi possível inserir a tabela -> $e");
  }

  erroInsert(e) {
    print("Não foi possível realizar a inserção -> $e");
  }
}
