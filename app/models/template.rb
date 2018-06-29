class Template < ApplicationRecord
  has_paper_trail meta: { template_id: :id, dealership_id: :dealership_id }

  DEFAULT_ID= Rails.env.production? ? 2 : 3
  belongs_to :dealership
  has_many :packages, autosave: true
  def self.default dealership_id, template_id = DEFAULT_ID
		template_id ||= DEFAULT_ID
    find(template_id).dup.tap{|template|
      template.dealership_id = dealership_id
      template.define_singleton_method(:packages) {
        Package.where(template_id: template_id).map{|package|
          package_id = package.id
          package.dup.tap{|package|
            package.define_singleton_method(:coverages) {
              Coverage.where(package_id: package_id).map(&:dup).tap{|a|
                a.define_singleton_method(:order) { |key|
                  sort_by{|c| c[key] }
                }
              }
            }
            package.define_singleton_method(:addons) {
              Addon.where(package_id: package_id).map(&:dup)
            }
          }
        }.tap{|packages|
            packages
              .define_singleton_method(:order) {|key| sort_by{|p| p[key] } }
        }
      }
    }
  end
end
