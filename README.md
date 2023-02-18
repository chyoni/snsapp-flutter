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

### #10 LoginFormScreen

- New features: - `Form`, `TextFormField` - 지금까지는 TextField로 값을 Controller를 통해 다루었다면 Form Widget안에 TextFormField를 사용해서 FormState를 다루어서 사용할 수도 있다. 그게 LoginFormScreen으로 구현된 내용들이다.

### #11 InterestsScreen

- New features: - `ScrollBar`, `ScrollController` - 그 헤더에 텍스트가 스크롤바가 얼마나 내려갔느냐에 따라 텍스트가 보여지고 안보여지고를 아주 간단하게 ScrollController로 구현할 수 있다.

### #12 Interests Button

### #13 OnBoard Screen

- New features: - `DefaultTabController`, `TabBarView`, `TabPageSelector` - 이 녀석들을 가지고 그 앱을 설치하고 최초로 실행하면 막 튜토리얼 같은 화면들 그걸 이제 onboard screen이라고 하는데
  그것들을 저 세 아이들로 구현하기 아주 용이하다.

### #14 OnBoard Screen 2

- New features: - `AnimatedCrossFade` - 이 녀석은 두 가지의 화면을 가지고 애니메이션으로 onboard screen을 구현할 수 있는데 구현하는 방식이 재밌다.
  사용자의 드래그 offset을 통해서 왼쪽에서 오른쪽 또는 오른쪽에서 왼쪽으로 이동하는 것을 감지해서 페이지를 보여주냐 마냐를 설정하고 애니메이션을 주는녀석

### #15 pushAndRemoveUntil

- New features: - `pushAndRemoveUntil` - 이 녀석은 네비게이팅을 할 때 그 전 페이지를 돌아갈 수 있냐 없냐를 결정할 수 있는 함수

### #16 BottomNavigationBar

- New features: - `BottomNavigationBar` - 이 녀석이 이제 바텀 네비게이션바를 만들 수 있는 녀석

### #17 CupertinoTabScaffold

- New features: - `CupertinoTabScaffold`, `CupertinoTabBar` - 이제 이것들은 애플 테마로 만들어진 바텀 네비게이션 바, `BottomNavigationBar`는 MaterialApp에 적합한 테마 즉 구글 테마로 만들어진 바텀 네비게이션 바

### #18 Custom Bottom Navigation Bar

### #19 Remain my nav tab page

- 인스타그램, 페이스북 등 우리가 흔히 사용하는 앱은 우리가 바텀 네비게이션 탭에서 예를 들어 홈 버튼에서 뭔가 스크롤을 죽죽 내리다가 프로필 탭을 눌렀다가 다시 홈으로 와도 우리가 딱 스크롤을 내린 그 지점으로 다시 돌아온다. 그것은 화면이 destroy 되지 않았다는 뜻인데 그것을 구현하는 방식이 `Stack`에 바텀 네비게이션에서 사용될 스크린을 차곡차곡 쌓아두고 `Offstage`라는 widget을 사용하는 방법이다.

```dart
body: Stack(children: [
  Offstage(
    offstage: selectedIndex != 0,
    child: const Center(
      child: Text("Home"),
    ),
  )
]),
```

### #20 Post video button

### #21 Infinite Scroll

- 현재 커밋의 `video_timeline_screen.dart` 파일 참고

### #22 VideoPlayer

- New features: - `VideoPlayer`, `VideoPlayerController` - flutter의 패키지 중 하나로 비디오를 실행하고 컨트롤할 수 있는 녀석들, 그리고 이 커밋에서 어떻게 flutter로 로컬 assets에 접근하는지 yaml 파일을 작업하는 내용들도 있다.

### #23 VisibilityDetector

- New features: - `VisibilityDetector` - 현재 문제가 뭐였냐면, 다음 비디오가 완전히 보이기 전에 실행이 되고 있는 상태였음, 그래서 비디오가 정확히 전부 다 보이기전까지 실행하는것을 멈춘상태에서 다 보일 때 실행하게끔 변경

### #24 IgnorePointer

- New features: - `IgnorePointer` - 비디오 정지 중에 노출되는 플레이 버튼 아이콘이 Stack의 맨 위에 올려있고 그 아래에 GestureDetector가 있기 때문에 당연히 아이콘을 눌러도 비디오 실행이 다시 되지 않는다. 그렇다고 그 아이콘도 GestureDetector로 감싸기 보단 IgnorePointer라는 위젯을 사용해서 해당 아이콘의 포인팅을 무시하는 방법을 사용

### #25 AnimationController

- 비디오를 play -> pause, pause -> play로 컨트롤할 때 앞에 보여지는 플레이 버튼의 scaling에 대한 애니메이션 효과를 넣음

### #26 Convert addListener to AnimatedBuilder

- 이전 커밋에서는 이벤트리스너를 사용하여 애니메이션을 실행 시 계속해서 build 함수를 리턴하는 setState를 사용했다면, AnimatedBuilder를 사용해서 애니메이션 시 새롭게 렌더링할 컴포넌트만 딱 집어서 빌드하는 방법으로 교체

