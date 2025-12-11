module Logout
  def logout
    if @user[:email].empty?
      puts "user already logged out !"
      return
    end
    @user[:email]=""
    puts "User logged out successfully"
  end
end
