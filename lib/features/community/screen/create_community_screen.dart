import 'package:redite_clone/features/community/controller/community_contorller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redite_clone/resposive/resposive.dart';

import '../../../core/common/loader.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final TextEditingController _communityNameController =
      TextEditingController();

  @override
  void dispose() {
    _communityNameController.dispose();
    super.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(_communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a community'),
      ),
      body: isLoading
          ? const Loader()
          : Responsive(
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Community Name')),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _communityNameController,
                      decoration: const InputDecoration(
                        hintText: 'r/Community Name',
                        filled: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      maxLength: 21,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: createCommunity,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Create Community',
                        style: TextStyle(fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
