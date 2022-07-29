CREATE MIGRATION m156qrttqoxwq6w7hctzflh45afjbpw2dadrrkl7u7ws2uhr66bs7q
    ONTO m1vjt2ke6m2cmw6logyq44eu66sjpanqyfihvdli3jdsyor4plgnoa
{
  ALTER TYPE default::User {
      ALTER PROPERTY email_verified {
          RENAME TO emailVerified;
      };
  };
};
