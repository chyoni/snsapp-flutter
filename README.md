# SNS App by using Flutter

### #01 Init

### #02 Auth Screen

- New features: `FractionallySizedBox` - 얘는 부모의 전체 이용가능한 공간을 비율로 사이즈를 가져갈 수 있는 있는 아이인 것 같다. 즉, 전체 가능한 사이즈 중 최대(1) 또는 절반 (0.5)해서 본인의 사이즈를 맞추는 위젯

### #03 FontAwesome Icon

- New features: `Stack`, `Align` - Stack으로 하면 위로 하나씩 차곡차곡 쌓는건데 그렇게 하고나서 Align으로 배치를 해주면 Row로 사용해서 밀려나는 약간의 공간을 정리할 수 있다.

### #04 Default ThemeData

- New features: 모든 스크린마다 다 같은 값인데 스크린 파일 하나하나 Scaffold의 backgroundColor나 그런것들을 지정해주기는 귀찮다. 그래서 main file에서 ThemeData에서 모든 파일에 기본값을 설정해줄 수 있다.

### #05 TextField

- New features:
  - `TextField`, `TextEditingController` - 화면상에서 입력필드를 보여주는데 해당 필드를 컨트롤할 수 있는 녀석이 `TextEditingController` 이 녀석임, 이 녀석으로 리스너를 등록하고, 받아오는 텍스트 값을 가져올 수 있음
  - `AnimatedContainer` - 이 녀석은 애니메이션 효과를 줄 수 있는 녀석임, 색상의 변경을 duration property 하나만으로도 줄 수 있음

### #06 dispose()

- New features:
  - `dispose()` - 얘는 해당 화면이 destroy될 때 실행되는 메소드이고, 그 메소드에서는 해당 화면이 destroy될 때 행해질 것들 (예를 들면, 이벤트리스너 구독해제 라던가, 소켓 클로즈 라든가 등등..) 이런것들을 하면 된다. 근데 얘는 super를 가장 마지막에 호출하는게 관습이다. initState는 super를 맨 위에 호출하는데 얘는 아니다. 맨 아래에 호출한다.
  - `StatefulWidget의 context` - StatefulWidget인 경우 context가 이미 우리를 위해 어디서나 사용가능하게 되어 있다. 그래서 onTap 메소드를 구현할 때 Stateless는 context를 파라미터로 받았는데, Stateful은 받지 않아도 사용가능하다.

### #07 KeyboardAvoiding

- New features:
  - `FocusScope.of(context).unfocus()` - 이게 이제 텍스트 필드가 아닌 다른 부분을 클릭했을 때 키보드를 내려주는 뭐 그런 녀석인데 되게 간단
  - `errorText` - 이 TextField의 decoration에는 errorText라는 프로퍼티가 있는데 이게 끝내주는 것 같다. 되게 간단하게 에러 메시지를 보여줄 수 있다.

### #08 PasswordScreen

### #09 BirthdayScreen
