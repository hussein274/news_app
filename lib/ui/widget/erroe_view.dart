import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
 final String textError;
 final Function() ?onRetry;
  const ErrorView({super.key,required this.textError, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textError),
          if(onRetry!=null)
          ElevatedButton(onPressed:
          (){
            onRetry!();
          }
          , child: Text("retry"))
        ],
      ),
    );
  }
}
