import 'package:flutter/material.dart';
import 'animal.dart';

class SecondPage extends StatefulWidget {
  
	List<Animal>? list;
  SecondPage({Key? key, this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? _flyExist = false;
    String? _imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
	        child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
               TextField(
		              controller: nameController,
		              keyboardType: TextInputType.text,
		              maxLines: 1
               ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
			            Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
			            Text("양서류"),
			            Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
			            Text("포유류"),
			            Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
			            Text("파충류"),
			          ]),
                    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("날 수 있습니까?"),
              Checkbox(
								value: _flyExist,
								onChanged: (bool? check) {
									setState(() {
										_flyExist = check;
									});
								}
							),
            ],
          ),
             Container(
									height: 100,
		              child: ListView(
		                scrollDirection: Axis.horizontal,
		               children: <Widget>[
		                  InkWell(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Image.asset('image/bee.png', width: 80),
                      ),
                      onTap: () {
                        _imagePath = "image/bee.png";
                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/cat.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/cat.png";
	                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/cow.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/cow.png";
	                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/dog.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/dog.png";
	                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/fox.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/fox.png";
	                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/monkey.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/monkey.png";
	                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/pig.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/pig.png";
	                      }),
		                  InkWell(
	                      child: Padding(
	                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
	                        child: Image.asset('image/wolf.png', width: 80),
	                      ),
	                      onTap: () {
	                        _imagePath = "image/wolf.png";
	                      })
		                ],
		              )
								),
               ElevatedButton(
                  onPressed: () {
                _addAnimal();
                 },
            child: Text("동물 추가하기")
					),
                
						]
					),
          
				),
        
			),
		);
	}
  _radioChange(int? value) {
		    setState(() {
		      _radioValue = value;
		    });
		  }
  _addAnimal() {
    setState(() {
      Animal newAnimal = Animal(
	      imagePath: _imagePath,
	      name: nameController.value.text,
	      kind: getKind(_radioValue),
	      flyExist: _flyExist
			);
      AlertDialog dialog = AlertDialog(
        title:  Image.asset('${_imagePath}', width: 30),
        content:  
        Text("이 동물은 ${newAnimal.name}입니다. "
            "또, 동물의 종류는 ${newAnimal.kind}입니다. \n추가하시겠습니까?",
            
				//원하는 Style이 있으면 style: ~ 로 작성
				),
        actions: [
          ElevatedButton(
            onPressed: () {
              widget.list?.add(newAnimal);
              Navigator.of(context).pop();
            },
            child: Text("Yes")),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"))
        ]);
      showDialog(
				context: context,
				builder: (BuildContext context) => dialog);
    });
  }
  	getKind(int? value) {
    switch (value) {
      case 0:
        return "양서류";
      case 1:
        return "포유류";
      case 2:
        return "파충류";
    }
  }
}