require 'csv'

class Authentication
  def initialize(user)
    @user = user
  end

  def register
    check_file
    @user[:email] = ''

    loop do
      print "Enter your Name : "
      @name = gets.chomp.strip
      if @name.empty?
        puts "please enter your name"
      elsif(!name_validator)
        puts "Enter valid name"
      else
        break
      end
    end

    loop do
      print "Enter your Email : "
      @email = gets.chomp.downcase
      if @email.empty?
        puts "please enter Email"
      elsif(!email_validate)
        @email.gsub!(/\s+/ , "")
        puts "Please enter valid email"
      else
        @email.gsub!(/\s+/ , "")
        break
      end
    end

    loop do
      print "Enter Password : "
      @password = gets.chomp
      if @password.empty?
        puts "please enter Password"
      elsif(!password_validator)
        puts "Please enter strong password"
      else
        break
      end
    end

    CSV.foreach("User.csv", headers: true) do |row|
      if row["email"] == @email
        puts "Email already registered !"
        return
      end
    end

    @new_user = {
      name: @name,
      email: @email,
      password: @password,
      balance: 0
    }

    CSV.open("User.csv", "a") do |users|
      # users << @new_user.values.map { |v| v.to_s.strip }
      users << @new_user.values
    end

    puts "Registration successful."
  end

  def login
    loop do
      print "Enter your Email : "
      @email = gets.chomp.downcase
      if @email.empty?
        puts "please enter Email"
      else
        @email.gsub!(/\s+/ , "")
        break
      end
    end

    loop do
      print "Enter Password : "
      @password = gets.chomp
      if @password.empty?
        puts "please enter Password"
      else
        break
      end
    end

    found = false

    CSV.foreach("User.csv", headers: true) do |row|
      if row["email"].to_s.strip.downcase == @email &&
         row["password"].to_s.strip == @password

        found = true
        @user[:name] = row["name"]
        @user[:email] = row["email"]
        @user[:password] = row["password"]
        @user[:balance] = row["balance"].to_i
        puts "Login Successful."
        break
      end
    end

    puts "Invalid Email or Password!" unless found
  end

  def logout
    if @user[:email].empty?
      puts "user already logged out !"
      return
    end
    @user[:email] = ""
    puts "User logged out successfully"
  end

  private

  def email_validate
    /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/.match?(@email)
  end

  def name_validator
    /^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}$/.match?(@name)
  end

  def password_validator
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/.match?(@password)
  end

  def check_file
    unless File.exist?("User.csv")
      CSV.open("User.csv", "w") do |csv|
        csv << ["name", "email", "password", "balance"]
      end
    end
  end
end
