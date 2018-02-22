# frozen_string_literal: true

class Setup < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.references :dealership, index: true
      t.string :name
      t.timestamps null: false
    end

    create_table :packages do |t|
      t.references :template, index: true
      t.string :name
      t.text :terms
      t.timestamps null: false
    end

    create_table :coverages do |t|
      t.references :package, index: true
      t.integer :length_in_months, :limit_in_miles
      t.text :caveat
      t.timestamps null: false
    end

    create_table :addons do |t|
      t.references :package, index: true
      t.string :name
      t.integer :amount_in_cents
      t.timestamps null: false
    end

    create_table :contracts do |t|
      t.references :dealership, index: true
      t.references :template, index: true

      t.integer :reference_number

      t.references :created_by, index: true
      t.references :submitted_by
      t.datetime :submitted_at

      t.string :first_name, :last_name
      t.string :email, :home_number, :work_number, :mobile_number
      t.string :address1, :address2, :address3, :city, :state, :zip

      t.string :vin, :make, :model, :year
      t.integer :odometer
      t.date :purchased_on

      t.references :coverage, index: true

      t.timestamps null: false
    end

    create_table :contract_addons do |t|
      t.references :contract, :addon, index: true
      t.timestamps null: false
    end

    create_table :claims do |t|
      t.references :contract, :provider, index: true
      t.integer :cost_in_cents, :odometer

      t.timestamps null: false
    end

    create_table :dealerships do |t|
      t.string :name
      t.string :address1, :address2, :address3, :city, :state, :zip
      t.string :phone

      t.timestamps null: false
    end

    create_table :service_providers do |t|
      t.string :name
      t.string :address1, :address2, :address3, :city, :state, :zip

      t.timestamps null: false
    end

    create_table :users do |t|
      t.references :dealership, index: true

      t.string :first_name, :last_name

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :provider, :uid

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
