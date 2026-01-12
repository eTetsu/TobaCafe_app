class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
end
