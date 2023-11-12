import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:calculator3d/sizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  final assetsAudioPlayer = AssetsAudioPlayer();

  void _onDigitPress(String digit) {
    setState(() {
      assetsAudioPlayer.open(
        Audio("assets/tap.mp3"),
      );
      if (_currentInput.length < 10) {
        if (_currentInput == "0" && digit != "0") {
          _currentInput = digit;
        } else {
          _currentInput += digit;
        }
      }
    });
  }

  void _onOperandPress(String operand) {
    setState(() {
      assetsAudioPlayer.open(
        Audio("assets/tap.mp3"),
      );
      _operand = operand;
      _num1 = double.parse(_currentInput);
      _currentInput = "";
    });
  }

  String _previousCalculation = "";

  void _onEqualPress() {
    setState(() {
      assetsAudioPlayer.open(
        Audio("assets/tap.mp3"),
      );
      _num2 = double.parse(_currentInput);

      _previousCalculation = '$_num1 $_operand $_num2';

      switch (_operand) {
        case "+":
          _currentInput = (_num1 + _num2).toString();
          break;
        case "-":
          _currentInput = (_num1 - _num2).toString();
          break;
        case "x":
          _currentInput = (_num1 * _num2).toString();
          break;
        case "/":
          _currentInput = (_num1 / _num2).toString();
          break;
        case "%":
          _currentInput = (_num1 % _num2).toString();
          break;
      }

      double result = double.parse(_currentInput);
      if (result % 1 == 0) {
        _previousCalculation = _previousCalculation.replaceAll(".0", "");
        _currentInput = _currentInput.replaceAll(".0", "");
      }
    });
  }

  void _onClearPress(String erase) {
    setState(() {
      assetsAudioPlayer.open(
        Audio("assets/tap.mp3"),
      );
      _currentInput = "";
      _num1 = 0;
      _num2 = 0;
      _operand = "";
      _output = "0";
      if(erase == 'AC'){
        _previousCalculation = "";
      }
    });
  }

  void _onRemoveLastDigit() {
    setState(() {
      assetsAudioPlayer.open(
        Audio("assets/tap.mp3"),
      );
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    color: mainColor,
                    intensity: 5,
                    depth: -4,
                    shadowLightColor: Colors.black26,
                    shadowLightColorEmboss: Colors.black26,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  ),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _previousCalculation,
                          style: const TextStyle(fontSize: 24, color: Colors.grey),
                        ),
                        Text(
                          _currentInput.isEmpty ? _output : _currentInput,
                          style: const TextStyle(fontSize: 48),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                5.w,
                _buildClearButton('AC'),
                5.w,
                _buildClearButton('C'),
                5.w,
                _buildOperandButton("/"),
                5.w,
                _buildRemoveLastDigitButton(),
                5.w,
              ],
            ),
            5.h,
            Row(
              children: [
                5.w,
                _buildCalcButton("7"),
                5.w,
                _buildCalcButton("8"),
                5.w,
                _buildCalcButton("9"),
                5.w,
                _buildOperandButton("x"),
                5.w,
              ],
            ),
            5.h,
            Row(
              children: [
                5.w,
                _buildCalcButton("4"),
                5.w,
                _buildCalcButton("5"),
                5.w,
                _buildCalcButton("6"),
                5.w,
                _buildOperandButton("+"),
                5.w,
              ],
            ),
            5.h,
            Row(
              children: [
                5.w,
                _buildCalcButton("1"),
                5.w,
                _buildCalcButton("2"),
                5.w,
                _buildCalcButton("3"),
                5.w,
                _buildOperandButton("-"),
                5.w,
              ],
            ),
            5.h,
            Row(
              children: [
                5.w,
                _buildLongButton("0"),
                5.w,
                _buildCalcButton("."),
                5.w,
                _buildEqualButton(),
                5.w,
              ],
            ),
            10.h,
          ],
        ),
      ),
    );
  }

  Widget _buildCalcButton(String text) {
    return Expanded(
      flex: 1,
      child: NeumorphicButton(
        onPressed: () => _onDigitPress(text),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: mainColor,
          shadowLightColor: Colors.black.withOpacity(0.01),
          intensity: 0.55,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 26,color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildOperandButton(String operand) {
    return Expanded(
      flex: 1,
      child: NeumorphicButton(
        onPressed: () => _onOperandPress(operand),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: Colors.grey.shade700,
          shadowLightColor: Colors.black.withOpacity(0.01),
          intensity: 0.55,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            operand,
            style: const TextStyle(fontSize: 26,color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildEqualButton() {
    return Expanded(
      flex: 1,
      child: NeumorphicButton(
        onPressed: _onEqualPress,
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: Colors.green.shade600,
          shadowLightColor: Colors.black.withOpacity(0.01),
          intensity: 0.55,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Center(
          child: Text(
            "=",
            style: TextStyle(fontSize: 26,color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton(String erase) {
    return Expanded(
      flex: 1,
      child: NeumorphicButton(
        onPressed: (){
          _onClearPress(erase);
        },
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: Colors.redAccent.shade700,
          shadowLightColor: Colors.black.withOpacity(0.01),
          intensity: 0.55,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            erase,
            style: const TextStyle(fontSize: 26,color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveLastDigitButton() {
    return Expanded(
      flex: 1,
      child: NeumorphicButton(
        onPressed: _onRemoveLastDigit,
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: Colors.red.shade600,
          shadowLightColor: Colors.black.withOpacity(0.01),
          intensity: 0.55,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24.5),
        child: const Center(
          child: Icon(CupertinoIcons.delete_left,size: 22,color: Colors.white)
        ),
      ),
    );
  }

  Widget _buildLongButton(String text) {
    return Expanded(
      flex: 2,
      child: NeumorphicButton(
        onPressed: () => _onDigitPress(text),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: mainColor,
          shadowLightColor: Colors.black.withOpacity(0.01),
          intensity: 0.55,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 26,color: Colors.black),
          ),
        ),
      ),
    );
  }
}
