class GtRegistration < ActiveRecord::Base
  validates_email_format_of :email, :message => ' neexistuje!'
  validates :email, :firstname, :surname, :price, presence: true
  #validates :email, :firstname, :surname, :price, presence: true
  validates :price, numericality:{ greater_than: 0, message: "nesmí být 0, hlášení o chybě bylo odesláno administrátorovi."}
  #validates :gt_category_id, :gt_race_id, presence: true
  belongs_to :gt_race
  belongs_to :gt_category
  before_save :set_age
  before_save :set_teammateage

  def get_age(_birth_date, _race_date)
    ((_race_date - _birth_date).to_i) / 365
  end

  def set_age
    birth = read_attribute(:birth)
    gt_category = GtRace.find(read_attribute(:gt_race_id))
    value = get_age(birth, gt_category.published)
    write_attribute(:age, value)
  end

  def set_teammateage
    birth = read_attribute(:teammate_birth)
    return unless birth
    gt_category = GtRace.find(read_attribute(:gt_race_id))
    value = get_age(birth, gt_category.published)
    write_attribute(:teammate_age, value)
  end


end
