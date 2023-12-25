class AppServerConstants {
  static const PAGE_SIZE = 10;

  /// mom visibility
  static const MV_Public = 0;
  static const MV_Confidential = 1;
  static const MV_Sensitive = 2;
  static const MV_Secret = 3;

  /// mom period
  static const MP_Yesterday = 1;
  static const MP_LastWeek = 2;
  static const MP_LastMonth = 3;
  static const MP_ThisMonth = 4;
  static const MP_LastQuarter = 5;

  /// mom recent
  static const MR_Recent_10 = 10;
  static const MR_Recent_15 = 15;
  static const MR_Recent_20 = 20;

  /// Mom Status
  static const MS_Draft = 0;
  static const MS_Reviewing = 1;
  static const MS_ToApprove = 2;
  static const MS_Approved = 3;
  static const MS_Completed = 4;
  static const MS_Return = 5;

  static const AS_NotStarted = 1;
  static const AS_InProgress = 2;
  static const AS_OnHold = 3;
  static const AS_Completed = 4;
  static const AS_Canceled = 5;

  static const ACTION_FILTER_IN_PROGRESS = 1;
  static const ACTION_FILTER_NOT_STARTED = 2;
  static const ACTION_FILTER_COMPLETED = 3;

  static const STATUS_DEFAULT_VALUE = -1111;

  static const Google_AuthType = 1;
  static const LinkedIn_AuthType = 2;
  static const Office_AuthType = 3;
  static const Apple_AuthType = 4;

  static const USER_VerificationType_SMS = 1;
  static const USER_VerificationType_EMAIL = 2;

  static const WORD_FILE_TYPE = 1;
  static const PP_FILE_TYPE = 2;
  static const PDF_FILE_TYPE = 3;

  static const Attach_FILE_TYPE = 1;
  static const Attach_IMAGE_TYPE = 2;
  static const Attach_VIDEO_TYPE = 3;
  static const Attach_OTHER_TYPE = 4;

  static const ATTENDEE_ROLE_CHAIRPERSON = 1;
  static const ATTENDEE_ROLE_REPORTER = 2;
  static const ATTENDEE_ROLE_REVIEWER = 3;
  static const ATTENDEE_ROLE_MEMBER = 4;
  static const ATTENDEE_ROLE_APPROVER = 5;

  static const Attendee_Status_Attended = 1;
  static const Attendee_Status_Absent = 2;
  static const Attendee_Status_Apologised = 3;
  static const Attendee_Status_Delegated = 4;

  /// Profile Contact Status
  static const PROFILE_CONTACT_PRIVATE = 1;
  static const PROFILE_CONTACT_PUBLIC = 2;

  static const EntityType_MOM = 1;
  static const EntityType_TASK = 2;
  static const EntityType_Discussion = 3;
  static const EntityType_User = 4;
  static const EntityType_Comment = 5;
}

enum MOMStatusENUM {
  MS_Draft,
  MS_Reviewing,
  MS_ToApprove,
  MS_Approved,
  MS_Completed,
  MS_Return,
}
enum ACTIONStatusENUM {
  ActionStatus,
  NotStarted,
  InProgress,
  OnHold,
  Completed,
  Canceled
}
enum MOMDetailsSection {
  MD_BASIC,
  MD_ATTENDEE,
  MD_DISCUSSIONS,
  MD_ACTIONS,
  MD_COMMENTS,
  MD_TAGS,
  MD_RELATED_MOMS,
  MD_ATTACHMENTS,
  MD_SHARED_MOMS
}
