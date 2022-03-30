import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool xTurn = true;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  List<String> xo = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    var width = screenSizes.width;
    //var height = screenSizes.height;
    var pad = width * 0.09;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ScoreBoard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: '2P',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Player X",
                            style: TextStyle(
                              color: xTurn ? Colors.white : Colors.grey,
                              fontSize: 15,
                              fontWeight:
                                  xTurn ? FontWeight.bold : FontWeight.normal,
                              fontFamily: '2P',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$xScore",
                            style: TextStyle(
                              color: xTurn ? Colors.white : Colors.grey,
                              fontSize: 15,
                              fontFamily: '2P',
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Player O",
                            style: TextStyle(
                              color: xTurn ? Colors.grey : Colors.white,
                              fontSize: 15,
                              fontWeight:
                                  xTurn ? FontWeight.normal : FontWeight.bold,
                              fontFamily: '2P',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$oScore",
                            style: TextStyle(
                              fontSize: 15,
                              color: xTurn ? Colors.grey : Colors.white,
                              fontFamily: '2P',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Positioned(
                    top: 20,
                    left: 15,
                    child: Hero(
                      tag: 'tag',
                      child: Image.asset(
                        'images/tictactoelogo.png',
                        color: Colors.white,
                        width: width - 30,
                      ),
                    )),
                GridView.builder(
                  shrinkWrap: false,
                  padding: EdgeInsets.all(pad),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (xo[index] == '')
                          playSound('tic');
                        else
                          playSound('error');
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Center(
                          child: Text(
                            xo[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: '2P',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: width,
              child: Center(
                  child: Text(
                'TIC TAC TOE',
                style: TextStyle(
                    color: Colors.white, fontFamily: '2P', fontSize: 30),
              )),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (xTurn && xo[index] == '') {
        xo[index] = "x";
        filledBoxes += 1;
      } else if (!xTurn && xo[index] == '') {
        xo[index] = "o";
        filledBoxes += 1;
      }
      xTurn = !xTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (xo[0] == xo[1] && xo[0] == xo[2] && xo[0] != '') {
      playSound('win');
      _showWinDialog(xo[0]);
    } else if (xo[3] == xo[4] && xo[3] == xo[5] && xo[3] != '') {
      playSound('win');
      _showWinDialog(xo[3]);
    } else if (xo[6] == xo[7] && xo[6] == xo[8] && xo[6] != '') {
      playSound('win');
      _showWinDialog(xo[6]);
    } else if (xo[0] == xo[3] && xo[0] == xo[6] && xo[0] != '') {
      playSound('win');
      _showWinDialog(xo[0]);
    } else if (xo[1] == xo[4] && xo[1] == xo[7] && xo[1] != '') {
      playSound('win');
      _showWinDialog(xo[1]);
    } else if (xo[2] == xo[5] && xo[2] == xo[8] && xo[2] != '') {
      playSound('win');
      _showWinDialog(xo[2]);
    } else if (xo[0] == xo[4] && xo[0] == xo[8] && xo[0] != '') {
      playSound('win');
      _showWinDialog(xo[0]);
    } else if (xo[2] == xo[4] && xo[2] == xo[6] && xo[2] != '') {
      playSound('win');
      _showWinDialog(xo[2]);
    } else if (filledBoxes == 9) {
      playSound('win');
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Player $winner Wins!",
            style: TextStyle(fontFamily: '2P'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play Again!'),
            ),
          ],
        );
      },
    );
    if (winner == 'x')
      xScore += 1;
    else if (winner == 'o') oScore += 1;
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Draw!!",
            style: TextStyle(fontFamily: '2P'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play Again!'),
            ),
          ],
        );
      },
    );
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) xo[i] = '';
      filledBoxes = 0;
    });
  }

  playSound(String sound) {
    final player = AudioCache();
    player.play('$sound.wav');
  }
}
