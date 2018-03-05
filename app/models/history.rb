class History < PaperTrail::Version
  belongs_to :created_by, optional: true, class_name: 'User', foreign_key: :whodunnit

  belongs_to :contract, optional: true
  belongs_to :template, optional: true
  belongs_to :user, optional: true
end
