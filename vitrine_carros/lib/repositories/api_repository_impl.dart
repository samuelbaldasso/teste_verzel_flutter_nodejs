import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitrine_carros/models/carro.dart';
import 'package:vitrine_carros/models/user.dart';
import 'package:vitrine_carros/repositories/api_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiRepositoryImpl implements ApiRepository {
  final baseUrl = 'http://10.0.2.2:3001';
  final _dio = Dio();

  @override
  Future<List<Carro>> getCarros() async {
    try {
      final token = await getToken();
      final response = await _dio.get(
        '$baseUrl/carros/carros',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return (response.data as List)
          .map((carro) => Carro.fromMap(carro))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCarro(Carro carro) async {
    try {
      final token = await getToken();
      await _dio.delete(
        "$baseUrl/carros/carros/${carro.id}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    try {
      await _dio.delete("$baseUrl/users/users/${user.id}");
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Carro> getCarro(Carro carro) async {
    try {
      final token = await getToken();
      final res = await _dio.get(
        "$baseUrl/carros/carros/${carro.id}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return Carro.fromMap(res.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('$baseUrl/users/users');
      return (response.data as List).map((user) => User.fromMap(user)).toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> postCarro(Carro carro) async {
    final token = await getToken();
    try {
      await _dio.post(
        '$baseUrl/carros/carros',
        data: carro.toMap(), // Convertendo o objeto carro para um mapa.
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  Future<void> registerUser(User user) async {
    try {
      await _dio.post(
        '$baseUrl/auth/register',
        data: user.toMap(), // Convertendo o objeto carro para um mapa.
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Carro> putCarro(Carro carro) async {
    final token = await getToken();
    try {
      final res = await _dio.put(
        '$baseUrl/carros/carros/${carro.id}',
        data: carro.toMap(), // Convertendo o objeto carro para um mapa.
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return Carro.fromMap(res.data); // Retornar o carro atualizado
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User> putUser(User user) async {
    final token = await getToken();
    try {
      final res = await _dio.put(
        '$baseUrl/users/users/${user.id}',
        data: user.toMap(), // Convertendo o objeto usuário para um mapa.
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return User.fromMap(res.data); // Retornar o usuário atualizado
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<void> loginUser(User user) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: user.toMap(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(response.data['token']);

      if (response.data != null && response.data['token'] != null) {
        await setToken(response.data['token']);
      } else {
        throw Exception('Token não recebido no servidor.');
      }
      if (decodedToken['id'] != null) {
        await setUserId(decodedToken['id'].toString());
      } else {
        throw Exception('Id do usuário não encontrado.');
      }
    } on DioException catch (e) {
      throw Exception("Falha no login: ${e.message}");
    }
  }

  @override
  Future<User?> fetchCurrentUser() async {
    try {
      final token = await getToken();
      final userId = await getUserId();
      if (token == null || userId == null) return null;

      final response = await _dio.get('$baseUrl/users/users/$userId',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      return User.fromMap(response.data);
    } on DioException {
      throw Exception('Falha ao mostrar usuário!');
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }

  @override
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  @override
  Future<void> removeTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('token');
  }
}
