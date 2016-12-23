class User < ActiveRecord::Base
  # Implementa los métodos y validaciones de tu modelo aquí.
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, :uniqueness => true
  validates :phone,:presence => true,
                   :numericality => true,
                   :length => { :minimum => 10, :maximum => 15 }
  validate :at_least_18

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

  def at_least_18
    errors.add(:birthday,"¡¡cooooooome on, you aren't 18 years old or more!!") if birthday.year > 1998
  end

end