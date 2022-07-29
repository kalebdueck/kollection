CREATE MIGRATION m1zflw53754ypiupu3cig6rikn7sxl2zxyzwdmddkhdruxdlh5ezhq
    ONTO m1hbgjjzst4tn7hszelnrpagelpnojt7ib6werp5bgyhcd672rkqxa
{
  CREATE ABSTRACT LINK default::link_with_count {
      CREATE PROPERTY count -> std::int64;
  };
  ALTER TYPE default::Collection {
      ALTER LINK cards {
          EXTENDING default::link_with_count LAST;
      };
  };
  ALTER TYPE default::Deck {
      ALTER LINK mainboard {
          EXTENDING default::link_with_count LAST;
      };
      ALTER LINK sideboard {
          EXTENDING default::link_with_count LAST;
      };
  };
  ALTER TYPE default::Card {
      CREATE PROPERTY price -> std::int64;
  };
  ALTER TYPE default::User {
      ALTER LINK collection {
          CREATE CONSTRAINT std::exclusive;
      };
  };
};
