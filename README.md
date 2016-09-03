# Styxie

Bridge between Server side and Client (JS) side which is divided into several modules:

* **Helpers**: set of helpers to support all other modules.
* **Initializer**: organizes JS into bootstrap classes and allows you to pass data from controller/view.

## Installation

In your Gemfile, add this line:

    gem 'styxie'
    
In your assets application.js include appropriate libs:

    //= require styxie           <- Helpers and Initializers

## Basic Usage

```ruby
# app/controllers/foos_controller.rb
class FoosController < ApplicationController
  include Styxie::Initializer
  helper_method :styxie_initialize # in case of Rails
end
```

Include modules to ApplicationController if you want to use it everywhere.


### Initializer

In common each controller in Rails comes with *app/assets/javascripts/controller_name.js.coffee*. 
**Styxie.Initializer** allows you to define bootstrap logic for each Rails action separately and 
pass some data from server right into it.

To enable initializers bootstrap, add *styxie_initialize* call into your layout:

```erb
  <head>
    <title>Rails Application</title>
    <%= stylesheet_link_tag    "application" %>
    <%= javascript_include_tag "application" %>
    <%= styxie_initialize %>
    <%= csrf_meta_tags %>
```

Imagine you have controller *Foos* and therefore *app/assets/javascripts/foos.js.coffee* file.

```coffee-script
@Styxie.Initializers.Foos =
  initialize: ->
    console.log 'This will be called in foos#ANY action after <head> was parsed'
      
  index: (data) ->
    console.log 'This will be called in foos#index action after <head> was parsed'
    
  show: (data) -> 
    $ ->
      console.log 'This will be called in foos#show action after the page was loaded'
```

Note that any method besides common *initialize* has the *data* parameter. To pass some data to your
initializers you can use *styxie_initialize_with* helper in your controller or views. Like that:

```ruby
# app/controllers/foos_controller.rb
class FoosController < ApplicationController
  def index
    styxie_initialize_with some: 'data', and: { even: 'more data' }
  end
end

# app/views/foos/index.html.erb
<%- styxie_initialize_with enabled: true %>
```

As the result *Styxie.Initializers.Foos->index* will be called with data equal to 

    {some: data, and: {even: 'mode data'}, enabled: true}
