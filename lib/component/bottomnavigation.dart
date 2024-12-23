
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shirtify/pages/ShopPage.dart';

import 'Colors.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key, required this.extra});

  final Map<String, dynamic> extra;

  @override
  _NavControllerState createState() => _NavControllerState();
}

class _NavControllerState extends State<Bottomnavigation> {
  final PageController _pageController = PageController(initialPage: 1); // Set initial page to index 1
  final List<bool> _isHovering = List<bool>.filled(6, false);
  late String email;
  late String role;
  late String id; // Initialize id
  int _currentIndex = 1; // Initialize to index 1

  @override
  void initState() {
    super.initState();
    email = widget.extra['email'];
    role = widget.extra['role'];
    id = widget.extra['id'];
    print('Role: $role');
    print('Email: $email');
    print('ID: $id');
    _loadUserInfo(); // Load user info

    // Automatically select index 1 on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (role == 'Admin') {
          _pageController.jumpToPage(1);
        } else {
          _pageController.jumpToPage(0);
        }
      });
    });
  }
  List<Widget> _getNavBarItems() {
    List<Widget> items = [];
    if (role == 'Admin') {
      items = [
        _buildNavItem(0, Icons.settings),
        _buildNavItem(1, Icons.add),
      ];
    } else {
      items = [
        _buildNavItem(0, Icons.shop),
        _buildNavItem(1, Icons.shopping_cart),
        _buildNavItem(2, Icons.person)
      ];
    }
    return items;
  }

  List<Widget> _getPageViewChildren() {
    List<Widget> pages = [];
    if (role == 'Admin') {
      pages = [
        Container(),
        Container(),
      ];
    } else {
      pages = [
       const ShopPage(),
        Container(),
        Container(),
      ];
    }
    return pages;
  }

  Future<void> _loadUserInfo() async {

  }

  Widget _buildNavItem(int index, IconData icon) {
    return InkWell(
      onHover: (hovering) {
        setState(() {
          _isHovering[index] = hovering;
        });
      },
      child: Icon(
        icon,
        color: _isHovering[index] ? Colors.grey : Colors.white,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Track current index
          });
        },
        children: _getPageViewChildren(),
      ),
      bottomNavigationBar: Stack(
        children: [
          CurvedNavigationBar(
            backgroundColor: ColorsPallete.white,
            color: ColorsPallete.orange,
            items: _getNavBarItems(),
            index: _currentIndex,
            // Set the initial index
            onTap: (index) {
              setState(() {
                _currentIndex = index; // Update current index on tap
                _pageController.jumpToPage(index); // Navigate to the selected page
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomPageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final List<Widget> children;

  const CustomPageView({
    required this.controller,
    required this.onPageChanged,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
      physics: const NeverScrollableScrollPhysics(), // Disable swipe gesture
    );
  }
}