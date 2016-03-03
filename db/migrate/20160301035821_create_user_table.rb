class CreateUserTable < ActiveRecord::Migration
  def up
    execute <<-SQL
      create extension pgcrypto;

      create table users (
        id serial primary key,
        email varchar not null unique,
        password_digest varchar not null
      );

      create table sessions (
        id serial primary key,
        user_id integer not null references users (id),
        token varchar not null,
        expires_at timestamptz not null
      );
    SQL
  end

  def down
    execute <<-SQL
      drop table sessions;
      drop table users;

      drop extension pgcrypto;
    SQL
  end
end
