CREATE MIGRATION m1vv5rvmoe2bzghpsexsgm67iw2trowcfzo5gx5setj5egqeq3gvpa
    ONTO m1c2iqc2b6fqrvydpei674sjccnvyznhwx5w3wxvvfemnytlcfziyq
{
  ALTER TYPE default::Session {
      ALTER PROPERTY expires {
          SET TYPE std::datetime USING (std::datetime_current());
      };
  };
  ALTER TYPE default::VerificationToken {
      DROP PROPERTY expired;
  };
  ALTER TYPE default::VerificationToken {
      CREATE REQUIRED PROPERTY expires -> std::datetime {
          SET REQUIRED USING (std::datetime_current());
      };
  };
};
