CREATE MIGRATION m1nsllt266px34ls24uhdgpkznm5wcantlunovwtkmprkigscllgiq
    ONTO m1zulhxdqiiwdcz42tle3wornivdosy5d3skcp7rioxgwyx2mnenzq
{
  ALTER TYPE default::Account {
      ALTER PROPERTY expires_at {
          SET TYPE std::int64 USING (0);
      };
  };
};
