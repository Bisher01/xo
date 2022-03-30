import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xo/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                child: Text(
                  "TIC TAC TOE",
                  style: TextStyle(
                      fontSize: 30, fontFamily: '2P', color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: AvatarGlow(
                endRadius: 140,
                duration: Duration(seconds: 2),
                glowColor: Colors.white,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.none,
                      ),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    child: Container(
                      child: Hero(
                        tag: 'tag',
                        child: Image.asset(
                          'images/tictactoelogo.png',
                          color: Colors.white,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    radius: 80.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                child: Text(
                  "@CREATED BY BISHER",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: '2P',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              playSound('start');
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HomePage()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(30),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'PLAY GAME',
                      style: TextStyle(
                        fontFamily: '2P',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  playSound(String sound) {
    final player = AudioCache();
    player.play('$sound.wav');
  }
}
