# banking system 
require 'csv'
require './Auth_module/register'
require './Auth_module/login'
require './Auth_module/logout'
require './Business_logic_module/withdraw'
require './Business_logic_module/deposit'
require './Business_logic_module/check_balance'
require './Business_logic_module/update_balance'
require './utilities/check_file'

class Main
  include Register
  include Login
  include Logout
  include Balance
  include Update_balance
  include Deposite
  include Withdraw
  include Check_file


  def initialize
    @user={name:'', email:'', password:'', balance:0}
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
          register
        when 2
          login
        when 3
          deposit
        when 4
          withdraw
        when 5
          balance
        when 6
          logout
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
