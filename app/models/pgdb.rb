class Pgdb < ActiveRecord::Base

  def self.get_statistics(training_category_id, period_id)
    prm = filter_handle(training_category_id, period_id)
    return connection.execute("select * from get_statistics(#{prm[:training_category_id]}, #{prm[:period_id]});").to_a
  end


  private
  def self.remove_blank x
    return x.blank? ? nil : x
  end

  def self.filter_handle training_category_id, period_id
    prms = {}
    prms[:training_category_id] = ActiveRecord::Base.connection.quote(remove_blank(training_category_id))
    prms[:period_id] = ActiveRecord::Base.connection.quote(remove_blank(period_id))
    return prms
  end

end
