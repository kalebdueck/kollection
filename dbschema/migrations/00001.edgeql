CREATE MIGRATION m1hbgjjzst4tn7hszelnrpagelpnojt7ib6werp5bgyhcd672rkqxa
    ONTO initial
{
  CREATE TYPE default::Card {
      CREATE REQUIRED PROPERTY name -> std::str;
      CREATE PROPERTY scryfall_data -> std::json;
      CREATE PROPERTY scryfall_id -> std::uuid;
  };
  CREATE TYPE default::Collection {
      CREATE MULTI LINK cards -> default::Card;
  };
  CREATE TYPE default::Format {
      CREATE REQUIRED PROPERTY mainboard_min -> std::int64;
      CREATE REQUIRED PROPERTY name -> std::str;
      CREATE REQUIRED PROPERTY sideboard_min -> std::int64;
  };
  CREATE TYPE default::Deck {
      CREATE MULTI LINK mainboard -> default::Card;
      CREATE MULTI LINK sideboard -> default::Card;
      CREATE LINK format -> default::Format;
      CREATE REQUIRED PROPERTY name -> std::str;
  };
  CREATE TYPE default::User {
      CREATE LINK collection -> default::Collection;
      CREATE REQUIRED PROPERTY email -> std::str;
      CREATE REQUIRED PROPERTY password -> std::str;
  };
};
