import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //http 패키지 설치 후
  static Future<List<WebtoonModel>> getTodaysToons() async {
    final List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    /*
     get은 Future 타입을 반환함.
     요청을 처리하는데 오래 걸릴 수도 있다. 따라서 await async 사용
     */
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //resoponse.body는 String이다. 이를 jsonDecode 함수를 통해 json으로 바꿔준후 생성자에 넣어준다.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);

      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLastEpisodeById(String id) async {
    List<WebtoonEpisodeModel> episodesInctances = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInctances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInctances;
    }
    throw Error();
  }
}
