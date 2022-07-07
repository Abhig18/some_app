import 'package:flutter/cupertino.dart';

class JokesScreen extends StatefulWidget {
  final List<dynamic> jokeList;
  const JokesScreen({Key? key, required this.jokeList}) : super(key: key);

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
