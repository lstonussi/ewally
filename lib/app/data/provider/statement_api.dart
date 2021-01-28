import 'package:dio/dio.dart';
import 'package:ewally/app/data/models/statement_model.dart';
import 'package:ewally/app/utils/generics.dart';
import 'package:get/get.dart' hide Response;

class StatementApi {
  final Dio _dio = Get.find<Dio>();
  Future<List<StatementModel>> getStatement(
      DateTime dateInitial, DateTime dateFinal) async {
    List<StatementModel> statements = [];
    Generics _generics = Generics();
    final token = await _generics.token;
    //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm');
    Response response = await _dio.get('/b2b/statement',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        queryParameters: {
          "initialDate":
              "${dateInitial.year}-${dateInitial.month.toString().padLeft(2, '0')}-${dateInitial.day.toString().padLeft(2, '0')}",
          "finalDate":
              "${dateFinal.year}-${dateFinal.month.toString().padLeft(2, '0')}-${dateFinal.day.toString().padLeft(2, '0')}"
        });

    if (response.statusCode == 200) {
      List<dynamic> dados = response.data['statement'];
      for (var i = 0; i < dados.length; i++) {
        statements.add(
          StatementModel.fromJson(dados[i]),
        );
      }
      return statements;
    } else
      return [];
  }
}
