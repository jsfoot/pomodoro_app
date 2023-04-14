import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int twentyFiveMinutes;
  late int totalSeconds = twentyFiveMinutes;
  int breakTime = 300;

  bool isRunning = false;
  int totalPomodoros = 0;
  int breakCounter = 0;
  late Timer timer;
  final List<int> timers = [15, 20, 25, 30, 35];
  bool isSelected = false;
  late int selectedIndex;
  bool isBreakTime = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    selectedIndex = 2;
    twentyFiveMinutes = timers[selectedIndex];
    timer = Timer(const Duration(seconds: 1), () {});

    super.initState();
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        breakCounter = breakCounter + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onClickReset() {
    if (!isRunning) {
      timer.cancel();
      setState(() {
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
    }
  }

  void onClickAllReset() {
    if (!isRunning) {
      timer.cancel();
      setState(() {
        isRunning = false;
        totalSeconds = timers[selectedIndex] * 60;
        totalPomodoros = 0;
        isBreakTime = false;
      });
    }
  }

  void onBreakTimePressed() {
    void onTick(Timer timer) {
      if (breakTime == 0) {
        setState(() {
          isRunning = false;
          isBreakTime = false;
          breakTime = 300;
          breakCounter = 0;
        });
        timer.cancel();
      } else {
        setState(() {
          breakTime = breakTime - 1;
        });
      }
    }

    void onStartPressed() {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        onTick,
      );
      setState(() {
        isRunning = true;
      });
    }

    onStartPressed();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String minutes(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String seconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    if (breakCounter == 4) {
      setState(() {
        isBreakTime = true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "POMOTIMER",
            style: TextStyle(
              letterSpacing: 2,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 230, 77, 61),
        elevation: 0,
        titleSpacing: 2,
        actions: [
          IconButton(
            iconSize: 32,
            color: Theme.of(context).cardColor,
            onPressed: onClickAllReset,
            icon: const Icon(
              Icons.restart_alt,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 230, 77, 61),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 18,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        width: 120,
                        height: 160,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white60,
                        ),
                        width: 110,
                        height: 165,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white54,
                        ),
                        width: 100,
                        height: 170,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          isBreakTime ? minutes(breakTime) : minutes(totalSeconds),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 230, 77, 61),
                            fontSize: 89,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  ":",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        width: 120,
                        height: 160,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white60,
                        ),
                        width: 110,
                        height: 165,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white54,
                        ),
                        width: 100,
                        height: 170,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          isBreakTime ? seconds(breakTime) : seconds(totalSeconds),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 230, 77, 61),
                            fontSize: 89,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isBreakTime)
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const RadialGradient(
                      radius: 1.5,
                      tileMode: TileMode.decal,
                      colors: [Colors.white, Colors.white12],
                      stops: [0.45, 0.65]).createShader(bounds);
                },
                child: ListView.separated(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  itemCount: timers.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 200,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (!isRunning) {
                          selectedIndex = index;
                          isSelected = !isSelected;
                          twentyFiveMinutes = timers[index] * 60;
                          _scrollController.animateTo(84.0 * (index + 1),
                              duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          onClickReset();
                        }
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: index == selectedIndex
                                ? Colors.white
                                : const Color.fromARGB(255, 230, 77, 61),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.white54,
                              width: 3,
                            ),
                          ),
                          child: Text(
                            timers[index].toString(),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: index == selectedIndex
                                  ? const Color.fromARGB(255, 230, 77, 61)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (isBreakTime)
            const Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  "YOU NEED TO HAVE BREAK TIME. \n SEE YOU AFTER 5 MINUTES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          if (!isBreakTime)
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  IconButton(
                    iconSize: 28,
                    color: Theme.of(context).cardColor,
                    onPressed: onClickReset,
                    icon: const Icon(
                      Icons.restore,
                    ),
                  ),
                  Center(
                    child: IconButton(
                      color: Colors.black26,
                      iconSize: 90,
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      icon: Icon(
                        isRunning ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (isBreakTime)
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Center(
                    child: IconButton(
                      color: Colors.black26,
                      iconSize: 100,
                      onPressed: isRunning ? onPausePressed : onBreakTimePressed,
                      icon: Icon(
                        isRunning ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${totalPomodoros ~/ 4}/4",
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white54,
                            ),
                          ),
                          const Text(
                            'ROUND',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$totalPomodoros/16',
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white54,
                            ),
                          ),
                          const Text(
                            'GOAL',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
