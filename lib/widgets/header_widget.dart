import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final double height;
  final IconData icon;
  final bool visibility;

  const HeaderWidget(
      {@required this.height,
      @required this.icon,
      @required this.visibility,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.9),
                    Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            clipper: ShapeClipper([
              Offset(width / 5, height),
              Offset(width / 10 * 5, height - 60),
              Offset(width / 5 * 4, height + 20),
              Offset(width, height - 18)
            ]),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.9),
                    Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            clipper: ShapeClipper([
              Offset(width / 3, height + 20),
              Offset(width / 10 * 8, height - 60),
              Offset(width / 5 * 4, height - 60),
              Offset(width, height - 20)
            ]),
          ),
          ClipPath(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
              ),
            ),
            clipper: ShapeClipper([
              Offset(width / 5, height),
              Offset(width / 2, height - 40),
              Offset(width / 5 * 4, height - 80),
              Offset(width, height - 20)
            ]),
          ),
          Visibility(
            visible: visibility,
            child: Container(
              height: height - 40,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.only(
                    left: 5.0,
                    top: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];

  ShapeClipper(this._offsets);

  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
