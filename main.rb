# banking system
require 'csv'
require_relative 'authentication'
require_relative 'bank_operations'

class Main
  def initialize
    @user = { name: '', email: '', password: '', balance: 0 }

    # class objects
    @auth = Authentication.new(@user)
    @bank = BankOperation.new(@user)
  end

  def choice
    loop do
      puts "1. Register"
      puts "2. Login"
      puts "3. Deposit"
      puts "4. Withdraw"
      puts "5. Balance"
      puts "6. Logout"
      puts "7. Exit"

      print "Enter your choice : "
      choice = gets.chomp.to_i

      case choice
      when 1
        @auth.register
      when 2
        @auth.login
      when 3
        @bank.deposit
      when 4
        @bank.withdraw
      when 5
        @bank.balance
      when 6
        @auth.logout
      when 7
        break
      else
        puts "invalid choice"
      end
    end
  end
end

user = Main.new
user.choice
