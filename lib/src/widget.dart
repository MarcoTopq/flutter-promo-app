import 'package:flutter/material.dart';

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("assets/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;
  final TextInputType _type;
  bool _secure;
  String _hint;
  // var controller;
  TextEditingController controller;
  InputWidget(this.topRight, this.bottomRight, this._type, this._secure,
      this._hint, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //         bottomRight: Radius.circular(bottomRight),
          //         topRight: Radius.circular(topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextFormField(
                controller: controller,
                obscureText: _secure,
                keyboardType: _type,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _hint,
                    hintStyle:
                        TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap di isi';
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class MyShapeBorder extends ContinuousRectangleBorder {
  const MyShapeBorder(this.curveHeight);
  final double curveHeight;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
    ..lineTo(0, 0)
    ..quadraticBezierTo(
      rect.size.width + 0.5,
      rect.size.height + curveHeight * 5,
      rect.size.width / 0.5,
      rect.size.height + curveHeight * 5,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}

Widget row(String text, Color color) {
  return Padding(
    padding: EdgeInsets.all(12.5),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12.5,
          ),
        ),
      ),
    ),
  );
}
