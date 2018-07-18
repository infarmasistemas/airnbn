class ApplicationController < ActionController::Base
  # previne a vulnerabilidade Cross-Site Request Forgery
  # mais detalhes em https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery.html
  protect_from_forgery
end
