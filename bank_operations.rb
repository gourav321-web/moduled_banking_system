require 'csv'

class BankOperation
  def initialize(user)
    @user = user
  end

  def withdraw
    if @user[:email].empty?
      puts "User not logged in!"
      return
    end

    print "Enter amount to withdraw: "
    amount = gets.chomp.to_f.round(2)

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

  def deposit
    if @user[:email].empty?
      puts "User not logged in!"
      return
    end

    print "Enter amount to deposit: "
    amount = gets.chomp.to_f.round(2)

    if amount < 0.1
      puts "please enter valid amount"
      return
    end

    @user[:balance] += amount
    update_balance
    puts "after deposit #{amount}, balance is #{@user[:balance]}"
  end

  def update_balance
    rows = CSV.read("User.csv", headers: true)

    rows.each do |row|
      if row["email"].to_s.strip == @user[:email]
        row["balance"] = @user[:balance].to_s
      end
    end

    CSV.open("User.csv", "w") do |csv|
      csv << rows.headers
      rows.each { |row| csv << row }
    end
  end

  def balance
    if @user[:email].empty?
      puts "user not logged in"
      return
    end
    puts "balance : #{@user[:balance]}"
  end
end
