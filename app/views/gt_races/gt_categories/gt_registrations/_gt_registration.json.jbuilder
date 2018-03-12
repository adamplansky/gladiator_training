json.extract! gt_registration, :id, :firstname, :surname, :gt_race_id, :price, :street, :city, :psc, :phone_number, :code, :birth, :sex, :notes, :created_at, :updated_at
json.url gt_registration_url(gt_registration, format: :json)
