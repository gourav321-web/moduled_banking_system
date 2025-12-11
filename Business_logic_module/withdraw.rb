module Withdraw
  def withdraw
    if @user[:email].empty?
      puts "User not logged in!"
      return
    end

    print "Enter amount to withdraw: "
    amount=gets.chomp.to_f.round(2)
    
    if amount < 0.1 
      puts "please enter valid amount"
      return

    elsif amount > @user[:balance]
      puts "Insufficient balance"
      return
    end

    @user[:balance] -= amount
    update_balance
    puts "balance after Withdraw #{amount} is #{@user[:balance]}"
  end
end