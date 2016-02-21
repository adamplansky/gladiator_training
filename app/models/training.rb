class Training < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_category
  belongs_to :period
end
