import 'package:flutter/material.dart';

class ExpandableInfoComponent extends StatefulWidget {
  final double totalGagne;

  const ExpandableInfoComponent({super.key, required this.totalGagne});

  @override
  _ExpandableInfoComponentState createState() => _ExpandableInfoComponentState();
}

class _ExpandableInfoComponentState extends State<ExpandableInfoComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _navigateToChartsPage() {
    Navigator.pushNamed(context, '/ChartsPage');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 150,
      decoration: BoxDecoration(
        color: _isExpanded ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.8),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // GestureDetector to control expansion/collapse by tapping on the totalGagne part
          GestureDetector(
            onTap: _toggleExpanded,
            child: Column(
              children: [
                Text(
                  '${widget.totalGagne.toStringAsFixed(2)} DT',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text('Total gagné', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isExpanded ? 150 : 0,
            child: _isExpanded
                ? Column(
                    children: [
                      Divider(thickness: 1, color: Colors.grey),
                      // GestureDetector to handle navigation to /ChartsPage by tapping on "Aujourd'hui"
                      GestureDetector(
                        onTap: _navigateToChartsPage,
                        child: Column(
                          children: [
                            Text(
                              'Aujourd\'hui',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '0 commandes effectués',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '0 commandes annulés',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
