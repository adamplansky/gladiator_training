class Dictionary < ActiveRecord::Base


  default_scope {order('en_name')}

end
