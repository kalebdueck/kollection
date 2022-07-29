CREATE MIGRATION m1v6vecue3v5puhgfvh2rdj6lm3njdtwpf33plwqlgyxsmnxwxzosa
    ONTO m1pznpfofpjdcavtlrqydbuwpasx3rxhntve3tzia6oqsrukrlkppq
{
  CREATE TYPE default::Account {
      CREATE REQUIRED PROPERTY provider -> std::str;
      CREATE REQUIRED PROPERTY provider_account_id -> std::str;
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK account -> default::Account {
          CREATE CONSTRAINT std::exclusive;
      };
  };
};
