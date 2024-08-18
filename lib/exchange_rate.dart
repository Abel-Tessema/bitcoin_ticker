import 'networking.dart';

const apiKey = '1099133D-D67B-48FE-B1DC-DDAEC3BAB20B';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class ExchangeRate {
  Future<dynamic> getExchangeRate(String baseCurrency, String quoteCurrency) {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$coinApiUrl/$baseCurrency/$quoteCurrency?apiKey=$apiKey');
    var exchangeRateData = networkHelper.getData();
    return exchangeRateData;
  }
}
