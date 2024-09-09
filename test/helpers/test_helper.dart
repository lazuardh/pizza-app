import 'package:mockito/annotations.dart';
import 'package:pizza_app/features/todo/data/datasources/remote_todo_datasource.dart';
import 'package:pizza_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TodoRepository,
  RemoteTodoDatasource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
