class SessionsController < ActionController::Base
  def create
    results =
      ActiveRecord::Base.connection.execute <<-SQL
        insert into sessions (user_id, token, expires_at)
        select users.id, digest(users.id || '|' || now()::varchar, 'md5'), now() + '2 days'
        from users
        where users.email = '#{params[:email]}'
          and users.password_digest = crypt('#{params[:session][:password]}', users.password_digest)
        returning *
      SQL
    if results.first.present?
      redirect_to user_path(results.first['user_id'])
    else
      flash[:alert] = 'Your email and password do not match'
      render new_session_path
    end
  end

  private

  def session
    Session.new
  end
  helper_method :session
end