### #27 RefreshIndicator

- flutter에서 제공하는 RefreshIndicator가 있다, 그리고 Scaffold의 기본 백그라운드 컬러는 흰색이다.

### #28 showModalBottomSheet

- New features: - `showModalBottomSheet()` - 얘는 이제 바텀시트가 모달로 나오는 그런 아이

### #29 Comment sheet

- 키보드가 노출될 때 Scaffold의 bottomNavigationBar를 사용해서 커멘트 입력창을 만들면 해당 bottomNavigationBar가 사라졌다가 키보드가 없어질 때 나타나기 때문에, bottomNavigationBar에서 그냥 Stack에 Positioned widget으로 변경했고, 그 안에 TextField를 넣었음.

### #30 Comment sheet and text field DONE

### #31 Discover Screen Init

### #32 GridView

- Flutter에서 Gridview를 만드는 방법

### #33 AspectRatio / FadeInImage / DefaultTextStyle / AssetImage

- New features:
  - `AspectRatio` - 이 위젯의 child는 비율을 정할 수 있다.
  - `FadeInImage` - Image를 렌더링할 때 로드하는 동안에는 정해진 placeholder image를 보여주고 로드가 끝나면 FadeIn으로 스르륵 이미지를 보여준다.
  - `DefaultTextStyle` - 이 녀석은 이 녀석의 child로 들어오는 위젯들의 텍스트 스타일 기본값을 지정해줄 수 있다.
  - `AssetImage` - `NetworkImage`가 있다면 `AssetImage`도 있는법.

### #34 TabController

- tabBarView를 통제하기 위해 TabController를 사용한다. 현재탭에서 다른탭으로 전환 시 키보드를 내리는 작업을 구현

### #35 Custom TextField No CupertinoTextField

### #36 ListTile

- ListTile은 리스트 아이템을 간단하게 만들어내는 위젯

### #37 RichText

- `RichText`는 그 글자안에 어디까지는 뭐 굵고 어디까지는 색이 다르고 이렇게 한 문장에도 여러 스타일을 줄 때 이녀석을 쓰면 용이하다.

### #38 Dismissible

- `Dismissible`는 그 앱에서 보면 알림뜰 때 제스쳐로 옆으로 드래그하면 알림 슉 하고 사라지는거 구현해주는 기능

### #39 Dismissible's onDismissed function

### #40 RotationTransition Animation

### #41 SlideTransition Animation

### #42 AnimatedModalBarrier

- `AnimatedModalBarrier`는 그 모달창 뒤에 오버레이 띄워주는 녀석

### #43 Chat Screen

### #44 AnimatedList

### #45 AnimatedList add / remove item

### #46 ChatDetail Screen

### #47 CustomScrollView

- CustomScrollView는 ScrollView를 사용하기 굉장히 좋은 것들을 가져다놓은건데 그 녀석들이 이 아래와 같다.
- `SliverAppBar`, `SliverToBoxAdapter`

### #48 NestedScrollView, SliverPersistentHeader

- 우선 기존에 사용하던 CustomScrollView는 더이상 사용할 수 없다. 왜냐하면, 우리가 TabBar를 사용하고 그 TabBarView를 사용할 때 GridView를 사용할건데,
  SliverGrid를 사용하려면 SliverToBoxAdapter 이 녀석 안에서 사용할 수 없고 slivers의 원소로 들어가야하는데 그러면 화면이 망가진다. 그렇기 때문에 NestedScrollView를 사용한다.
  얘는 `headerSliverBuilder`와 `body` 라는 프로퍼티가 있는데 `headerSliverBuilder` 이 녀석이 이제 윗부분에 쓰여질 녀석이고 `body`가 이제 GridView로 사용될 녀석이다.
  그리고 또 하나 `SliverPersistentHeader` 라는 녀석이 있는데 스크롤하더라도 이 부분은 위에 남아있게되는 그런 녀석이고 이번 커밋이 이를 구현

### #49 DateRangePicker, TimePicker, DatePicker

### #50 SwitchListTile, CheckboxListTile

### #51 showCupertinoDialog, showDialog

### #52 showCupertinoModalPopup

### #53 OrientationBuilder

- 이녀석은 이제 핸드폰을 가로로 만들었을 때와 세로로 만들었을 때 다르게 렌더링하기 위해 필요한 Builder고 그 작업에 대한 커밋

### #54 setPreferredOrientations

### #55 Mute or not on video

### #56 Responsive Design (Web view)

### #57 LayoutBuilder

- 얘는 builder function의 parameter로 context, constraints를 받는데 여기서 constraints의 maxWidth, maxHeight은 스크린의 사이즈가 아니라
  해당 layout의 사이즈를 가르킨다. 그래서 얘를 사용하는 이유는 스크린의 사이즈가 아니라 스크린안에 이 layout의 사이즈의 변함에 따라 보여지고 말고를 정할 수 있고 그러기 위해 사용하는 widget
- 이 커밋에서는 discover 화면에 gridview의 item들의 layout 사이즈에 따라 하단 아바타와 유저네임을 보여주냐마냐를 결정할 때 사용했다.

