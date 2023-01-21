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
