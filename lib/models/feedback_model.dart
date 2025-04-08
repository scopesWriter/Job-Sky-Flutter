class FeedbackModel {
  final String uid;
  final String userName;
  final String feedbackTitle;
  final String feedbackMessage;

  FeedbackModel({
    required this.uid,
    required this.userName,
    required this.feedbackTitle,
    required this.feedbackMessage,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      uid: map['uid'] ?? '',
      userName: map['username'] ?? 'Unknown',
      feedbackTitle: map['feedbackTitle'] ?? '',
      feedbackMessage: map['feedbackMessage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': userName,
      'feedbackTitle': feedbackTitle,
      'feedbackMessage': feedbackMessage,
    };
  }
}
