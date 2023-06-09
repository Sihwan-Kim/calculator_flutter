import 'dart:io';
import 'package:flutter/material.dart';
import 'package:calculator_flutter/Model.dart' ;
import 'package:provider/provider.dart';

var calcuControl = new CalculatorControl() ;

class CalculatorControl 
{
	var makeNumber = '' ;
	var selectedOperator = '+';
	var pointExist = false ;

	dynamic firstNumber = 0 ;
	dynamic secondNumber = 0 ;
	//-----------------------------------------------------------------------------------------
	void teCalculatorControlm()
	{
	}
	//-----------------------------------------------------------------------------------------
	void operatorOnPressed(BuildContext context, String st)
	{
		resultOnPressed(context) ;

		selectedOperator = st ;
		firstNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;
	}
	//-----------------------------------------------------------------------------------------
	void resultOnPressed(BuildContext context)
	{
		var display = '0' ;
		secondNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;
		makeNumber = '';

		switch(selectedOperator)
		{
			case '+' : firstNumber = firstNumber + secondNumber ;	break ;
			case '−' : firstNumber = firstNumber - secondNumber ;	break ;
			case '×' : firstNumber = firstNumber * secondNumber ;	break ;
			case '÷' : firstNumber = firstNumber / secondNumber ;	break ;
		}

		display = firstNumber.toString();
		firstNumber = 0 ;
		selectedOperator = '+';		
		pointExist = false ;		

		if(display.length >= 3 && display.startsWith('.0', display.length-2)) 
		{
			display = display.substring(0, display.length-2) ;  // 정수일 경우 소수점 이하 지워라...
		}	

		_display(context, display) ;
	}
	//-----------------------------------------------------------------------------------------
	void functionOnPressed(BuildContext context, String st)
	{
		var display = '0' ;

		if(st == 'C')		// clear input
		{
			selectedOperator = '+';
			makeNumber = ''; 
			firstNumber = 0 ;
			secondNumber = 0 ;
		}
		else if(st == '%')
		{
			var imsi = double.parse(context.read<DisplayNumValue>().displayValue) / 100 ;

			if(selectedOperator == '+' || selectedOperator == '-' )
			{
				display = (imsi * firstNumber).toString();
			}
			else
			{
				display = imsi.toString();
			}
		}
		else
		{
			var imsiString = context.read<DisplayNumValue>().displayValue ;
			makeNumber = '';

			if(imsiString.length > 1)
			{
				display = imsiString.substring(0, imsiString.length-1) ;
				makeNumber = display;
			}
		}

		_display(context, display) ;
	}
	//-----------------------------------------------------------------------------------------
	void numberOnPressed(BuildContext context, String st)  		// 숫자키 입력 이벤트 함수 
	{
		bool inputAdd = true ; 

		if(st == '.') // 소숫점이 눌려졌을 경우 
		{
			if(makeNumber.isEmpty == true)
			{ 
				makeNumber += '0.';
				inputAdd = false ;
			}
			else
			{
				if(pointExist == true) inputAdd = false ; // 소숫점이 없을 경우만 추가
			}

			pointExist = true ;
		}
		else if(st == '0' && makeNumber.isEmpty == true)  inputAdd = false;
		
		if(inputAdd == true)
		{
	 		makeNumber += st ;
		}

		_display(context, makeNumber) ;
	}
	//-----------------------------------------------------------------------------------------
	void _display(BuildContext context, String Number)  // private member function
	{
		var fontSizes = 80.0 ;
		if(Number.length >= 8) fontSizes = 50 ;  // 글자 크기를 선택 

		context.read<DisplayNumValue>().Display(Number, fontSizes) ;
	}
	//-----------------------------------------------------------------------------------------
}