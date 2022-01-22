import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';

String email = '';
String password = '';

Widget buildEmailField() {
  return TextFormField(
    decoration: InputDecoration(
      icon: const Icon(Icons.email, size: 30, color: Colors.purple),
//        fillColor: Color(0xfff3f3f4),
      //    filled: true,
      labelText: "email",
      hintText: 'Enter your Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    //initialValue: 'ahmed@Epark.com',

    cursorColor: Colors.purple,
    validator: (String? value) {
      if (value!.isEmpty) {
        return 'Email is required';
      }

      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return 'Please enter a valid email address';
      }

      return null;
    },
    onChanged: (value) {
      email = value;
    },
//      onSaved: (String value) {
//        _user.email = value;
//      },
  );
}

Widget buildPasswordField({required TextEditingController passController}) {
  return TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      icon: const Icon(Icons.lock, size: 30, color: Colors.purple),
      suffixIcon: IconButton(
        icon: const Icon(Icons.visibility),
        onPressed: () {},
      ),
      fillColor: const Color(0xfff3f3f4),
      filled: true,
      labelText: "password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    cursorColor: Colors.purple,

    controller: passController,
    validator: (value) {
      if (value == null) {
        return 'Password is required';
      }

      if (value.length < 5 || value.length > 20) {
        return 'Password must be betweem 5 and 20 characters';
      }

      return null;
    },
//      onSaved: (String value) {
//        _user.password = value;
//      },
    onChanged: (value) {
      password = value;
    },
  );
}

// Widget defaultButton({
//   double width = double.infinity,
//   background = Colors.purple,
//   bool isUpperCase = true,
//   double radius = 8.0,
//   required Function function,
//   required String? text,
// }) =>
//     Container(
//       width: width,
//       height: 50.0,
//       child: ElevatedButton(
//         onPressed: function(),
//         child: Text(
//           isUpperCase ? text!.toUpperCase() : text!,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           radius,
//         ),
//         color: background,
//       ),
//     );

// Widget defaultTextButton({
//   required Function function,
//   required String text,
// }) =>
//     TextButton(
//       onPressed: function(),
//       child: Text(
//         text.toUpperCase(),
//       ),
//     );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit!(),
      onChanged: onChange!(),
      onTap: onTap!(),
      validator: validate(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed!(),
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Container(
      color:Colors.white ,
      child: Padding(

        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      color: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favorites[model.id]!
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_outlined,
                            size: 30.0,
                            color: Colors.purple,
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
      ),
    );
