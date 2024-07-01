import 'package:flutter/material.dart';

import '../../core/common/widgets/logout_button.dart';
import '../../core/common/widgets/profile_app_bar.dart';
import '../../core/common/widgets/profile_content.dart';
import 'widgets/expense_month_selector.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProfileAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            ProfileContent(
              child: ExpenseMonthSelector(),
            ),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}
