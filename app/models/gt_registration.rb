require 'csv'
class GtRegistration < ActiveRecord::Base
  validates_email_format_of :email, :message => ' neexistuje!'
  validates :email, :firstname, :surname, :price, presence: true
  #validates :email, :firstname, :surname, :price, presence: true
  validates :price, numericality:{ greater_than: 0, message: "nesmí být 0, hlášení o chybě bylo odesláno administrátorovi."}
  validate :capacity_validation, :on => :create
  #validates :gt_category_id, :gt_race_id, presence: true
  belongs_to :gt_race
  belongs_to :gt_category
  before_save :set_age
  before_save :set_teammateage

  def full_name
    "#{firstname} #{surname}"
  end

  def full_name_teammate
    "#{teammate_firstname} #{teammate_surname}"
  end

  def get_age(_birth_date, _race_date)
    ((_race_date - _birth_date).to_i) / 365
  end

  def set_age
    birth = read_attribute(:birth)
    gt_category = GtRace.find(read_attribute(:gt_race_id))
    value = get_age(birth, gt_category.published)
    write_attribute(:age, value)
  end

  def capacity_validation
    gt_race = GtRace.find(read_attribute(:gt_race_id))
    gt_category = GtCategory.find(read_attribute(:gt_category_id))
    if gt_category.name == 'Junior'
      size = GtRegistration.junior_category_size(gt_race.id)
      capacity = gt_race.max_junior_capacity
    else
      size = GtRegistration.not_junior_category_size(gt_race.id)
      capacity = gt_race.max_others_capacity
    end
    if size >= capacity
      errors.add(:kapacita, "závodu je naplněna #{size} / #{capacity} ")
    end

  end

  def set_teammateage
    birth = read_attribute(:teammate_birth)
    return unless birth
    gt_category = GtRace.find(read_attribute(:gt_race_id))
    value = get_age(birth, gt_category.published)
    write_attribute(:teammate_age, value)
  end

  def self.junior_category_size(race_id)
    junior_category_id = GtCategory.find_by_name("Junior").id
    gt = GtRace.find(race_id)
    gt.gt_registrations.where(gt_category_id: junior_category_id).size
  end

  #GtRegistration.not_junior_category_size()
  def self.not_junior_category_size(race_id)
    junior_category_id = GtCategory.find_by_name("Junior").id
    gt = GtRace.find(race_id)
    gt.gt_registrations.where.not(gt_category_id: junior_category_id).size
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << %w{ id kategorie email jméno příjmení rok_narození pohlaví tým jméno2 příjmení2 rok_narození_2 pohlaví2 klub mesto}
      all.each do |reg|
        csv << [reg.id, reg.gt_category.name, reg.email, reg.firstname, reg.surname, reg&.birth&.year, reg.sex, reg.team_name, reg.teammate_firstname, reg.teammate_surname, reg&.teammate_birth&.year, reg.teammate_sex, reg.team, reg.city]
      end
    end
  end



end
