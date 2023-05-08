import 'package:flutter/material.dart';

class ExpendedTitle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpendedTitleState();
  }
}

class _ExpendedTitleState extends State {
  List<Results> results = [
    Results(
        category: 'Entertainment: Board Games',
        type: 'multiple',
        difficulty: 'hard',
        question:
            "The board game &quot;Monopoly&quot; is a variation of what board game?",
        correctAnswer: "The Landlord&#039;s Game",
        allAnswers: [
          "Territorial Dispute",
          "Property Feud",
          "The Monopolist&#039;s Game",
          "The Landlord&#039;s Game",
        ]),
    Results(
        category: 'Geography',
        type: 'multiple',
        difficulty: 'easy',
        question:
        "Which country does Austria not border?",
        correctAnswer: 'France',
        allAnswers: [
          "Slovenia", "Switzerland", "Slovakia",'France',
        ]),
  ];

  Future<void> fetchQuestions() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        elevation: 0.0,
      ),
      body: RefreshIndicator(onRefresh: fetchQuestions, child: questionList()),
    );
  }

  ListView questionList() {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        elevation: 0.0,
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  results[index].question,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(results[index].category),
                        onSelected: (b) {},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(
                          results[index].difficulty,
                        ),
                        onSelected: (b) {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Text(results[index].type.startsWith("m") ? "M" : "B"),
          ),
          children: results[index].allAnswers.map((m) {
            return AnswerWidget(results, index, m);
          }).toList(),
        ),
      ),
    );
  }
}

class AnswerWidget extends StatefulWidget {
  final List<Results> results;
  final int index;
  final String m;

  AnswerWidget(this.results, this.index, this.m);

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color c = Colors.black;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          if (widget.m == widget.results[widget.index].correctAnswer) {
            c = Colors.green;
          } else {
            c = Colors.red;
          }
        });
      },
      title: Text(
        widget.m,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Results {
  late String category;
  late String type;
  late String difficulty;
  late String question;
  late String correctAnswer;
  late List<String> allAnswers;

  Results({
    this.category = '',
    this.type = '',
    this.difficulty = '',
    this.question = '',
    this.correctAnswer = '',
    this.allAnswers = const [],
  });

  Results.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    allAnswers = json['incorrect_answers'].cast<String>() ?? [];
    allAnswers.add(correctAnswer);
    allAnswers.shuffle();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['incorrect_answers'] = this.allAnswers;
    return data;
  }
}
