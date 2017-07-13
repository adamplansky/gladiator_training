module GtRegistrationsHelper
  def zaplaceno(zaplaceno)
    if zaplaceno == true
      "ANO"
    else
      "NE"
    end
  end

  def zaplaceno_cls(zaplaceno)
    if zaplaceno == true
      "btn-success"
    else
      "btn-danger"
    end
  end
end
