class Admin::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = @exams.order_desc.page params[:page]
  end
end
