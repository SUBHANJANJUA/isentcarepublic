import 'package:flutter/material.dart';

class OverlappingAvatars extends StatelessWidget {
  final List<String> participants;
  final double radius;
  final double overlapOffset;

  const OverlappingAvatars({
    required this.participants,
    this.radius = 16.0,
    this.overlapOffset = 12.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius * 2,
      width: (participants.length.clamp(0, 3) * overlapOffset) + radius * 2,
      child: Stack(
        children: [
          for (int i = 0; i < participants.take(3).length; i++)
            Positioned(
              left: i * overlapOffset,
              child: CircleAvatar(
                radius: radius,
                backgroundImage: AssetImage(participants[i]),
              ),
            ),
          if (participants.length > 3)
            Positioned(
              left: participants.take(3).length * overlapOffset,
              child: CircleAvatar(
                radius: radius,
                backgroundColor: Color(0xff2051E5),
                child: Text(
                  '+${participants.length - 3}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
