CREATE MIGRATION m1pgefnra6xjcxvr4rkbmzzqkuewv32pljs2e6br7ax7xqa3grehhq
    ONTO m156qrttqoxwq6w7hctzflh45afjbpw2dadrrkl7u7ws2uhr66bs7q
{
  ALTER TYPE default::Account {
      CREATE PROPERTY access_token -> std::str;
  };
  ALTER TYPE default::Account {
      CREATE PROPERTY account_type -> std::str;
  };
  ALTER TYPE default::Account {
      CREATE PROPERTY expires_at -> std::datetime;
  };
  ALTER TYPE default::Account {
      CREATE PROPERTY id_token -> std::str;
  };
  ALTER TYPE default::Account {
      ALTER PROPERTY provider_account_id {
          RENAME TO providerAccountId;
      };
  };
  ALTER TYPE default::Account {
      CREATE PROPERTY refresh_token -> std::str;
      CREATE PROPERTY scope -> std::str;
      CREATE PROPERTY session_state -> std::str;
      CREATE PROPERTY token_type -> std::str;
  };
};
