import 'package:flutter/material.dart';
import 'package:flutter_pat_application/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

import '../providers/communication_provider.dart';
import '../widgets/communication_header.dart';
import '../widgets/communication_title.dart';
import '../widgets/communication_contract_card.dart';
import '../widgets/communication_tabs.dart';
import '../widgets/communication_chat_area.dart';
import '../widgets/communication_bottom_input.dart';

class CommunicationScreen extends ConsumerStatefulWidget {
  const CommunicationScreen({super.key});

  @override
  ConsumerState<CommunicationScreen> createState() =>
      _CommunicationScreenState();
}

class _CommunicationScreenState extends ConsumerState<CommunicationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CommunicationHeader(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    const CommunicationTitle(),
                    SizedBox(height: 20.h),
                    const CommunicationContractCard(),
                    SizedBox(height: 20.h),
                    CommunicationTabs(
                      onNavigation: () async {
                        final result = await context
                            .pushNamed<List<PlatformFile>>(
                              AppRouter.attachFileDocuments,
                            );
                        if (result != null && result.isNotEmpty) {
                          for (var file in result) {
                            ref
                                .read(communicationProvider.notifier)
                                .sendMessage('แนบไฟล์: ${file.name}');
                          }
                          Future.delayed(const Duration(milliseconds: 300), () {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CommunicationChatArea(
                      chatState: ref.watch(communicationProvider),
                    ),
                  ],
                ),
              ),
            ),
            CommunicationBottomInput(
              controller: _messageController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    ref.read(communicationProvider.notifier).sendMessage(text);
    _messageController.clear();

    // Scroll to bottom after a short delay to allow UI to update
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
