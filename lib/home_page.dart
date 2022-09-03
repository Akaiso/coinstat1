import 'dart:convert';

import 'package:coinstat/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  HTTPService? _http;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),

                _selectedCoinDropdown()!,
                _dataWidgets(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _selectedCoinDropdown() {
    List<String> _coins = ["bitcoin", "Ethereum", "LiteCoin", "Dodge", ];
    List<DropdownMenuItem<String>> _items = _coins
        .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            )))
        .toList();
    return DropdownButton(
      value: _coins.first,
      items: _items,
      onChanged: (_value) {},
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Colors.white,
      ),
      underline: Container(),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: _http?.get("/coins/bitcoin"),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          Map _data = jsonDecode(_snapshot.data.toString());
          num _usdPrice = _data["market_data"]["current_price"]["usd"];
          num _change24h = _data["market_data"]["price_change_percentage_24h"];
          String _imageUrl = _data["image"]["large"];
          String _description = _data["description"]["en"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _coinImageWidget(_imageUrl),
              _currentPriceWidget(_usdPrice),
              _percentageChangeWidget(_change24h),
              _coinDescriptionWidget(_description),
            ],
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.yellow,
          ));
        }
      },
    );
  }

  Widget _currentPriceWidget(num _rate) {
    return Text(
      "${_rate.toStringAsFixed(2)}  USD",
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _percentageChangeWidget(num _change) {
    return Text(
      "${_change.toString()} %",
      style: const TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _coinImageWidget(String _imageURL) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration:
           const BoxDecoration(image: DecorationImage(image: NetworkImage("_imageURL") ),
          ),
    );
  }

  Widget _coinDescriptionWidget(String _description){
    return Container(margin: EdgeInsets.all(20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color.fromRGBO(103, 88, 206, 0.9)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(_description, style: TextStyle(color: Colors.white70),),
      ),
    );
  }
}
