import 'package:corona/country.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart';

class Helper {
  Client _client;

  Helper() {
    this._client = Client();
  }

  Future<List<Country>> getAllCountry() async {
    List<Country> allCountry = [];

    final response = await _client.get(
        "https://www.worldometers.info/coronavirus/");
    //"https://www.worldometers.info/coronavirus/countries-where-coronavirus-has-spread/
    final document = parse(response.body);
    final allCountryTd = document.getElementsByTagName('tbody');

    for (dom.Element oneCountry in allCountryTd) {
      final country = oneCountry.getElementsByTagName('tr');

      for (dom.Element perCountry in country) {

        final countryName = perCountry.getElementsByTagName('td')[0].text;
        final cases = perCountry.getElementsByTagName('td')[1].text;
        final deaths = perCountry.getElementsByTagName('td')[3].text;
        final recovered = perCountry.getElementsByTagName('td')[5].text;
        print (countryName);
        print (cases);
        print (deaths);
        print(recovered);

        if (recovered == "Total:"){


        } else {
          final country2 =
          Country(countryName: countryName,
              cases: cases,
              deaths: deaths,
              recovered: recovered);
          allCountry.add(country2);
        }
      }
    }
    return allCountry;
  }


}
