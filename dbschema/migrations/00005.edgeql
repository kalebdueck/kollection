CREATE MIGRATION m1jn34ru3fxzwjpzeddlbggg2pcoxmd4aldzeijqkrjp3v6456dmlq
    ONTO m1v6vecue3v5puhgfvh2rdj6lm3njdtwpf33plwqlgyxsmnxwxzosa
{
  ALTER TYPE default::User {
      ALTER PROPERTY email_verified {
          SET TYPE std::datetime USING (std::datetime_current());
      };
  };
};
