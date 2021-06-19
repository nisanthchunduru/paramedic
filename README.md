# paramedic

A Stripe API inspired params validation library for Rails

## Installation

Add paramedic your Rails app's Gemfile

```ruby
gem "paramedic", git: "https://github.com/nisanth074/paramedic", branch: "main"
```

and bundle install

```bash
bundle install
```

## Usage

```ruby
# In app/controllers/application_controller.rb
class ApplicationController
  include Paramedic::ActionControllerAdditions
end

# In app/controllers/users_controller.rb
class UsersController
  def create
    User.create!(user_attributes)
  end

  private

  def user_attributes
    paramedic.
      required("user", type: :hash).
      required("user.email", type: :email).
      optional("user.name")
  end
end
```

When a required param is missing or when a param has incorrect type, paramedic will respond 

```bash
% curl -X POST http://lvh.me:3000/users --data '{}'
{
  "errors": [{
    'message': "Param 'user' is missing in request JSON"
  }]
}

% curl -X POST http://lvh.me:3000/users --data '{
  "user": {
    "email": "John Doe"
  }
}'
{
  "errors": [{
    'message': "Param 'user.email' must be an email address"
  }]
}
```

### Advanced example

```ruby
# In app/controllers/notifications_controller.rb
class NotificationsController
  def create
    Notification.create!(notification_attributes)
  end

  private

  def notification_attributes
    recipient_schema = {
      "external_id" => { type: :string },
      "email" => { type: :email }
    }
    paramedic .
      required("notification", type: :hash).
      required("notification.title").
      required("notification.recipients", type: :array, element_schema: recipient_schema, max: 1000).
      optional("notification.action_url").
      optional("notification.category").
      optional("notification.custom_attributes", type: :hash)
  end
end
```

## Todos

- Move rspecs from the app to here
- Publish to rubygems.org
