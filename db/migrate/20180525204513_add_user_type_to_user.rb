class AddUserTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_type, :integer
    User.all.each do |user|
      if user.dealership.present?
        user.user_type = :owner
        user.save
      end
    end
  end
end
