import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  late final AnimationController _animationController;
  // ! begin 0.0 과 end 0.5 가 의미하는건 180도만 회전할 것을 의미 만약, end가 1.0이면 360도 회전
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onTitleTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  // ! 이건 우리가 알림을 제스쳐로 지울 때 그 녀석을 위젯트리에서도 날려줘야한다. Dismissible은 위젯을 날리지만 위젯트리에서는 남아있기 때문에 날려줘야한다.
  void _onDismissed(String noti) {
    _notifications.remove(noti);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h2,
              RotationTransition(
                turns: _animation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
            ),
            child: Text(
              "New",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Gaps.v14,
          for (var noti in _notifications)
            Dismissible(
              key: Key(noti),
              onDismissed: (direction) => _onDismissed(noti),
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.green.shade400,
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.size10,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.white,
                    size: Sizes.size24,
                  ),
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.red.shade400,
                child: const Padding(
                  padding: EdgeInsets.only(
                    right: Sizes.size10,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
                    size: Sizes.size24,
                  ),
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size14,
                ),
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: Sizes.size1,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Account updates:",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: Sizes.size16,
                    ),
                    children: [
                      const TextSpan(
                        text: " Upload longer videos",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: " $noti",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
