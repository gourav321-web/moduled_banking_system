module Update_balance
  def update_balance
    rows = CSV.read("User.csv",headers:true)
    rows.each do |row|
      if row["email"] == @user[:email]
        row["balance"] = @user[:balance].to_s
      end
    end
    
    CSV.open("User.csv","w") do |csv|
      csv << rows.headers
      rows.each do |row|
        csv << row
      end
    end
  end
end