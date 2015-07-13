class String
  def is_numeric?
    self.match(/\A\d+\Z/) == nil ? false : true
  end
  #here can be added other methods like is_guid? etc
end
