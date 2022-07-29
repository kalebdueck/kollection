CREATE MIGRATION m1c2iqc2b6fqrvydpei674sjccnvyznhwx5w3wxvvfemnytlcfziyq
    ONTO m1nsllt266px34ls24uhdgpkznm5wcantlunovwtkmprkigscllgiq
{
  CREATE TYPE default::Session {
      CREATE REQUIRED PROPERTY expires -> std::int64;
      CREATE REQUIRED PROPERTY sessionToken -> std::str;
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK session -> default::Session {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  CREATE TYPE default::VerificationToken {
      CREATE REQUIRED PROPERTY expired -> std::int64;
      CREATE REQUIRED PROPERTY identifier -> std::str;
      CREATE REQUIRED PROPERTY token -> std::str;
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK verificationToken -> default::VerificationToken {
          CREATE CONSTRAINT std::exclusive;
      };
  };
};
