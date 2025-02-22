class Admin::GroupUsersController < ApplicationController
  before_action :authenticate_admin!
end
