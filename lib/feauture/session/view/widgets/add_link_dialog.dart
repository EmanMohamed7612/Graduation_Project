import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class AddLinkDialog extends StatefulWidget {
  final int sessionId;
  final String expertId;

  const AddLinkDialog({super.key, required this.sessionId, required this.expertId});

  @override
  State<AddLinkDialog> createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<AddLinkDialog> {
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                Icon(Icons.link, color: Color(0xff6D4C41)),
                SizedBox(width: 8),
                Text(LocaleKeys.meetinglink.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                hintText: "https://zoom.us/j/... or Google Meet link",
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF5ED),
                borderRadius: BorderRadius.circular(15),
              ),
              child:  Text(
                LocaleKeys.clientwillreceivethemeetinglinkviaemail.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffB79770), fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child:  Text(LocaleKeys.cancel.tr(), style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_linkController.text.isNotEmpty) {
                        context.read<ExpertServiceCubit>().updateLink(
                          sessionId: widget.sessionId,
                          link: _linkController.text,
                          expertId: widget.expertId,
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7B5B4F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child:  Text(LocaleKeys.confirm.tr(), style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}