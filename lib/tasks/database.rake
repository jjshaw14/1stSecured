namespace :db do
  task clean: :environment do
    puts "Clean..."
    ActiveRecord::Base.connection.execute(%(
      DROP SCHEMA public CASCADE;
      CREATE SCHEMA public;
      GRANT ALL ON SCHEMA public TO postgres;
      GRANT ALL ON SCHEMA public TO public;
    ))
  end
  task flush: [:clean, :migrate, :seed]
end
