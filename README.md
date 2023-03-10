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

### #76 FlashMode

### #77 Recording button animation

- Button Scale Animation
- Recording time Progress Animation

### #78 Recorded video and VideoPreviewScreen

- 비디오를 촬영하고, 촬영한 비디오가 어디에 저장되는지, 그 비디오를 가지고 프리뷰 화면으로 넘겨주는거까지의 커밋

### #79 Save video

```yaml
gallery_saver: 2.3.2
```

### #80 Real Device Run

아래 문서를 통해 내 실제 iPhone으로 테스트 해볼 수 있다.

- https://docs.flutter.dev/deployment/ios#review-xcode-project-settings

혹시, 새로운 패키지를 깔고 다시 Xcode에서 Build할 때 해당 패키지가 없다라는 에러가 나오면, 아래 명령어를 차례대로 수행하고 다시 실행

```bash
flutter clean
flutter run
```

### #81 Image picker

### #82 didChangeAppLifecycleState

- 얘는 이제 AppLifecycle의 state를 통해 앱을 관리하는 메소드이고, 이 메소드를 사용하려면 WidgetsBindingObserver라는 Mixin을 사용해야 한다.
- 이에 대한 작업을 구현한 커밋

### #83 Zoom In-Out

### #84 Route Change

- 내가 원하는건 Signup 화면에서 /Signup 에서 Email, Username, Password, Birthday를 다 작성하길 원함 /Email, /Username, ... 이게 아님
  그래서 최초 라우팅 path만 지정하고 그 안에서 다음 페이지로 넘길 땐 Navigator를 사용. 나머지 화면도 마찬가지.

### #85 InheritWidget

- 지난 시간까지 사용했던 of(context)를 우리만의 InheritWidget으로 만들 수 있다. 그에 대한 커밋

### #86 StatefulInheritWidget

- 바로 지난 커밋에서는 우리만의 InheritWidget을 만들었지만 그 Widget이 가지는 상태에 대한 업데이트를 다른 화면이 공유할 수 없었다면 이제는 그 각 상태들을 공유할 수 있게
  StatefulWidget으로 만든 커밋

### #87 ChangeNotifier

- 86번 커밋의 InheritStatefulWidget을 정확히 동일하게 구현할 수 있는 녀석이 ChangeNotifier고, 얘가 사용법이 훨씬 간편하다.
  그리고 얘는 상태에 대한 업데이트를 두 가지 방법으로 구현할 수 있는데 하나는 `AnimatedBuilder`고 하나는 `Listener`다.
  AnimatedBuilder랑 연동해서 rebuild도 좋고 `notifyListeners()`라는 함수가 있는데 이 함수를 호출해서 이 ChangeNotifier를 Listen하고 있는 Listener에게 알려주면 그거에 대한 작업을 해주면 된다.

### #88 ValueNotifier

- ChangeNotifier와 비슷한데, 얘는 한가지 value에 대해서 Listen하는 녀석이다. 이 녀석을 이용해서 dark mode인지 아닌지 Listening하는것을 구현한 커밋

### #89 Provider

- ChangeNotifier같은 녀석의 state관리하기 위한 Provider

### #90 MVVM Design Pattern

- `MVVM`은 View - View Model - Model 구조를 의미한다.
  - View: 유저가 보는 화면
  - View Model: 유저가 View에서 어떤 작업을 했을 때 해당 작업에 대한 API를 정의
  - Model: 데이터를 정의한 부분
  - (Repository): Repository는 Model의 데이터를 디스크에 저장하고 재사용할 수 있는 저장창고

### #91 Riverpod

- `Riverpod`은 reactive하게 caching을 해주는 프레임워크인데, 알아서 데이터 패치, 캐싱, 데이터 조합, 데이터 정제 등 약간 Redux라고 생각하면 된다. 근데 이게 웃긴게
  Riverpod이 Provider의 철자를 바꿔서 만든거래

- `이 커밋은 ChangeNotifier에서 Riverpod으로 변경하는 커밋`

