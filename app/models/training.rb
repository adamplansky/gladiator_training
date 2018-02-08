class Training < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_category
  belongs_to :period
  paginates_per 20

  default_scope { order('created_at DESC') }

  validates :user, presence: true
  validates :period, presence: { message: "Není vytvořena nová sezóna, kontaktuje administrátora" }

  def distance=(val)
    val.sub!(',', '.') if val.is_a?(String)
    self['distance'] = val
  end
end