### #58 BoxConstraints

- 얘가 LayoutBuilder에서 constraints의 타입인데 이 녀석을 Container widget에서도 사용할 수 있다.
  그 Container widget에서 사용하면, 이제 해당 컨테이너의 maxWidth나 maxHeight을 해당 컨테이너 사이즈에 따라 조절할 수 있게 된다.

### #59 DarkMode

- 우선 다크모드를 구현하려면 앱을 만들기 전부터 먼저 구상을 해놓는것이 가장 베스트이다. 현재 상황처럼 미리 염두에 두지 않으면 위젯별로 컬러를 하드코드로 넣은것들은 일일이 다 작업을 해줘야하기때문.
  그래서 미리 구상을 해 두고 `두가지 방식`으로 구현이 가능한데, 이 커밋처럼 utils 파일로 다크모드인지 아닌지를 구분해주는 함수하나를 구현해서 다크모드일 때 아닐 때를 다르게 컬러를 주던가 `main.dart`
  파일에서 theme을 전부 다 구현해놓고 시작하던가.

### #60 Google fonts, TextTheme

### #61 Theme

- https://pub.dev/packages/flex_color_scheme

- 지금까지는 이 theme을 매뉴얼로 다 작업해서 darkMode와 lightMode를 구분해서 설정했는데, 사실 이 관련 library가 있다. 그건 `flex_color_scheme` 이라는 library고 이거를 쓰면 간단하게 지금까지 한 걸
  구현 할 수 있지만 직접해보는 것에 의의를 두었다.

### #62 Localizations

### #63 l10n

- `Flutter Intl` extension 다운로드
- `l10n.yaml` 파일 생성
- `intl` 폴더에 커밋과 같이 생성

```bash
# 아래 명령어 실행 (이거 실행하면 l10n.yaml 파일에 적힌 내용에 따라 .dart_tool 이라는 폴더에 localization을 생성 )
flutter gen-l10n
```

- `main.dart`에 커밋과 같이 작성
- 사용하기

### #64 AppLocalizations

- 위에서 사용한거 그대로 사용하는데, 변수로도 localization이 가능함

### #65 Use 'Flutter Intl' extension

- 위에서 한 작업을 모두 알아서 해주는 플러그인이다.

- 우선 첫번째로 저 익스텐션을 깔고 Command + Shift + P 를 입력해서 팔레트 창을 노출시킨 후 거기에 intl 이라고 입력하면 `Flutter Intl: Initialize`라는 녀석이 나온다.
  얘를 클릭하면 generated 폴더랑, l10n폴더랑 알아서 다 만들어줌. 그리고 추가적인 Locale이 필요하면 같은 방법으로 `Flutter Intl: Add locale`을 클릭해서 원하는 locale(ko)를 입력하면 된다.
  그리고 또 신기한건 localization하고 싶은 스트링을 하이라이팅하고 Command + . 을 클릭하면 Extract to ARB가 있는데 이거 클릭하면 알아서 만들어줌

### #66 Select, Plural Localization

- 신기한게 엄청 많다. 변수로 어떤것을 받을 수도 있는데 intl_en.arb 파일을 보면 그 형식을 알 수 있다.

### #67 Numbers l10n

- 숫자, 개수도 역시 localization이 가능하다.

### #68 PageRouteBuilder

- 라우팅할 때 스스로 애니메이션을 만들고 할 수 있는 builder

### #69 pushNamed

- 라우팅할 때 route name을 지정해서 라우팅할 수 있다.

### #70 pushNamed with Args

- 라우팅을 route name으로 하는데 그 때 페이지로부터 args 받는 방법

### #71 why we use go_router package and pushNamed Limitation

- https://pub.dev/packages/go_router

- pushNamed 이 방법은 flutter가 추천하지 않는다. 그래서 우리도 새로운 navigator를 사용할거다. 왜 추천하지 않냐면, 웹 브라우저에서 이 기능을 사용할 경우 forward 버튼이 정상적으로 동작하지 않는다.
  플러터는 iOS, Android 할 것 없이 browser모두 지원해주기 때문에 우린 이것을 쓰면 안된다. 그렇다고 그 전에 사용하던 방식(PageRouterBuilder, MaterialPageRouteBuilder)도 좋지 않다.
  왜냐하면 그 전에 사용하던 방식의 navigator는 URL이 없다. 그래서 모든 페이지가 다 같은 URL로 보인다. 이것이 문제다 그 전 Navigator는.

### #72 go_router with parameter

### #73 How to send queryParameter, extra data in go_router

### #74 go_router with pageBuilder

- go_router를 사용해서도 역시 pageBuilder를 만들 수 있고 이는 우리만의 애니메이션을 가지게 한다.

### #75 Video Recording (Use camera / permissions)

- 우선, iOS Simulator는 카메라 기능이 없기 때문에 Android Simulator를 사용하던가, iPhone을 사용한다면 직접 내 핸드폰으로 연결하던가 둘 중하나로 해야하고,
  아래 두 패키지를 설치해야한다.
  ```yaml
  camera: 0.10.3
  permission_handler: 10.2.0
  ```
