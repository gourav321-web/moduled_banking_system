module Register
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
    flag=false
    CSV.foreach("User.csv", headers:true) do |row|
      row_email = row["email"]
      if row["email"] == @email
        flag = true
        puts "Email already registered !"
        break
      end
    end
    return if flag
    if(!email_validate)
      puts "please enter valid email"
      return
    end
    @new_user={name:@name,email:@email,password:@password,balance:0}
    CSV.open("User.csv","a") do |users|
      users << @new_user.values
    end
    puts "Registration successful."
  end

  def email_validate
    return /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/.match?(@email)
  end

  def name_validator
    return (/^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}$/.match?(@name))
  end

  def password_validator
    return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.match?(@password)
  end

end