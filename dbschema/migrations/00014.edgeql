CREATE MIGRATION m1l75oxnwq7kvf3ncv3urabkscrxftyino5hpgfmzjh5w4hzhbkkxq
    ONTO m1vr5pzlflzwwrcu26yw752mvx5r5hh5dlqv37ztlbszzxtb2ed57q
{
  ALTER TYPE default::Account {
      ALTER PROPERTY refresh_token_expired_in {
          RENAME TO refresh_token_expires_in;
      };
  };
};
