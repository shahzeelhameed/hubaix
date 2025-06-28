import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/population_model.dart';

class PopulationApiService {
  Future<List<Population>> fetchPopulationData() async {
    try {
      final url = Uri.parse('http://localhost:4000/api/population'); // update if needed
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List jsonData = jsonDecode(response.body);
        return jsonData.map((e) => Population.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load population data. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching population data: $e');
    }
  }
}
