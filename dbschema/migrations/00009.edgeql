CREATE MIGRATION m1zulhxdqiiwdcz42tle3wornivdosy5d3skcp7rioxgwyx2mnenzq
    ONTO m1pgefnra6xjcxvr4rkbmzzqkuewv32pljs2e6br7ax7xqa3grehhq
{
  ALTER TYPE default::Account {
      ALTER PROPERTY account_type {
          RENAME TO provider_type;
      };
  };
  ALTER TYPE default::Account {
      CREATE PROPERTY userId -> std::str;
  };
};
