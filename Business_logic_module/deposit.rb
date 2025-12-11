module Deposite
  def deposit
    if @user[:email].empty?
      puts "User not logged in!"
      return
    end

    print "Enter amount to deposit: "
    amount=gets.chomp.to_f.round(2)

    if amount < 0.1
      puts "please enter valid amount"
      return
    end

    @user[:balance] += amount
    update_balance
    puts "after deposit #{amount}, balance is #{@user[:balance]}"
    return
  end
end