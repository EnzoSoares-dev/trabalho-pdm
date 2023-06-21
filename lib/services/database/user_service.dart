import 'connection.dart';
import 'tasks_service.dart';

class UserService {
  var banco = Connection();
  var taskService = TaskService();

  insertUser(String name, email, password) {
    banco.mappedQuery(
        "insert into tb_user values(nextval('user_sequence'), $name, $email, $password)",
        banco.insertCompleto,
        banco.erroInsert);
  }

  findUser(String email, password) {
    banco.mappedQuery(
      "select * from tb_user where nm_email = $email and ps_senha = $password",
      (result, numRegistros) {
        print(result);
        return result;
    },
      (e) {
        return "Usuário não encontrado";
      }
    );
  }

  findUserById(int idUser) {
    banco.mappedQuery("select * from tb_user where id_usuario = $idUser",
        (result, numRegistro) {
      return result;
    }, (e) {
      return "Não foi possível encontrar o usuário";
    });
  }

  updateUser(int idUser, String dado) {
    
  }

  deleteUser(int idUser) {
    taskService.deleteTaskbyUser(idUser);
    banco.mappedQuery("Delete from tb_user where id_user = $idUser",
        (result, numRegistro) {
      return "Usuário deletado";
    }, (e) {
      return "Não foi possiível deletar o usuário";
    });
  }
}
