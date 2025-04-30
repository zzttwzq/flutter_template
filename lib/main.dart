
import 'package:flutter/material.dart';
import 'package:cubixd/cubixd.dart';
import 'package:vector_math/vector_math_64.dart' show Vector2;
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CubixD 手势控制演示',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CubixDDemo(),
    );
  }
}

class CubixDDemo extends StatefulWidget {
  @override
  _CubixDDemoState createState() => _CubixDDemoState();
}

class _CubixDDemoState extends State<CubixDDemo> with TickerProviderStateMixin {
  String currentSide = "front";
  Vector2 cubeRotation = Vector2(0, 0);
  Offset? _startPosition;

  // 动画控制器
  late AnimationController _rotationController;
  late AnimationController _translationController;

  // 动画
  late Animation<Vector2> _rotationAnimation;
  late Animation<Vector2> _translationAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // 旋转动画控制器
    _rotationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    // 平移动画控制器
    _translationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // 初始化动画
    _rotationAnimation = AlwaysStoppedAnimation(Vector2(0, 0));
    _translationAnimation = AlwaysStoppedAnimation(Vector2(0, 0));
    _opacityAnimation = AlwaysStoppedAnimation(1.0);

    // 添加监听器
    _rotationController.addListener(() {
      setState(() {
        cubeRotation = _rotationAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _translationController.dispose();
    super.dispose();
  }

  // 旋转立方体到指定面
  void _rotateCubeTo(String targetSide) {
    Vector2 targetRotation;
    switch (targetSide) {
      case "front":
        targetRotation = Vector2(0, 0);
        break;
      case "back":
        targetRotation = Vector2(0, math.pi);
        break;
      case "left":
        targetRotation = Vector2(0, -math.pi/2);
        break;
      case "right":
        targetRotation = Vector2(0, math.pi/2);
        break;
      case "top":
        targetRotation = Vector2(-math.pi/2, 0);
        break;
      case "bottom":
        targetRotation = Vector2(math.pi/2, 0);
        break;
      default:
        targetRotation = Vector2(0, 0);
    }

    // 创建旋转动画
    _rotationAnimation = Vector2Tween(
      begin: cubeRotation,
      end: targetRotation,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _rotationController.reset();
    _rotationController.forward().then((_) {
      setState(() {
        currentSide = targetSide;
      });
    });
  }

  // 根据滑动确定目标面
  String _getTargetFace(String direction) {
    Map<String, Map<String, String>> navigationMap = {
      "front": {
        "up": "top",
        "down": "bottom",
        "left": "left",
        "right": "right"
      },
      "back": {
        "up": "top",
        "down": "bottom",
        "left": "right",
        "right": "left"
      },
      "left": {
        "up": "top",
        "down": "bottom",
        "left": "back",
        "right": "front"
      },
      "right": {
        "up": "top",
        "down": "bottom",
        "left": "front",
        "right": "back"
      },
      "top": {
        "up": "back",
        "down": "front",
        "left": "left",
        "right": "right"
      },
      "bottom": {
        "up": "front",
        "down": "back",
        "left": "left",
        "right": "right"
      }
    };

    // 如果当前面和方向都存在于映射中，返回目标面
    if (navigationMap.containsKey(currentSide) &&
        navigationMap[currentSide]!.containsKey(direction)) {
      return navigationMap[currentSide]![direction]!;
    }

    // 默认返回当前面
    return currentSide;
  }

  // 平移方法 - 水平方向
  void _translateHorizontal(bool toRight) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 第一阶段：移出屏幕
    _translationAnimation = Tween<Vector2>(
      begin: Vector2(0, 0),
      end: Vector2(toRight ? screenWidth : -screenWidth, 0),
    ).animate(CurvedAnimation(
      parent: _translationController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _translationController,
      curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
    ));

    _translationController.reset();
    _translationController.forward().then((_) {
      // 第二阶段：从反方向进入
      _translationAnimation = Tween<Vector2>(
        begin: Vector2(toRight ? -screenWidth : screenWidth, 0),
        end: Vector2(0, 0),
      ).animate(CurvedAnimation(
        parent: _translationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOutQuad),
      ));

      _opacityAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _translationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ));

      _translationController.reset();
      _translationController.forward();
    });
  }

