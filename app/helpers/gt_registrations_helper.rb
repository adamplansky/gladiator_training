module GtRegistrationsHelper
  def zaplaceno(zaplaceno)
    if zaplaceno == true
      "ANO"
    else
      "NE"
    end
  end
end
