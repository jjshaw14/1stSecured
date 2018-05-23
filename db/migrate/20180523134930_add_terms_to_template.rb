require 'default_terms'
class AddTermsToTemplate < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :terms, :text
    Template.all.each do |template|
      template.terms = DEFAULT_TERMS
      template.save
    end if Template.column_names.include? 'terms'
  end
end
