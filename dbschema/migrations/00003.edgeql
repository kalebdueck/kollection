CREATE MIGRATION m1pznpfofpjdcavtlrqydbuwpasx3rxhntve3tzia6oqsrukrlkppq
    ONTO m1zflw53754ypiupu3cig6rikn7sxl2zxyzwdmddkhdruxdlh5ezhq
{
  ALTER TYPE default::User {
      CREATE REQUIRED PROPERTY email_verified -> std::bool {
          SET REQUIRED USING (false);
      };
  };
  ALTER TYPE default::User {
      CREATE PROPERTY image -> std::str;
  };
  ALTER TYPE default::User {
      ALTER PROPERTY password {
          RENAME TO name;
      };
  };
};
