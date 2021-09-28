import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void navigateTo(context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateToReplacement(context, Widget screen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

void showToest(String message, context) {
  // Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 5,
  //     textColor: Colors.white,
  //     fontSize: 16.0);
  Toast.show(message, context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}

Widget textInput(
  context, {
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  IconData suffixIcon,
  IconData prefixIcon,
  @required String hint,
  bool isPass = false,
  Function validator,
  Function onSubmitted,
  Function suffixPressed,
  bool isFocuse = false,
}) {
  return TextFormField(
    onFieldSubmitted: onSubmitted,
    validator: validator,
    autofocus: isFocuse,
    obscureText: isPass,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelStyle: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(fontWeight: FontWeight.bold),
      suffixIcon: IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixPressed,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.grey[600],
      ),
      hintText: hint,
    ),
  );
}

Widget customBtn({
  Function onClick,
  @required String text,
  bool isUperCase = false,
  Color bgColor = Colors.blueAccent,
}) {
  return InkWell(
    onTap: onClick,
    child: Material(
      borderRadius: BorderRadius.circular(7),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Container(
        color: bgColor,
        child: Center(
          child: (Text(
            isUperCase ? text.toUpperCase() : text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'jannah',
            ),
          )),
        ),
        width: double.infinity,
        height: 50,
      ),
    ),
  );
}