  // 平移方法 - 垂直方向
  void _translateVertical(bool toBottom) {
    final screenHeight = MediaQuery.of(context).size.height;

    _translationAnimation = Tween<Vector2>(
      begin: Vector2(0, 0),
      end: Vector2(0, toBottom ? screenHeight : -screenHeight),
    ).animate(CurvedAnimation(
      parent: _translationController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _translationController,
      curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
    ));

    _translationController.reset();
    _translationController.forward().then((_) {
      _translationAnimation = Tween<Vector2>(
        begin: Vector2(0, toBottom ? -screenHeight : screenHeight),
        end: Vector2(0, 0),
      ).animate(CurvedAnimation(
        parent: _translationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOutQuad),
      ));

      _opacityAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _translationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ));

      _translationController.reset();
      _translationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CubixD 手势控制演示'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('当前面: $currentSide',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            GestureDetector(
              onVerticalDragStart: (details) {
                _startPosition = details.globalPosition;
                if (_rotationController.isAnimating) {
                  _rotationController.stop();
                }
              },
              onVerticalDragEnd: (details) {
                if (_startPosition == null) return;

                // 垂直滑动的方向
                final vertical = details.velocity.pixelsPerSecond.dy;

                // 根据滑动速度判断方向
                String direction;
                if (vertical > 0) {
                  direction = "down"; // 向下滑动
                } else {
                  direction = "up"; // 向上滑动
                }

                // 根据当前面和滑动方向确定目标面
                String targetFace = _getTargetFace(direction);
                _rotateCubeTo(targetFace);

                _startPosition = null;
              },
              onHorizontalDragStart: (details) {
                _startPosition = details.globalPosition;
                if (_rotationController.isAnimating) {
                  _rotationController.stop();
                }
              },
              onHorizontalDragEnd: (details) {
                if (_startPosition == null) return;

                // 水平滑动的方向
                final horizontal = details.velocity.pixelsPerSecond.dx;

                // 根据滑动速度判断方向
                String direction;
                if (horizontal > 0) {
                  direction = "right"; // 向右滑动
                } else {
                  direction = "left"; // 向左滑动
                }

                // 根据当前面和滑动方向确定目标面
                String targetFace = _getTargetFace(direction);
                _rotateCubeTo(targetFace);

                _startPosition = null;
              },
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _rotationController,
                  _translationController
                ]),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        _translationAnimation.value.x,
                        _translationAnimation.value.y
                    ),
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: CubixD(
                        size: 260.0,
                        delta: cubeRotation,
                        sensitivityFac: 0.01,
                        front: _buildCubeFace(Colors.red, '前'),
                        back: _buildCubeFace(Colors.blue, '后'),
                        left: _buildCubeFace(Colors.green, '左'),
                        right: _buildCubeFace(Colors.yellow, '右'),
                        top: _buildCubeFace(Colors.purple, '上'),
                        bottom: _buildCubeFace(Colors.orange, '下'),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30),

            // 手动控制和平移按钮
            Column(
              children: [
                // 旋转按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _rotateCubeTo('front'),
                      child: Text('正面'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _rotateCubeTo('back'),
                      child: Text('背面'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _rotateCubeTo('left'),
                      child: Text('左面'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _rotateCubeTo('right'),
                      child: Text('右面'),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // 平移按钮
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _translateHorizontal(false),
                          child: Text('左移'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => _translateHorizontal(true),
                          child: Text('右移'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _translateVertical(false),
                          child: Text('上移'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => _translateVertical(true),
                          child: Text('下移'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 创建立方体的每个面
  Widget _buildCubeFace(Color color, String faceName) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          faceName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 自定义Tween用于Vector2动画插值
class Vector2Tween extends Tween<Vector2> {
  Vector2Tween({required Vector2 begin, required Vector2 end})
      : super(begin: begin, end: end);

  @override
  Vector2 lerp(double t) {
    return Vector2(
      begin!.x + (end!.x - begin!.x) * t,
      begin!.y + (end!.y - begin!.y) * t,
    );
  }
}
