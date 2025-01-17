import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;

  const InputField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false, // Valor predeterminado
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Asegúrate de definir backgroundColor
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          obscureText: widget.isPassword ? !_passwordVisible : false,
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:waterapp/Components/Colors/colorBlue.dart';

// class InputField extends StatelessWidget {
//   const InputField(
//       {super.key,
//       required this.hint,
//       required this.icon,
//       required this.controller,
//       this.passwordInvisible = false});

//   final String hint;
//   final IconData icon;
//   final TextEditingController controller;
//   final bool passwordInvisible;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         width: size.width * 0.9,
//         height: 55,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: TextFormField(
//             obscureText: passwordInvisible,
//             controller: controller,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: hint,
//               prefixIcon: Icon(icon),
//             ),
//           ),
//         ));
//   }
// }