- https://docs-v2.riverpod.dev/
- Flutter Riverpod Snippets (익스텐션)

### #92 AsyncNotifier

- AsyncNotifier는 비동기 Notifier로 데이터를 주고받고 패치할때 유용하게 쓰일듯하다.
- Timeline을 이 AsyncNotifier로 변경한 커밋 (추후에 실 데이터를 이용할 것)

### #93 Firebase setup

아래 문서 참조하여 Setup 하기

- https://firebase.google.com/docs/flutter/setup?platform=ios

- 잘 따라가다보면 flutterfire configure 이라는 명령어를 실행하는 순서가 나오는데, 이때 이제 프로젝트가 없으면
  프로젝트를 만든다. 근데 만약에 path 설정이 안되어있으면 zshrc에 (혹은 bash_profile, ...) 아래 한 줄 추가해주자.

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

- 이제 위 명령어를 실행해서 프로젝트를 만들면 되는데 프로젝트명이 굉장히 중요한게 이게 내 계정에 유니크가 아니고 firebase 전체 프로젝트중에 유니크한 프로젝트명으로 작성해야한다.
- 나 firebase 계정이 chiwon99881이건가봐..

- Step 4까지 다 해야해 !

- 우리가 사용할 plugin은 firebase_auth, cloud_firestore, firebase_storage이고 이거를 설치하려면 `flutter pub add <plugin name>`를 실행
- 그리고 firebase plugin을 설치하거나 제거했으면 무조건 `flutterfire configure` 실행 다시해줘야하네
- 그 flutterfire configure할 때 macos는 체크해제할건데 체크해제하려면 스페이스바 누르면 됨

### #94 Firebase authentication

- firebase를 이용해서 authenticated를 한다. 그리고 그를 구현하기 위해 Riverpod을 이용하여 Provider를 사용한 커밋

### #95 Firebase project setting

- 우선, firebase console로 가서 내 프로젝트로 들어오면 화면 앞 대문짝만하게 Authentication이 있다. 이거를 누르고 Get started를 하면
  어떤 유형의 Auth를 할지 여러개가 있다. 여기서 Email/Password를 선택한다. 선택하고 Enable

### #96 Signup with Firebase

### #97 SignOut

### #98 Login / SnackBar (When Firebase error)

### #99 Firebase with Social Auth

- Github -> 일단 firebase console로 가서 Auth provider 추가를 Github로 하나 해주면, 거기서 Enable 시키면 아래 뭐 주소같은게 있는데 그게 Github의 callback URL에 넣으면 된다. 이거는 Github 페이지에서 Settings에 OAuth 새로 만들 때 하단에 callback URL에 넣어주면 되고 그렇게해서 Github OAuth를 만들면, Github에서 Client ID랑 Secret을 준다 그거를 firebase에 넣어주면 됨

### #100 Github Login

### #101 FireStore, Storage

- Firebase에서 data를 관리하기 위해, Firebase에 들어가서 대문짝만하게 Cloud Firestore라는 녀석을 클릭하면 Create database 버튼을 누른다. 거기서 test mode 선택해서 Next를 누르면
  지역을 선택하면 되고 (Seoul) 그러고 Enable누르면 된다. 그 다음에 Storage를 Get started하면 되는데 얘는 좌측 사이드바에 Build 아래에 있다. 얘도 역시나 test mode로 선택해서 진행

### #102 Create User to Firebase DB

### #103 Create User to Firebase DB (Done)

### #104 Find user profile on Firestore / Storage on Firebase

### #105 User avatar

### #106 Update user profile

### #107 Upload video to Firebase

### #108 Upload video to Firebase 2

### #109 Cloud Functions

- Functions은 firebase를 사용할 때 미들웨어 같은 녀석인데 예를 들어, 내 firestore에 데이터에 대해 functions의 조건에 따라 trigger가 되는 경우
  조건은 (onCreate, onDelete, onUpdate, onWrite) 뭐 이렇게 있고 여튼 이 조건에 부합할 때 해당 데이터를 가져와서 추가적인 작업을 할 수 있다.

