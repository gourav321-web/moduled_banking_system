module Balance
  def balance
    if @user[:email].empty?
      puts "user not logged in"
      return
    end
    puts "balance : #{@user[:balance]}"
    return
  end
end