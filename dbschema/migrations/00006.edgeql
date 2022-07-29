CREATE MIGRATION m1vjt2ke6m2cmw6logyq44eu66sjpanqyfihvdli3jdsyor4plgnoa
    ONTO m1jn34ru3fxzwjpzeddlbggg2pcoxmd4aldzeijqkrjp3v6456dmlq
{
  ALTER TYPE default::User {
      ALTER PROPERTY email_verified {
          RESET OPTIONALITY;
      };
  };
};
