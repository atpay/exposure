# Exposure

Rails plugin to provide various interfaces to an ActiveRecord model by subclassing,
without forcing STI. The following would provide similar functions on the model, the first
without Exposure, the second with:

```ruby
# app/models/user.rb

class User < ActiveRecord::Base
  attr_accessor :simple_signup
  attr_accessor :advanced_signup

  validates_presence_of :email
  validates_presence_of :name, :if => :simple_signup
  validates_presence_of :phone, :city, :if => :advanced_signup
end

# 

User.create(:email => "test@localhost")
User.create(:simple_signup => true, :email => "test@localhost", :name => "Test Nancy")
User.create(:advanced_signup => true, :email => "test@localhost", :name => "Test Nancy", :city => "Albuquerque")
```

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  validates_presence_of :email
end

# app/models/simple_signup.rb
class SimpleSignup < User
  include Exposure

  validates_presence_of :email, :name
end

# app/models/advanced_signup.rb
class AdvancedSignup < User
  include Exposure

  validates_presence_of :email, :name, :phone, :city
end

# 

User.create(:email => "test@localhost")
SimpleSignup.create(:simple_signup => true, :email => "test@localhost", :name => "Test Nancy")
AdvancedSignup.create(:advanced_signup => true, :email => "test@localhost", :name => "Test Nancy", :city => "Albuquerque")
```

Using Exposure allows us to extract the validation into easier to read and more
maintainable units, and also enables us to define attribute overrides where maintaining
a simple model would become more difficult:

```ruby
class User
  after_create :delver_welcome

  def deliver_welcome
    # System-based
  end
end

class SimpleSignup < User
  def deliver_welcome
    SimpleSignupWelcome.send_to(email)
  end
end

class AdvancedSignup < User
  def deliver_welcome
    AdvancedSignupWelcome.send_to(email)
  end
end
```
