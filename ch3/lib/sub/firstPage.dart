import 'package:flutter/material.dart';
import 'animal.dart';

class FirstPage extends StatelessWidget{

List<Animal>? list;
  FirstPage({Key? key, this.list}) : super(key : key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Center(
            child: ListView.builder(
	          itemBuilder: (context, position) {
             	return GestureDetector( 
                child:Card(
	                    child: Row(children: <Widget>[
                        Image.asset(
                          list![position].imagePath!,
                          height: 100,
                          width: 100,
													fit: BoxFit.contain,
                        ),
                        Text(list![position].name!)
                      ],
										),
									),
                  				onTap: () {
                        AlertDialog dialog = AlertDialog(
                            content: Text('이 동물은 ${list![position].kind} 입니다.',
                                style: TextStyle(fontSize: 30)));
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog);
                      },
              );
								},
								itemCount: list!.length
		          )
						
					),
        ),
      );
  }
}