CREATE MIGRATION m1vr5pzlflzwwrcu26yw752mvx5r5hh5dlqv37ztlbszzxtb2ed57q
    ONTO m1vv5rvmoe2bzghpsexsgm67iw2trowcfzo5gx5setj5egqeq3gvpa
{
  ALTER TYPE default::Account {
      CREATE PROPERTY refresh_token_expired_in -> std::int64;
  };
};
