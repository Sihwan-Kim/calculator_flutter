import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_flutter/Model.dart' ;
import 'package:calculator_flutter/ViewModel.dart' ;
import 'package:get/get.dart';

class CalculatorApp extends StatelessWidget 
{
	const CalculatorApp({super.key});
  
	@override  
	Widget build(BuildContext context)  // This widget is the root of your application.
	{
		return GetMaterialApp
		(
			title: 'Flutter Demo',
			theme: ThemeData(primarySwatch: Colors.blue,),
			home: DesignPage(),
		);
  }
}
//-----------------------------------------------------------------------------------------
class DesignPage extends StatelessWidget
{
  final controller = Get.put(DisplayNumValue());

  @override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar(title: const Text('Calculator Program'),),
			body: Column
			(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: <Widget>
				[
					Container
					(
						padding: const EdgeInsets.all(30),
						alignment: const Alignment(1.0, 1.0),   // 내부 위젯의 위치를 우측 하단으로 설정 
						color: Colors.black,
						height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.25,   // 화면의 35%를 차지하도록 설정
						child: GetBuilder<DisplayNumValue>
						(
							builder:(controller) 
                            { return Text(controller.displayValue, 
                                          style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontSize: controller.fontSize,),
			                              textAlign: TextAlign.right) ; 
              				},
						),
					),
					const ButtonGroupWidget(),   // 버튼그룹을 화면에 표시 
				],					
			),
			backgroundColor: Colors.black,
		);
	}
}  	
//-----------------------------------------------------------------------------------------
class CalButton extends StatelessWidget
{
	const CalButton({super.key, required this.caption, required this.color, required this.buttonKind});
	final String caption ;  // 입력된 버튼의 문자 
	final Color color;      // 버튼의 색
	final int buttonKind;   // 입력된 버튼의 기능(0:숫자, 1:연산, 2:기능)

	@override
	Widget build(BuildContext context)
	{
		return ElevatedButton
		(
			onPressed: () 
			{ 
				switch(buttonKind)
				{
					case 0 : calcuControl.numberOnPressed(caption); break ;
					case 1 : calcuControl.operatorOnPressed(caption); break ;
					case 2 : calcuControl.resultOnPressed(); break ; 
					case 3 : calcuControl.functionOnPressed(caption) ;
				} 
			},
			style: ElevatedButton.styleFrom
			(
				backgroundColor: color, 
				fixedSize: Size((MediaQuery.of(context).size.width/4)-30, (MediaQuery.of(context).size.width/4)-20), 
				shape: const CircleBorder(),
			),
			child: Text(caption, style: const TextStyle(fontSize: 40,),),
		);
	}
}
//-----------------------------------------------------------------------------------------
class ButtonGroupWidget extends StatelessWidget 
{
  const ButtonGroupWidget({super.key});

  @override
  Widget build(BuildContext context) 
	{
		return Table
		(
			children: const <TableRow>
			[
				TableRow
				(
					children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: 'C', color: Colors.grey, buttonKind: 3,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '%', color: Colors.grey, buttonKind: 3,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '⇍', color: Colors.grey, buttonKind: 3,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '÷', color: Colors.orange, buttonKind: 1,),),
					],
				),
				TableRow
				(
					children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '7', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '8', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '9', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '×', color: Colors.orange, buttonKind: 1,),),
					],
				),
				TableRow
				(
					children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '4', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '5', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '6', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '−', color: Colors.orange,buttonKind: 1,),),
					],
				),
				TableRow
				(
					children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '1', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '2', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '3', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+', color: Colors.orange, buttonKind: 1,),),
					],
				),			
				TableRow
				(
					children: <Widget>
					[
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+/-', color:Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '0', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '.', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
						Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '=', color: Colors.orange, buttonKind: 2,),),
					],
				),		
			],
		);
  }
}
//-----------------------------------------------------------------------------------------
