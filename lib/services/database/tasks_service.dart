import 'connection.dart';

class TaskService {
  var banco = Connection();
  deleteTaskbyUser(int idUser) {
    banco.mappedQuery(
      "Delete * from tb_task where id_usuario = $idUser",
      (result, numRegistros) {
        return "Atividades do usuário com id $idUser foram deletados";
      },
      (e) {
        return "Não foi possível deletar as atividades do usuário";
      }
    );
  }
}
