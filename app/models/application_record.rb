class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include Pagy::Backend
end
