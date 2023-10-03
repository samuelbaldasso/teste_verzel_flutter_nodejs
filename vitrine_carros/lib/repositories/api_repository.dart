import 'package:vitrine_carros/models/carro.dart';
import 'package:vitrine_carros/models/user.dart';

abstract class ApiRepository {
  Future<List<Carro>> getCarros();
  Future<Carro> getCarro(Carro carro);
  Future<void> postCarro(Carro carro);
  Future<Carro> putCarro(Carro carro);
  Future<void> deleteCarro(Carro carro);

  Future<List<User>> getUsers();
  Future<User?> fetchCurrentUser();
  Future<void> loginUser(User user);
  Future<void> registerUser(User user);
  Future<User> putUser(User user);
  Future<void> deleteUser(User user);
  Future<void> setToken(String token);
  Future<void> setUserId(String userId);
  Future<String?> getUserId();
  Future<String?> getToken();
  Future<void> removeTokens();
}
