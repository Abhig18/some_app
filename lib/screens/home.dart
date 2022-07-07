import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:some_app/api/api_calls.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color _buttonColor = const Color(0xfffecd00);

  final Api _api = Api();

  int? count;

  bool? _isLoading;

  @override
  void initState() {
    count = 1;
    _isLoading = false;
    super.initState();
  }

  _randomJoke() async {
    int getCount = await _countDialogBox();

    setState(() {
      count = getCount;
      _isLoading = true;
    });

    List<dynamic> jokeList = [];

    try {
      jokeList = await _api.getRandomJoke(count!);
    } catch (error) {
      print(error.toString());
    }

    setState(() {
      _isLoading = false;
    });

    print(jokeList);
  }

  Future<dynamic> _countDialogBox() {
    int currValue = 1;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('How many jokes can you handle?'),
            content: SpinBox(
                min: 1.0,
                max: 500.0,
                value: 1.0,
                onChanged: (double val) => currValue = val.toInt()),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(currValue),
                  child: const Text('Done',
                      style: TextStyle(
                        color: Colors.amber,
                      )))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _isLoading! ? _loading() : _body(),
    );
  }

  Center _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: _buttonColor,
      ),
    );
  }

  Container _body() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Button to generate random jokes
          _randomJokeBtn(),
          Image.asset('assets/images/image.png'),
          // Button to search for specific type of jokes
          _searchJokeBtn()
        ],
      ),
    );
  }

  ElevatedButton _searchJokeBtn() {
    return ElevatedButton.icon(
        onPressed: () {
          // _api.getSearchedJoke('dumb');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_buttonColor),
        ),
        icon: const Icon(Icons.search),
        label: const Text('Search for your fetish here'));
  }

  ElevatedButton _randomJokeBtn() {
    return ElevatedButton(
      onPressed: _randomJoke,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_buttonColor),
      ),
      child: const Text('No I don\'t know what I want'),
    );
  }
}
