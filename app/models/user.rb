class User < ActiveRecord::Base
  def self.create(email:, password:)
    result =
      User.connection.execute <<-SQL
        insert into users (email, password_digest)
        values ('#{email}', crypt('#{password}', gen_salt('bf')))
        returning *;
      SQL

    if result.first.blank?
      false
    else
      User.new(result.first)
    end
  end
end