```bash
flutter pub add cloud_functions

flutterfire configure

firebase init functions
  - 기존 프로젝트로 선택
  - Typescript 선택
  - ESLint는 사용하지 않음
  - NPM dependencies는 설치

# 이 작업을 끝내면 프로젝트 루트 경로에 functions이라는 폴더가 생긴다.
# functions > src > index.ts 파일에서 실제 우리가 어떤 행위를 할지 소스를 작성하면 된다.

# 그리고 이렇게 작성을 하고 나서 firebase와 상호작용 하려면 아래 커맨드를 입력
# 아래 커맨드는 index.ts 파일을 업데이트하면 항상 적용해줘야 함
firebase deploy --only functions

위 커맨드를 입력했을 때 작업이 다 끝나면 firebase에 들어가서 functions 탭으로 가면 우리가 만든 function이 있을거다.

자 근데 만약에 뭔가 새로운 module을 npm으로 내려받고 막 작업을 했을 때 deploy가 안되면 아래처럼 해보자
1. node_modules 폴더 지우기
2. package-lock.json 파일 지우기
3. npm i
```

### #110 ffmpeg

- video, audio 등을 뭐 어떤 다른 형태로 변환해주는 package인가보다.
- 이거를 사용해서 firebase에 올라간 동영상의 썸네일을 만드는 커밋
- https://ffmpeg.org/ffmpeg.html

```bash
# functions 폴더 안에서 실행할 것 !!!!

npm i child-process-promise
```

### #111 Video thumbnail done

### #112 Real data on timeline screen

### #113 Infinite Scroll with Firebase

- firebase에서 firestore의 데이터를 가져올 때 orderBy의 어떤 기준으로 어디서부터 어디까지를 가져올 수 있다.

### #114 FamilyAsyncNotifier

- `FamilyAsyncNotifier`는 이 NotifierProvider에게 extra data를 던져줄 수 있게 해주는 Notifier다.

### #115 toggle like video / firebase functions

### #116 Create Chat Room with firebase

### #117 All chats list 1

### #118 All chats list 2

### #119 All chats list done / send message done

### #120 Chat detail stream provider

- `StreamProvider`는 WebSocket같은 녀석, Connection을 유지하고 있는 상태에서 새로운 데이터가 들어오거나 나갈 때 바로바로 반응해줌

### #121 Delete message with ContextMenuPopup

### #122 State shared chats screen with chat detail screen

### #123 Video like react

### #124 user's like video 1

### #124 user's like video done

### #125 Video like all done

- [x] 좋아요 누르면 이모티콘 색, 좋아요 카운트 변경
- [x] 좋아요 누르면 해당 비디오 프로필에 패치
- [x] 좋아요 취소 시, 해당 비디오 프로필에서 제거
- [x] 프로필에서 좋아요 누르거나 취소해도 위와 동일

### Push notification

- 우선, Android로 해야한다. 왜냐하면 iOS는 App Developer 등록을 해야하는데 이거 등록하려면 아마도 돈 내야할듯 identifier가 필요해서..
  아래 링크로 필요한 플러그인을 다운받을 수 있다.

- https://firebase.google.com/docs/cloud-messaging/flutter/client

```bash
flutter pub add firebase_messaging
flutterfire configure
```

### Firebase push notification (Foreground / Background / Terminated)

### Target notification

- 이거는 만약 내가 어떤 특정 유저의 비디오를 좋아요 눌렀을 때 그 유저(target)한테 알림이 가도록 하는 방식인데,
  이걸 구현하기 위해 firebase functions을 사용할거다. 그리고 Cloud messaging api를 사용하기 위해 또 해줘야하는 작업은

  - https://console.cloud.google.com/apis/api/googlecloudmessaging.googleapis.com
  - 여기서 해당 API를 Enable해줘야한다.

- Target은 firebase notification을 사용하기 위해 발급되는 token으로 특정 유저의 Device에 접근할 수 있다.

### Unit Test

### Widget Test

- Mocking SharedPreferences
- Get ThemeData

### Integration Test
