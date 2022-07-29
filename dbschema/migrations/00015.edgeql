CREATE MIGRATION m1ygeu35vyg2yroa5divswzjhlj3ojcebbaq6wrfvfaab6ccq5pfaq
    ONTO m1l75oxnwq7kvf3ncv3urabkscrxftyino5hpgfmzjh5w4hzhbkkxq
{
  ALTER TYPE default::Account {
      ALTER PROPERTY refresh_token_expires_in {
          RENAME TO refresh_token_expired_in;
      };
  };
  ALTER TYPE default::User {
      ALTER LINK account {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::User {
      ALTER LINK session {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
};
