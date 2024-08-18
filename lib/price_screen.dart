import 'package:bitcoin_ticker/exchange_rate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'crypto_card.dart';

NumberFormat value = NumberFormat('#,###.##', 'en_US');

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[currenciesList.indexOf('USD')];
  ExchangeRate exchangeRate = ExchangeRate();
  String exchangeRateAmountForBTC = '?';
  String exchangeRateAmountForETH = '?';
  String exchangeRateAmountForLTC = '?';

  void updateUI() async {
    var exchangeRateDataForBTC =
        await exchangeRate.getExchangeRate(cryptoList[0], selectedCurrency);
    var exchangeRateDataForETH =
        await exchangeRate.getExchangeRate(cryptoList[1], selectedCurrency);
    var exchangeRateDataForLTC =
        await exchangeRate.getExchangeRate(cryptoList[2], selectedCurrency);
    setState(() {
      if (exchangeRateDataForBTC == null ||
          exchangeRateDataForETH == null ||
          exchangeRateDataForLTC == null) {
        exchangeRateAmountForBTC = '?';
        exchangeRateAmountForETH = '?';
        exchangeRateAmountForLTC = '?';
        return;
      }
      exchangeRateAmountForBTC = value.format(exchangeRateDataForBTC['rate']);
      exchangeRateAmountForETH = value.format(exchangeRateDataForETH['rate']);
      exchangeRateAmountForLTC = value.format(exchangeRateDataForLTC['rate']);
    });
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownList = [];
    for (String currency in currenciesList) {
      dropdownList.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> cupertinoPickerList = [];
    for (String currency in currenciesList) {
      cupertinoPickerList.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
      },
      children: cupertinoPickerList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                cryptocurrency: cryptoList[0],
                exchangeRateAmount: exchangeRateAmountForBTC,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptocurrency: cryptoList[1],
                exchangeRateAmount: exchangeRateAmountForETH,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptocurrency: cryptoList[2],
                exchangeRateAmount: exchangeRateAmountForLTC,
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
